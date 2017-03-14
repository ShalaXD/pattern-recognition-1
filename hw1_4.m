load 'case4.mat'
mu_a = mean(a)';
mu_b = mean(b)';
sigma_a = cov(a);
sigma_b = cov(b);

plot(a(:,1),a(:,2),'ro');
hold on;
plot(b(:,1),b(:,2),'b+');
display(mu_a);
display(sigma_a);


% MED classicification boundary
c=[a;b]
x=min(c(:,[1])):1:max(c(:,[1]));
y=min(c(:,[2])):1:max(c(:,[2]));
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

x=min(c(:,[1])):1:max(c(:,[1]));
y=min(c(:,[2])):1:max(c(:,[2]));
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

legend('Class a','Class b','MED','GED');
title('Case 4');


