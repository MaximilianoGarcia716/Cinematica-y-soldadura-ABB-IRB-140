clc
clear
close all
% dimensiones:

    d1 = 0.352;
    a1 = 0.070;
    a2 = 0.360;
    d4 = 0.380;
    d6 = 0.065;
    
    % DH parameter table
    %     theta d a alpha
    d_h = [0 d1 a1  -pi/2 0;
          0 0  a2  0      0;
          0 0  0   pi/2   0;
          0 d4 0   -pi/2  0;
          0 0  0   pi/2   0;
          0 d6 0   pi/2   0];
 
% objeto:
R = SerialLink(d_h);
% offset en articulaciones:
R.offset = [0 pi/2 pi/4 pi/4 0 0];
% posición a mostrar:
q = [0 -pi/4 0 pi/4 pi/2 0];
% espacio de trabajo (-x, +x, -y, +y, -z, +z):
ws = [-2, 2,-2, 2, -1 2];
% plot modelos 3D:
%R.plot3d(q,'path',pwd,'workspace',ws)
R.plot(q,'workspace',ws)
% panel para mover articulaciones:
R.teach

