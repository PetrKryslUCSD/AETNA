% FFT on the output of direct integration, undamped, unforced.
function n3_undamped_fft
    [M,C,K,A] = properties_undamped;
    nparticles =size(M,1);
    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);
    tspan = [0, 14];
    dt =2*pi/max(abs(diag(D)))/20
    % Initial condition as a mixture of various modes
    y0 =sum(real(V(:,[1:2,5:6]))')';
    [t,y]=odetrap(@(t,y)A*y,tspan,y0,odeset('InitialStep',dt));style ='r-';
    
    figure
    x=y(:,3);% this is the signal to transform
    N = 2^nextpow2(length(x)); % Next power of 2 from length of x
    X = (1/N)*fft(x,N);% Now we compute the coefficients X_k
    f_Ny=(1/dt)/2; % This is the Nyquist frequency
    f = f_Ny*linspace(0,1,N/2);% These are the frequencies
    absX=2*abs(X(1:N/2)); % Take 2 times one half of the coefficients
    plot(f,absX,'Color', 'r','LineWidth', 3,'LineStyle', '-','Marker', '.'); hold on
    xlabel ('Frequency f [Hz]'); ylabel ('One-sided amplitude spectrum |X(f)|');
    set(gca,'xlim', [0,5])
    %     fig2eps(['n3_oscillator_undamped_fft_modes'  '.eps']) 
%     fig2eps(['n3_oscillator_undamped_fft_Forced'  '.eps'])

end
