function q2 = Theta2(robot, q, Pm)

L2 = robot.a(2);
L3 = robot.d(4);

T01 = D_H(robot,q,1,1);

% Se expresa Pm en referencia al sistema 1
p1 = inv(T01)*[Pm ; 1];
r = sqrt(p1(1)^2 + p1(2)^2);

beta = atan2(-p1(2), p1(1));
gamma = (acos((L2^2 + r^2 - L3^2)/(2*r*L2)));

if ~isreal(gamma)
    disp('WARNING: punto para q2 no alcanzable, soluciones imaginarias'); 
end

q2(1) = - beta - gamma;% + pi/2; % codo arriba
q2(2) = - beta + gamma;% + pi/2; % codo abajo
end
 % sa