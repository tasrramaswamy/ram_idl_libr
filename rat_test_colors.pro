pro rat_test_colors,dummy

x = fltarr(256) & y =fltarr(256)

colors1 = x
i1 = indgen(40)
x (0:41)= 0.1 & x(41:80) = 0.19 & X(81:120) = 0.28 
X(121:160) = 0.37 & X(161:200)  = 0.46 & X(201:240) = 0.54
X(241:255) = 0.63

y1  = 0.95 - (indgen(40)*.02)

y(1:40) = y1 & y(41:80) = y1 & y(81:120) =y1
y(121:160) = y1 & y(161:200) = y1 & y(201:240) = y1
y(241:255) = y1(0:14)

str1= string(256)
s= replicate(str1,256)
for  i =0,255 do xyouts,x(i),y(i),'COLOR #'+ strcompress(string(i)),$
	/normal,color=i


end
