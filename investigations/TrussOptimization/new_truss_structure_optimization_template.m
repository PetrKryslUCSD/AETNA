function truss_structure_optimization_template
% Optimization of truss structure
%
% The places where input data needs to be supplied or where something
% needs to be computed are indicated with "% MODIFY".

% In other places the calculation may be optional, which will be indicated
% with "% OPTIONAL".
%
% For all the variables (such as the arrays below) one can find
% reference in the MaDS file. Try to use the right mouse button on the word
% MaDS, and select Help on "MaDS".
    
    
    
    % Design variables: initial values
    DV0 = [?];% MODIFY
    % lower bounds on the design variables
    lb = [?];% MODIFY
    % upper bounds on the design variables
    ub = [?];% MODIFY
    
    % MODIFY
    % Now we will have to modify the function structural_solver() below
    % to suit our purpose. We have to decide what we need to compute,
    % calculate it inside this function and return it as a struct. When we
    % are done, we can return here.
    
    % MODIFY
    % Define the objective function (OF) value as a relative quantity:
    % calculate the INITIAL value.
    results = structural_solver(DV0, X, kconn, dof, nfreedof, AppliedF, rho, E);
    % Variable results now holds the initial value that we can use to
    % define the OF
    Initial? = results.?;
    
    % MODIFY
    % Now we define the function to calculate the current value of the OF.
    % Then the current OF is the initial value of Y/current value of Y,
    % where Y may be the mass of the structure, the compliance or some
    % other quantity.
    function OF = objf(DV)
        results = structural_solver(DV, X, kconn, dof, nfreedof, AppliedF, rho, E);
        OF = results.? / Initial?;
    end
    
    % MODIFY
    % Divide the values of the constraints. Use non-dimensional
    % numbers for the constraints for good scaling and accuracy.
    function [c, ceq] = nonlcon(DV)
        % In our situation we have no inequality constraints: leave this empty.
        ceq = [];
        % Evaluate the current solution and use the results to define the
        % inequality constraints.
        results = structural_solver(DV, X, kconn, dof, nfreedof, AppliedF, rho, E);
        % MODIFY
        % The constraints should be negative when satisfied, and they should be
        % defined  as non-dimensional numbers.
        c = [?]; % MODIFY
    end
    
    % Run the optimizer
    format long
    options = optimoptions('fmincon','Display','iter');
    DV = fmincon(@objf, DV0, [], [], [], [], lb, ub, @nonlcon, options)
end

%
% ==========================================================================
% FUNCTIONS

function results = structural_solver(Design_variables)
    % Solver of the truss-structure system.
    %
    % results = structural_solver(Design_variables)
    %
    % Returns
    % results = structure with objective function value and the values of
    %   the constraints

    % MODIFY in some places below

    % Basic material data.
    rho = ?;% MODIFY
    E = ?;% MODIFY
    
    % Geometry and topology data.
    % Locations of joints
    X = [?];% MODIFY
    % Connectivity of the structure.
    kconn = [?];% MODIFY
    
    % Degree of freedom data.
    % Array of degrees of freedom
    dof = [?];% MODIFY
    nfreedof = ?;% MODIFY
    
    % Loading data.
    AppliedF = [?];% MODIFY
    
    % Extract the design variables.
    % The individual design variables need to be extracted from the array
    % Design_variables.
    ? = Design_variables;% MODIFY
    
    % The stiffnesses of the truss members probably depend on the design
    % variables: recalculate them.
    k = zeros(size(kconn, 1));
    for i = 1:size(kconn, 1)
        k(i) = E * area(i) / MaDS.len(X(kconn(i, :), :));% MODIFY
    end
    
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
    
    % % OPTIONAL
    %     If desired, use the block below to display the deformation of the
    % structure.
    if (false)
        scale = 100.0;% MODIFY. Multiplying factor for the displacements.
        Xdeformed = X + scale*u;
        f = figure;% Create figure
        ax = gca;% Draw into these axes
        axis equal
        SimPl.draw_springs(X, kconn, MaDS.SpringWidth, MaDS.HintColor)
        SimPl.draw_springs(Xdeformed, kconn, MaDS.SpringWidth, MaDS.SpringColor)
        SimPl.draw_joints(X, MaDS.JointRadius, MaDS.JointColor);
        SimPl.draw_joint_numbers(X, MaDS.NumberColor, 14, [0.05,  0.08])
        freeJoints = dof(:, 1) <= nfreedof & dof(:, 2) <= nfreedof;
        fixedJoints = ~freeJoints;
        SimPl.draw_joints(Xdeformed(freeJoints, :), MaDS.JointRadius, MaDS.JointColor);
        SimPl.draw_joints(Xdeformed(fixedJoints, :), 2*MaDS.JointRadius, MaDS.JointColor);
        labels x y
    end
    
    % Compute the total mass of the structure as currently  defined by the
    % values of the design variables.
    CurrentMass = 0.0;
    for  i  = 1:size(kconn, 1)
        CurrentMass = CurrentMass + rho * area(i) * MaDS.len(X(kconn(i, :), :));
    end
    
    % OPTIONAL: If you think you will be using the internal forces in the truss
    % members, here is how to compute them:
    N = zeros(size(kconn, 1), 1);
    for  i = 1:size(kconn, 1)
        N(i) = k(i)*MaDS.elong(X(kconn(i, :), :), u(kconn(i, :), :));
    end
    
    results.current_mass = CurrentMass;
    % OPTIONAL: Is there anything else you would like to return?
    %     results.axial_forces = N;
    
end % structural_solver
