function truss_cant_sizing_optimization
% Optimization of truss structure

% For all the variables (such as the arrays below) one can find
% reference in the MaDS file. Try to use the right mouse button on the word
% MaDS, and select Help on "MaDS".
     [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, lowestfreq] = tcant_data;

    % Design variables: initial values
    DV0 = A;
    % lower bounds on the design variables
    lb = A / 10;% MODIFY
    % upper bounds on the design variables
    ub = [];% MODIFY

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
    disp(['Current: ' 'Mass=' num2str(results.current_mass)])
    disp(['Current: ' 'Displacements=' num2str(results.tipd')])
    disp(['Current: ' 'Frequency=' num2str(results.frequency)])
    disp(['Initial: ' 'Mass=' num2str(results0.current_mass)])
    disp(['Initial: ' 'Displacements=' num2str(results0.tipd')])
    disp(['Initial: ' 'Frequency=' num2str(results0.frequency)])
    tcant_draw(DV)
end

%
% ==========================================================================
% FUNCTIONS

function results = structural_solver(DV0, DV)
    % Solver of the truss-structure system.
    %
    % results = structural_solver(Design_variables)
    %
    % Returns
    % results = structure with objective function value and the values of
    %   the constraints

     [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, lowestfreq] =tcant_data;

    % Extract the design variables.
    A = DV;
    
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
      %  tcant_draw(DV); pause(0.01)

    results.current_mass = CurrentMass;
    results.tipd = U(1:4);% Tip deflection
    results.frequency = frequency;
end % structural_solver

% Truss cantilever data
function [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, lowestfreq] = tcant_data
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
    dof = [1, 2; 3, 4; 5, 6; 7, 8; 9, 10; 11, 12];% MODIFY
    nfreedof = 8;% number of free degrees of freedom;
     
    W = 6000;% Live load, N
    % Loading data.
    AppliedF = [0, -W; 0, -W; 0, 0; 0, 0; 0, 0];% MODIFY
        
    A = zeros(size(kconn,1),1)+pi*60*7;% cross-sectional areas mm^2

    addM = 0.096;% additional mass, 1000*kg
    addMidx = 1;%  Mass at which joints?
    
    maxtipd = 10;%mm, Maximum deflection magnitude
    lowestfreq =13; % Hertz
end

% Draw the structure
function tcant_draw(DV)
    [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, Lowestfreq] = tcant_data;
    % The current areas of the cross sections are the current values of the
    % design variables 
    A = DV;
    
    % Calculate the line width to represent visually the cross sections
    minrad = sqrt(min(A));
    maxrad = sqrt(max(A));
    if maxrad > minrad
        SpringWidth = 2*(sqrt(A)-minrad)/(maxrad-minrad) +1;
    else
        SpringWidth = 1;
    end
    ForceScaling = 0.0; NumberOffSet = [-200,200]; TextSize = 12;
    MaDS.plot_structure(X, kconn, dof, nfreedof, AppliedF, ForceScaling, NumberOffSet, TextSize, SpringWidth)
    
%     fig2eps(['figure_tcant_sizing_optimization'  '.eps'])
end