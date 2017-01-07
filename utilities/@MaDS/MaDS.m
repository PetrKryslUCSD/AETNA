classdef MaDS
    % MaDS: Mass-Damper-Spring Linear Model Solver
    %
    % Example of use: see the MaDS.demo() method
    %
    % Note: All methods need to be called by referencing the class MaDS,
    %       as for instance
    %            MaDS.demo()
    %       or
    %            K=MaDS.stiffness(X,k,kconn,dof)
    
    methods (Static, Access = public) % Demo
        
        function demo()
        % Undamped vibration problem, with animation.
        %
        % MaDS.demo()
        %
        % This is the problem of three carriages that is solved in the textbook.
            m= 1.3;  k = 61;   c =0; % Mass, stiffness, damping parameters
            X=[0,-0.5; 0,0; 0,0.5; 0,1.0];% Locations of joints
            kconn=[1,2; 2,3; 3,4];% Which joints are connected by springs
            k=[61, 61, 61];% Spring constants
            m=[0, 1.3, 1.3, 1.3];%  Joint masses
            dof=[7,8; 4,1; 5,2; 6,3];% Definition of the degrees of freedom: 
            % each  joint can move in the X direction and in the Y
            % direction, so it has 2 degrees of freedom. The free degrees
            % of freedom are 1,2,3; then we number the degrees of freedom
            % that are fixed at value  0.0.
            nfreedof=3;% How many  unknown degrees of freedom?
            
            % Check the input data
            MaDS.sanity_check(X,k,m,[],kconn,[],dof,nfreedof);
            % Construct the stiffness matrix
            K=MaDS.stiffness(X,k,kconn,dof);
            % Construct the mass matrix
            M=MaDS.mass(X,m,dof);
            % Solve the generalized eigenvalue problem for the mode shapes (V) and
            % natural frequencies (diagonal of D)
            [V,D]=eig(K(1:nfreedof,1:nfreedof),M(1:nfreedof,1:nfreedof));
            disp( [ 'Frequencies =', num2str(sqrt(diag(D)')/2/pi) ])
            
            % Visualize the results
            Mode= 1;
            omega=sqrt(D(Mode,Mode));% angular frequency of the selected  mode
            Tn=2*pi/abs(omega);% period  of the selected mode
            dX=0*X; % this will hold the joint displacements
            freedofix= find(dof<=nfreedof);% indexes of the free degrees of freedom
            dX(freedofix)=V(dof(freedofix),Mode);% distribute the mode shape displacements to the joints
            % Some visualization parameters
            JointRadius= 8; SpringWidth= 0.8; scale=  0.3;
            extrad=scale*max(abs(V(:,Mode)));
            xrange=[min(X(:,1))-extrad,max(X(:,1))+extrad];
            yrange=[min(X(:,2))-extrad,max(X(:,2))+extrad];
            % Make a figure and retrieve the axes
            f=figure;
            ax=gca;
            for t=linspace(0,4*Tn,150) % these are the time instants to display the shape
                try, figure(f); cla; % if we still have the figure, clear the axes;
                catch, % otherwise we are done
                    break, end
                xscale=sin(omega*t);
                SimPl.draw_extents(ax,xrange,yrange);
                SimPl.draw_joints(ax,X,JointRadius,0.7*[1,1,1]);
                SimPl.draw_springs(ax,X+xscale*scale*dX,kconn,SpringWidth,0.7*[1,0,0], true)
                SimPl.draw_joints(ax,X+xscale*scale*dX,JointRadius,0.7*[1,0,0]);
                drawnow;
                pause( 0.01 );
            end
        end
        
    end
    
    methods (Static, Access = public) % Modeling methods
        
        function sanity_check(X,k,m,c,kconn,cconn,dof,nfreedof)
            % Sanity checks for a system of springs connecting joints.
            %
            % MaDS.sanity_check(X,k,m,c,kconn,cconn,dof,nfreedof)
            %
            % X= array of joint coordinates, one row per joint
            % k= array of spring stiffnesses,  one stiffness coefficient per spring
            % m= array of concentrated masses at joints,  one mass coefficient
            %      per joint; if supplied as empty  (such as for statics), this
            %      argument is not checked.
            % c= array of damper coefficients,  one stiffness coefficient per damper;
            %      if supplied as empty  (such as for statics), this
            %      argument is not checked.
            % kconn= which  joints are connected by the spring? array of two joint
            %      numbers, one row per spring
            % cconn= which  joints are connected by the damper? array of two joint
            %      numbers, one row per damper; if supplied as empty  (such as for
            %      statics), this argument is not checked.
            % dof= array of degree of freedom numbers, one row per joint
            %
            % Error is reported when the data is not consistent.
            
            if (size(X,1)<2)
                error('Need more than one joint')
            end
            
            if (size(X,2)~=2)
                error('The geometry needs to be described in two dimensions: X is the wrong dimension')
            end
            
            if (size(X)~=size(dof))
                error('The degree of freedom array not the same size as the location array X')
            end
            
            if (~isempty(m)) % Checked only for dynamics
                if (length(m)~=size(X,1))
                    error('Need precisely one mass coefficient per joint: m is the wrong dimension')
                end
            end
            
            if (~isempty(kconn)) % Only if springs are present
                if (size(kconn,2)~=2)
                    error('Each spring needs to link two joints: kconn is the wrong dimension')
                end
                
                if (size(kconn,1)~=length(k))
                    error('Each spring needs to have a stiffness: k is the wrong dimension')
                end
            end
            
            if (~isempty(cconn)) % Only if dampers are present
                if (size(cconn,2)~=2)
                    error('Each damper needs to link two joints: cconn is the wrong dimension')
                end
                
                if (size(cconn,1)~=length(c))
                    error('Each spring needs to have a stiffness: c is the wrong dimension')
                end
            end
            
            jc=zeros(size(X,1),1);
            if (~isempty(kconn))
                jc(kconn(:))=1;
            end
            if (~isempty(cconn))
                jc(cconn(:))=1;
            end
            if (~isempty(find(jc==0)))
                error('Each joint needs to be connected by spring or damper')
            end
            
            if sum(abs((sort(dof(:))-(1:prod(size(dof)))')))~=0
                error('The degrees of freedom must be between 1 and number of joints times 2')
            end
            
            if (nfreedof>prod(size(dof)))
                error('The number of free degrees of freedom must be between 1 and number of joints times 2')
            end
            
            
            
        end
        
        function F=applied_forces(AppliedF,dof)
            % Compute the a vector of the applied loads for a system of springs.
            %
            % F=MaDS. applied_forces(AppliedF,dof,nfreedof)
            %
            % AppliedF= array of force components, one row per joint
            % dof= array of degree of freedom numbers, one row per joint
            %
            % F= force vector, in length equal to the dimension of the
            %      space times the number of joints.
            F =zeros(prod(size(dof)),1);
            % Add the applied forces
            for ii  =1:size(AppliedF,1)
                for  mm =1:2
                    d=dof(ii,mm);
                    F(d)= F(d) + AppliedF(ii,mm);
                end
            end
        end
        
        function K=stiffness(X,k,kconn,dof)
            % Compute the stiffness matrix  of a system of springs.
            %
            % K=MaDS.stiffness(X,k,kconn,dof)
            %
            % X= array of joint coordinates, one row per joint
            % k= array of spring stiffnesses,  one stiffness coefficient per spring
            % kconn= which  joints are connected by the spring? array of two joint
            %      numbers, one row per spring
            % dof= array of degree of freedom numbers, one row per joint
            %
            % K= stiffness matrix, square matrix in size equal to the dimension of the
            % space times the number of joints.
            
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            K=zeros(size(X,1)*size(X,2));
            % Now  loop over all the springs
            for j=1:size(kconn,1)
                % Length of the spring
                L=MaDS.len(X(kconn(j,:),:));
                % Construct the transformation matrix from the projections of the
                % spring onto the Cartesian axes
                ds=MaDS.delt(X(kconn(j,:),:))/L;
                B=[-ds,ds];
                % The stiffness matrix  of a single spring.  Transform the
                % local-coordinate stiffness matrix to the global-coordinate spring
                % stiffness matrix.
                K_e = B'*( k(j) )*B;
                % The degrees of freedom connected by the spring
                edof=[dof(kconn(j,1),:),dof(kconn(j,2),:)];
                % Assemble the spring stiffness to the structural stiffness matrix
                K(edof,edof)= K(edof,edof)+K_e;
            end
        end
        
        function C=damping(X,c,cconn,dof)
            % Compute the damping matrix  of a system of viscous dampers.
            %
            % C=MaDS.damping(X,c,cconn,dof)
            %
            % X= array of joint coordinates, one row per joint
            % c= array of damper constants,  one damping coefficient per damper
            % cconn= which  joints are connected by the damper? array of two joint
            %      numbers, one row per spring
            % dof= array of degree of freedom numbers, one row per joint
            %
            % C= damping matrix, square matrix in size equal to the dimension of the
            % space times the number of joints.
            
            
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            C=zeros(size(X,1)*size(X,2));
            % Now  loop over all the springs
            for j=1:size(cconn,1)
                % Length of the spring
                L=MaDS.len(X(cconn(j,:),:));
                % Construct the transformation matrix from the projections of the
                % spring onto the Cartesian axes
                ds=MaDS.delt(X(cconn(j,:),:))/L;
                B=[-ds,ds];
                % The stiffness matrix  of a single spring.  Transform the
                % local-coordinate stiffness matrix to the global-coordinate spring
                % stiffness matrix.
                C_e = B'*( c(j) )*B;
                % The degrees of freedom connected by the spring
                edof=[dof(cconn(j,1),:),dof(cconn(j,2),:)];
                % Assemble the spring stiffness to the structural stiffness matrix
                C(edof,edof)= C(edof,edof)+C_e;
            end
        end
        
        function M=mass(X,m,dof)
            % Compute the mass matrix for a system of springs and joints.
            %
            % M=MaDS.mass(X,m,dof)
            %
            % X= array of joint coordinates, one row per joint
            % m= array of concentrated masses at joints,  one mass coefficient
            %      per joint
            % dof= array of degree of freedom numbers, one row per joint
            %
            % M= mass matrix, square matrix in size equal to the dimension of the
            %      space times the number of joints.
            
            I=eye(2);
            % Allocate the stiffness matrix in size equal to the dimension of the
            % space times the number of joints.
            M=zeros(size(X,1)*size(X,2));
            % Now  loop over all the joints
            for j=1:size(X,1)
                % The degrees of freedom associated with a joint
                edof=[dof(j,:)];
                % Assemble the spring mass to the structural stiffness matrix
                M(edof,edof)= M(edof,edof)+m(j)*I;
            end
        end
        
        function u=scatter_vector(U,dof)
            % Create an array of joint displacements from a displacement vector.
            %
            % u=MaDS.scatter_vector(U,dof)
            %
            % U= array of displacements, one value per row, a single column
            % dof= array of degree of freedom numbers, one row per joint
            %
            % Output:
            % u= displacement array, one row per joint
            
            % The displaced positions of the joints are represented by an
            % array of the same shape as X.
            u=zeros(size(dof));
            % The components of the vector U now need to be added into the
            % correct places in the array Xdeformed. First we find the
            % locations of the free degrees of freedom.
            nfreedof=length(U);
            freedofix= find(dof<=nfreedof);
            % The above call to the find() function treats the dof array as
            % one-dimensional: first column 1, then column 2, all
            % concatenated  into one long array.  The array of the indexes
            % freedofix points into the array dof.
            u(freedofix)= U(dof(freedofix));
        end
        
        
    end
    
    methods (Static, Access = public) % General geometry helpers
        
        % Compute the components of the oriented vector from the first to the
        % second joint on each spring
        %
        % d=MaDS.delt(x)
        %
        % x= array of coordinates of the joints connected by the spring, one row per joint
        function  d=delt(x)
            d =diff(x);
        end
        
        % Compute the length of the spring  as the distance between the two joints the spring connects.
        %
        % L=MaDS.len(x)
        %
        % x= array of coordinates of the joints connected by the spring, one row per joint
        function  L=len(x)
            L=sqrt(sum(MaDS.delt(x).^2));
        end
        
        % Compute the elongation of the spring.
        %
        % dL=MaDS.elong(x,u)
        %
        % x= array of coordinates of the joints connected by the spring, one row per joint
        % u= array of displacements of the joints connected by the spring, one row per joint
        %
        % The elongation is the change in length of the spring (positive
        % for the spring getting longer), negative for tthe spring getting
        % shorter) and it is caused by the displacements of the joints.
        function  dL=elong(x,u)
            del=MaDS.delt(x);
            L=sqrt(sum(del.^2));
            dL=(del/L)*(u(2,:)-u(1,:))';
        end
         
        
    end
    
end

