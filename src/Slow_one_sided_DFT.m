% An extremely inefficient DFT.
% dt= the signal is sampled with this period.
% x = this is the discrete signal.
%     [f,Y] =Slow_one_sided_DFT(dt,x);
%     hold on;plot(f,Y,'r')
%     [f,Y] =one_sided_DFT(dt,x);
%     hold on;plot(f,Y,'g') 
% 
function [f,Y] =Slow_one_sided_DFT(dt,x)
    N = 2^nextpow2(length(x)); % the number of points in the FFT
    fs =(1/dt);% sampling frequency
    f = fs/2*linspace(0,1,N/2);% Well-sampled frequencies
    M =zeros(N,N);
    m=0:1:N-1;%These are the row and column indexes
    n=0:1:N-1;
    M =(1/N)*exp(-1i*2*pi*n'*m/N);% This is the transformation matrix
    xp=zeros(N,1);
    xp(1:length(x)) =x;
    yp=M*xp;
    fs =(1/dt);% sampling frequency
    f = fs/2*linspace(0,1,N/2);% Well-sampled frequencies are only up to Nyquist frequency
    Y =2*abs(yp(1:N/2));
end