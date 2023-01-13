function [DE,idx] = computeDose1Burst(t,e,etarget,slitFilterCoefs,Ts)
    arguments
      t
      e
      etarget
      slitFilterCoefs
      Ts = 20e-6
    end
    dtSlit = Ts*numel(slitFilterCoefs);
    tExclude = 20e-3 + dtSlit;
    
    t = t - t(1);
    
    EE = (e - etarget)/etarget;
    DE = filter(slitFilterCoefs,sum(slitFilterCoefs),...
      EE);
    
    idx = t>tExclude;
    DE(~idx) = nan;

end