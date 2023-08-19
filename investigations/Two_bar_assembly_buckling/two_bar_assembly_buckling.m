
function two_bar_assembly_buckling()
% 
X = [-4000, 0.0; 0, 0; 0, -5000];% Locations of joints
kconn = [1, 2; 2, 3];% Which joints are connected by springs
k = 68900.0* 400*[1/4000, 1/5000];% Spring constants
dof = [3, 4; 1, 2; 5, 6];% Definition of the degrees of freedom:
nfreedof = 2;% How many  unknown degrees of freedom?
AppliedF = [0, 0.0; -1000, 0; 0, 0];
JointRadius=6;
SpringWidth=1;
SpringColor = "green";

% Check the input data
MaDS.sanity_check(X, k, [], [], kconn, [], dof, nfreedof);
% Construct the stiffness matrix
K = MaDS.stiffness(X, k, kconn, dof);
F = MaDS.applied_forces(AppliedF, dof);
u = MaDS.scatter_vector(K(1:nfreedof,1:nfreedof)\F(1:nfreedof), dof)
Kgeo = MaDS.initial_stress_stiffness(X, k, kconn, dof, u)
% Solve the generalized eigenvalue problem for the mode shapes (V) and
% natural frequencies (diagonal of D)
[V, D] = eig(K(1:nfreedof, 1:nfreedof), Kgeo(1:nfreedof, 1:nfreedof));
disp( [ 'Frequencies =', num2str(sqrt(diag(D)')/2/pi) ])
V, D

% Visualize the results
Mode =  2;
omega = sqrt(abs(D(Mode, Mode)));% angular frequency of the selected  mode
Tn = 2*pi/abs(omega);% period  of the selected mode
dX = 0*X; % this will hold the joint displacements
freedofix =  find(dof <= nfreedof);% indexes of the free degrees of freedom
dX(freedofix) = V(dof(freedofix), Mode);% distribute the mode shape displacements to the joints
% Some visualization parameters
scale =   1000.3;
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
    SimPl.draw_joints(X, 3*JointRadius, 0.7*[1, 1, 1]);
    SimPl.draw_springs(X+xscale*scale*dX, kconn, SpringWidth, SpringColor, true)
    SimPl.draw_joints(X+xscale*scale*dX, 3*JointRadius, 0.7*[1, 0, 0]);
    axis equal; axis off
    pause( 0.1 );

end
end
