
clc, clear, close all,

% ---- DIMENSIONES --------------------------------------------------------
d1 = 0.352;
a1 = 0.070;
a2 = 0.360;
d4 = 0.380;
d6 = 0.065; %

% ------------ PARAMETROS DH ----------------------------------------------
%     theta  d  a  alpha  R/T  (0:R / 1:T)
d_h = [0.0     d1   a1    -pi/2  0;
       0.0    0.0   a2     0.0   0;   % theta -pi/2
       0.0    0.0   0.0   -pi/2  0;  
       0.0     d4   0.0    pi/2  0;  
       0.0    0.0   0.0   -pi/2  0;
       0.0     d6   0.0    0.0   0];
       
% ------------ OBJETO -----------------------------------------------------
R = SerialLink(d_h, 'name','IRB140 Welding Torch');

% ----------- HERRAMIENTA -------------------------------------------------  
L = 0.295;  % largo 
H = 0.112;  % alto 
R.tool = transl([-H, 0, L])*troty(-pi/4);%* trotx(pi/3); % ES UN OBJETO

% OFFSET en articulaciones ------------------------------------------------
R.offset = [5*pi/6 1.6*pi 1.9*pi pi 0.1 -pi];   

% LIMITES de las articulaciones -------------------------------------------
Qlimites = [-pi     -pi/2    -23*pi/18   -20*pi/18   -12*pi/18  -40*pi/18; 
             pi   11*pi/18    5*pi/18     20*pi/18    12*pi/18   40*pi/18];
R.qlim = Qlimites';

% POSICION A MOSTRAR ------------------------------------------------------
%qpos = [(pi/8) -pi/2  -(2*pi/3) (2*pi/3) -pi/3 -pi/2];
% qpos=[0.1 0.2 0.3 0.4 0.5 0.6];
 qpos=[-60*2*pi/360 -20*2*pi/360 -70*2*pi/360 0 0 0];

% ESPACIO DE TRABAJO (-x, +x, -y, +y, -z, +z) -----------------------------
ws = [-2, 2,-2, 2, -0.5 2];

% ------- GRAFICAR --------------------------------------------------------
%R.plot3d(qpos,'path',pwd,'workspace',ws)
R.plot(qpos,'workspace',ws,'scale',0.5)

% PANEL para mover articulaciones:
R.teach('approach')

% =========================================================================
%       CINEMATICA
% =========================================================================
Ttotal = CinematicaDirecta(R,qpos); % SUMAR OFFSET
disp('Ttotal: '), disp(Ttotal);


qinvSoluciones = CinematicaInversa(R,Ttotal); % RESTAR OFFSET
disp('qinvSoluciones: '), disp(qinvSoluciones), disp('');
disp('Posiciones deseadas: '),disp(qpos),
disp('Offset: '),disp(R.offset),
disp('Qlim: '),disp(R.qlim')
% Elegido = Seleccionado(qinvSoluciones,qpos); % Problema con 0 o pi durante la norma
% Verificar(Ttotal,qinvSoluciones)
%{
Pos = getpos(R); devuelve los q1
%}


%Calculamos 8 trayectorias del robot para una linea recta
Roll=0;
Pitch=-pi/4;
Yaw=0;
Rot=[Roll Pitch Yaw];
% P1=[0.2;0.4;0.4];
% P2=[0.3;0.6;0.4];
P1=[-0.4;-0.4;0.3];
P2=[-0.4;0.6;0.7];
dist=0.005;
[qs,Ps,singularidades]=Trayectoria(R,P1,P2,Rot,dist);
%animamos al robot para las 8 trayectorias siempre que estas no tengan
%singularidades

% JacobMat=[];
% detJacobiano=zeros(8,1);
% for i=1:1:size(qs,2)
%     for j=1:1:size(qs,3)
%         detJacobiano(j)=det(R.jacob0(transpose(qs(:,i,j))));
%     end
%     JacobMat=[JacobMat detJacobiano];
% end
%ctrl+R=Comentar
%ctrl+T=Descomentar

for i=1:1:8
    if singularidades(i)==0
        trayectoria=qs(:,:,i);
        AnimarRobot(R,trayectoria,Ps,ws);
        pause(1);
    else
        plot3(Ps(1,:),Ps(2,:),Ps(3,:),'r');
        printstring=sprintf('La trayectoria %.0f no se anima por presencia de singularidad',i);
        disp(printstring);
    end
end
%Visualizamos el plano yz del espacio de trabajo
pause(1)
R.plot(qpos,'workspace',ws,'scale',0.5)
view(90,0);
Space(R,2);
pause(1)
Space(R,1);