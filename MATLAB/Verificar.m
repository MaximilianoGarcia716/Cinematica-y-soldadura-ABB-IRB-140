function Verificar(T,q)

    for i=1:size(q,2)
        Ti = CinematicaDirecta(T,q(:,i));
        disp('Ti: '), disp(Ti), disp('T: '), disp(T),
    end

end