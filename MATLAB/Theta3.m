 function q3 = Theta3(robot, q, Pm)

L2 = robot.a(2);
L3 = robot.d(4);
 
T01 = D_H(robot, q, 1,1);

p1 = inv(T01)*[Pm; 1];
r = sqrt(p1(1)^2 + p1(2)^2);
eta = (acos((L2^2 + L3^2 - r^2)/(2*L2*L3)));

if ~isreal(eta)
   disp('WARNING: puntopara q3 no alcanzable, soluciones imaginarias'); 
end

q3(1) = pi/2 - eta;
q3(2) = eta - 3*pi/2;
 end