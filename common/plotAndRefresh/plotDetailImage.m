function plotDetailImage(img,whichAxe,fig)
himg = imshow(img,[],'Parent',whichAxe);
scrollpanel = imscrollpanel(fig,himg);
set(scrollpanel,'Units','normalized','Position',[0.05 0.05 0.4 0.89]);
api = iptgetapi(scrollpanel);
best = api.findFitMag();
api.setMagnification(best+0.2*best);
end