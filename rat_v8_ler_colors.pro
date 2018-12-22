function rat_v8_ler_colors 

;V8 colors for Reflectivity331
R0 = [40,60,80,100,120,140,160,180,200,220]
G0 = [40,60,80,100,120,140,160,180,200,220]
B0= [40,60,80,100,120,140,160,180,200,220]
Levels = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]


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

