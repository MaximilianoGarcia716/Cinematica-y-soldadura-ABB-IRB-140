%Funcion para animar una trayectoria del robot y compararla con los puntos
%generados
function [] = AnimarRobot(robot,qs,Ps,ws)

qs=transpose(qs);
for i=1:1:size(qs,1)
    robot.plot(qs(i,:),'workspace',ws,'scale',0.5);
    T=double(robot.fkine(qs(i,:)'));
    hold on
    plot3(T(1,4),T(2,4),T(3,4),'*r');
    plot3(Ps(1,:),Ps(2,:),Ps(3,:),'b');
    %hold off
    pause(0.01)
end
plot3(T(1,4),T(2,4),T(3,4),'*r');
hold off