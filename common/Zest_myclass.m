classdef myclass
    %CLASS �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
       a
       c
    end
    
    methods
        function obj = myclass(b)
            %CLASS ��������ʵ��
            %   �˴���ʾ��ϸ˵��
            obj.a = b;
            obj = obj.increment();
            
        end
        
        function obj = increment(obj)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   �˴���ʾ��ϸ˵��
            obj.c = 2*obj.a;
        end
        function [obj,flag] = doublea(obj)
            obj.a = 2*obj.a;
            flag = true;
        end
    end
end

