function q = CinematicaInversa(robot, T_07)

q = zeros(6,8);
THerramienta = double(robot.tool);
T = T_07*inv(THerramienta);

Z = T(1:3,3);
L6 = robot.d(6);

Px = T(1,4);
Py = T(2,4);
Pz = T(3,4);

% Pm: posicion de la muñeca
Pm = [Px Py Pz]' - L6*Z;

% si q(1) es solucion, entonces q(1) + pi tambien es solucion
q1 = atan2(Pm(2), Pm(1));

q2_1 = Theta2(robot, [q1 0 0 0 0 0], Pm);

q2_2 = Theta2(robot, [q1+pi 0 0 0 0 0], Pm);

q3_1 = Theta3(robot, [q1 0 0 0 0 0], Pm);
q3_2 = Theta3(robot, [q1+pi 0 0 0 0 0], Pm);
    
q = [q1         q1         q1        q1       q1+pi   q1+pi   q1+pi   q1+pi;   
     q2_1(1)    q2_1(1)    q2_1(2)   q2_1(2)  q2_2(1) q2_2(1) q2_2(2) q2_2(2);
     q3_1(1)    q3_1(1)    q3_1(2)   q3_1(2)  q3_2(1) q3_2(1) q3_2(2) q3_2(2);
     0          0          0         0         0      0       0       0;
     0          0          0         0         0      0       0       0;
     0          0          0         0         0      0       0       0];

% se dejan las partes reales+
q = real(q);

% q3 tiene un rango no simetrico, por eso se evita la
% normalizacion de -pi  a pi como en todos los otros qi

 q(1,:) = Norma(q(1,:));
 q(2,:) = Norma(q(2,:));

% 3 ultimas articulaciones para las combinaciones de las primeras 3
for i=1:2:size(q,2)    
    % Metodo algebraico/ Metodo geometrico 
    qtemp = Pieper(robot, q(:,i), T, 1); %  codo arriba
    qtemp(4:6) = Norma(qtemp(4:6));
    q(:,i) = qtemp;
    
    qtemp = Pieper(robot, q(:,i), T, -1); %  codo abajo
    qtemp(4:6) = Norma(qtemp(4:6));
    q(:,i+1) = qtemp;
end

 q = q - robot.offset' * ones(1,8); 
 q = Norma(q);
end







