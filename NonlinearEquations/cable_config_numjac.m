% Solve for equilibrium configuration of prestressed cable structure (w/ numjac).
function [y,sigma]=cable_config_numjac
    % undeformed configuration, lengths in millimeters
    p =[10,10;   25,25;    0,0;    40,40;   40,0]*1000;
    y =p;% Initialize deformed configuration
    % Which joints are connected by which cables?
    conn = [3,1; 1,2; 2,4; 5,1; 5,2];
    % Initial cable lengths
    Initial_L =[...
      1.025*[Length(1),Length(2),Length(3)],...
      0.88*Length(4),0.81*Length(5)];
    A= [150,150,150,100,100];% Cable cross-section mm^2
    E=200000;% Young's modulus, MPa
    AbsTol = 0.0000005;%Tolerance in millimeters
    maximum_iteration = 12;% How many iterations are allowed?
    N =zeros(size(conn,1),1);% Prestressing force
    
    function   Delt=Delta(j)% Compute the run/rise
        Delt =diff(y(conn(j,:),:));
    end
    function  L=Length(j)% Deformed cable length
        L=sqrt(sum(Delta(j).^2));
    end
    % Compute the force residual
    function R=Force_residual(Ignore1,Y,varargin)
        y(1,:) =Y(1:2)';
        y(2,:) =Y(3:4)';
        F =zeros(size(p,1),2);
        for j=1:size(conn,1)
            L=Length(j);
            N(j)=E*A(j)*(L-Initial_L(j))/L;
            F(conn(j,1),:) =F(conn(j,1),:) +N(j)*Delta(j)/L;
            F(conn(j,2),:) =F(conn(j,2),:) -N(j)*Delta(j)/L;
        end
        R =[F(1,:)';F(2,:)'];
    end
     
    Y=[y(1,:)';y(2,:)'];% Initialize deformed configuration
    for iteration = 1: maximum_iteration % Newton loop
        R=Force_residual(0,Y);% Compute residual
        [dRdy] = numjac(@Force_residual,0,...
            Y,R,Y/1e3,[],0);% Compute Jacobian
        dY=-dRdy\R;% Solve for correction
        if norm(dY,inf)<AbsTol % Check convergence
            y(1,:) =Y(1:2)';% Converged
            y(2,:) =Y(3:4)';
            R=Force_residual(0,Y);% update the forces
            sigma =N./A';% Stress
            return;
        end
        Y=Y+dY;% Update configuration
    end
    error('Not converged')% bummer :(
end