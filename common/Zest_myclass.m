classdef myclass
    %CLASS 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
       a
       c
    end
    
    methods
        function obj = myclass(b)
            %CLASS 构造此类的实例
            %   此处显示详细说明
            obj.a = b;
            obj = obj.increment();
            
        end
        
        function obj = increment(obj)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            obj.c = 2*obj.a;
        end
        function [obj,flag] = doublea(obj)
            obj.a = 2*obj.a;
            flag = true;
        end
    end
end

