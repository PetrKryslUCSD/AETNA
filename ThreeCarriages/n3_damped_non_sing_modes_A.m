% Standard eigenvalue problem, numerical, non-proportionally damped, Singular stiffness. 
function n3_damped_non_sing_modes_A
    scale = 40;
    scalev = 4 ; 
   [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_damped_sing_non_proportional;
    nparticles =size(M,1);
    [V,D]=eig(K,M);   
    % [V,D]=eig(M^-1*K);
    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);
    ReV =real(V); ReV(find(abs(real(V))<1e-9)) =0;
    ImV =imag(V); ImV(find(abs(imag(V))<1e-9))=0;
    matrix2latex(100*(ReV+i*ImV),3)
    ReD =real(D); ReD(find(abs(real(D))<1e-9)) =0;
    ImD =imag(D); ImD(find(abs(imag(D))<1e-9))=0;
    matrix2latex(ReD+i*ImD,3)

    Gray =[0.72, 0.72, 0.72];

    for mode = 1:6;

        V(:,mode)=V(:,mode)/max(abs(V(:,mode)));
        if (abs(D(mode,mode))>1e-9), scale = 6*abs(D(mode,mode));
        else, scale = 6; end
        scalev = 6;
        %         clc

        All=GPath_group();
        All.group ={};

        Frame=GPath_polygon([-5,-1;34, 2]);
        Frame.edgecolor ='w';
        Frame.color = [];
        Frame.linestyle ='none';
        Frame.linewidth =1;
        All= append(All,Frame);

        Carriage1=GPath_group();
        Glyph=glyph_rectangle([6,3],Gray,Gray);
        Carriage1= append(Carriage1,Glyph);

        Glyph= glyph_circle(1.8,Gray,'w');
        Glyph =translate (Glyph,[-1.6,-1.3]);
        Carriage1= append(Carriage1,Glyph);

        Glyph= glyph_circle(1.8,Gray,'w');
        Glyph =translate (Glyph,[+1.6,-1.3]);
        Carriage1= append(Carriage1,Glyph);

        if (k1~=0)
            Glyph=glyph_spring([-8, -0.7],[-3,-0.7],1.9);
            Glyph.edgecolor = Gray;
            All= append(All,Glyph);
        end
        if (c1~=0)
            Glyph=glyph_damper([-8, 0.7],[-3, 0.7],1.9 );
            Glyph.edgecolor = Gray;
            All= append(All,Glyph);
        end

        if (k2~=0)
            Glyph=glyph_spring([-8+11, -0.7],[-3+11,-0.7],1.9);
            Glyph.edgecolor = Gray;
            All= append(All,Glyph);
        end
        if (c2~=0)
            Glyph=glyph_damper([-8+11, 0.7],[-3+11, 0.7],1.9 );
            Glyph.edgecolor = Gray;
            All= append(All,Glyph);
        end

        if (k3~=0)
            Glyph=glyph_spring([-8+11+11, -0.7],[-3+11+11,-0.7],1.9);
            Glyph.edgecolor = Gray;
            All= append(All,Glyph);
        end
        if (c3~=0)
            Glyph=glyph_damper([-8+11+11, 0.7],[-3+11+11, 0.7],1.9 );
            Glyph.edgecolor = Gray;
            All= append(All,Glyph);
        end


        Glyph=glyph_rectangle([ 36 +1.2+1.2, 0.7],Gray,Gray);
        Glyph =translate (Glyph,[9,-3.5]);
        All= append(All,Glyph);

        Glyph=glyph_rectangle([1.2, 6.4],Gray,Gray);
        Glyph =translate (Glyph,[-8.6,-1.5]);
        All= append(All,Glyph);


        Carriage2 = translate(Carriage1,[11,0]);
        Carriage3 = translate(Carriage1,[22,0]);


        All= append(All,Carriage1);
        All= append(All,Carriage2);
        All= append(All,Carriage3);

        g= glyph_vector( [0, 0],scalev*[real(V(4,mode)), imag(V(4,mode))], 1.9);
        g.linewidth =2;
        g.edgecolor ='r';
        All= append(All,g);

        g= glyph_vector( [0, 0],scale*[real(V(1,mode)), imag(V(1,mode))], 1.9);
        g.linewidth =2;
        g.edgecolor ='g';
        All= append(All,g);

        Glyph= glyph_circle(0.3,'k','w');
        Glyph =translate (Glyph,[0,0]);
        All= append(All,Glyph);

        t1 =GPath_text([ -1.2,2.5],['z_{1' num2str(mode) '},','z_{4' num2str(mode) '}']);
        t1.fontname ='Times';
        t1.fontsize =16;
        t1.fontangle ='italic';
        t1.horizontalalignment='center';
        t1.color ='k';
        t1.interpreter='latex';
        All= append(All,t1);

        g= glyph_vector( [11, 0],scalev*[real(V(5,mode)), imag(V(5,mode))], 1.9);
        g.linewidth =2;
        g.edgecolor ='r';
        All= append(All,g);

        g= glyph_vector( [11, 0],scale*[real(V(2,mode)), imag(V(2,mode))], 1.9);
        g.linewidth =2;
        g.edgecolor ='g';
        All= append(All,g);

        Glyph= glyph_circle(0.3,'k','w');
        Glyph =translate (Glyph,[11,0]);
        All= append(All,Glyph);

        t1 =GPath_text([ 11-1.2,2.5],['z_{2' num2str(mode) '},','z_{5' num2str(mode) '}']);
        t1.fontname ='Times';
        t1.fontsize =16;
        t1.fontangle ='italic';
        t1.horizontalalignment='center';
        t1.color ='k';
        t1.interpreter='latex';
        All= append(All,t1);

        g= glyph_vector( [22, 0],scalev*[real(V(6,mode)), imag(V(6,mode))], 1.9);
        g.linewidth =2;
        g.edgecolor ='r';
        All= append(All,g);

        g= glyph_vector( [22, 0],scale*[real(V(3,mode)), imag(V(3,mode))], 1.9);
        g.linewidth =2;
        g.edgecolor ='g';
        All= append(All,g);

        Glyph= glyph_circle(0.3,'k','w');
        Glyph =translate (Glyph,[22,0]);
        All= append(All,Glyph);

        t1 =GPath_text([22-1.2,2.5],['z_{3' num2str(mode)  '},','z_{6' num2str(mode) '}']);
        t1.fontname ='Times';
        t1.fontsize =16;
        t1.fontangle ='italic';
        t1.horizontalalignment='center';
        t1.color ='k';
        t1.interpreter='latex';
        All= append(All,t1);

        figure; hold on
        set(gca,'Units','centimeter')
        render(All)
        axis equal
        % grid on
        axis off

        fig2eps(['n3_oscillator_damped_non_sing_A_mode' num2str(mode) '.eps'])
    end
end