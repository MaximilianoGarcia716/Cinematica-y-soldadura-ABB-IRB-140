function q = Pieper(robot, q, T, wrist, method)

        A01 = D_H(robot, q, 1,1);
        A12 = D_H(robot, q, 2,1);
        A23 = D_H(robot, q, 3,1);
        
        Q = inv(A23)*inv(A12)*inv(A01)*T;
        
        % Si q5 = 0 -> hay infinitas soluciones. Por eso es que usa un thresh
        thresh = 1e-12;
        if abs(Q(3,3)-1)>thresh
            if wrist==1 
                q(4)=atan2(Q(2,3),Q(1,3));
                q(6)=atan2(Q(3,2),-Q(3,1));
            else 
                q(4)=atan2(Q(2,3),Q(1,3))+pi;
                q(6)=atan2(Q(3,2),-Q(3,1))+pi;
            end
            
            if abs(cos(q(6)+q(4)))>thresh
                cq5=-(-Q(1,1)-Q(2,2))/cos(q(4)+q(6))-1;
            end
            if abs(sin(q(6)+q(4)))>thresh
                cq5=-(Q(1,2)-Q(2,1))/sin(q(4)+q(6))-1;
            end
            
            if abs(sin(q(6)))>thresh
                sq5=-Q(3,2)/sin(q(6));
            end
            if abs(cos(q(6)))>thresh
                sq5=Q(3,1)/cos(q(6));
            end
            q(5)=atan2(sq5,cq5);
        else 
            if wrist==1 
                q(4)=0;
                q(5)=0;
                q(6)=atan2(Q(1,2)-Q(2,1),-Q(1,1)-Q(2,2));
            else 
                q(4)=-pi;
                q(5)=0;
                q(6)=atan2(Q(1,2)-Q(2,1),-Q(1,1)-Q(2,2))+pi;
            end
            
        end
        
