function results = tower_statics_only
    % Optimization of truss tower: static load, elastic response constraint,
    % minimization of mass. Lower bound on the cross section.
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
    DV0 = zeros(28, 1) + 1e-6;% MODIFY
    % lower bounds on the design variables
    lb = DV0;% MODIFY
    % upper bounds on the design variables
    ub = zeros(size(DV0)) + inf;% MODIFY
    
    % MODIFY
    % Now we will have to modify the function structural_solver() below
    % to suit our purpose. We have to decide what we need to compute,
    % calculate it inside this function and return it as a struct. When we
    % are done, we can return here.

    % First we calculate the initial mass of the structure.
    results = structural_solver(DV0, DV0);
    initial_mass = results.current_mass;
    % Now we define the function to calculate the current value of the OF.
    % The objective function is normalized.
    function OF = objf(DV)
        results = structural_solver(DV0, DV);
        OF = results.current_mass / initial_mass;
    end
    
    % Calculate the values of the constraints. Use non-dimensional
    % numbers for the constraints for good scaling and accuracy.
    function [c, ceq] = nonlcon(DV)
        % In our situation we have no inequality constraints: leave this empty.
        ceq = [];
        % Evaluate the current solution and use the results to define the
        % inequality constraints.
        results = structural_solver(DV0, DV);
        c = abs(results.axial_forces) ./ results.N_yield - 1; 
    end
    
    % Run the optimizer. 
    format long
    options = optimoptions('fmincon','Display','iter');
    DV = fmincon(@objf, DV0, [], [], [], [], lb, ub, @nonlcon, options)
    % Return the results of the structural solver calculation with the
    % final values of the design variables.
    results = structural_solver(DV0, DV, true)
end

%
% ==========================================================================
% FUNCTIONS

function results = structural_solver(DV0, DV, graphics)
    % Solver of the truss-structure system.
    %
    % results = structural_solver(Design_variables)
    %
    % Returns
    % results = structure with objective function value and the values of
    %   the constraints
 
    if ~exist('graphics', 'var')
        graphics = 0;
    end

    % MODIFY in some places below

    % Basic material data.
    rho = 7850;% MODIFY
    E = 2.1e11;% MODIFY
    sigma_y = E / 1000;
    
    % Geometry and topology data.
    % Locations of joints
    X = [   
   1.000000000000000   9.000000000000000
   1.500000000000000   7.000000000000000
   2.000000000000000   5.000000000000000
   1.000000000000000   2.000000000000000
  -1.000000000000000   2.000000000000000
  -4.000000000000000                   0
  -3.000000000000000   2.000000000000000
                   0   7.000000000000000
  -1.000000000000000   9.000000000000000
  -1.500000000000000   7.000000000000000
  -2.000000000000000   5.000000000000000
   3.000000000000000   2.000000000000000
                   0   4.000000000000000
   4.000000000000000                   0
                   0  10.000000000000000];% MODIFY
    % Connectivity of the structure.
    kconn = [
     1     2
     2     3
     4     3
     5     4
     6     5
     7     6
     7     5
     1     8
     9     8
    10     9
    10    11
    11     8
     8     3
     8     2
     3    12
     3    13
    13     4
     4    14
    14    12
    12     4
     5    13
     5    11
    11     7
     9     1
    15     1
    15     9
     8    10
    13    11];% MODIFY
    
    % Degree of freedom data.
    % Array of degrees of freedom
    [dof, nfreedof] = MaDS.dofs(size(X, 1), [6, MaDS.FIX_X + MaDS.FIX_Y; 14, MaDS.FIX_X + MaDS.FIX_Y]);
    
    % Loading data.
    motor_mass = 5000;
    AppliedF = zeros(size(X, 1), 2);% MODIFY
    AppliedF(15, 2) = -9.81 * motor_mass;
    
    % Extract the design variables.
    % The individual design variables need to be extracted from the array
    % Design_variables.
    area = @(i) DV(i);
    
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
    if (graphics)
        ForceScaling = 0.00004;
        SpringWidth = sqrt(DV) ./ max(DV) .* 0.1;
        MaDS.plot_structure(X, kconn, dof, nfreedof, AppliedF, ForceScaling, MaDS.SpringColor, MaDS.NumberOffset, MaDS.TextSize, SpringWidth);
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
    results.axial_forces = N;
    results.N_yield = zeros(length(N), 1);
    for  i = 1:size(kconn, 1)
        results.N_yield(i) = area(i) * sigma_y;
    end
    
end % structural_solver
