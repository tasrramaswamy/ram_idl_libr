function rat_get_pos_multi5,dummy,_nobottom=_nobottom
!p.multi=[0,0,5,0,0] & !p.charsize=2.0
if(~KEYWORD_SET(_nobottom)) then begin
	loc=[[0.1,0.80,0.95,0.95],$
		[0.1,0.61,0.95,0.76],$
		[0.1,0.42,0.95,0.57],$
		[0.1,0.23,0.95,0.38],$
		[0.1,0.04,0.95,0.19]]
endif else begin
	loc=[[0.1,0.80,0.95,0.95],$
		[0.1,0.6,0.95,0.75],$
		[0.1,0.4,0.95,0.55],$
		[0.1,0.2,0.95,0.35],$
		[0.1,0.01,0.95,0.15]]
endelse
return,loc
end
