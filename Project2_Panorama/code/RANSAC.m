function [XX1,YY1,H] = RANSAC(X,Y, iteration, thresh)
    %--------------------------------------
    %      RANSAC with translation model
    %--------------------------------------
    
    %--------------------------------------
    % input
    % X is a matrix(2*num) => column
    % X(1,:)->the first image, X(2,:)->the second image
    % Y is a matrix(2*num) => row
    % Y(1,:)->the first image, Y(2,:)->the second image
    for t = 1:iteration
        p = randperm(size(X,2),1);
        m1 = X(2,p) - X(1,p);
        m2 = Y(2,p) - Y(1,p);
        du = X(2,:) - (X(1,:)+m1);
        dv = Y(2,:) - (Y(1,:)+m2);
        H{t} = [m1,m2]; % m1 = shift column, m2 = shift row 
        ok{t} = (du.*du+dv.*dv) < thresh;
        score(t) = sum(ok{t});
    end
    [score, best] = max(score);
    H = H{best};
    ok = ok{best};
    XX1 = X(:,ok);
    YY1 = Y(:,ok);
end
        
