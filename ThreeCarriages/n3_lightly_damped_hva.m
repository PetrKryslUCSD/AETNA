% Harmonic Vibration Analysis, lightly damped. 
function n3_lightly_damped_hva
    scale = 50;
    scalev = 5;
    [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_damped_proportional;
    nparticles =size(M,1);
    C=C/20;% Very lightly damped
    
    [V,Lambda]=eig(K,M);
    V'*M*V
    
    Frequencies =logspace( -1, log10(2.5), 4000 );
    Hs = zeros(nparticles, nparticles, length(Frequencies));
    for j=1:length(Frequencies)
        f  =Frequencies(j);
        omega  =2*pi*f;
        S = -omega^2*M + 1i*omega*C + K;
        H(:,:,j)=inv(S);% Normally we would take advantage of modal decomposition:  we are being sloppy here because the system is so small
    end    
    
    figure('Position', [329 25 903 949])
    whichplot=1;
    for i=1:nparticles
        for j=1:nparticles 
            subplot(nparticles,nparticles,whichplot);
            plot(Frequencies,abs(squeeze(H(i,j,:))));
            grid on; set(gca,'linewidth',2);
            xlabel('Frequency'); ylabel(['|H_{',num2str(i),num2str(j),'}(\omega)|']);
            whichplot=whichplot+1;
        end
    end
    saveas(gcf,['n3_undamped_hva_abs'  '.eps'],'epsc')
    
    figure('Position', [329 1 1230 1200])
    minRe=min(min(min(real(squeeze(H)))))- 0.001;
    maxRe=max(max(max(real(squeeze(H)))))+ 0.001;
    minIm=min(min(min(imag(squeeze(H)))))- 0.001;
    maxIm=max(max(max(imag(squeeze(H)))))+ 0.001;
    d=max([maxRe-minRe,maxIm-minIm]);
    maxRe=minRe+d; maxIm=minIm+d;
    minF=0;,maxF= 2.7;
    zv=0*Frequencies;
    whichplot=1;
    for i=1:nparticles
        for j=1:nparticles 
            subplot(nparticles,nparticles,whichplot);
            l=line('xdata',real(squeeze(H(i,j,:))),'zdata',imag(squeeze(H(i,j,:))),'ydata',Frequencies);
            set(l,'color',0.0*[0,1,0]);
            l=line('xdata',real(squeeze(H(i,j,:))),'zdata',minIm+0*zv,'ydata',Frequencies);
            set(l,'color',0.7*[1,0,0]);
            l=line('xdata',maxRe+0*zv,'zdata',imag(squeeze(H(i,j,:))),'ydata',Frequencies);
            set(l,'color',0.7*[0,1,0]);
            l=line('xdata',real(squeeze(H(i,j,:))),'zdata',imag(squeeze(H(i,j,:))),'ydata',maxF+0*zv);
            set(l,'color',0.7*[0,0,1]);
            grid on; set(gca,'linewidth',2);
            xlabel(['Re H_{',num2str(i),num2str(j),'}(\omega)']); 
            zlabel(['Im H_{',num2str(i),num2str(j),'}(\omega)']);
            ylabel(['Frequency']);
            view(3)
            set(gca,'xlim',[minRe,maxRe]);
            set(gca,'zlim',[minIm,maxIm]);
            set(gca,'ylim',[minF,maxF]);
            %             set(gca,'dataaspectratiomode','manual');
            whichplot=whichplot+1;
        end
    end
    %     saveas(gcf,['n3_undamped_hva_all'  '.pdf'])
    set(gcf,'renderer','painters')
        saveas(gcf,['n3_undamped_hva_all'  '.eps'],'epsc')
    %     fig2eps(['n3_undamped_hva_all'  '.eps']);
    
    %     figure('Position', [329 25 903 949])
    %     whichplot=1;
    %     for i=1:nparticles
    %         for j=1:nparticles
    %             subplot(nparticles,nparticles,whichplot);
    %             plot(real(squeeze(H(i,j,:))),imag(squeeze(H(i,j,:))));%
    %             grid on; set(gca,'linewidth',2); axis equal
    %             xlabel(['Re H_{',num2str(i),num2str(j),'}(\omega)']); ylabel(['Im H_{',num2str(i),num2str(j),'}(\omega)']);
    %             whichplot=whichplot+1;
    %         end
    %     end
    %     saveas(gcf,['n3_undamped_hva_Nyquist_receptance'  '.eps'])
    
    %     H=1i*omega*H;
    %     figure('Position', [329 25 903 949])
    %     whichplot=1;
    %     for i=1:nparticles
    %         for j=1:nparticles
    %             subplot(nparticles,nparticles,whichplot);
    %             plot(real(squeeze(H(i,j,:))),imag(squeeze(H(i,j,:))));%
    %             grid on; set(gca,'linewidth',2); axis equal
    %             xlabel(['Re H_{',num2str(i),num2str(j),'}(\omega)']); ylabel(['Im H_{',num2str(i),num2str(j),'}(\omega)']);
    %             whichplot=whichplot+1;
    %         end
    %     end
    %     saveas(gcf,['n3_undamped_hva_Nyquist_mobility'  '.eps'])
    %
    
    
end