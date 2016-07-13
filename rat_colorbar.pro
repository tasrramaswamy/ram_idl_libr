;This is a wrapper function calls David Fanning's colorbar program
;and modifies how colorbars are shown

pro rat_colorbar,_extra=_extra,position=position,ncolors=ncolors,$
	low_color = low_color , high_color=high_color,$
	divisions=divisions,stop1=stop1

;low_color = 0  &  high_color=ncolors-1
;ncolors=ncolors-2
;if(KEYWORD_SET(divisions)) then divisions=divisions-2
colorbar_fan,_extra=_extra,position=position,ncolors=ncolors,$
	divisions=divisions
;stop
if(n_elements(low_color) gt 0 or n_elements(high_color) gt 0) then begin
	xst = position[0]
	yst = position[1]
	xend = position[2]
	yend=position[3]
	xlen = xend - xst
	ylen = yend - yst

	if(xlen gt ylen) then begin ;horizontal bar
		;Low out of scale
		if(n_elements(low_color) gt 0) then begin
			xpos = [xst,xst,(xst - (xlen/float(ncolors))/2.0),xst]
			ypos = [yst,yst+ylen,(yst + ylen/2.0),yst]
			polyfill,xpos,ypos,color=low_color,/normal
			plots,xpos,ypos,color=!p.color,/normal

		endif

		;High out of scale 
		if(n_elements(high_color) gt 0) then begin
			xpos = [xend,xend,(xend + (xlen/float(ncolors)/2.0)),xend]
			ypos = [yend,yend-ylen,(yend - ylen/2.0),yend]
			polyfill,xpos,ypos,color=high_color,/normal
			plots,xpos,ypos,color=!p.color,/normal


		endif
		;	plot,
	endif else begin
		;Low out of scale
		if(n_elements(low_color) gt 0) then begin
			xpos = [xst,xst+xlen,(xst + (xlen/2.0)),xst]
			ypos = [yst,yst,(yst -(ylen/float(ncolors)/2.0)),yst]
			polyfill,xpos,ypos,color=low_color,/normal
			plots,xpos,ypos,color=!p.color,/normal

			endif

		;High out of scale
			if(n_elements(high_color) gt 0 ) then begin
			xpos = [xend-xlen , xend  , (xend - (xlen/2.0)), xend-xlen]
			ypos = [yend, yend,(yend+ (ylen/float(ncolors))/2.0) , yend]
			polyfill,xpos,ypos,color=high_color,/normal
			plots,xpos,ypos,color=!p.color,/normal

			endif

	endelse
endif

if(KEYWORD_SET(stop1)) then stop
end



