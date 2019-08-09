function [tour,eva] = tabu_search(city)
%TUBA_SEARCH Summary of this function goes here
%   Detailed explanation goes here
t=0;
len=length(city);
% generate matix of city distance
dist=squareform(pdist(city));
tour=randperm(len);
eva = evaluate(dist,tour);
% init a global best tour
gtour=tour;
geva = evaluate(dist,gtour);
recency = 5;
while (t<10)
    t=t+1;
    count =0;
    
% memorize search recently
    memory = zeros(len);
% iterate for 100 times
    while(count<100)
        count=count+1;
% init iterating tour 
        tourIterate = tour;
        tourIbest = tour;
        evaIbest = eva;
        ind = [0,0];
% two interchange
        for i = 1:len
            tourClimb = tourIterate;
            for j=i+1:len
%                 tabu
                if memory(i,j)~=0&&count-memory(i,j)<recency
                    continue;
                end
% exchange current site with the back sites.            
                c = tourClimb(i);
                tourClimb(i)= tourClimb(j);
                tourClimb(j)=c;
                evaClimb=evaluate(dist,tourClimb);
                if evaClimb<evaIbest
                    tourIbest = tourClimb;
                    evaIbest = evaClimb;
                    ind=[i,j];
                end
            end
        end
        
% update tabu memory
        if ind(1)>0 && ind(2)>0
            memory(ind(1),ind(2))=count;
        end
        if evaIbest<eva
           tour = tourIbest;
           eva = evaIbest;
        end
        
    end
%     restore the global best solution
    if eva<geva
        gtour = tour;
        geva = eva;
    end
%     generate a new random tour
    tour=randperm(len);
    eva = evaluate(dist,tour);
end
tour = gtour;
eva = geva;
end

