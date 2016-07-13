pro rat_cbar, pos, min = min,max = max,posimage = posimage,$
	top=top
;   Display color bar, then label color bar.

n_para =n_params()
if(n_para eq 0 ) then poscbar =[0.917000, 0.16444 , 0.937000 , 0.885333] $
		else poscbar=pos
if(~KEYWORD_SET(top)) then top=8
devcbar = fix(poscbar * [!D.X_SIZE, !D.Y_SIZE, !D.X_SIZE, !D.Y_SIZE])
cbar_length = devcbar(3) - devcbar(1)

xsb = devcbar(2) - devcbar(0) - 1
 ysb = devcbar(3) - devcbar(1) - 1

a = intarr (2,2)
a(0,0) = 0
a(1,0) = 0
a(0,1) = top
a(1,1) = top
x = findgen(30) / 30.0
y = findgen (cbar_length) / float(cbar_length)
color_bar = interpolate(a,x,y,/grid)

if (!D.Y_SIZE lt 1000) then begin
  tv, congrid (rotate (color_bar,2),xsb,ysb, /interp),devcbar(0)+1,devcbar(1)+1
  if(KEYWORD_SET(min)) then  xyouts,devcbar(2)+1,devcbar(1)+1,min,/device
  if(KEYWORD_SET(max)) then xyouts,devcbar(2)+1,devcbar(3)+1,max,/device
endif else begin
  xs = xb2 - xb1
  ys = yi2 - yi1
  tv,rotate (color_bar,2),xb1,yi1,xsize=xs,ysize=ys,/normal
endelse
;stop
return
end
