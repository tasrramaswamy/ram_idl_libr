;This is a wrapper function calls David Fanning's colorbar program
;and modifies how colorbars are shown

pro rat_colorbar2,_extra=_extra,position=position,ncolors=ncolors1,$
	low_color = low_color , high_color=high_color,$
	divisions=divisions,stop1=stop1

low_color = 0  &  high_color=ncolors1 - 1
ncolors_fan=ncolors1 - 2
if(n_elements(divisions) gt 0) then divisions=divisions-2

colorbar_fan,_extra=_extra,position=position,ncolors=ncolors_fan[0],bottom=1,$
	divisions=divisions[0]

;Restore vairbales to original value


;stop
;if(KEYWORD_SET(low_color) or KEYWORD__SET(high_color)) then begin
	xst = position[0]
	yst = position[1]
	xend = position[2]
	yend=position[3]
	xlen = xend - xst
	ylen = yend - yst

	if(xlen gt ylen) then begin ;horizontal bar
		;Low out of scale
		;if(KEYWORD_SET(low_color)) then begin
			xpos = [xst,xst,(xst - (xlen/float(ncolors_fan))/2.0),xst]
			ypos = [yst,yst+ylen,(yst + ylen/2.0),yst]
			polyfill,xpos,ypos,color=low_color,/normal
			plots,xpos,ypos,color=!p.color,/normal

			;	endif

		;High out of scale 
			;		if(KEYWORD_SET(high_color)) then begin
			xpos = [xend,xend,(xend + (xlen/float(ncolors_fan)/2.0)),xend]
			ypos = [yend,yend-ylen,(yend - ylen/2.0),yend]
			polyfill,xpos,ypos,color=high_color,/normal
			plots,xpos,ypos,color=!p.color,/normal


			;endif
		;	plot,
	endif else begin
		;Low out of scale
		;if(KEYWORD_SET(low_color)) then begin
			xpos = [xst,xst+xlen,(xst + (xlen/2.0)),xst]
			ypos = [yst,yst,(yst -(ylen/float(ncolors_fan)/2.0)),yst]
			polyfill,xpos,ypos,color=low_color,/normal
			plots,xpos,ypos,color=!p.color,/normal

			;endif

		;High out of scale
			;if(KEYWORD_SET(high_color)) then begin
			xpos = [xend-xlen , xend  , (xend - (xlen/2.0)), xend-xlen]
			ypos = [yend, yend,(yend+ (ylen/float(ncolors_fan))/2.0) , yend]
			polyfill,xpos,ypos,color=high_color,/normal
			plots,xpos,ypos,color=!p.color,/normal

			;endif

	endelse
	;endif

if(KEYWORD_SET(stop1)) then stop
end



