
%  Normaliza de -pi a pi
function q = Norma(q)

for i=1:size(q,2)
   q(:,i)=atan2(sin(q(:,i)),cos(q(:,i))); 
end

end
