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
    %       DH parameter table
    %     theta  d  a  alpha  R/T
    %
    d_h = [0    d1  a1  -pi/2  0;
%            0-pi/2    0   a2    0    0;
           0    0   a2    0    0;
           0    0   0   -pi/2  0;  
           0    d4  0    pi/2  0;  
           0    0   0   -pi/2  0;
           0   d6   0     0    0];
    %}

% objeto:
R = SerialLink(d_h, 'name','IRB140 Welding Torch');
% offset en articulaciones:
R.offset = [0 pi/2 pi/4 pi/4 0 0];
% posición a mostrar:
q = [-pi/4 -pi -pi/3 2*pi/3 -pi/3 pi];
%q = [0 0 0 0 0 0];
% espacio de trabajo (-x, +x, -y, +y, -z, +z):
ws = [-2, 2,-2, 2, -1 2];
% plot modelos 3D:
R.plot3d(q,'path',pwd,'workspace',ws)
%R.plot(q,'workspace',ws)
% panel para mover articulaciones:
R.teach


h = [  
    0.000  0.352  0.070 -pi/2  0;
    0.000  0.000  0.360  0.000 0;
    0.000  0.000  0.000 -pi/2  0;
    0.000  0.380  0.000  pi/2  0;
    0.000  0.000  0.000 -pi/2  0;
    0.000  0.065  0.000  0.000 0];

R = SerialLink(h);

q = [0 -pi/2 0 0 0 0];
 
for i = 1:R.n
    A = double(R.links(i).A(q(i)));    
    disp(['A',num2str(i),':'])
    disp(A)
end

