pro rat_load_qual12_colors,dummy

;## 01/26/11 Changing colors 
;Set color0 to black (0,0,0), color 255 to white

COLORS = [ fltarr(4)+1,fltarr(4)+2, fltarr(4)+3, 4 ]
loadct,38
;ct_data = read_ascii('~/IDL_LIBR/colors/qual_brewer_colors6.tbl'$
;	,comment=';')
rat_arr_read,'~/IDL_LIBR/colors/qual_brewer_colors11.tbl',$
	r1,g1,b1


tvlct,r,g,b,/get
;r1=ct(0,*) & g1 = ct(1,*) &   b1 = ct(2,*)

nrecs=n_elements(b1)
r(1:nrecs) = r1 & g(1:nrecs)=g1 & b(1:nrecs)= b1
;r(1:nrecs-1) = r1 & g(1:nrecs-1)=g1 & b(1:nrecs-1)= b1
; Set Color 255 to white and 0 to black
r(0)= 0 & g(0)=0  & b(0)=0
r(255) = 255 & g(255) =255 & b(255) = 255
r(254) = 255 & g(254) =255 & b(254) = 255
tvlct,r,g,b

end
