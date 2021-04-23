classdef SimPl
    % Simple Plots of MaDS: Mass-Damper-Spring Models
    %
    % Example of use: see the SimPl.demo1() and SimPl.demo2()
    %
    % Note: All methods need to be called by referencing the class SimPl,
    %       as for instance
    %            SimPl.demo()
    %
    % (C) 2016-2019, Petr Krysl
    
    methods (Static, Access = public) % Demos
        
        function demo1()
            % Simple demo of graphics.
            %
            % SimPl.demo1()
            %
            % Display structure, with and without deformation.  With and
            % without applied forces. With and without numbers for various
            % entities.
            % 
            
            % Some dimensions, all in millimeters
            W1=200; W2=200; H=250;
            % Locations of joints in the undeformed configuration.  Each joint has
            % one row in this array.
            x0 =[0,H;   -W1,H;    W2,H;    -W1,0;   W2,0; 0,0];
            % Which joints are connected by which springs? Each spring has a row in
            % this array.
            conn = [2,1; 1,3; 4,1; 1,5; 4,2; 5,3; 2,6; 6,3];
            % Numbers of the degrees of freedom (components of positions of the joints)
            dof=[1,2; 3,4; 5,6; 7,8; 9,10; 11,12];
            % Total number of the unknowns
            nfreedof=6;
            % Applied  forces in Newton
            FMax=3500;
            % Spring stiffnesses, N/mm
            k= 50*ones(size(conn,1),1);
            % Locations of joints in the deformed configuration.
            x =[61.6112  252.4267
                -150.4855  261.2726
                249.2307  230.1979
                -200.0000         0
                200.0000         0
                0         0];
            % Array of applied forces
            AppliedF =zeros(size(x));
            AppliedF(1,1)=FMax;
            % Various settings for graphics
            PlainJointRadius=6; PlainSpringWidth=2; Gray = 0.825*ones(1,3);  Red = [1,0,0];
            ForceScale=0.037;
            
            figure('name', 'Only the springs, undeformed, plain'); ax=gca;
            axes(ax); cla; axis equal; grid on; labels x y; hold on
            SimPl.draw_springs(x0,conn,PlainSpringWidth,Gray)
            pause(2)
            
            figure('name', 'Only the springs, undeformed, fancy'); ax=gca;
            axes(ax); cla; axis equal; grid on; labels x y; hold on
            SimPl.draw_springs(x0,conn,0.4,Gray,true)
            pause(2)
            
            figure('name', 'Springs and joints, undeformed, plain'); ax=gca;
            axes(ax); cla; axis equal; grid on; labels x y; hold on
            SimPl.draw_springs(x0,conn,PlainSpringWidth,Gray)
            SimPl.draw_joints(x0,PlainJointRadius,Gray)
            pause(2)
            
            figure('name', 'Springs, joints, forces, undeformed, plain'); ax=gca;
            axes(ax); cla; axis equal; grid on; labels x y; hold on
            SimPl.draw_springs(x0,conn,PlainSpringWidth,Gray)
            SimPl.draw_joints(x0,PlainJointRadius,Gray)
            SimPl.draw_forces(x0,AppliedF,'k',ForceScale);
            pause(2)
            
            figure('name', 'Springs, joints (free and fixed), forces, undeformed, plain'); ax=gca;
            axes(ax); cla; axis equal; grid on; labels x y; hold on
            SimPl.draw_springs(x0,conn,PlainSpringWidth,Gray)
            SimPl.draw_joints(x0,PlainJointRadius,Gray)
            SimPl.draw_forces(x0,AppliedF,'k',ForceScale);
            SimPl.draw_joints(x0(4:6,:),2*PlainJointRadius,Gray)
            pause(2)
            
            figure('name', 'Springs, joints, deformed and undeformed, plain'); ax=gca;
            axes(ax); cla; axis equal; grid on; labels x y; hold on
            SimPl.draw_springs(x0,conn,PlainSpringWidth,Gray)
            SimPl.draw_joints(x0,PlainJointRadius,Gray)
            SimPl.draw_springs(x,conn,PlainSpringWidth,Red)
            SimPl.draw_joints(x,PlainJointRadius,Red)
            pause(2)
        end
        
        function demo2()
            % Undamped vibration problem, with animation.
            %
            % demo2()
            %
            % This is the problem of three carriages that is solved in the textbook.
            % Refer to the class demo MaDS.demo()
            MaDS.demo()
        end
        
    end
        
    methods (Static, Access = public) % Graphics
        
        function draw_extents(xrange,yrange)
            % Set the drawing extents in a plot of a spring-damper-mass system.
            %
            % draw_extents(xrange,yrange)
            %
            % Input:
            % ax = axis handle object
            % xrange,yrange = 2 arrays  of two elements each: minimum and maximum
            %      for the x-coordinate and the y-coordinate
            %
            % This is the function to be called first, before anything else gets drawn.
            %
            % Example:
            %     t=linspace(0,2*Tn,50);
            %     for i =1:length(t)
            %         try, figure(f); cla;; catch, break, end
            %         xscale=sin(omega*t(i));
            %         draw_extents(xrange,yrange);
            %         draw_joints(X,JointRadius,0.7*[1,1,1]);
            %         draw_springs(X+xscale*scale*dX,kconn,SpringWidth,0.7*[1,0,0])
            %         draw_joints(X+xscale*scale*dX,JointRadius,0.7*[1,0,0]);
            %         drawnow;
            %         pause( 0.001 );
            %     end
            
            %             axes(ax); hold on
            %     set('Units','centimeter');
            axis equal
            
            Frame =GPath_group();
            Frame.group ={};
            Glyph= glyph_circle(1/1000,'w','w');
            Glyph =translate(Glyph,[min(xrange),min(yrange)]);
            Frame= append(Frame,Glyph);
            Glyph= glyph_circle(1/1000,'w','w');
            Glyph =translate(Glyph,[max(xrange),max(yrange)]);
            Frame= append(Frame,Glyph);
            
            %             axes(ax);
            axis off
            render(Frame);
            
            hold on
        end
        
        function draw_springs(x,kconn,SpringWidth,Color,FancyRendering)
            % Draw the springs in a spring-damper-mass system.
            %
            % draw_springs(x,kconn,SpringWidth,Color,FancyRendering)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints.  Each joint has
            %      one row in this array.
            % kconn = Which joints are connected by the springs? Each spring has a row in
            %     this array, with joint numbers in the columns.
            % SpringWidth= width of the line that represents the spring, 
            %      with plain rendering; otherwise, with fancy rendering, 
            %      width of the spring spiral, in fraction of the spring
            %      length
            % Color = draw the springs using this color
            % FancyRendering = true or false?  If true, fancy rendering of the
            %      springs is used; otherwise plain line segment represents a spring.
            
            if (~exist('FancyRendering','var'))
                FancyRendering= false;
            end
            %
            %             axes(ax); hold on;
            %
            if (~FancyRendering)
                if (SpringWidth<=0)
                    SpringWidth=1;
                end
                for  j =1:size(kconn,1)
                    c=kconn(j,:);
                    L=sqrt(sum(diff(x(c,:))));
                    line('XData',x(c,1),'YData',x(c,2),'color',Color, 'linewidth',SpringWidth);
                end
            else
                for  j =1:size(kconn,1)
                    c=kconn(j,:);
                    L=sqrt(sum(diff(x(c,:))));
                    Glyph =glyph_spring(x(c(1),:),x(c(2),:),SpringWidth);
                    Glyph.edgecolor=Color;
                    render(Glyph);
                end
            end
        end
        
        function draw_forces(x,AppliedF,Color,ForceScale)
            % Draw the applied forces for a spring-damper-mass system.
            %
            % draw_forces(x,AppliedF,Color,ForceScale)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints in the undeformed configuration.  Each joint has
            %      one row in this array.
            % AppliedF = Applied  forces.  Force applied to each joint is
            %     supplied in the row of this array.
            % Color = draw the forces using this color
            
            % axes(ax); hold on;
            
            for  ii =1:size(AppliedF,1)
                F=AppliedF(ii,:);
                if (norm(F)>0)
                    Glyph= glyph_vector([0,0],ForceScale*F,min([norm(ForceScale*F)/3]));
                    Glyph =translate(Glyph,x(ii,:));
                    Glyph.color=Color;
                    render(Glyph);
                end
            end
            
        end
        
        function draw_joints(x,JointRadius,Color,FancyRendering)
            % Draw the joints of a spring-damper-mass system.
            %
            % draw_joints(x,JointRadius,Color)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints in the undeformed configuration.  Each joint has
            %      one row in this array.
            % JointRadius= radius of the marker symbolizing joint,
            %     in the units in which the geometry is described for FancyRendering=true;
            %     otherwise the marker size is expressed in terms of pixels.
            % Color = draw the joints and the springs using this color
            % FancyRendering = true or false?  If true, fancy rendering of the
            %      joints is used; otherwise plain markers are used.
            
            if (~exist('FancyRendering','var'))
                FancyRendering= false;
            end
            
            %             % axes(ax); hold on;
            
            if (FancyRendering)
                for  ii =1:size(x,1)
                    Glyph= glyph_circle(JointRadius,Color,'w');
                    Glyph =translate(Glyph,x(ii,:));
                    render(Glyph);
                end
            else
                for  ii =1:size(x,1)
                    line('XData',x(ii,1),'YData',x(ii,2),'color',Color,'marker','o', 'markersize',JointRadius);
                end
            end
        end
        
        function draw_joint_numbers(x,Color,FontSize,Offset)
            % Draw the numbers of the entities of a spring-damper-mass system.
            %
            % draw_joint_numbers(x,Color,FontSize,Offset)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints in the undeformed configuration.  Each joint has
            %      one row in this array.
            % Offset = array with one row and two columns: offsets of the
            %      displayed number with respect to the location of the joint
            % Color = draw the numbers using this color
            
            % axes(ax); hold on;
            
            if (~isempty(x))
                for  j =1:size(x,1)
                    Glyph =GPath_text(x(j,:)+Offset,num2str(j));
                    Glyph.fontname ='Times';
                    Glyph.fontsize =FontSize;
                    Glyph.fontangle ='italic';
                    Glyph.horizontalalignment='center';
                    Glyph.color =Color;
                    %             t1.interpreter='latex';
                    render(Glyph);
                end
            end
            
        end
        
        function draw_spring_numbers(x,kconn,Color,FontSize,Offset)
            % Draw the numbers of the entities of a spring-damper-mass system.
            %
            % draw_spring_numbers(x,kconn,Color,FontSize,Offset)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints in the undeformed configuration.  Each joint has
            %      one row in this array.
            % kconn = Which joints are connected by which springs? Each spring has a row in
            %     this array.
            % Color = draw the joints and the springs using this color
            % Offset = array with one row and two columns: offsets of the
            %      displayed number with respect to the location of the joint
            
            % axes(ax); hold on;
            
            if (~isempty(kconn))
                for  j =1:size(kconn,1)
                    c=kconn(j,:);
                    Center=mean(x(c,:));
                    Glyph =GPath_text(Center+Offset,num2str(j));
                    Glyph.fontname ='Times';
                    Glyph.fontsize =FontSize;
                    Glyph.fontangle ='italic';
                    Glyph.horizontalalignment='center';
                    Glyph.color =Color;
                    %             t1.interpreter='latex';
                    render(Glyph);
                end
            end
        end
        
        function draw_dampers(x,cconn,DamperWidth,Color,FancyRendering)
            % Draw the dampers in a spring-damper-mass system.
            %
            % draw_dampers(x,cconn,DamperWidth,Color,FancyRendering)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints.  Each joint has
            %      one row in this array.
            % cconn = Which joints are connected by the dampers? Each damper has a row in
            %     this array, with joint numbers in the columns.
            % DamperWidth= width of the line that represents the damper, 
            %      with plain rendering; otherwise, with fancy rendering, 
            %      width of the damper symbol, in fraction of the damper
            %      length
            % Color = draw the springs using this color
            % FancyRendering = true or false?  If true, fancy rendering of the
            %      springs is used; otherwise plain line segment represents a spring.
            
            if (~exist('FancyRendering','var'))
                FancyRendering= false;
            end
            
            % axes(ax); hold on;
            
            if (~FancyRendering)
                for  j =1:size(cconn,1)
                    c=cconn(j,:);
                    L=sqrt(sum(diff(x(c,:))));
                    line('XData',x(c,1),'YData',x(c,2),'color',Color);
                end
            else
                for  j =1:size(cconn,1)
                    c=cconn(j,:);
                    L=sqrt(sum(diff(x(c,:))));
                    Glyph =glyph_damper(x(c(1),:),x(c(2),:),DamperWidth);
                    Glyph.edgecolor=Color;
                    render(Glyph);
                end
            end
        end
        
        function draw_damper_numbers(x,cconn,Color,FontSize,Offset)
            % Draw the numbers of the entities of a spring-damper-mass system.
            %
            % draw_spring_numbers(x,kconn,Color,FontSize,Offset)
            %
            % Input:
            % ax = axis object
            % x  = Locations of joints in the undeformed configuration. 
            %      Each joint has one row in this array.
            % cconn = Which joints are connected by the dampers? Each damper 
            %      has a row in this array.
            % Color = draw the joints and the springs using this color
            % Offset = array with one row and two columns: offsets of the
            %      displayed number with respect to the location of the joint
            
            % axes(ax); hold on;
            
            if (~isempty(cconn))
                for  j =1:size(cconn,1)
                    c=cconn(j,:);
                    Center=mean(x(c,:));
                    Glyph =GPath_text(Center+Offset,num2str(j));
                    Glyph.fontname ='Times';
                    Glyph.fontsize =FontSize;
                    Glyph.fontangle ='italic';
                    Glyph.horizontalalignment='center';
                    Glyph.color =Color;
                    %             t1.interpreter='latex';
                    render(Glyph);
                end
            end
        end
        
    end
    
end
