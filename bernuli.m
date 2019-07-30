function [p,u]=bernuli(data1,data2)
n=sum(data1);
w=sum(data2);
if n<=1
    p=NaN;
    u=NaN;
else
p=w/n;
u=sqrt(p*(1-p)/(n-1));
end
end