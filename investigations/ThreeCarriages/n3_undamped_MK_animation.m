% Generalized eigenvalue problem, animation, undamped. 
function n3_undamped_MK_animation
    mode =3;% Choose which mode should be animated, 1, 2, or 3

    [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_undamped;
    nparticles =size(M,1);

    function Out=rhs(t, y, varargin)
        Out= A*y;
    end
  
    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);
    clc
    
    All=GPath_group();
    All.group ={};
    
    Carriage1=GPath_group();
    Glyph=glyph_rectangle([6,3],'k','y');
    Carriage1= append(Carriage1,Glyph);
    
    Glyph= glyph_circle(1.8,'k','w');
    Glyph =translate (Glyph,[-1.6,-1.3]);
    Carriage1= append(Carriage1,Glyph);
    
    Glyph= glyph_circle(1.8,'k','w');
    Glyph =translate (Glyph,[+1.6,-1.3]);
    Carriage1= append(Carriage1,Glyph);
    
    p1 =[0,0];
    p2 =[11,0];
    p3 =[22,0];
    Spring_length =5;
    
    Ground=GPath_group();
    Ground.group ={};
    Glyph=glyph_rectangle([42 +1.2+1.2, 0.7],'k','k');
    Glyph =translate (Glyph,[11,-3.5]);
    Ground= append(Ground,Glyph);
    
    Glyph=glyph_rectangle([2, 6.4],'k','k');
    Glyph =translate (Glyph,[-9.2,-1.5]);
    Ground= append(Ground,Glyph);
    
    Axes= glyph_cartesian_axes(4*[-1.2,1.2],4*[-1.2,1.2],'k',0.2);
    
    t1 =GPath_text([ 11-1.2,22.5],['\mbox{Mode } \;' num2str(mode) ]);
    t1.fontname ='Times';
    t1.fontsize =24;
    t1.fontangle ='italic';
    t1.horizontalalignment='center';
    t1.color ='k';
    t1.interpreter='latex';
     
    f=figure; hold on
    set(gca,'Units','centimeter')
    render(All)
    axis equal
    % grid on
    axis off
    Stop = uicontrol('Position',[10 10 100 20],'String','Stop');
    Resume = uicontrol('Position',[10 10 100 20],'String','Resume');
    set(Resume,'visible','off');
    function stopcb(varargin)
        set(Stop,'visible','off');
        set(Resume,'visible','on');
        uiwait(f);
    end
    set(Stop,'Callback',@stopcb);
    function resumcb(varargin)
        set(Resume,'visible','off');
        set(Stop,'visible','on');
        uiresume(f);
    end
    set(Resume,'Callback',@resumcb);
    
    mode =mode*2;
    lambda =D(mode,mode);
    Tn=2*pi/abs(lambda);
    t=linspace(0,4*Tn,150);
    Magnified = [2/max(abs(V(1:3,mode)))*[1,1,1]';2/max(abs(V(4:6,mode)))*[1,1,1]'];
    vscale =9/2;
    for i =1:length(t)
        phasors=Magnified.*(V(:,mode)*exp(lambda*t(i)));
        try,v=get(f); catch, break,end
        figure(f);
        cla
        render(translate(glyph_rectangle([3,3],'w','w'), [58,38]/2));
        render(Ground);
        render(translate(Carriage1,p1+[real(phasors(1)), 0]));
        render(translate(Carriage1,p2+[real(phasors(2)), 0]));
        render(translate(Carriage1,p3+[real(phasors(3)), 0]));
        if (k1~=0)
            s =[-8, 0]+[0,0];
            e =p1+[real(phasors(1)), 0]+[-6/2,0];
            render(glyph_spring(s,e,1.9/norm(e-s)*Spring_length));
        end
        if (k2~=0)
            s =p1+[real(phasors(1)), 0]+[6/2,0];
            e =p2+[real(phasors(2)), 0]+[-6/2,0];
            render(glyph_spring(s,e,1.9/norm(e-s)*Spring_length));
        end
        if (k3~=0)
            s =p2+[real(phasors(2)), 0]+[6/2,0];
            e =p3+[real(phasors(3)), 0]+[-6/2,0];
            render(glyph_spring(s,e,1.9/norm(e-s)*Spring_length));
        end
        render(translate(Axes,p1+[0, 10]));
        g= glyph_vector([0, 0],vscale*[real(phasors(1)),0], 2.1);
        g.linewidth =4;
        g.edgecolor ='g';
        render(translate(g,p1+[0, 10]));
        
        render(translate(Axes,p2+[0, 10]));
        g= glyph_vector([0, 0],vscale*[real(phasors(2)),0], 2.1);
        g.linewidth =4;
        g.edgecolor ='g';
        render(translate(g,p2+[0, 10]));
        
        render(translate(Axes,p3+[0, 10]));
        g= glyph_vector([0, 0],vscale*[real(phasors(3)),0], 2.1);
        g.linewidth =4;
        g.edgecolor ='g';
        render(translate(g,p3+[0, 10]));
        
        render(t1);
        
        axis equal
        % grid on
        axis off
        drawnow; pause (0.01);
    end
end