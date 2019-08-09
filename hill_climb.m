
function [tour,eva] = hill_climb(city)
t=0;
len=length(city);
% generate matix of city distance
dist=squareform(pdist(city));
tour=randperm(len);
eva = evaluate(dist,tour);
% init a global best tour
gtour=tour;
geva = evaluate(dist,gtour);
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
            if evaClimb<eva
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
% return the global best solution
tour = gtour;
eva = geva;

end
