pro rat_brewer,tbl_no,_erase=_erase
	np=N_PARAMS()
	if(np eq 0) then tbl_no=20
	home_dir=getenv('HOME')
	loadct,tbl_no,file=home_dir+'/IDL_LIBR/colors/brewer.tbl'
	if(KEYWORD_SET(_erase)) then begin
		TVLCT,r,g,b,/get
		r[254]=0 & g[254]=0 & b[254]=0
		r[255]=255 & g[255]=255 & b[255]=255
		TVLCT,r,g,b
		!p.background= 255
		!p.color=254
		erase
	endif
end
