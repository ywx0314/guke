classdef wholeImg
    %WHOLEIMG class wholeImg manipulates the stitchingImage
    %   Properties:
    %       pixels: pixel matrix
    %       imPatchList: the underlying imPatch that construct this
    %                       wholeImg, imPatch class
    %       patchNum:   the number of patches that construct this wholeImg
    %       stitchRowNumList:  stores the stitchRowNum w.r.t the height of
    %                   the wholeImg
    
    properties
        pixels
        imPatchList
        patchNum
        stitchRowNumList
    end
    
    methods
        function obj = wholeImg(pixels,imPatchList,patchNum,stitchRowNumList)
            %WHOLEIMG 构造此类的实例
            %   此处显示详细说明
            obj.pixels = pixels;
            obj.imPatchList = imPatchList;
            obj.patchNum = patchNum;
            obj.stitchRowNumList = stitchRowNumList;
        end
        
        function obj = update(obj)
            %update call this whenever the underlying imPatchList gets
            %chagnged
            %   updates pixels and stitchRowNumList
            all = [];
            stitchPlace = 0;
            for i = 1:obj.patchNum
                all = [all;obj.imPatchList(i).actualPart]; 
                if i < obj.patchNum
                    stitchPlace = stitchPlace + obj.imPatchList(i).stitchRowNum;
                    obj.stitchRowNumList(i) = stitchPlace;
                end
            end
            obj.pixels = all;
        end
        
        function obj = processStitchUpDown(obj,whichStitch,dist)
            obj.imPatchList(whichStitch) = obj.imPatchList(whichStitch).updateStitch(dist);
            obj = obj.update();
        end 
        
        function obj = processLeftRight(obj,whichStitch,dist)
            % dist > 0 right  dist < 0 left
            if dist > 0 % images below the stitch line goes right
                %image belows the line; movesBlockRight
                largestBreakThrough = 0;
                % check whether breakThrough exists
                for i = (whichStitch + 1):obj.patchNum
                    requiresExtra = obj.imPatchList(i).enoughRoomToMoveBlockRight(abs(dist));
                    if requiresExtra > largestBreakThrough
                        largestBreakThrough = requiresExtra;
                    end                    
                end
                % notify the blocks that room is going to enlarge
                if largestBreakThrough > 0 
                    for j = 1:obj.patchNum
                        obj.imPatchList(j) = obj.imPatchList(j).acceptNotification(...
                            largestBreakThrough,'Right');
                    end
                end
                % now can safely move blocks
                for k = (whichStitch + 1):obj.patchNum
                    obj.imPatchList(k) = obj.imPatchList(k).safelyMoveBlockRight(abs(dist));
                end
            else % images below the stitches line goes left
                %image belows the line; movesBlockRight
                largestBreakThrough = 0;
                % check whether breakThrough exists
                for i = (whichStitch + 1):obj.patchNum
                    requiresExtra = obj.imPatchList(i).enoughRoomToMoveBlockLeft(abs(dist));
                    if requiresExtra > largestBreakThrough
                        largestBreakThrough = requiresExtra;
                    end                    
                end
                % notify all blocks that room is going to enlarge
                if largestBreakThrough > 0 
                    for j = 1:obj.patchNum
                        obj.imPatchList(j) = obj.imPatchList(j).acceptNotification(...
                            largestBreakThrough,'Left');
                    end
                end
                % now can safely move blocks
                for k = whichStitch + 1:obj.patchNum
                    obj.imPatchList(k) = obj.imPatchList(k).safelyMoveBlockLeft(abs(dist));
                end
                
            end 
            % stationary blocks also need to update
            for k = 1:whichStitch
                obj.imPatchList(k) = obj.imPatchList(k).updatePaddingImage();
            end
                
            obj = obj.update();
        end
        
    end
end

