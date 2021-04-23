function c=xcorrf(a,b)
corrLength=length(a)+length(b)-1;
c=fftshift(ifft(fft(a,corrLength).*conj(fft(b,corrLength))));
c=c/dot(a,b);
