% FFT on the output of direct integration, damped, unforced, 
function n3_damped_fft
    scale = 30;
    scalev = 4 ;
    [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_damped_proportional;
    nparticles =size(M,1);
    [V,D]=eig(K,M);
    % [V,D]=eig(M^-1*K);
    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);



    (diag(D))

    tspan = [0, 14];
    dt =2*pi/max(abs(diag(D)))/20
    % Initial condition as a mixture of various modes
%     y0 =sum(real(V(:,1:4))')';
%     [t,y]=odetrap(@(t,y)A*y,tspan,y0,odeset('InitialStep',dt));style ='r-';
    % Zero initial condition, Harmonic excitation
    y0 =[0;0;0;0;0;0];
    [t,y]=odetrap(@(t,y)A*y+sin(2*pi*3*t)*[0;0;1;0;0;0],tspan,y0,odeset('InitialStep',dt));style ='r-';
    
%     subplots
    
    figure
    x=y(:,3);
    N = 2^nextpow2(length(x)); % Next power of 2 from length of x
    X = (1/N)*fft(x,N);% Now we compute the coefficients X_k
    f_Ny=(1/dt)/2; % This is the Nyquist frequency
    f = f_Ny*linspace(0,1,N/2);% These are the frequencies
    absX=2*abs(X(1:N/2)); % Take 2 times one half of the coefficients
    plot(f,absX,'Color', 'r','LineWidth', 3,'LineStyle', '-','Marker', '.'); hold on
    xlabel ('Frequency f [Hz]'); ylabel ('One-sided amplitude spectrum |X(f)|');
    set(gca,'xlim', [0, 5])
        fig2eps(['n3_oscillator_damped_fft_modes'  '.eps'])
    %     fig2eps(['n3_oscillator_damped_fft_Forced'  '.eps'])

    abs(diag(D))/(2*pi)

    function subplots
        %         ylim =[min(min(y(:,1:3))),max(max(y(:,1:3)))]
        subplot(3,2,1)
        plot(t,y(:,1),style); ylabel('y(1)'); grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,3)
        plot(t,y(:,2),style); ylabel('y(2)');grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,5)
        plot(t,y(:,3),style); ylabel('y(3)'); grid on; hold on
        set(gca,'ylim',ylim);
        xlabel ('t');
%         ylim =[min(min(y(:,4:6))),max(max(y(:,4:6)))]
        subplot(3,2,2)
        plot(t,y(:,4),style); ylabel('y(4)'); grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,4)
        plot(t,y(:,5),style); ylabel('y(5)'); grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,6)
        plot(t,y(:,6),style); ylabel('y(6)'); grid on; hold on
        set(gca,'ylim',ylim);
        xlabel ('t');
    end
end