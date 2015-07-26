% Animated diagram of the eigenvalues of the linear oscillator
function animated_eigenvalue_diagram
    m= 13;    k=  6100; omega_n= sqrt(k/m);
    c_cr=2*m*omega_n;
    grid on;
    phi =linspace(0,360,37);
    plot(omega_n*cos(phi/360*2*pi),omega_n*sin(phi/360*2*pi),'k-','linewidth',2);
    set(gca,'xlim', 1.1*omega_n*[-2.5,1]);
    set(gca,'ylim', 1.1*omega_n*[-1,1]);
    axis equal
    hold on
    grid on;
    zetas= {linspace(0, 1.5, 40),linspace(1.5, 0, 40),linspace(0, 1.5, 40),linspace(1.5, 0, 40)};
    pD=zeros(2);
    for j=1:length(zetas)
        for zeta=zetas{j}
            c=zeta*c_cr;
            A = [0, 1; -omega_n^2, -(c/m)];
            [V,D]=eig(A);
            plot(real(pD(1,1)),imag(pD(1,1)),'wo','linewidth',4);
            plot(real(pD(2,2)),imag(pD(2,2)),'wo','linewidth',4);
            plot(omega_n*cos(phi/360*2*pi),omega_n*sin(phi/360*2*pi),'k-','linewidth',2);
            plot(real(D(1,1)),imag(D(1,1)),'mo','linewidth',4);
            plot(real(D(2,2)),imag(D(2,2)),'mo','linewidth',4);
            xlabel('Re\lambda'),ylabel('Im\lambda')
            title(['\zeta=' num2str(zeta)])
            pause(0.1)
            pD=D;
        end
    end
end