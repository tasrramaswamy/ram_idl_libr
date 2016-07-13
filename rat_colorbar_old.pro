;This is a wrapper function calls David Fanning's colorbar program
;and adds out of scale colors to the colorbar
pro rat_colorbar,_extra=_extra,position=position,ncolors=ncolors,$
	low_color = low_color , high_color=high_color

colorbar_fan,_extra=_extra,position=position,ncolors=ncolors
;stop
if(KEYWORD_SET(low_color) or KEYWORD_SET(high_color)) then begin
	xst = position[0]
	yst = position[1]
	xend = position[2]
	yend=position[3]
	xlen = xend - xst
	ylen = yend - yst

	if(xlen gt ylen) then begin ;horizontal bar
		;Low out of scale
		if(KEYWORD_SET(low_color)) then begin
			xpos = [xst,xst,(xst - (xlen/float(ncolors))/2.0)]
			ypos = [yst,yst+ylen,(yst + ylen/2.0)]
			polyfill,xpos,ypos,color=low_color,/normal
		endif

		;High out of scale 
		if(KEYWORD_SET(high_color)) then begin
			xpos = [xend,xend,(xend + (xlen/float(ncolors)/2.0))]
			ypos = [yend,yend-ylen,(yend - ylen/2.0)]
			polyfill,xpos,ypos,color=high_color,/normal
		endif
		;	plot,
	endif else begin
		;Low out of scale
		if(KEYWORD_SET(low_color)) then begin
			xpos = [xst,xst+xlen,(xst + (xlen/2.0))]
			ypos = [yst,yst,(yst -(ylen/float(ncolors)/2.0))]
			polyfill,xpos,ypos,color=low_color,/normal
		endif

		;High out of scale
		if(KEYWORD_SET(high_color)) then begin
			xpos = [xend-xlen , xend  , (xend - (xlen/2.0))]
			ypos = [yend, yend,(yend+ (ylen/float(ncolors))/2.0)]
			polyfill,xpos,ypos,color=high_color,/normal
		endif

	endelse
endif


end



