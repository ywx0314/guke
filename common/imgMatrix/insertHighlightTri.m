function img = insertHighlightTri(img,stitchList,edgeLength)
    width = size(img,2);
    polygons = [];
    for i = 1:length(stitchList)
        row = stitchList(i);
        
        leftTri = [edgeLength*1.5,row,1,row - edgeLength/2,1,row+edgeLength/2];
        rightTri = [width-edgeLength*1.5,row,width,row - edgeLength/2,width,row+edgeLength/2];
        polygons = [polygons;leftTri;rightTri];
    end
    img = insertShape(img,'FilledPolygon',polygons,...
    'Color', 'blue','Opacity',0.7);
        
end