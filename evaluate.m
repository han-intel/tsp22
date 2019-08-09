function eva = evaluate(dist,tour)
eva=0;
num=length(tour);
for i=1:num
    j=i+1;
    if j>num
        j=1;
    end
    eva=eva+dist(tour(i),tour(j));
end
