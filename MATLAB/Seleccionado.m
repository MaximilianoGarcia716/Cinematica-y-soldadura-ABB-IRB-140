 function q = Seleccionado(qTotal, qconsigna)
q = -1;

for i=1:size(qTotal,2)
    distancia = 0;
    x=0;
    for j = 1:size(qTotal,1)
        x = x + ( qTotal(j,i) - qconsigna(j) )^2;
    end
    distancia = sqrt(x);   % DEVUELVE UN NUMERO
    if(distancia == 0)      
        q = i;
        break;
    end
    
end
end

