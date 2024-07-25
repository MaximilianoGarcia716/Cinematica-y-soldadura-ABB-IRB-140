function Space(robot,option)

hold on;
if option==1
    jump=2*pi/360*16;
        for q2=robot.qlim(2,1):jump:robot.qlim(2,2)
            for q3=robot.qlim(3,1):jump:robot.qlim(3,2)
                    for q5=robot.qlim(5,1):jump:robot.qlim(5,2)
                            %q=[-60*2*pi/360 q2 q3 0 q5 0];
                            q=[-60*2*pi/360 q2 q3 0 q5 0];
                            qprint=CinematicaDirecta(robot,q);
                            qprint=[qprint(1,4);qprint(2,4);qprint(3,4)];
                            plot3(qprint(1),qprint(2),qprint(3),'b.'); 
                    end
            end
        end
end
if option==2
    jump=2*pi/360*4;
        for q3=robot.qlim(3,1):jump:robot.qlim(3,2)
                for q2=robot.qlim(2,1):jump:robot.qlim(2,2)
                q=[-60*2*pi/360 q2 q3 0 0 0];
                            qprint=CinematicaDirecta(robot,q);
                            qprint=[qprint(1,4);qprint(2,4);qprint(3,4)];
                            plot3(qprint(1),qprint(2),qprint(3),'r.'); 
                end
        end
end
hold off;