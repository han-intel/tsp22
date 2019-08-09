function [tour,eva] = evolution_path_ox(city)
len=length(city);
dist=squareform(pdist(city));
t=0;
psize = 30;
%random parent
p=zeros(psize,len);
for i=1:psize
    tourP=randperm(len);
    p(i,:)=tourP;
end
while t<200
    t=t+1;
    o=zeros(psize,len);
    %create offspring
    pr=randperm(psize);
    for i=1:2:psize-1
        p1=p(pr(i),:);
        p2=p(pr(i+1),:);
        o1=zeros(1,len);
        o2=zeros(1,len);
        c=randi(len,1,2);
        c1=c(1);
        c2=c(2);
        if c1>c2
            t1=c1;
            c1=c2;
            c2=t1;
        end
        o1(c1:c2)=p1(c1:c2);
        o2(c1:c2)=p2(c1:c2);
        p1order=[p1(c2+1:len),p1(1:c2)];
        p2order=[p2(c2+1:len),p2(1:c2)];
        %order the left elements in parents
        p1left=zeros(1,len-(c2-c1+1));
        p2left=zeros(1,len-(c2-c1+1));
        p1leftindex=1;
        p2leftindex=1;
        for j=1:len
            if ismember(p2order(j),o1)==0
                p1left(p1leftindex)=p2order(j);
                p1leftindex=p1leftindex+1;
            end
            if ismember(p1order(j),o2)==0
                p2left(p2leftindex)=p1order(j);
                p2leftindex=p2leftindex+1;
            end
        end
        o1(c2+1:len)=p1left(1:len-c2);
        o1(1:c1-1)=p1left(len-c2+1:length(p1left));
        o2(c2+1:len)=p2left(1:len-c2);
        o2(1:c1-1)=p2left(len-c2+1:length(p2left));
        o(i,:)=o1;
        o(i+1,:)=o2;
    end
    %choose the best 30 from parents and offsprings
    a=zeros(psize*2,len);
    a(1:psize,:)=p;
    a(psize+1:psize*2,:)=o;
    aeva=zeros(psize*2,2);
    for i=1:psize*2
        aeva(i,1)=evaluate(dist,a(i,:));
        aeva(i,2)=i;
    end
    aeva=sortrows(aeva);
    for i=1:psize
        p(i,:)=a(aeva(i,2),:);
    end
end
%choose the best one
aeva=zeros(psize,2);
for i=1:psize
    aeva(i,1)=evaluate(dist,p(i,:));
    aeva(i,2)=i;
end
aeva=sortrows(aeva);
tour=p(aeva(1,2),:);
eva=evaluate(dist,tour);


