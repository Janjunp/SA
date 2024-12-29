function y=fun1(x)
global xx
alpha=x(1);
beta=x(2);
gamma=x(3);
%fc=12;预测期数
k=12;
S=xx;
n=length(S);
a(1)=sum(S(1:k))/k;
b(1)=(sum(S(k+1:2*k))-sum(S(1:k)))/k^2;
s=S-a(1);
y=a(1)+b(1)+s(1);

for i=1:n%+fc
    if i==length(S)
        S(i+1)=a(end)+b(end)+s(end-k+1);
    end
a(i+1)=alpha*(S(i)-s(i))+(1-alpha)*(a(i)+b(i));
b(i+1)=beta*(a(i+1)-a(i))+(1-beta)*b(i);%趋势
s(i+1)=gamma*(S(i)-a(i)-b(i))+(1-gamma)*s(i);%周期
y(i+1)=a(i+1)+b(i+1)+s(i+1);
end
    sse=0;%计算sse
    for j=2:37
    sse=sse+(y(j)-xx(j-1))^2;
    end
 y=sse;

