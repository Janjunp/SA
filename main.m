clear
clc
load yinghu5.mat
global xx
global yuce
yuce = zeros(12,1);
xx=xx1;

narvs = 3 ;
T0 = 1000;   % 初始温度
T = T0; %第一次迭代时温度为T0
maxgen = 5000;  
Lk = 200;  
alfa = 0.95;  % 温度衰减系数
x_lb = [0 0 0];%参数的下界
x_ub = [1 0.1 1];%由图可看出长期变化趋势并不明显，故我们取其上界为0.1 
x0 = zeros(1,narvs);
x0=[0.5 0 0];
y0 = fun1(x0); 
min_y = y0;     % 初始化找到的最佳的解对应的函数值为y0

for iter = 1 : maxgen  % 外循环，指定最大迭代次数
    for i = 1 : Lk  %  内循环，在每个温度下开始迭代
        y = randn(1,narvs); 
        z = y / sqrt(sum(y.^2)); % 根据新解的产生规则计算z
        x_new = x0 + z*T;
        for j = 1: narvs
            if x_new(j) < x_lb(j)
                r = rand(1);
                x_new(j) = r*x_lb(j)+(1-r)*x0(j);
            elseif x_new(j) > x_ub(j)
                r = rand(1);
                x_new(j) = r*x_ub(j)+(1-r)*x0(j);
            end
        end
        x1 = x_new;   
        y1 = fun1(x1);  % 计算新解的函数值
        if y1 < y0   
            x0 = x1; % 更新当前解为新解
            y0 = y1;
        else
            p = exp(-(y0 - y1)/T); % 根据Metropolis准则计算一个概率
            if rand(1) < p   
                x0 = x1; 
                y0 = y1;
            end
        end
        if y0 < min_y  % 如果当前解更好，则对其进行更新
            min_y = y0; 
            best_x = x0; 
        end
    end
    T = alfa*T;   % 温度下降      
end
disp('最佳的水平平滑参数和季节平滑参数是：'); disp(best_x)
    plot_fun1(best_x);
disp('此时SSE为：'); disp(min_y)
disp('预测未来一年的月销量为：');disp(yuce)
