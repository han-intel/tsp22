
function [tour,eva] = stochastic_hill_climb(city)
t=0;
len=length(city);
% generate matix of city distance
dist=squareform(pdist(city));
tour=randperm(len);
eva = evaluate(dist,tour);
% init a global best tour
gtour=tour;
geva = evaluate(dist,gtour);
%if small like 1 the search revert into ordinary hill-climb,and when too huge the search becomes random
temperature = 0.1;
while (t<100)
    t=t+1;
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
end
tour = gtour;
eva = geva;
