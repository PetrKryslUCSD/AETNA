function Ih =riemquad(f,a,b, n)
x=linspace(a,b,n+1);
h =mean(diff(x));
Ih=0;
for j=1:length(x)-1
    Ih =Ih +h*f(x(j));
end 
% 
% % %
% Ih1 =riemquad(@(x)sin(x),0,pi, 3)
% Ih2 =riemquad(@(x)sin(x),0,pi, 6)
% Ih3 =riemquad(@(x)sin(x),0,pi, 12)
% % int(sym ('sin(x)'),0,pi)
% %
% % Ih =
% %
% %     1.9338
% %
% %
% % Ih =
% %
% %     1.9835
% %
% %
% % Ih =
% %
% %     1.9959
% %
% %
% % ans =
% %
% % 2
% n1=1/5; Ih1 =riemquad(@(x)sin(x),0,pi, n1)
% n2=n1*2; Ih2 =riemquad(@(x)sin(x),0,pi, n2)
% Iest= (Ih1*1/n2-Ih2*1/n1)/(1/n2-1/n1)
