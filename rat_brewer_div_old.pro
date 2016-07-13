

pro rat_brewer_div ,idx=idx,n_colors=n_colors,center=center,reverse=reverse
	if(n_elements(idx) eq 0) then idx=0
	if(n_elements(n_colors) eq 0) then n_colors=8
	
	seq=[[140,81,10],$
		[191,129,45],$
		[223,194,125],$
		[246,232,195],$
		[245,245,245],$
		[199,234,229],$
		[128,205,193],$
		[53,151,143],$
		[1,102,94]]
	;rat_brewer,36
	;tvlct,r,g,b,/get
	seq = rat_get_brewer_colors(n_colors,idx,/div)
	r = bytarr(256) & g = r & b=r
	r1 = reform(seq[0,*]) & g1=reform(seq[1,*]) & b1=reform(seq[2,*])
	;stop
	n1 = n_elements(r1)
	if(KEYWORD_SET(reverse)) then begin
		r1 = reverse(r1) & g1=reverse(g1) & b1 = reverse(b1)
	endif

	r[0:n1-1]=r1 & g[0:n1-1]=g1 & b[0:n1-1]=b1


	r[255]=255 & g[255]=255 & b[255]=255
	r[254]=0  & g[254]=0 & b[254]=0
	r[251]=130 & g[251]=130 & b[251]=130

	if(KEYWORD_SET(center)) then begin
		if(n_colors mod 2 eq 0) then begin
			ctr = long(n1)/2L 
			r0 = r & g0=g  & b0=b
			r[ctr+1:20]= r0[ctr:19] 
			g[ctr+1:20]= g0[ctr:19] 
			b[ctr+1:20]= b0[ctr:19] 
			;r[ctr]=130 & g[ctr]=130 & b[ctr]=130
			r[ctr]=170 & g[ctr]=170 & b[ctr]=170
		endif else $ 
			print,'!!!!WARNING : Cannot load center color if n_colors is odd'
	endif
	TVLCT,r,g,b
	!p.background=255
	!p.COLOR=254
	erase
end

