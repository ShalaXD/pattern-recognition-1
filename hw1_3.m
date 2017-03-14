%hw1_3
%hw1_2
% Shala Chen - HW1 - case1
% define the mean and variance
clear all
close all
mu_a = [0,0]';
sigma_a = [3,1; 1,2];
mu_b = [3,0]';
sigma_b = [7,-3; -3,4];

% generate random number
data_a = mvnrnd(mu_a, sigma_a, 200);
data_b = mvnrnd(mu_b, sigma_b, 200);
plot(data_a(:,1),data_a(:,2),'ro');
hold on
plot(data_b(:,1),data_b(:,2),'b*');
hold on



% MED classicification bounda
x = -9:0.25:9;
y = -9:0.25:9;
[X,Y] = meshgrid(x,y);
Z = zeros(size(X));
    for n=1:numel(y)
        for m = 1:numel(x)
            xx=[x(m),y(n)];   
            p1=(mu_a-mu_b)' * xx' ;
            p2=0.5*(mu_b'*mu_b - mu_a' * mu_a);
            Z(n,m)=p1+p2;
        end
    end
%figure;
contour(X,Y,Z,[0,0],'R','LineWidth',3);



% GED classicification boundary
x = -9:0.25:9;
y = -9:0.25:9;
[X,Y] = meshgrid(x,y);
Z = zeros(size(X));
    for n=1:numel(y)
        for m = 1:numel(x)
            xx=[x(m),y(n)];
            Q0 = sigma_a^-1 - sigma_b^-1;
            Q1 = 2*(mu_b' * sigma_b^-1 - mu_a' * sigma_a^-1);
            Q2 = mu_a' * sigma_a^-1 * mu_a - mu_b' * sigma_b^-1 * mu_b;
            Z(n,m)=xx * Q0 * xx' + Q1 * xx' + Q2;
        end
    end
%figure;
contour(X,Y,Z,[0,0],'Y','LineWidth',2);


% MAP classicification boundary
x = -9:0.25:9;
y = -9:0.25:9;
[X,Y] = meshgrid(x,y);
Z = zeros(size(X));
    for n=1:numel(y)
        for m = 1:numel(x)
            xx=[x(m),y(n)];
            pa = 0.5;
            pb = 0.5;
            Q0 = sigma_a^-1 - sigma_b^-1;
            Q1 = 2*(mu_b' * sigma_b^-1 - mu_a' * sigma_a^-1);
            Q2 = mu_a' * sigma_a^-1 * mu_a - mu_b' * sigma_b^-1 * mu_b;
            Q3 = log(pb/pa);
            Q4 = log(det(sigma_a)/det(sigma_b));
            Z(n,m) = xx * Q0 * xx' + Q1 * xx' + Q2 + 2 * Q3 +Q4;
        end
    end
%figure;
contour(X,Y,Z,[0,0],'--B','LineWidth',1);



% unit standard deviation contour
x = -9:0.25:9;
y = -9:0.25:9;
[X,Y] = meshgrid(x,y);
Z = zeros(size(X));
    for n=1:numel(y)
        for m = 1:numel(x)
            xx=[x(m),y(n)];
            Q = (((xx'- mu_a)')*inv(sigma_a)*(xx'-mu_a))^0.5;
            Z(n,m) = Q;
        end
    end
%figure;
contour(X,Y,Z,[1,1],'k','LineWidth',2);

Z = zeros(size(X));
    for n=1:numel(y)
        for m = 1:numel(x)
            xx=[x(m),y(n)];
            Q = (((xx'- mu_b)')*inv(sigma_b)*(xx'-mu_b))^0.5;
            Z(n,m) = Q;
        end
    end
%figure;
contour(X,Y,Z,[1,1],'k','LineWidth',2);

legend('Class a','Class b','MED','GED','MAP','Unit Std');
title('Case 3');

