% add flag smearing for close events and only flag negative spikes
% if events within +/- T seconds of other events -> count as 1 event
function idx_OOS = getOOSlocations(DE) %add ,smear_factor
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
    idx_OOS = (DE_maxmin == 1) & logical(abs(DE*100) > OOS_spec); % logical index of all oos MAX points
end
