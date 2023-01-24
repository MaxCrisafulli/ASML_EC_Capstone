classdef IHateYouSimulink < matlab.mixin.Copyable
  %quick 'n dirty helper class cause simulink syntax is crazy and i hate it
  
  properties
    simInput
    modelName
  end
  
  methods
    function obj = IHateYouSimulink(modelName)
      obj.simInput = Simulink.SimulationInput(modelName);
      obj.modelName = modelName;
    end
    
    %% basic wrappers
    
    function setVariable(obj,vname,value)
      obj.simInput = ...
        obj.simInput.setVariable(vname,value);%,...
                        %'workspace',obj.modelName);
      poo = get_param(obj.modelName,'ModelWorkspace');
      assignin(poo,vname,value)
    end

    function setVariant(obj,vname,value)
      obj.simInput = ...
        obj.simInput.setVariable(vname,value);%,...
      %'workspace',obj.modelName);
    end

    function o = getVariable(obj,vname)
      o = obj.simInput.getVariable(vname);
    end
    
    function setInput(obj,t,x)
      if nargin == 2
        x = t(:,2:end);
        t = t(:,1);
      end
      obj.simInput = ...
        obj.simInput.setExternalInput(...
        double([t x]));
      obj.setModelParameter('stopTime',num2str(max(t)));
    end
    
    function setModelParameter(obj,vname,value)
      obj.simInput = ...
        obj.simInput.setModelParameter(vname,value);
    end

    function [simOut,logsOut] = sim(obj)
      simOut = sim(obj.simInput);
      logsOut = simlogsout2struct(simOut);
    end
    
    function [simOut,logsOut] = parsim(obj)
      simOut = parsim(obj.simInput);
      logsOut = simlogsout2struct(simOut);
    end
    %% convenience functions
    function setProps(obj,vstruct,prop)
      arguments
        obj
        vstruct
        prop = 'variable'
      end
      fnames = fieldnames(vstruct);
      for k = 1:length(fnames)
        if contains('variable',prop,"IgnoreCase",true)
          obj.setVariable(fnames{k},vstruct.(fnames{k}));
        elseif contains('modelparameter',prop,"IgnoreCase",true)
          obj.setModelParameter(fnames{k},vstruct.(fnames{k}));
        elseif contains('variant',prop,"IgnoreCase",true)
          obj.setVariant(fnames{k},vstruct.(fnames{k}));
        end
      end
    end
    
    function disp(obj)
      disp(obj.simInput)
      disp("Simulation Variables:")
      T = table(string({obj.simInput.Variables.Name})',...
        {obj.simInput.Variables.Value}',...
        'VariableNames',["Name","Value"]);
      disp(T)
      builtin('disp',obj)
    end
    
    
  end
end

