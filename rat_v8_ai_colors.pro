function rat_v8_ai_colors 

;V8 colors for Reflectivity331
R0 = [0,0,100,235,255,220,200,170,255,220,160,40]
G0 = [0,100,180,255,255,220,200,170,100,50,0,0]
B0= [100,150,220,255,235,190,140,80,50,0,0,0]
levels = [-2.0,-1.5,-1.0,-0.5, 0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0]


loadct, 39
tvlct,r,g,b,/get

n1 = n_elements(r0)
r1 = r & g1 = g & b1 = b
r1[255] = 255 & g1[255] = 255 & b1[255] = 255
r1[254] = 0 & g1[254] = 0 & b1[254] = 0
r1[0:n1-1] = r0 & g1[0:n1-1] = g0 & b1[0:n1-1] = b0

!p.color=254
!p.background=255
TVLCT,r1,g1,b1
erase

return ,levels

end

