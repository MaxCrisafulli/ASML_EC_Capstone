function DE_filtered = remove_OOS(DE)
    % Below code computes logical indexes of all out of spec max mins 
    DEderiv = gradient(DE)*1e4;
    DEderiv(isnan(DEderiv)) = 0;
    DEderiv_sign = sign(DEderiv);
    
    for i = [1:1:length(DEderiv_sign)]
        if DEderiv_sign(i,1) < 0
            DEderiv_sign(i,1) = logical(0);
        elseif DEderiv_sign(i,1) >= 0
            DEderiv_sign(i,1) = logical(1);
        end
    end
    
    for i = [2:1:length(DEderiv)]
        if DEderiv_sign(i-1,1) ~= DEderiv_sign(i,1)
            DE_maxmin(i,1) = 1;
        else
            DE_maxmin(i,1) = 0;
        end
    end
    
    OOS_spec = 1; % in percent
    DE_OOS = logical(abs(DE*100) > OOS_spec); % logical index of all oos points
    DE_maxmin_OOS = and(DE_OOS,DE_maxmin); %oos AND a max min
    DE_maxmin_NOT_OOS = xor(DE_maxmin,DE_maxmin_OOS);
    
    % End of DE maxmin oos code
    
    % below code identifies and converts recovery period indices to NaN
    killList = logical(zeros(size(DE))); %index of points to convert to NaN, 1 = kill, 0 = keep
    
    
    
    % possibly modify to go back or forward some extra indices
    EDGE_TRIM = 25; %pad indices on the edge of the kill list
    
    for i = 1:1:length(DE)
        if DE_maxmin_OOS(i,1) == 1
            tempprev = i - 1; tempnext = i + 1;
    
               % walk back until the next min or max (OOS or not)
            while(tempprev >= 1)
                if (DE_maxmin_OOS(tempprev,1) == 1) || (DE_maxmin_NOT_OOS(tempprev,1) == 1)
                    killList((tempprev-EDGE_TRIM):i,1) = 1; %sets all inbetween to 1 on killist
                    break;
                else
                    tempprev = tempprev - 1; %iterate backwards;
                end
            end
    
    
           % walk forward until the next min or max (OOS or not)
            while(tempprev <= length(DE))
                if (DE_maxmin_OOS(tempnext,1) == 1) || (DE_maxmin_NOT_OOS(tempnext,1) == 1)
                    killList(i:(tempnext+EDGE_TRIM),1) = 1; %sets all inbetween to 1 on killist
                    break;
                else
                    tempnext = tempnext + 1; %iterate backwards;
                end
            end
        end
    end
    
    DE_filtered = DE;
    DE_filtered(killList) = NaN;
end