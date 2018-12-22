pro  ram_divide_ct, ct,n_colors, $
	_center=_center, _reverse=_reverse,$
	_extra=_extra

n1 = n_colors
loadct, ct
tvlct,r,g,b,/get
m = rat_linspace(1,254,n1)
mr = round(m)

r1 = r & g1 = g & b1 = b
r1[255] = 255 & g1[255] = 255 & b1[255] = 255
r1[254] = 0 & g1[254] = 0 & b1[254] = 0
r[251]=130 & g[251]=130 & b[251]=130 ; grey color

r1[0:n1-1] = r[mr] & g1[0:n1-1] = g[mr] & b1[0:n1-1] = b[mr]

;center would create a grey color in the center
if KEYWORD_SET(center) then begin
	ctr = floor(n1/2)
	r0 = r1 & g0=g1  & b0=b1
	r1[ctr+1:n+1]= r0[ctr:n]
	g1[ctr+1:n+1]= g0[ctr:n]
	b1[ctr+1:n+1]= b0[ctr:n]
	r[ctr]=220 & g[ctr]=220 & b[ctr]=220
endif




;Set black as default write color
!p.color=254
!p.background=255
TVLCT,r1,g1,b1
erase


end

