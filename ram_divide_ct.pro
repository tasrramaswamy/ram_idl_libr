pro  ram_divide_ct, ct,n_colors, $
	_center=_center, _reverse=_reverse,$
	_extra=_extra

n1 = n_colors
loadct, ct
tvlct,r,g,b,/get
m = rat_linspace(1,254,n1)
mr = round(m)

if(KEYWORD_SET(_reverse)) then begin
	r1 = reverse(r) & g1 = reverse(g) & b1 = reverse(b)
endif else begin
	r1 = r & g1 = g & b1 = b
endelse

r1[255] = 255 & g1[255] = 255 & b1[255] = 255
r1[254] = 0 & g1[254] = 0 & b1[254] = 0
r[251]=130 & g[251]=130 & b[251]=130 ; grey color

r1[0:n1-1] = r[mr] & g1[0:n1-1] = g[mr] & b1[0:n1-1] = b[mr]

help,r1,g1,b1
;center would create a grey color in the center
; Shift colors from center to end, by one index to right
if KEYWORD_SET(_center) then begin
	ctr = floor(n1/2)
	r0 = r1 & g0=g1  & b0=b1
	help,r0,g0,b0,ctr,n1
	r1[ctr+1:n1+1]= r0[ctr:n1]
	g1[ctr+1:n1+1]= g0[ctr:n1]
	b1[ctr+1:n1+1]= b0[ctr:n1]
	r1[ctr]=220 & g1[ctr]=220 & b1[ctr]=220
endif




;Set black as default write color
TVLCT,r1,g1,b1
!p.color=254
!p.background=255
erase


end

