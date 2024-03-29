classdef MaDS
    % MaDS: Mass-Damper-Spring Linear Model Solver
    % Copyright 2017-2023 Petr Krysl
    %
    % The system can be a representation of a truss structure: The bars
    % can be understood as the springs, there may be added dampers, and the
    % masses associated with the joints are the third component.
    %
    % Example of use: see the MaDS.demo() method
    %
    % Note: All methods need to be called by referencing the class MaDS,
    %       as for instance
    %            MaDS.demo()
    %       or
    %            K = MaDS.stiffness(X,k,kconn,dof)
    
    properties (Constant, Access = public) % Demos
        HintColor = 0.8*[1, 1, 1];   
        SpringWidth = 3.0;
        SpringColor = 0.7*[1, 0, 0];   
        DeformedSpringColor = 0.7*[1, 0, 1];   
        JointRadius = 4.0;
        JointColor = 0.1*[1, 1, 1];
        ForceColor = 0.7*[0, 0, 1];   
        NumberColor = 0.0*[1, 1, 1];
        NumberOffset = [0.0, 0.0];
        TextSize = 16;
    end
    
    properties (Constant, Access = public) % Demos
        FIX_X = 1;   
        FIX_Y = 2;
    end
    
    methods (Static, Access = public) % Demo
        
        function demo()
            % Undamped vibration problem, with animation.
            %
            % MaDS.demo()
            %
            % This is the problem of three carriages that is solved in the
            % AETNA textbook.
            m =  1.3;  k = 61;   c  = 0; % Mass, stiffness, damping parameters
            X = [0, -0.5; 0, 0; 0, 0.5; 0, 1.0];% Locations of joints
            kconn = [1, 2; 2, 3; 3, 4];% Which joints are connected by springs
            k = [61, 61, 61];% Spring constants
            m = [0, 1.3, 1.3, 1.3];%  Joint masses
            dof = [7,8; 4,1; 5,2; 6,3];% Definition of the degrees of freedom:
            % each  joint can move in the X direction and in the Y
            % direction, so it has 2 degrees of freedom. The free degrees
            % of freedom are 1,2,3; then we number the degrees of freedom
            % that are fixed at value  0.0.
            nfreedof = 3;% How many  unknown degrees of freedom?
            
            % Check the input data
            MaDS.sanity_check(X, k, m, [], kconn, [], dof, nfreedof);
            % Construct the stiffness matrix
            K = MaDS.stiffness(X, k, kconn, dof);
            % Construct the mass matrix
            M = MaDS.mass(X, m, dof);
            % Solve the generalized eigenvalue problem for the mode shapes
            % (V) and natural frequencies (diagonal of D)
            [V, D] = eig(K(1:nfreedof, 1:nfreedof), M(1:nfreedof, 1:nfreedof));
            disp( [ 'Frequencies =', num2str(sqrt(diag(D)')/2/pi) ])
            
            % Visualize the results
            Mode =  1;
            omega = sqrt(D(Mode, Mode));% angular frequency of the selected  mode
            Tn = 2*pi/abs(omega);% period  of the selected mode
            dX = 0*X; % this will hold the joint displacements
            freedofix =  find(dof <= nfreedof);% indexes of the free degrees of freedom
            dX(freedofix) = V(dof(freedofix), Mode);% distribute the mode shape displacements to the joints
            % Some visualization parameters
            scale =   0.3;
            extrad = scale*max(abs(V(:, Mode)));
            xrange = [min(X(:, 1))-extrad, max(X(:, 1))+extrad];
            yrange = [min(X(:, 2))-extrad, max(X(:, 2))+extrad];
            % Make a figure and retrieve the axes
            f = figure;
            ax = gca;
            for t = linspace(0, 4*Tn, 150) % these are the time instants to display the shape
                %                 figure(f); cla;
                try, figure(f); cla; % if we still have the figure, clear the axes;
                catch,  break, % otherwise we are done
                end
                xscale = sin(omega*t);
                SimPl.draw_extents(xrange, yrange);
                SimPl.draw_joints(X, 3*MaDS.JointRadius, 0.7*[1, 1, 1]);
                SimPl.draw_springs(X+xscale*scale*dX, kconn, MaDS.SpringWidth, MaDS.SpringColor, true)
                SimPl.draw_joints(X+xscale*scale*dX, 3*MaDS.JointRadius, 0.7*[1, 0, 0]);
                axis equal; axis off
                pause( 0.1 );
            end
        end
        
    end
    
    methods (Static, Access = public) % Modeling methods
        
        function sanity_check(X, k, m, c, kconn, cconn, dof, nfreedof)
            % Sanity checks for a system of springs and dampers connecting
            % joints with given masses. 
            %
            % MaDS.sanity_check(X, k, m, c, kconn, cconn, dof, nfreedof)
            %
            % X =  array of joint coordinates, one row per joint
            % k =  array of spring stiffnesses,  one stiffness coefficient
            %      per spring
            % m =  array of concentrated masses at joints, one mass
            %      coefficient per joint; if supplied as empty (such as for
            %      Constants), this argument is not checked.
            % c =  array of damper coefficients,  one stiffness coefficient
            %      per damper; if supplied as empty  (such as for Constants),
            %      this argument is not checked.
            % kconn =  which  joints are connected by the spring? array of
            %      two joint numbers, one row per spring
            % cconn =  which  joints are connected by the damper? array of
            %      two joint numbers, one row per damper; if supplied as
            %      empty  (such as for Constants), this argument is not
            %      checked.
            % dof =  array of degree of freedom numbers, one row per joint
            % nfreedof = number of free degrees of freedom
            %
            % Error is reported when the data is not consistent.
            
            if (size(X,1)<2)
                error('Need more than one joint')
            end
            
            if (size(X, 2) ~= 2)
                error('The geometry needs to be described in two dimensions: X is the wrong dimension')
            end
            
            if (size(X) ~= size(dof))
                error('The degree of freedom array not the same size as the location array X')
            end
            
            if (~isempty(m)) % Checked only for dynamics
                if (length(m) ~= size(X, 1))
                    error('Need precisely one mass coefficient per joint: m is the wrong dimension')
                end
            end
            
            if (~isempty(kconn)) % Only if springs are present
                if (size(kconn, 2) ~= 2)
                    error('Each spring needs to link two joints: kconn is the wrong dimension')
                end
                
                if (size(kconn, 1) ~= length(k))
                    error('Each spring needs to have a stiffness: k is the wrong dimension')
                end
            end
            
            if (~isempty(cconn)) % Only if dampers are present
                if (size(cconn, 2) ~= 2)
                    error('Each damper needs to link two joints: cconn is the wrong dimension')
                end
                
                if (size(cconn, 1) ~= length(c))
                    error('Each spring needs to have a stiffness: c is the wrong dimension')
                end
            end
            
            jc = zeros(size(X, 1), 1);
            if (~isempty(kconn))
                jc(kconn(:)) = 1;
            end
            if (~isempty(cconn))
                jc(cconn(:)) = 1;
            end
            if (~isempty(find(jc==0)))
                error('Each joint needs to be connected by spring or damper')
            end
            
            if sum(abs((sort(dof(:))-(1:prod(size(dof)))'))) ~= 0
                error('The degrees of freedom must be between 1 and number of joints times 2')
            end
            
            if (nfreedof>prod(size(dof)))
                error('The number of free degrees of freedom must be between 1 and number of joints times 2')
            end
            
        end
        
        function Lengths = lengths(X, kconn)
            % Compute the lengths of the springs (bars).
            %
            % Ls = MaDS.lengths(X, kconn)
            %
            % X =  array of joint coordinates, one row per joint
            % kconn =  which  joints are connected by the spring? array of
            %      two joint numbers, one row per spring
            %
            % Returns
            % Lengths = array of the lengths of the springs.

            Lengths = zeros(size(kconn, 1), 1);
            % Now  loop over all the springs
            for j = 1:size(kconn, 1)
                % Length of the spring
                Lengths(j) = MaDS.len(X(kconn(j, :), :));
            end
        end
        
        function F = applied_forces(AppliedF, dof)
            % Compute the a vector of the applied loads for a system of springs.
            %
            % F = MaDS. applied_forces(AppliedF, dof, nfreedof)
            %
            % AppliedF =  array of force components, one row per joint
            % dof =  array of degree of freedom numbers, one row per joint
            % nfreedof = number of free degrees of freedom
            %
            % Returns
            % F =  force vector, in length equal to the dimension of the
            %      space times the number of joints.
            F  = zeros(prod(size(dof)),1);
            % Add the applied forces
            for ii   = 1:size(AppliedF, 1)
                for  mm  = 1:2
                    d = dof(ii, mm);
                    F(d) =  F(d) + AppliedF(ii, mm);
                end
            end
        end
        
        function K = stiffness(X, k, kconn, dof)
            % Compute the stiffness matrix of a system of springs (bars).
            %
            % K = MaDS.stiffness(X, k, kconn, dof)
            %
            % X =  array of joint coordinates, one row per joint
            % k =  array of spring stiffnesses,  one stiffness coefficient
            %      per spring
            % kconn =  which  joints are connected by the spring? array of
            %      two joint numbers, one row per spring
            % dof =  array of degree of freedom numbers, one row per joint
            %
            % Returns
            % K =  stiffness matrix, square matrix in size equal to the
            %      dimension of the space times the number of joints.
            
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            K = zeros(size(X, 1)*size(X, 2));
            % Now  loop over all the springs
            for j = 1:size(kconn, 1)
                % Length of the spring (bar)
                L = MaDS.len(X(kconn(j, :), :));
                % Strain-displacement matrix.
                ds = MaDS.delt(X(kconn(j, :), :))/L;
                B = [-ds, ds];
                % The stiffness matrix  of a single spring in the global
                % coordinates.
                K_e = B'*( k(j) )*B;
                % The degrees of freedom connected by the spring
                edof = [dof(kconn(j, 1), :), dof(kconn(j, 2), :)];
                % Assemble the spring stiffness to the structural stiffness matrix
                K(edof, edof) =  K(edof, edof)+K_e;
            end
        end
        
        function C = damping(X, c, cconn, dof)
            % Compute the damping matrix  of a system of viscous dampers.
            %
            % C = MaDS.damping(X, c, cconn, dof)
            %
            % X =  array of joint coordinates, one row per joint
            % c =  array of damper constants,  one damping coefficient per
            %      damper
            % cconn =  which  joints are connected by the damper? array of
            %      two joint numbers, one row per spring
            % dof =  array of degree of freedom numbers, one row per joint
            %
            % Returns
            % C =  damping matrix, square matrix in size equal to the
            %      dimension of the space times the number of joints.
            
            
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            C = zeros(size(X, 1)*size(X, 2));
            % Now  loop over all the springs
            for j = 1:size(cconn, 1)
                % Length of the spring
                L = MaDS.len(X(cconn(j, :), :));
                % Construct the transformation matrix from the projections of the
                % spring onto the Cartesian axes
                ds = MaDS.delt(X(cconn(j, :), :))/L;
                B = [-ds, ds];
                % The stiffness matrix  of a single spring.  Transform the
                % local-coordinate stiffness matrix to the global-coordinate spring
                % stiffness matrix.
                C_e = B'*( c(j) )*B;
                % The degrees of freedom connected by the spring
                edof = [dof(cconn(j, 1), :), dof(cconn(j, 2), :)];
                % Assemble the spring stiffness to the structural stiffness matrix
                C(edof, edof) =  C(edof, edof)+C_e;
            end
        end
        
        function M = mass(X, m, dof)
            % Compute the mass matrix for a system of springs and joints.
            %
            % M = MaDS.mass(X, m, dof)
            %
            % X =  array of joint coordinates, one row per joint
            % m =  array of concentrated masses at joints,  one mass
            %      coefficient per joint
            % dof =  array of degree of freedom numbers, one row per joint
            %
            % Returns
            % M =  mass matrix, square matrix in size equal to the
            %      dimension of the space times the number of joints.
            
            I = eye(2);
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            M = zeros(size(X, 1)*size(X, 2));
            % Now  loop over all the joints
            for j = 1:size(X, 1)
                % The degrees of freedom associated with a joint
                edof = [dof(j, :)];
                % Assemble the isotropic spring mass to the structural
                % mass matrix.
                M(edof, edof) =  M(edof, edof) + m(j)*I;
            end
        end
        
        function K = initial_stress_stiffness(X, k, kconn, dof, u)
            % Compute the initial-stress stiffness matrix  of a system of springs (bars).
            %
            % K = MaDS.initial_stress_stiffness(X, k, kconn, dof, u)
            %
            % X =  array of joint coordinates, one row per joint
            % k =  array of spring stiffnesses,  one stiffness coefficient
            %      per spring
            % kconn =  which  joints are connected by the spring? array of
            %      two joint numbers, one row per spring
            % dof =  array of degree of freedom numbers, one row per joint
            % u =  array of displacements of the joints connected by the
            %      spring, one row per joint
            %
            % Returns
            % K =  stiffness matrix, square matrix in size equal to the
            %      dimension of the space times the number of joints.
            
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            K = zeros(size(X, 1)*size(X, 2));
            % Now  loop over all the springs
            for j = 1:size(kconn, 1)
                h = MaDS.len(X(kconn(j, :), :)); % the length of the spring
                N = k(j)*MaDS.elong(X(kconn(j, :), :), u(kconn(j, :), :));% axial force
                % Construct the submatrix generated by the force
                ds = MaDS.delt(X(kconn(j, :), :))/h;
                e2 = [-ds(2); ds(1)]; % direction orthogonal to the spring
                subm = (N/h)*(e2*e2');
                % The initial-stress stiffness matrix  of a single spring.
                K_egeo = [subm, -subm;
                         -subm,  subm];
                % The degrees of freedom connected by the spring
                edof = [dof(kconn(j, 1), :), dof(kconn(j, 2), :)];
                % Assemble the spring initial-stress stiffness to the global matrix
                K(edof, edof) =  K(edof, edof) + K_egeo;
            end
        end
        
        function u = scatter_vector(U, dof)
            % Create array of joint displacements from displacement vector.
            %
            % u = MaDS.scatter_vector(U, dof)
            %
            % U =  array of displacements, one value per row, a single
            %      column
            % dof =  array of degree of freedom numbers, one row per joint
            %
            % Returns
            % u =  displacement array, one row per joint
            
            % The displaced positions of the joints are represented by an
            % array of the same shape as X.
            u = zeros(size(dof));
            % The components of the vector U now need to be added into the
            % correct places in the array Xdeformed. First we find the
            % locations of the free degrees of freedom.
            nfreedof = length(U);
            freedofix = find(dof <= nfreedof);
            % The above call to the find() function treats the dof array as
            % one-dimensional: first column 1, then column 2, all
            % concatenated  into one long array.  The array of the indexes
            % freedofix points into the array dof.
            u(freedofix) = U(dof(freedofix));
        end
        
        function U = gather_vector(u, dof)
            % Create displacement vector from array of joint displacements.
            %
            % U = MaDS.gather_vector(u, dof)
            %
            % u =  displacement array, one row per joint
            % dof =  array of degree of freedom numbers, one row per joint
            %
            % Returns
            % U =  array of displacements, one value per row, a single
            %      column
            
            % The displaced positions of the joints are represented by an
            % array of the same shape as X.
            u = zeros(size(dof));
            % The components of the vector U now need to be added into the
            % correct places in the array Xdeformed. First we find the
            % locations of the free degrees of freedom.
            nfreedof = length(U);
            freedofix = find(dof <= nfreedof);
            % The above call to the find() function treats the dof array as
            % one-dimensional: first column 1, then column 2, all
            % concatenated  into one long array.  The array of the indexes
            % freedofix points into the array dof.
            u(freedofix) = U(dof(freedofix));
        end
        
        function [dof, nfreedof] = dofs(njoints, fixities)
            % Create the array of the degrees of freedom.
            %
            % [dof, nfreedof] = MaDS.dofs(njoints, fixities)
            %
            % njoints = number of joints, 
            % fixities = two-column array, in the first column there is the
            %      node number, in the second column the flags MaDS.FIX_X
            %      (fix X displacement), MaDS.FIX_Y(fix Y displacement), or
            %      MaDS.FIX_X+MaDS.FIX_Y (fix both X and Y displacements).
            dof = zeros(njoints, 2);
            isfixed = dof;
            for J=1:size(fixities, 1)
                node = fixities(J, 1);
                fixity = fixities(J, 2);
                if (fixity == MaDS.FIX_X) || (fixity == MaDS.FIX_X+MaDS.FIX_Y)
                    isfixed(node, 1) = true;
                end
                if (fixity == MaDS.FIX_Y) || (fixity == MaDS.FIX_X+MaDS.FIX_Y)
                    isfixed(node, 2) = true;
                end
            end           
            % First number the free degrees of freedom
            nfreedof = 0;
            for J=1:size(isfixed, 1)
                for  k =1:2
                    if ~isfixed(J, k)
                        nfreedof = nfreedof + 1 ;
                        dof(J, k) = nfreedof;
                    end
                end
            end
            % Now number the fixed degrees of freedom
            ndof = nfreedof;
            for J=1:size(isfixed, 1)
                for  k =1:2
                    if isfixed(J, k)
                        ndof = ndof + 1 ;
                        dof(J, k) = ndof;
                    end
                end
            end
        end
        
    end
    
    methods (Static, Access = public) % Convenience postprocessing methods
        
        function plot_structure(X, kconn, dof, nfreedof, AppliedF, ForceScaling, SpringColor, NumberOffset, TextSize, SpringWidth)
            % Plot the initial shape of the structure.
            %
            % MaDS.plot_structure(X, kconn, dof, nfreedof, AppliedF, ForceScaling, SpringColor, NumberOffset, TextSize, SpringWidth)
            % 
            % Plot the initial shape of the structure, with labels of
            % joints and springs. Also, supported joints are marked with
            % bigger circles, and the forces are displayed as arrows.
            % 
            % X =  array of joint coordinates, one row per joint
            % k =  array of spring stiffnesses,  one stiffness coefficient
            %      per spring
            % kconn =  which  joints are connected by the spring? array of
            %      two joint numbers, one row per spring
            % dof =  array of degree of freedom numbers, one row per joint
            % nfreedof = number of free degrees of freedom
            % AppliedF = array of force components, one row per joint
            % ForceScaling = scaling of the arrows representing forces
            %
            % Optional: 
            % NumberOffset = distance to offset that the numbers from the 
            %   joint locations or the centres of the bars (default 0.0),
            % TextSize = size of the text labels (default 14)
            % SpringWidth = array of line widths to be used to plot the
            %   springs, or just a single number
            
            if (~exist('ForceScaling','var'))
                ForceScaling = 1.0;
            end
            
            if (~exist('SpringColor','var'))
                SpringColor = MaDS.SpringColor;
            end
            
            if (~exist('NumberOffset','var'))
                NumberOffset = [0.0, 0.0];
            end
            
            if (~exist('TextSize','var'))
                TextSize = 14;
            end
            
            if (~exist('SpringWidth','var'))
                SpringWidth = zeros(size(kconn, 1), 1) + MaDS.SpringWidth;
            end
            
            % Which joints are supported (fixed)? Which are free?
            fixedJoints = unique([find(dof(:,1)>nfreedof); find(dof(:,2)>nfreedof)]);
            freeJoints = setdiff(1:size(X, 1), fixedJoints);
            
            axis equal; hold on
            
            SimPl.draw_springs(X, kconn, SpringWidth, SpringColor)
            SimPl.draw_joints(X(freeJoints, :), MaDS.JointRadius, MaDS.JointColor);
            SimPl.draw_joint_numbers(X, MaDS.NumberColor, TextSize, NumberOffset)
            SimPl.draw_joints(X(fixedJoints, :), 2*MaDS.JointRadius, MaDS.JointColor);
            SimPl.draw_forces(X, AppliedF, MaDS.ForceColor, ForceScaling);
            SimPl.draw_spring_numbers(X, kconn, MaDS.NumberColor, TextSize, NumberOffset);
            labels x y
        end
        
        function plot_deformed_structure(X, kconn, dof, nfreedof, u, scale, SpringColor, SpringWidth)
            % Plot the deformed structure.
            %
            % MaDS.plot_deformed_structure(X, kconn, dof, nfreedof, u, scale, SpringColor, SpringWidth)
            %
            % 
            % X =  array of joint coordinates, one row per joint
            % k =  array of spring stiffnesses,  one stiffness coefficient 
            %      per spring
            % kconn =  which  joints are connected by the spring? array 
            %      of two joint numbers, one row per spring
            % dof =  array of degree of freedom numbers, one row per joint
            % nfreedof = number of free degrees of freedom
            % u =  displacement array, one row per joint
            % scale = multiplier for the magnitude of the displayed
            %      displacement field
            
            if (~exist('SpringColor','var'))
                SpringColor = MaDS.DeformedSpringColor;
            end
            
            if (~exist('NumberOffset','var'))
                NumberOffset = [0.0, 0.0];
            end
            
            if (~exist('TextSize','var'))
                TextSize = 14;
            end
            
            if (~exist('SpringWidth','var'))
                SpringWidth = zeros(size(kconn, 1), 1) + MaDS.SpringWidth;
            end
            
            % Which joints are supported (fixed)? Which are free?
            fixedJoints = unique([find(dof(:,1)>nfreedof); find(dof(:,2)>nfreedof)]);
            freeJoints = setdiff(1:size(X, 1), fixedJoints);
            
            axis equal; hold on
            
            Xdeformed = X + scale*u;
            SimPl.draw_springs(Xdeformed, kconn, SpringWidth, SpringColor)
            SimPl.draw_joints(Xdeformed(freeJoints, :), MaDS.JointRadius, MaDS.JointColor);
            SimPl.draw_joints(Xdeformed(fixedJoints, :), 2*MaDS.JointRadius, MaDS.JointColor);
            labels x y
        end
        
    end
    
    methods (Static, Access = public) % General geometry helpers
        
        function  d = delt(x)
        % Compute oriented vector from the first to the second joint
        %
        % d = MaDS.delt(x)
        %
        % Compute the components of the oriented vector from the first to the
        % second joint on each spring.
        %
        % x =  array of coordinates of the joints connected by the spring, 
        %      one row per joint
        %
        % Returns
        % d = vector from the first (tail) to the second joint (head of the
        %      arrow)
            d  = diff(x);
        end
        
        function  L = len(x)
        % Compute spring length as the distance between the two joints.
        %
        % L = MaDS.len(x)
        %
        % x =  array of coordinates of the joints connected by the spring, 
        %      one row per joint
        % 
        % Compute the length of the spring  as the distance between the 
        % two joints the spring connects.
        %
        % Returns
        % L = length of the spring
            L = sqrt(sum(MaDS.delt(x).^2));
        end
        
        function  dL = elong(x, u)
        % Compute the elongation of the spring.
        %
        % dL = MaDS.elong(x, u)
        %
        % x =  array of coordinates of the joints connected by the spring, 
        %      one row per joint
        % u =  array of displacements of the joints connected by the 
        %      spring, one row per joint
        %
        % Returns
        % dL = The elongation is the change in length of the spring 
        %      (positive for the spring getting longer), negative for 
        %      the spring getting shorter) and it is caused by the 
        %      displacements of the joints.
            del = MaDS.delt(x);
            L = sqrt(sum(del.^2));
            dL = (del/L)*(u(2, :)-u(1, :))';
        end
        
        
    end
    
    methods (Static, Access = public) % Import and export from and to Abaqus
        
        function [X, kconn] = Abaqus_import(filename)
            % Import 2D truss mesh from the Abaqus .INP file.
            %
            % [X, kconn] = Abaqus_import(filename)
            %
            % Import 2D truss mesh from the Abaqus .INP file. Only the geometry and
            % connectivity is imported: an array of the locations of the joints, and
            % the connectivity of the bars.
            [pathstr, name, ext] = fileparts(filename) ;
            if (isempty(pathstr)),pathstr  = '.'; end
            
            chunk = 1000;
            
            function tokens =  all_tokens(String, Separator)
                tokens = {};
                while ~isempty( String )
                    [tokens{end+1}, String] = strtok(regexprep(String,'\s*',''),Separator);
                end
            end
            
            function [Valid] = Parse_element_line(String)
                Valid = false;
                if ~ischar(String), return; end
                tokens =  all_tokens(String, ',');
                if (strcmpi(tokens{1},'*ELEMENT'))
                    if (length(tokens)>=2)
                        tok1 =  all_tokens(tokens{2}, '=');
                        if (strcmpi(upper(tok1{1}),'TYPE'))
                            if (strcmpi(upper(tok1{2}),'T3D2')) || (strcmpi(upper(tok1{2}),'T2D2'))
                                Valid = true;
                            end
                        end
                    end
                end
            end
            
            % Find and process the *NODE block
            
            fid = fopen(filename,'r');
            if fid == -1,
                error('Unable to open specified file.');
            end
            
            nnode = 0;
            node = zeros(chunk,3);
            temp = '';
            while ~strncmpi(temp,'*NODE',5)
                temp = fgetl(fid);   if ~ischar(temp), break, end
            end
            if (~strncmpi(temp,'*NODE',5))
                error(['Got keyword: ', temp, '; Expected *NODE'])
            end
            
            temp = '';
            while true
                nnode = nnode+1;
                temp = fgetl(fid);
                if (strncmpi(temp,'*',1))
                    nnode = nnode-1;
                    break
                end
                A = sscanf(temp, '%g,%g,%g');
                node(nnode,:) = A;
                if (size(node,1) <= nnode)
                    node(size(node,1)+1:size(node,1)+chunk,:) = zeros(chunk,3);
                end
            end
            
            fclose(fid);
            
            % Now find and process all *ELEMENT blocks
            
            fid = fopen(filename,'r');
            if fid == -1,
                error('Unable to open specified file.');
            end
            
            More_data = true;
            while More_data
                % Find the next block
                temp = '';
                while ~strncmpi(temp,'*ELEMENT',8)
                    temp = fgetl(fid);
                    if ~ischar(temp),
                        More_data=~true;
                        break,
                    end
                end
                if (Parse_element_line(temp))
                    % Valid element type
                    nelem = 0;
                    elem =  [];
                    temp = '';
                    while true
                        nelem = nelem+1;
                        temp = fgetl(fid);
                        if (isempty(elem))
                            All  = sscanf(temp, '%d,',inf);
                            if (length(All)-1 ~= 2)
                                error('Wrong number of data items for an element');
                            end
                            elem = zeros(chunk,3);
                        end
                        if (strncmpi(temp,'*',1))
                            nelem = nelem-1;
                            break
                        end
                        A = sscanf(temp, '%d,',inf);
                        elem(nelem,:) = A';
                        if (size(elem,1) <= nelem)
                            elem(size(elem,1)+1:size(elem,1)+chunk,:) = zeros(chunk,ennod+1);
                        end
                    end
                end
            end
            
            fclose(fid);
            
            
            % Process output arguments
            % Extract coordinates
            if (norm((1:nnode)'-node(1:nnode,1)))
                error('Nodes needs to be given in serial order')
            end
            X = node(node(1:nnode,1),2:3);
            
            % Cleanup element connectivities
            kconn = elem(1:nelem,2:end);
            
        end
        
        function Abaqus_export(filename, X, kconn)
            % Export 2D truss mesh to an Abaqus .INP file.
            %
            % MaDS.Abaqus_export(filename, X, kconn)
            %
            
            % %             Example of such a file:
            % *Heading
            % *Part, name=Part-1
            % *Node
            %       1,       -2.875,         2.25
            %       2,          1.5,         2.25
            %       3,       -0.375,          -1.
            %       4,           4.,          -1.
            %       5,        -4.75,          -1.
            % *Element, type=T2D2
            % 1, 1, 2
            % 2, 3, 2
            % 3, 4, 3
            % 4, 2, 4
            % 5, 5, 1
            % 6, 1, 3
            % 7, 3, 5
            % *Nset, nset=Set-1
            %  1, 2, 4, 5
            % *Elset, elset=Set-1
            %  1, 4, 5
            % *Nset, nset=Set-2, generate
            %  1,  5,  1
            % *Elset, elset=Set-2
            %  2, 3, 6, 7
            % ** Section: Section-upper
            % *Solid Section, elset=Set-1, material=SteelSI(m)
            % 0.01,
            % ** Section: Section-upper
            % *Solid Section, elset=Set-2, material=SteelSI(m)
            % 0.01,
            % *End Part
            % **
            % **
            % ** ASSEMBLY
            % **
            % *Assembly, name=Assembly
            % **
            % *Instance, name=Part-1-1, part=Part-1
            % *End Instance
            % **
            % *Nset, nset=Set-1, instance=Part-1-1
            %  4,
            % *Nset, nset=Set-2, instance=Part-1-1
            %  5,
            % *Nset, nset=Set-3, instance=Part-1-1
            %  1, 2
            % *End Assembly
            % **
            % ** MATERIALS
            % **
            % ** Mechanical and thermal properties of steel, units: SI (m)
            % *Material, name=SteelSI(m)
            % *Conductivity
            % 45.,
            % *Density
            % 7850.,
            % *Elastic
            %  2.09e+11, 0.3
            % *Expansion
            %  1.3e-05,
            % *Specific Heat
            % 1200.,
            % ** ----------------------------------------------------------------
            % **
            % ** STEP: Step-1
            % **
            % *Step, name=Step-1, nlgeom=NO, perturbation
            % *Constant
            % **
            % ** BOUNDARY CONDITIONS
            % **
            % ** Name: BC-pin Type: Displacement/Rotation
            % *Boundary
            % Set-1, 1, 1
            % Set-1, 2, 2
            % ** Name: BC-roller Type: Displacement/Rotation
            % *Boundary
            % Set-2, 2, 2
            % **
            % ** LOADS
            % **
            % ** Name: Load-upper   Type: Concentrated force
            % *Cload
            % Set-3, 2, -3.
            % **
            % ** OUTPUT REQUESTS
            % **
            % **
            % ** FIELD OUTPUT: F-Output-1
            % **
            % *Output, field, variable=PRESELECT
            % **
            % ** HISTORY OUTPUT: H-Output-1
            % **
            % *Output, history, variable=PRESELECT
            % *End Step
            
            [pathstr, name, ext] = fileparts(filename) ;
            if (isempty(pathstr)),pathstr  = '.'; end
            
            fid = fopen(filename,'r');
            if fid == -1,
                error('Unable to open specified file.');
            end
            
            printf('*Heading\n');
            printf('*Part, name=Part-1\n');
            printf('*Node\n');
            for j = 1:size(X, 1)
                printf('%d, %g, %g\n', j, X(j, :))
            end
            
            printf('*Element, type=T2D2\n');
            for j = 1:size(kconn, 1)
                printf('%d, %d, %d\n', j, kconn(j, :))
            end
            
            printf('*Elset, elset=Set-2\n');
            printf('2, 3, 6, 7\n');
            
            
            printf('*Solid Section, elset=Set-2, material=SteelSI(m)\n');
            printf('0.01,\n');
            printf('*End Part\n');
            printf('*Assembly, name=Assembly\n');
            printf('*Instance, name=Part-1-1, part=Part-1\n');
            printf('*End Instance\n');
            printf('*Nset, nset=Set-1, instance=Part-1-1\n');
            printf(' 4,\n');
            printf('*End Assembly\n');
            printf('*Material, name=%s\n', materialname);
            printf('*Density\n');
            printf('%g,\n', rho);
            printf('*Elastic\n');
            printf('%g, %g\n', E, nu);
            printf('*Step, name=Step-1, nlgeom=NO, perturbation\n');
            printf('*Constant\n');
            % **
            % ** BOUNDARY CONDITIONS
            % **
            % ** Name: BC-pin Type: Displacement/Rotation
            % *Boundary
            % Set-1, 1, 1
            % Set-1, 2, 2
            % ** Name: BC-roller Type: Displacement/Rotation
            % *Boundary
            % Set-2, 2, 2
            % **
            % ** LOADS
            % **
            % ** Name: Load-upper   Type: Concentrated force
            % *Cload
            % Set-3, 2, -3.
            
            printf('*Output, field, variable=PRESELECT\n');
            printf('*Output, history, variable=PRESELECT\n');
            printf('*End Step\n');
            fclose(fid);
            
        end
        
    end
    
end
