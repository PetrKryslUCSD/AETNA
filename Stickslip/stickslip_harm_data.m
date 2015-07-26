% Stick-slip motion of the eccentric mass shaker data
function [m,mus,mud,N,A,omega,vstick] = stickslip_harm_data
    m= 0.5;% Kilograms
    N =m*9.81;% Newton
    mus= 0.6;% coefficient of dry friction of steel
    mud= 0.2;% coefficient of dry friction of steel
    A = 0.615*N;% Force amplitude
    omega =10*2*pi;% angular frequency
    vstick = 0.01;% meters per second