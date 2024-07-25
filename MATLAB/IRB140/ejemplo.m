clc
clear
close all
% dimensiones:
    
    d1 = 0.352;
    a1 = 0.070;
    a2 = 0.360;
    d4 = 0.380;
    d6 = 0.065;
    L = 0.382;
    H = 0.114;
% parámetros DH (tita, d, a, alfa, sigma):

    dh = [0 d1 a1  -pi/2
          0 0  a2  0
          0 0  0   -pi/2
          0 d4 0   pi/2
          0 0  0   -pi/2
          0 d6 0   0];    

       
% objeto:
R = SerialLink(dh);
% offset en articulaciones:
R.offset = [0 pi/2 pi/4 pi/4 0 0];
% posición a mostrar:
q = [-pi/4 -pi -pi/3 2*pi/3 -pi/3 pi];
% espacio de trabajo (-x, +x, -y, +y, -z, +z):
ws = [-1, 1,-1, 1, 0 1.1];
% plot modelos 3D:
R.plot3d(q,'path',pwd,'workspace',ws)
%R.plot(q,'workspace',ws)
% panel para mover articulaciones:
R.teach