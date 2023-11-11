function truss_contact
    % Tutorial for the Mass-Damper-Spring (MadS) solver: Optimization
    % solution of a contact problem.
    %
    % For all the variables (such as the arrays below) one can find
    % reference in the MaDS file. Try to use the right mouse button on the word
    % MaDS, and select Help on "MaDS".
    %
    % This is the main function. Simply run.

    % Get the problem data.
    [X, kconn, dof, nfreedof, AppliedF, A, E, rho, maxdeflection, constrained_joint] = data();
    
    % Design variables: original values
    DV0 = zeros(nfreedof, 1);
    % lower bounds on the design variables
    lb = [];
    % upper bounds on the design variables
    ub = [];
    
    % Compute the original performance.
    results0 = structural_solver(DV0, DV0);
    
    % Now we define the function to calculate the current value of the OF.
    function OF = objf(DV)
        results = structural_solver(DV0, DV);
        OF = results.TE;
    end
    
    % Calculate the values of the constraints. Use non-dimensional
    % numbers for the constraints for good scaling and accuracy.
    function [c, ceq] = nonlcon(DV)
        % In our situation we have no inequality constraints: leave this empty.
        ceq = [];
        % Evaluate the current solution and use the results to define the
        % inequality constraints.
        results = structural_solver(DV0, DV);
        c = (-results.deflection / maxdeflection - 1);
    end
    
    % Run the optimizer
    format long
    options = optimoptions('fmincon','Display','iter');
    DV = fmincon(@objf, DV0, [], [], [], [], lb, ub, @nonlcon, options)
    DV(dof(constrained_joint, 2))
    results = structural_solver(DV0, DV);
    % Display the original performance data
    
    % Plot the Structure
    draw_structure(DV)

    % These are the nested functions used by the main function.

    function [X, kconn, dof, nfreedof, AppliedF, A, E, rho, maxdeflection, constrained_joint] = data()
        % Truss cantilever data.
        % coordinates of the joints
        X = [0 0; 4 0; 8 0; 12 0; 16 0; ...
            0 3; 4 3; 8 3; 12 3; 16 3]*1000;% mm
        % Connectivity of the structure. Which joints are linked by the bars?
        kconn = [1 6; 2 7; 3 8; 4 9; 5 10; 1 2; 2 3; 3 4; 4 5; 6 7; 7 8; 8 9; 9 10; 1 7; 2 8; 3 9; 4 10];
        E= 70000;% Young's modulus:  aluminum, MPa
        rho=2.700e-9;% mass density, 1000*kg/mm^3

        % Degree of freedom data.
        % Array of degrees of freedom
        [dof, nfreedof] = MaDS.dofs(size(X, 1), [1, MaDS.FIX_X + MaDS.FIX_Y; 6, MaDS.FIX_X + MaDS.FIX_Y]);
        
        W = 10000; % Live load, N
        % Loading data.
        AppliedF = zeros(size(X, 1), 2);
        AppliedF([7, 8, 9, 10], 2) = -W;

        % cross-sectional areas mm^2
        A = zeros(size(kconn,1),1)+pi*60*7;

        % Performance parameters
        maxdeflection = 100; %mm, Maximum deflection magnitude
        constrained_joint = [4, 5];
    end

    function results = structural_solver(DV0, DV)
        % Solver of the truss-structure system.
        %
        % results = structural_solver(Design_variables)
        %
        % Returns
        % results = structure with objective function value and the values of
        %   the constraints

        [X, kconn, dof, nfreedof, AppliedF, A, E, rho, maxdeflection, constrained_joint] = data();

        % The stiffnesses of the truss members probably depend on the design
        % variables: recalculate them.
        k = zeros(size(kconn, 1));
        for i = 1:size(kconn, 1)
            k(i) = E * A(i) / MaDS.len(X(kconn(i, :), :));
        end
        
        % Compute the stiffness matrix and the load vector
        K = MaDS.stiffness(X, k, kconn, dof);
        K = K(1:nfreedof, 1:nfreedof); % free-free stiffness matrix
        F = MaDS.applied_forces(AppliedF, dof);
        F = F(1:nfreedof); % loads on the free degrees of freedom

        % The solution of the equilibrium equations is a vector of displacements
        % only for the free degrees of freedom:
        U = DV;
        
        % Animation of the optimization process: uncomment to see it. Beware:
        % makes the computation SLOW.
        %         draw_structure(DV); pause(0.01)

        results.TE = 1/2*U'*K*U - U'*F;
        results.deflection = U(dof(constrained_joint, 2));
    end % structural_solver

    % Draw the structure
    function draw_structure(DV)

        [X, kconn, dof, nfreedof, AppliedF, A, E, rho, maxdeflection, constrained_joint] = data();
        u = MaDS.scatter_vector(DV, dof);

        ForceScaling = 0.2; NumberOffSet = 1000*[0.5, -0.35]; TextSize = 16;
        MaDS.plot_structure(X, kconn, dof, nfreedof, AppliedF, ForceScaling, NumberOffSet, TextSize);
        scale = 50;         
        MaDS.plot_deformed_structure(X, kconn, dof, nfreedof, u, scale);
        fig2eps(['trust_contact_' num2str(maxdeflection)  '.eps'])
    end
end
