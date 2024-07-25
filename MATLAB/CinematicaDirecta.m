function [Ttotal] = CinematicaDirecta(robot,q)

THerramienta = double(robot.tool);  % NOTA: T.tool es un objeto, por eso lo convierto para poder usarlo
A_0 = double(robot.base);           % Por defecto es la identidad de 4x4   
T = A_0;

for i=1:length(q),
    Tant = T*D_H(robot,q,i,-1);
    T = Tant;
%     disp(i),disp(D_H(robot,q,i,-1))
end

Ttotal = T*THerramienta;

end

