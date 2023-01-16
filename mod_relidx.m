function mod_relidx = mod_relidx(relidx,X,Y)
    %modify the relidx vector by trimming the first X and last Y samples
    %(setting it to zero to only get steady state dynamics)
    mod_relidx = relidx;

    [N,~] = size(relidx);
    for i = (1+X):1:(N-Y)
        if (relidx(i) == 1 && relidx(i - 1) == 0)
            mod_relidx(i:(i+X)) = 0;
        end

        if(relidx(i - 1) == 1 && relidx(i) == 0)
            mod_relidx((i-Y):i) = 0;
        end
    end
end

