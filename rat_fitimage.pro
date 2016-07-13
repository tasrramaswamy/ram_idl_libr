; PRO FITIMAGE
; to call:  fitimage,image,[x0,y0,x1,y1],xstart,ystart
;
; to put image on window:  tv,image,xstart,ystart
; to put image on postscript:  tv,image,xstart,ystart
;
; EXAMPLE:  this is how a call to fitimage would look in your program
;
; fitimage,image_arr,[.1,.75,.95,.98],xstart,ystart,xsize,ysize
; if !D.NAME eq 'PS' then begin
;   tv,t,xstart,ystart,xsize=xsize,ysize=ysize
; endif else begin
;   tv,t,xstart,ystart
; endelse


function rat_fitimage,image,pos,xstart,ystart,xsize,ysize,_plot=_plot

print,'in fitimage'
xsize=(pos(2)-pos(0))*!D.X_VSIZE
ysize=(pos(3)-pos(1))*!D.Y_VSIZE
xstart=pos(0)*!D.X_VSIZE
ystart=pos(1)*!D.Y_VSIZE

if !D.NAME eq 'PS' then goto,quit

image=congrid(image,xsize,ysize)
quit:
if(KEYWORD_SET(_plot)) then begin
	t=image
	if !D.NAME eq 'PS' then begin
		tv,t,xstart,ystart,xsize=xsize,ysize=ysize
	endif else begin
		 tv,t,xstart,ystart
	 endelse
endif
return,image
end
