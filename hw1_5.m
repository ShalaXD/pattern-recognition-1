function [X Y Z]=mashid(Ua,Sa,Ub,Sb,All)
    x=min(All(:,1)):0.25:max(All(:,1));
    y=min(All(:,2)):0.25:max(All(:,2));
    [X,Y] = meshgrid(x,y);
    Z=zeros(size(X));
    for n=1:numel(X)
        xx=[X(n),Y(n)];    
        d1=(((xx'-Ua)')*inv(Sa)*(xx'-Ua))^0.5;
        d2=(((xx'-Ub)')*inv(Sb)*(xx'-Ub))^0.5;
        Z(n)=d1-d2;
    end