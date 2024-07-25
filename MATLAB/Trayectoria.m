%Funcion que genera una trayectoria recta y devuelve una matriz con las
%posibles trayectorias en el espacio articular, asi como los puntos para
%poder graficarlos luego
function [qs,Ps,singularidades] = Trayectoria(robot,P1,P2,Rot,dist)

singularidades=zeros(8,1);
%Calculamos el vector director de la recta y normalizamos
Pd=P2-P1;
%tomamos los valores de Roll, Pitch y Yaw deseados
Roll=Rot(1);
Pitch=Rot(2);
Yaw=Rot(3);



%Discretizamos los vectores y los guardamos en una matriz, sumamos 2 al
%tamaño de los vectores porque toma el primero y ultimo punto
Psx=linspace(P1(1),P2(1),norm(Pd)/dist+2);
Psy=linspace(P1(2),P2(2),norm(Pd)/dist+2);
Psz=linspace(P1(3),P2(3),norm(Pd)/dist+2);
Ps=[Psx;Psy;Psz];
printstring=sprintf('Distancia real del trazado: %f\n',(norm(Ps(:,2)-Ps(:,1))));
disp(printstring);

%armamos las matrices de Roll Pitch Yaw
Rm=[1     0         0;
    0 cos(Roll) -sin(Roll);
    0 sin(Roll) cos(Roll)];

Pm=[cos(Pitch) 0 sin(Pitch);
         0     1     0     ;
   -sin(Pitch) 0 cos(Pitch)];

Ym=[cos(Yaw) -sin(Yaw) 0;
    sin(Yaw) cos(Yaw)  0;
        0       0      1];
%armamos la matriz de rotacion
R=Ym*Pm*Rm;

%calculamos la matriz q donde cada vector q(:,i) son las coordenadas
%angulares del robot para un punto dado, y cada q(:,:,i) son las posibles
%trayectorias basadas en la cinematica inversa del primer punto

q=zeros(6,size(Ps,2),8);
T=[R,Ps(:,1);0,0,0,1];
qprovisorio=CinematicaInversa(robot,T);
%calculamos la cinematica inversa del primer punto y la guardamos en la 
%segunda coordenada de cada trayectoria, dejando como primer punto al 
%[0,0,0,0,0,0]
for i=1:1:size(q,3)
   q(:,1,i)= qprovisorio(:,i);
end

for i=2:1:size(q,2)
    %Calculo La Ci para cada punto
   T=[R,Ps(:,i-1);0,0,0,1];
   qprovisorio=CinematicaInversa(robot,T);
   for j=1:1:size(q,3)
       distmin=1000;
       for k=1:1:8
           %calculo la distancia de las coordenadas a las del punto
           %anterior de la trayectoria y elijo la mas cercana
           DistanciaArticular=norm(qprovisorio(:,k)-q(:,i-1,j));
           if distmin>DistanciaArticular
               next=k;
               distmin=DistanciaArticular;
           end
       end
       q(:,i,j)=qprovisorio(:,next);
   end
end
%calculo la distancia articular recorrida por cada trayectoria desde el
%punto P1 a P2, siendo la que menor distancia recorra la mas continua de
%todas
DistanciaTotal=zeros(size(q,3),1);
for i=1:1:size(q,3)
    for j=2:1:size(q,2)
        DistanciaArticular=norm(q(:,j,i)-q(:,j-1,i));
        DistanciaTotal(i)=DistanciaTotal(i)+DistanciaArticular;
    end
end
%ordeno las soluciones de la que recorre menos distancia articular a la que
%recorre mas
qs=zeros(6,size(Ps,2),8);
for i=1:1:size(q,3)
    [~,m]=min(DistanciaTotal);
    qs(:,:,i)=q(:,:,m);
    DistanciaTotal(m)=10000000;
end

%Reordeno enviando las soluciones con jacobiano con valor absoluto <0.05 al
%final de un vector auxiliar qss, y manteniendo las soluciones con
%determinantte jacobiano >0.05 al inicio
inicio=1;
final=8;
qss=qs*0;
for i=1:1:size(q,3)
    minJacobiano=1000;
    for j=2:1:size(q,2)
        Jacobiano=robot.jacob0(transpose(qs(:,j,i)));
        DetJacobiano=det(Jacobiano);
        if minJacobiano>abs(DetJacobiano)
            minJacobiano=abs(DetJacobiano);
        end
    end
    if minJacobiano<0.05
        qss(:,:,final)=qs(:,:,i);
        singularidades(final)=1;
        final=final-1;
    else
        qss(:,:,inicio)=qs(:,:,i);
        inicio=inicio+1;
    end
end
%Asigno el valor de qss a qs
qs=qss;