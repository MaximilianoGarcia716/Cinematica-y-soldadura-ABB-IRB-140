function A = D_H(theta, d, a, alpha)

if(alpha == -1)  % HAY QUE RESTARLE EL OFFSET
        irb = theta;
        q = d + irb.offset;
        i = a;
        
        theta = q(i);
        d = irb.d(i);
        a = irb.a(i);
        alpha = irb.alpha(i);      
        
        A=[ cos(theta)  -cos(alpha)*sin(theta)   sin(alpha)*sin(theta)   a*cos(theta);
            sin(theta)   cos(alpha)*cos(theta)  -sin(alpha)*cos(theta)   a*sin(theta);
            0              sin(alpha)             cos(alpha)             d;
            0                     0                     0                1];
else if(alpha == 1) % NO HAY QUE RESTARLE EL OFFSET
        irb = theta;
        q = d;
        i = a;
        
        theta = q(i);
        d = irb.d(i);
        a = irb.a(i);
        alpha = irb.alpha(i);      
        
        A=[ cos(theta)  -cos(alpha)*sin(theta)   sin(alpha)*sin(theta)   a*cos(theta);
            sin(theta)   cos(alpha)*cos(theta)  -sin(alpha)*cos(theta)   a*sin(theta);
            0              sin(alpha)             cos(alpha)             d;
            0                     0                     0                1];
else  % INGRESO LOS 4 PARAMETROS Y CALCULA LA MATRIZ
        A=[ cos(theta)  -cos(alpha)*sin(theta)   sin(alpha)*sin(theta)   a*cos(theta);
            sin(theta)   cos(alpha)*cos(theta)  -sin(alpha)*cos(theta)   a*sin(theta);
            0              sin(alpha)             cos(alpha)             d;
            0                    0                     0                 1];
end

end