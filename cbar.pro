pro cbar ;   Display color bar, then label color bar.


x1bound=[0.11,0.11]
y1bound=[0.57,0.15]
x2bound=[0.90,0.90]
y2bound=[0.90,0.80]
jj=1

x1=x1bound(jj)
y1=y1bound(jj)
x2=x2bound(jj)
y2=y2bound(jj)
cbar_length=1000

command=0
dev_thic_adj = 1.50
dev_pos_adj = 1.00
dev_siz_adj = 0.75
xyout_cnt = 0

xoff=0.001
yoff = (y2 - y1) / 45.0
xi1 = x1 + xoff
xi2 = x2 - xoff
yi1 = y1 + yoff
yi2 = y2 - yoff * 2.0
xb1 = x2 + 0.017
xb2 = xb1 + 0.02
poscbar = [xb1,yi1,xb2,yi2]
posimage = [xi1,yi1,xi2,yi2]
posaxis1 = [x1,y1,x2,y2]
devimage = fix(posimage * [!D.X_SIZE, !D.Y_SIZE, !D.X_SIZE, !D.Y_SIZE])
devcbar = fix(poscbar * [!D.X_SIZE, !D.Y_SIZE, !D.X_SIZE, !D.Y_SIZE])

if (jj eq 0) then begin   ; UP IMAGE
  posaxis_up=posaxis1
  devimage_up=devimage
  devcbar_up=devcbar
endif
if (jj eq 1) then begin   ; DN IMAGE
  posaxis_dn=posaxis1
  devimage_dn=devimage
  devcbar_dn=devcbar
endif
xsi = devimage(2) - devimage(0) - 1
ysi = devimage(3) - devimage(1) - 1
xsb = devcbar(2) - devcbar(0) - 1
ysb = devcbar(3) - devcbar(1) - 1

labtimy = (y2 - yoff * 1.9)
yoff = 0.8 / 45.0
lablony = (y1 - yoff * 2.9)
lablaty = (y1 - yoff * 2.0)
lablony = (y2 + yoff * 0.23)
lablaty = (y2 + yoff * 1.0)

if (jj eq 0) then lablaty_up=lablaty
if (jj eq 1) then lablaty_dn=lablaty


a = intarr (2,2)
a(0,0) = 0
a(1,0) = 0
a(0,1) = 255
a(1,1) = 255
x = findgen(30) / 30.0
y = findgen (cbar_length) / float(cbar_length)
color_bar = interpolate(a,x,y,/grid)

if (!D.Y_SIZE lt 1000) then begin
  tv, congrid (rotate (color_bar,2),xsb,ysb, /interp),devcbar(0)+1,devcbar(1)+1
endif else begin
  xs = xb2 - xb1
  ys = yi2 - yi1
  tv,rotate (color_bar,2),xb1,yi1,xsize=xs,ysize=ys,/normal
endelse
stop
end
