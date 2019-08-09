
function [tour,eva] = stimulated_annealing(city)
t=0;
len=length(city);
% generate matix of city distance
dist=squareform(pdist(city));
% init tour
tour=randperm(len);
eva = evaluate(dist,tour);
% init a global best tour
gtour=tour;
geva = evaluate(dist,gtour);
%if small like 1 the search revert into ordinary hill-climb,and when too huge the search becomes random
tmax = 10;
tmin = 0.1;
temperature=tmax;
while (t<100)
%     repeat the annealing process
    st = 0;
    while (st<100)
%         temperature=annealing(temperature,st);
        % init iterating tour 
        tourIterate = tour;
        for i = 1:len
            tourClimb = tourIterate;
            for j=i+1:len
                % exchange current site with the back sites.            
                c = tourClimb(i);
                tourClimb(i)= tourClimb(j);
                tourClimb(j)=c;
                evaClimb=evaluate(dist,tourClimb);
                probability=1/(1+exp((evaClimb-eva)/temperature));
    %           change the best tour with probability
                if evaClimb<eva
                    tour = tourClimb;
                    eva = evaClimb;
                    
                elseif rand()<=probability
                    tour = tourClimb;
                    eva = evaClimb;
                end
                if evaClimb<geva
                    gtour = tourClimb;
                    geva = evaClimb;
                end
            end
        end
        st = st+1;
    end
%     update the temperature
    temperature=annealing(temperature,t);
    t=t+1;
end
tour = gtour;
eva = geva;
    function temperature = annealing(temperature,t)
%     temperature decay rate
    rate = 0.1;
    temperature = tmax*exp(-t*rate);
    end
end
