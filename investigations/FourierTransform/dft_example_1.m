% Fourier-transform example
Data = load('elcentro.mat');
dt = Data.delt;% The sampling interval
x = Data.han;% This is the signal: Let us process the North-South acceleration
L = length(x); % Number of samples
t = (0:1:L-1)*dt;% The times at which samples were taken
N = 2^nextpow2(length(x)); % Next power of 2 from length of x
X = (1/L)*fft(x,N);% Now we compute the coefficients X_k
f_Ny = (1/dt)/2; % This is the Nyquist frequency
f = f_Ny*linspace(0,1,N/2);% These are the frequencies
absX = 2*abs(X(1:N/2)); % Take 2 times one half of the coefficients
plot(f,absX,'Color', 'r','LineWidth', 3,'LineStyle', '-','Marker', '.'); hold on
xlabel (' Frequency f [Hz]'); ylabel (' |X(f)|');
