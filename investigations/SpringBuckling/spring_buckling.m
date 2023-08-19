
function spring_buckling()
% 
X = [-4000, 0.0; 4000, 0; ];% Locations of joints
kconn = [1, 2; ];% Which joints are connected by springs
k = 68900.0* 400*[1/8000, ];% Spring constants
dof = [1, 2; 3, 4];% Definition of the degrees of freedom:
nfreedof = 4;% How many  unknown degrees of freedom?
AppliedF = [1000, 0.0; -1000, 0; ];
ks = k / 100; % structure-to-ground spring stiffness
ks_stabilization = k / 100; % structure-to-ground spring stiffness
JointRadius=6;
SpringWidth=1;
SpringColor = "green";

% Check the input data
MaDS.sanity_check(X, k, [], [], kconn, [], dof, nfreedof);
% Construct the stiffness matrix
K = MaDS.stiffness(X, k, kconn, dof);
% Add transverse springs the ground
for i = dof(:, 2)'
    K(i, i) = K(i, i) + ks;
end
% Add stabilization axial spring 
i = dof(1, 1);
K(i, i) = K(i, i) + ks_stabilization;
% Computed the displacements due to the applied load
F = MaDS.applied_forces(AppliedF, dof);
u = MaDS.scatter_vector(K(1:nfreedof,1:nfreedof)\F(1:nfreedof), dof)

% Compute the initial stress matrix, given the internal forces due to the
% displacements
Kgeo = MaDS.initial_stress_stiffness(X, k, kconn, dof, u)

% Solve the generalized eigenvalue problem for the mode shapes (V) and
% natural frequencies (diagonal of D)
[V, D] = eig(-Kgeo(1:nfreedof, 1:nfreedof), K(1:nfreedof, 1:nfreedof));
disp( [ 'Buckling factors =', num2str(1 / (diag(D))) ])


% Visualize the results
Mode = 4;
dX = 0*X; % this will hold the joint displacements
freedofix =  find(dof <= nfreedof);% indexes of the free degrees of freedom
dX(freedofix) = V(dof(freedofix), Mode);% distribute the mode shape displacements to the joints
% Some visualization parameters
scale =   10000;
extrad = scale*max(abs(V(:, Mode)));
xrange = [min(X(:, 1))-extrad, max(X(:, 1))+extrad];
yrange = [min(X(:, 2))-extrad, max(X(:, 2))+extrad];
% Make a figure and retrieve the axes
f = figure;
ax = gca;

SimPl.draw_extents(xrange, yrange);
SimPl.draw_joints(X, 3*JointRadius, 0.7*[1, 1, 1]);
SimPl.draw_springs(X+scale*dX, kconn, SpringWidth, SpringColor, true)
SimPl.draw_joints(X+scale*dX, 3*JointRadius, 0.7*[1, 0, 0]);
axis equal; axis off

end
