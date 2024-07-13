% Fourier-transform example
d = readtable('2024-06-1808.47.25.csv')
t = d.time(1):0.005:d.time(end);
az = interp1(d.time, d.az_m_s_2_, t);
dt = mean(diff(t));% The sampling interval
x = az;% This is the signal
L = length(x); % Number of samples
t = (0:1:L-1)*dt;% The times at which samples were taken
N = 2^nextpow2(length(x)); % Next power of 2 from length of x
X = (1/L)*fft(x,N);% Now we compute the coefficients X_k
f_Ny = (1/dt)/2; % This is the Nyquist frequency
f = f_Ny*linspace(0,1,N/2);% These are the frequencies
absX = 2*abs(X(1:N/2)); % Take 2 times one half of the coefficients
plot(f,absX,'Color', 'r','LineWidth', 3,'LineStyle', '-','Marker', '.'); hold on
xlabel (' Frequency f [Hz]'); ylabel (' |X(f)|');
