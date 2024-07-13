% Fourier-transform example
dt = 0.0005;
L = 2^15;
t = (0:1:L-1)*dt;% The times at which samples were taken
az = 3*cos(2*pi*5*t) + 1.5*cos(2*pi*7*t); 
x = az;% This is the signal
L = length(x); % Number of samples
N = 2^nextpow2(length(x)); % Next power of 2 from length of x
X = (1/L)*fft(x,N);% Now we compute the coefficients X_k
f_Ny = (1/dt)/2; % This is the Nyquist frequency
f = f_Ny*linspace(0,1,N/2);% These are the frequencies
absX = 2*abs(X(1:N/2)); % Take 2 times one half of the coefficients
plot(f,absX,'Color', 'r','LineWidth', 1,'LineStyle', '-','Marker', '.'); hold on
xlabel (' Frequency f [Hz]'); ylabel (' |X(f)|');
