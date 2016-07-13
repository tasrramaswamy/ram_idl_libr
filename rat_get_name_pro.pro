function rat_get_name_pro , nu ,stop1=stop1
	help,calls=names
	;print,names
	n_el = n_elements(names)
	ret_str='$MAIN$'
	if(n_el eq  0) then no = n_el - 2
	if(n_el gt 0) then no = 1
	if(n_el lt 0) then no = abs(nu)+1
	if(no gt 0 and no ne  n_el-1) then begin
		str1 = names[no]
		pos1 = strpos(str1,'<')
		pos2 = strpos(str1,'(')
		pos3 = strpos(str1,'>')
		if(pos2 lt 0) then pos2=pos3
		str2 = strmid(str1,pos1+1,pos2-pos1-1)
		ret_val=str2
	endif
	if(KEYWORD_SET(stop1)) then stop
	return,ret_val

end
