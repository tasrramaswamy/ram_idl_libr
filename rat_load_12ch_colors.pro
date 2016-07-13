pro rat_load_12ch_colors,dummy,rev=rev

;## 01/26/11 Changing colors 
;Set color0 to black (0,0,0), color 255 to white

COLORS = [ fltarr(4)+1,fltarr(4)+2, fltarr(4)+3, 4 ]
loadct,38
home_dir=getenv('HOME')
;ct_data = read_ascii('/Users/ramaswamy/IDL_LIBR/colors/qual_brewer_colors6.tbl'$
;	,comment=';')
ct_data = read_ascii(home_dir+'/IDL_LIBR/RAT/ram_colors.tbl'$
	,comment=';')
ct=ct_data.field1
tvlct,r,g,b,/get
;r1=ct(0,*) & g1 = ct(1,*) &   b1 = ct(2,*)
r1=transpose(ct(0,*)) & g1 = transpose(ct(1,*)) 
b1 = transpose(ct(2,*))
nrecs=n_elements(b1)
;r(1:nrecs) = r1 & g(1:nrecs)=g1 & b(1:nrecs)= b1
r(0:nrecs-1) = r1 & g(0:nrecs-1)=g1 & b(0:nrecs-1)= b1
; Set Color 255 to white
r(255) = 255 & g(255) =255 & b(255) = 255
r(254) = 255 & g(254) =255 & b(254) = 255
if (KEYWORD_SET(rev)) then begin
	r(0) = 255 & g(0) =255 & b(0) = 255
	r(255) = 0 & g(255) =0 & b(255) = 0
endif
tvlct,r,g,b
erase
end
