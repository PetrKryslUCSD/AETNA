function results = tower_vibration_only
    % Optimization of truss tower: constraint on the smallest vibration
    % frequency. Minimization of total mass.
    %
    % The places where input data needs to be supplied or where something
    % needs to be computed are indicated with "% MODIFY".
    
    % In other places the calculation may be optional, which will be indicated
    % with "% OPTIONAL".
    %
    % For all the variables (such as the arrays below) one can find
    % reference in the MaDS file. Try to use the right mouse button on the word
    % MaDS, and select Help on "MaDS".
    
    minimum_frequency = 10;
    
    % lower bounds on the design variables
    lb = zeros(28, 1) + 1e-6;% MODIFY
    % Design variables: initial values
    DV0 = 1000 * lb;% MODIFY
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
        c = 1 - min(results.frequencies) / minimum_frequency;
    end

    % Run the optimizer
    format long
    options = optimoptions('fmincon','Display','iter', 'MaxFunctionEvaluations', 60000);
    DV = fmincon(@objf, DV0, [], [], [], [], lb, ub, @nonlcon, options)
    structural_solver(DV0, DV, true)
    % Return the results of the structural solver calculation with the
    % final values of the design variables.
    results = structural_solver(DV0, DV, true)
end

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
    m=zeros(size(X,1),1);
    for  i =1:size(kconn)
        m(kconn(i,:))=m(kconn(i,:))+rho*area(i)*MaDS.len(X(kconn(i,:),:))/2;
    end
    m(15) = m(15) + motor_mass;
    
    % Compute the stiffness matrix and the load vector
    K = MaDS.stiffness(X, k, kconn, dof);
    K = K(1:nfreedof, 1:nfreedof); % free-free stiffness matrix
    M = MaDS.mass(X, m, dof);
    M = M(1:nfreedof, 1:nfreedof); % free-free mass matrix
    
    % Solve the free vibration problem
    [V,D]=eig(K(1:nfreedof,1:nfreedof), M(1:nfreedof,1:nfreedof));
    [~,ix]=sort(diag(D));
    D=D(ix,ix); V=V(:,ix);
    frequencies = sqrt(diag(D)) / (2*pi);
    
    % % OPTIONAL
    %     If desired, use the block below to display the deformation of the
    % structure.
    if (graphics)
        SpringWidth = sqrt(DV) ./ max(DV) .* 0.5;
        scale = 1.0;
        mode = 1;
        MaDS.plot_structure(X, kconn, dof, nfreedof, AppliedF, 0.0, MaDS.SpringColor, MaDS.NumberOffset, MaDS.TextSize, SpringWidth);
        MaDS.plot_deformed_structure(X, kconn, dof, nfreedof, MaDS.scatter_vector(V(:, mode),dof), scale, [0, 0, 0]);
    end
    
    % Compute the total mass of the structure as currently  defined by the
    % values of the design variables.
    CurrentMass = 0.0;
    for  i  = 1:size(kconn, 1)
        CurrentMass = CurrentMass + rho * area(i) * MaDS.len(X(kconn(i, :), :));
    end
    
    results.current_mass = CurrentMass;
    results.frequencies = frequencies;
end % structural_solver
