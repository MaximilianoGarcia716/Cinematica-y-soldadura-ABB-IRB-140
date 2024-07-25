clc, close all, 

syms H L C1 C2 C3 C4 C5 C6 S1 S2 S3 S4 S5 S6 A1 A2 D1 D4 D6

A_01 = [C1,0,-S1,A1*C1;  S1,0,C1,A1*S1;   0,-1,0,D1;  0,0,0,1];   
A_12 = [C2,-S2,0,A2*C2;  S2,C2,0,A2*S2;   0,0,1,0;    0,0,0,1];
A_23 = [C3,0,-S3,0;      S3,0,C3,0;       0,-1,0,0;   0,0,0,1];
A_34 = [C4,0,S4,0;       S4,0,-C4,0;      0,1,0,D4;   0,0,0,1];
A_45 = [C5,0,-S5,0;      S5,0,C5,0;       0,-1,0,0;   0,0,0,1];
A_56 = [C6,-S6,0,H*C6;   S6,C6,0,H*S6;    0,0,1,D6+L; 0,0,0,1];

A_06 = A_01*A_12*A_23*A_34*A_45*A_56;

disp('Matriz de transformacion del extremo respecto la base'); disp('A_06:');disp(A_06);

disp('A_06(:,1):');disp(A_06(:,1));disp('A_06(:,2):');disp(A_06(:,2));
disp('A_06(:,3):');disp(A_06(:,3));disp('A_06(:,4):');disp(A_06(:,4));

r_11= C6*(C5*(S1*S4 + C4*(C1*C2*C3 - C1*S2*S3)) - S5*(C1*C2*S3 + C1*C3*S2)) - S6*(S4*(C1*C2*C3 - C1*S2*S3) - C4*S1);
r_21= C6*(C5*(C4*(C2*C3*S1 - S1*S2*S3) - C1*S4) - S5*(C2*S1*S3 + C3*S1*S2)) - S6*(S4*(C2*C3*S1 - S1*S2*S3) + C1*C4);
r_31= C6*(S5*(S2*S3 - C2*C3) - C4*C5*(C2*S3 + C3*S2)) + S4*S6*(C2*S3 + C3*S2);

r_12= -S6*(C5*(S1*S4 + C4*(C1*C2*C3 - C1*S2*S3)) - S5*(C1*C2*S3 + C1*C3*S2)) - C6*(S4*(C1*C2*C3 - C1*S2*S3) - C4*S1);
r_22= -S6*(C5*(C4*(C2*C3*S1 - S1*S2*S3) - C1*S4) - S5*(C2*S1*S3 + C3*S1*S2)) - C6*(S4*(C2*C3*S1 - S1*S2*S3) + C1*C4);
r_32=  C6*S4*(C2*S3 + C3*S2) - S6*(S5*(S2*S3 - C2*C3) - C4*C5*(C2*S3 + C3*S2));

r_13= -C5*(C1*C2*S3 + C1*C3*S2) - S5*(S1*S4 + C4*(C1*C2*C3 - C1*S2*S3));
r_23= -C5*(C2*S1*S3 + C3*S1*S2) - S5*(C4*(C2*C3*S1 - S1*S2*S3) - C1*S4);
r_33= C5*(S2*S3 - C2*C3) + C4*S5*(C2*S3 + C3*S2);

X_0= A1*C1 - (C5*(C1*C2*S3 + C1*C3*S2) + S5*(S1*S4 + C4*(C1*C2*C3 - C1*S2*S3)))*(D6 + L) - D4*(C1*C2*S3 + C1*C3*S2) + A2*C1*C2 + C6*H*(C5*(S1*S4 + C4*(C1*C2*C3 - C1*S2*S3)) - S5*(C1*C2*S3 + C1*C3*S2)) - H*S6*(S4*(C1*C2*C3 - C1*S2*S3) - C4*S1); 
Y_0= A1*S1 - (C5*(C2*S1*S3 + C3*S1*S2) + S5*(C4*(C2*C3*S1 - S1*S2*S3) - C1*S4))*(D6 + L) - D4*(C2*S1*S3 + C3*S1*S2) + A2*C2*S1 + C6*H*(C5*(C4*(C2*C3*S1 - S1*S2*S3) - C1*S4) - S5*(C2*S1*S3 + C3*S1*S2)) - H*S6*(S4*(C2*C3*S1 - S1*S2*S3) + C1*C4);
Z_0= D1 + (C5*(S2*S3 - C2*C3) + C4*S5*(C2*S3 + C3*S2))*(D6 + L) + D4*(S2*S3 - C2*C3) - A2*S2 + C6*H*(S5*(S2*S3 - C2*C3) - C4*C5*(C2*S3 + C3*S2)) + H*S4*S6*(C2*S3 + C3*S2);



%{
A_01_inv = inv(A_01);
A_12_inv = inv(A_12);
A_23_inv = inv(A_23);
A_34_inv = inv(A_34);
A_45_inv = inv(A_45);
A_56_inv = inv(A_56);
A_06_inv = inv(A_06);
%}


