pro  rat_load_brewer,n_colors,idx,_extra=_extra,bg_color=bg_color,fg_color=fg_color,$
	fill_color=fill_color,_reverse=_reverse
	if(n_elements(bg_color) eq 0) then bg_color = [255,255,255]
	if(n_elements(fg_color) eq 0) then fg_color = [0,0,0]
	rgb = rat_get_brewer_colors(n_colors,idx,_extra=_extra)
	if(~KEYWORD_SET(_reverse)) then rgb= reverse(rgb,2)
	r = bytarr(256) & g = r & b=r
	r[0:n_colors-1] = rgb[0,*] 
	g[0:n_colors-1] = rgb[1,*] 
	b[0:n_colors-1] = rgb[2,*]
	r[255] = bg_color[0] & g[255] = bg_color[1] & b[255] = bg_color[2]
	r[254] = fg_color[0] & g[254] = fg_color[1] & b[254] = fg_color[2]
	if(n_elements(fill_color) gt 0) then begin
		r[253] = fill_color[0] & g[253] = fill_color[1] & b[253] = fill_color[2]
	endif
		
	device,decomposed=0
	TVLCT,r,g,b
	!p.background = 255
	!p.color = 254
	erase

end

;Brewer Colors

; Diverging(3-11 colors)
;
;0	BrBG
;1	PiYG
;2	PRGn
;3	PuOr
;4	RdBu
;5	RdGy
;6	RdYlBu
;7	RdYlGn
;8	Spectral
;
;Sequential(3-9 colors)
;0	BuGn	
;1	BuPu
;2	GnBu
;3	OrRd
;4	PuBu
;5	PuBuGn
;6	PuRd
;7	RdPu
;8	YlGn
;9	YlGnBu
;10	YlOrBr
;11	YlOrRd
;12	Blues
;13	Greens
;14	Greys
;15	Oranges
;16	Purples
;17	Reds
;
;Qualitative(3-8 colors)
;0	Accent
;1	Dark2
;2	Paired
;3	Pastel1
;4	Pastel2
;5	Set1
;6	Set2
;7	Set3
;
;
