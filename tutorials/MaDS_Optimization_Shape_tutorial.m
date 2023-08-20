% This tutorial shows how to set up an optimization problem to minimize the
% mass of a truss structure, while satisfying constraints on a static
% deflection and the minimum frequency of vibration.

% For all the variables (such as the arrays below) one can find
% reference in the MaDS file. Try to use the right mouse button on the word
% MaDS, and select Help on "MaDS".

function MaDS_Optimization_Shape_tutorial
    % Tutorial for the Mass-Damper-Spring (MadS) solver: Optimization of shape.
    %
    % This is the main function. Simply run.
    
    % Get the problem data.
    [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, lowestfreq] = data;
    
    % Design variables: original values
    DV0 = [X(3, :), X(4, :)];
    % lower bounds on the design variables
    lb = [];
    % upper bounds on the design variables
    ub = [];
    
    % Compute the original performance.
    results0 = structural_solver(DV0, DV0);
    
    % Now we define the function to calculate the current value of the OF.
    function OF = objf(DV)
        results = structural_solver(DV0, DV);
        OF = results.current_mass / results0.current_mass;
    end
    
    % Calculate the values of the constraints. Use non-dimensional
    % numbers for the constraints for good scaling and accuracy.
    function [c, ceq] = nonlcon(DV)
        % In our situation we have no inequality constraints: leave this empty.
        ceq = [];
        % Evaluate the current solution and use the results to define the
        % inequality constraints.
        results = structural_solver(DV0, DV);
        c = [-(maxtipd-abs(results.tipd'))/maxtipd, (lowestfreq-results.frequency) / lowestfreq];
    end
    
    % Run the optimizer
    format long
    options = optimoptions('fmincon','Display','iter');
    DV = fmincon(@objf, DV0, [], [], [], [], lb, ub, @nonlcon, options)
    results = structural_solver(DV0, DV);
    % Display the original performance data
    results0.tipd
    results0.frequency
    % Displayed the optimized performance data
    results.tipd
    results.frequency
    % Plot the Structure
    draw_structure(DV)

    % These are the nested functions used by the main function.

    function [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
            maxtipd, lowestfreq] = data()
        % Truss cantilever data.
        % coordinates of the joints
        X = [7.0, 2.5; ...
            6., 3.5; ...
            7.0, -1.0; ...
            6.0, 1.5; ...
            0, -1; ...
            0, 1.5]*1000;% mm
        % Connectivity of the structure. Which joints are linked by the bars?
        kconn = [5,3;3,1;6,4;4,2;1,2;3,4;1,4;3,6];
        E= 70000;% Young's modulus:  aluminum, MPa
        rho=2.700e-9;% mass density, 1000*kg/mm^3

        % Degree of freedom data.
        % Array of degrees of freedom
        dof = [1, 2; 3, 4; 5, 6; 7, 8; 9, 10; 11, 12];
        nfreedof = 8; % number of free degrees of freedom;

        W = 6000; % Live load, N
        % Loading data.
        AppliedF = [0, -W; 0, -W; 0, 0; 0, 0; 0, 0];

        % cross-sectional areas mm^2
        A = zeros(size(kconn,1),1)+pi*60*7;

        addM = 0.096;% additional mass, 1000*kg
        addMidx = 1;%  Mass at which joints?

        % Performance parameters
        maxtipd = 10;%mm, Maximum deflection magnitude
        lowestfreq =13; % Hertz
    end

    function results = structural_solver(DV0, DV)
        % Solver of the truss-structure system.
        %
        % results = structural_solver(Design_variables)
        %
        % Returns
        % results = structure with objective function value and the values of
        %   the constraints

        [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
            maxtipd, lowestfreq] = data();

        % Extract the design variables.
        % The individual design variables need to be extracted from the array
        % Design_variables.
        X(3, :) = DV(1:2);
        X(4, :) = DV(3:4);

        % The stiffnesses of the truss members probably depend on the design
        % variables: recalculate them.
        k = zeros(size(kconn, 1));
        for i = 1:size(kconn, 1)
            k(i) = E * A(i) / MaDS.len(X(kconn(i, :), :));
        end
        m = zeros(size(X, 1), 1);
        for i = 1:size(kconn, 1)
            for j = kconn(i, :);
                m(j) = m(j) + rho * A(i) * MaDS.len(X(kconn(i, :), :)) / 2;
            end
        end
        % Add additional mass
        m(addMidx) = m(addMidx) + addM;

        % Compute the stiffness matrix and the load vector
        K = MaDS.stiffness(X, k, kconn, dof);
        K = K(1:nfreedof, 1:nfreedof); % free-free stiffness matrix
        F = MaDS.applied_forces(AppliedF, dof);
        F = F(1:nfreedof); % loads on the free degrees of freedom

        % The solution of the equilibrium equations is a vector of displacements
        % only for the free degrees of freedom:
        U = K\F;
        % Array of joint displacements
        u = MaDS.scatter_vector(U, dof);

        M = MaDS.mass(X, m, dof);
        M = M(1:nfreedof, 1:nfreedof); % free-free stiffness matrix
        [V,D] = eig(K, M);% Solve the eigenvalue problem
        frequency = min(sqrt(diag(D))/2/pi);

        % Compute the total mass of the structure as currently  defined by the
        % values of the design variables.
        CurrentMass = 0.0;
        for  i  = 1:size(kconn, 1)
            CurrentMass = CurrentMass + rho * A(i) * MaDS.len(X(kconn(i, :), :));
        end

        % OPTIONAL: If you think you will be using the internal forces in the truss
        % members, here is how to compute them:
        %     N = zeros(size(kconn, 1), 1);
        %     for  i = 1:size(kconn, 1)
        %         N(i) = k(i)*MaDS.elong(X(kconn(i, :), :), u(kconn(i, :), :));
        %     end

        % Animation of the optimization process: uncomment to see it. Beware:
        % makes the computation SLOW.
        %         draw_structure(DV); pause(0.01)

        results.current_mass = CurrentMass;
        results.tipd = U(1:4);% Tip deflection
        results.frequency = frequency;
    end % structural_solver

    % Draw the structure
    function draw_structure(DV)

        [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
            maxtipd, Lowestfreq] = tcant_data;
        X(3, :) = DV(1:2);
        X(4, :) = DV(3:4);

        clf; %figure;
        hold on
        set(gca,'Units','centimeter')

        Gray = [1, 1, 1]*0.8;

        All=GPath_group();
        All.group ={};

        Glyph=glyph_rectangle(1000*[1,4],Gray,Gray);
        Glyph =translate (Glyph,[-500,750]);
        All= append(All,Glyph);

        for e=1:size(kconn,1)
            DeltaX=diff(X(kconn(e,:),1));
            DeltaY=diff(X(kconn(e,:),2));
            L= sqrt(DeltaX^2+DeltaY^2);
            Glyph=GPath_polygon([X(kconn(e,:),1),X(kconn(e,:),2)]);
            Glyph.edgecolor ='k';
            Glyph.color = [];
            Glyph.linestyle ='-';
            Glyph.linewidth =2;
            All= append(All,Glyph);
            t1 =GPath_text(sum([X(kconn(e,:),1),X(kconn(e,:),2)])/2-2*[100,100],['' num2str(e)]);
            t1.fontname ='Times';
            t1.fontsize =20;
            t1.fontangle ='italic';
            t1.horizontalalignmkconnt='ckconnter';
            t1.color ='k';
            t1.interpreter='latex';
            All= append(All,t1);
        end

        for i=1:size(X,1)
            Glyph = glyph_circle(200,'r','r');
            Glyph = translate (Glyph,X(i,:));
            All = append(All,Glyph);
            t1 =GPath_text(X(i,:)+3*[100,100],['' num2str(i)]);
            t1.fontname ='Times';
            t1.fontsize =20;
            t1.fontangle ='italic';
            t1.horizontalalignmkconnt='ckconnter';
            t1.color ='k';
            t1.interpreter='latex';
            All= append(All,t1);
        end

        render(All);
        hold on
        axis equal
        % grid on
        axis off

        % fig2eps(['figure_tcant'  '.eps'])
    end
end
