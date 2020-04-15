classdef imPatch
    %IMPATCH manipulate everything related to imPatch, the basic elements
    %that we are trying to stitch together
    %   Properties:
    %       rawImage: the image pixel profile, remains unchanged
    %       stitchRowNum: the current rowNum that stitch takes place
    %       actualPart:  the actual part of the image that is used to
    %                       construct the whole image
    
    properties
        rawImage
        paddingImage
        stitchRowNum
        rightRoom
        leftRoom
        actualPart
        backgroundColor
    end
    
    methods
        function obj = imPatch(img,rowNum)
            %IMPATCH 构造此类的实例
            %   此处显示详细说明
            if nargin < 2
                obj.rawImage = img;
                obj.stitchRowNum = size(img,1);
            else
                obj.rawImage = img;
                obj.stitchRowNum = rowNum;
            end
            obj.paddingImage = obj.rawImage;
            obj = obj.calActualPart();
            obj.leftRoom = 0;
            obj.rightRoom = 0;
            t = graythresh(img);
            
            obj.backgroundColor = mean(mean(img(img>t)));
            
        end
        
        function obj = calActualPart(obj)
            if obj.stitchRowNum <= size(obj.paddingImage,1)
                obj.actualPart = obj.paddingImage(1:obj.stitchRowNum,:);
            else
                obj.actualPart = [obj.paddingImage;...
                    zeros(obj.stitchRowNum-size(obj.paddingImage,1),size(obj.paddingImage,2))];
            end
            
        end
        function [imgForFusion,bandHeight] = getInfoForFusion(obj)
            if obj.stitchRowNum <= size(obj.paddingImage,1)
                bandHeight = size(obj.paddingImage,1) - obj.stitchRowNum;
                imgForFusion = obj.paddingImage;
            else
                bandHeight = -1;
                imgForFusion = [obj.paddingImage;...
                    zeros(obj.stitchRowNum-size(obj.paddingImage,1),size(obj.paddingImage,2))];
            end
                
        end
        
        function  obj = updateStitch(obj,distance)
            %   distance: "+" stitch moves downwards, "-" stitch moves
            %   upwards
            if obj.stitchRowNum + distance < 1
                warning("Ignore your operation");
                return
            else
                obj.stitchRowNum = obj.stitchRowNum + distance;
                obj = obj.calActualPart();
            end
            
        end
        
        function requiresExtra = enoughRoomToMoveBlockRight(obj,howMuch)
            if howMuch <= obj.rightRoom
                requiresExtra = 0;
            else
                requiresExtra = howMuch - obj.rightRoom;
            end
                
        end
        function obj = safelyMoveBlockRight(obj,howMuch)
            obj.rightRoom = obj.rightRoom - howMuch;
            obj.leftRoom = obj.leftRoom + howMuch;             
            obj = obj.updatePaddingImage();
        end
        
        function requiresExtra = enoughRoomToMoveBlockLeft(obj,howMuch)
            if howMuch <= obj.leftRoom
                requiresExtra = 0;
            else
                requiresExtra = howMuch - obj.leftRoom;
            end
                
        end
        function obj = safelyMoveBlockLeft(obj,howMuch)          
            obj.leftRoom = obj.leftRoom - howMuch;
            obj.rightRoom = obj.rightRoom + howMuch;
            obj = obj.updatePaddingImage();
                
        end
        
        function obj = acceptNotification(obj,extraRoom,whichSide)
            if strcmp(whichSide,'Left')
                obj.leftRoom = obj.leftRoom + extraRoom;
                return
            end
            if strcmp(whichSide,'Right')
                obj.rightRoom = obj.rightRoom + extraRoom;
                return
            end
            warn("Unrecognized whichSide parameter when calling imPatch.acceptNotification");
            
            
        end
        
        function obj = updatePaddingImage(obj)
            obj.paddingImage = constructPaddingImage(obj.leftRoom,...
                obj.rightRoom,obj.rawImage,obj.backgroundColor);
            obj = obj.calActualPart();
        end
        
        
        
        function outputArg = change_(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

function paddedImg = constructPaddingImage(leftRoom,rightRoom,img,gray)
    leftBand = zeros(size(img,1),leftRoom) + gray;
    rightBand = zeros(size(img,1),rightRoom) + gray;
   paddedImg = [leftBand,img,rightBand];
end

