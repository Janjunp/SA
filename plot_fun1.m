function y=plot_fun1(x)
global xx
global yuce
alpha=x(1);
beta=x(2);
gamma=x(3);
fc=12;%预测期数
k=12;
S=xx;
plot(S,'r-');
n=length(S);
a(1)=sum(S(1:k))/k;
b(1)=(sum(S(k+1:2*k))-sum(S(1:k)))/k^2;
s=S-a(1);
y=a(1)+b(1)+s(1);

for i=1:n+fc+1
    if i==length(S)
        S(i+1)=a(end)+b(end)+s(end-k+1);
    end
a(i+1)=alpha*(S(i)-s(i))+(1-alpha)*(a(i)+b(i));%水平平滑方程
b(i+1)=beta*(a(i+1)-a(i))+(1-beta)*b(i);%趋势为0
s(i+1)=gamma*(S(i)-a(i)-b(i))+(1-gamma)*s(i);%季节平滑方程
y(i+1)=a(i+1)+b(i+1)+s(i+1);
end 
hold on
m=length(y);
j=n:m-1;
y(n+1)=[];
for i=1 : 12
yuce(i) = y(j(i+2));%将预测值存入全局变量
end
plot(y(2:end-12),'b-')%拟合曲线
plot(j-1,y(j),'g')%预测数据的曲线
set(gca,'XTick',0:1:50);
legend('实际月销量','拟合月销量','预测之后12个月的月销量')
xlabel('日期');
ylabel('销量');