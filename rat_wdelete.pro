pro rat_wdelete,dummy,all=all,force=force
if(KEYWORD_SET(force)) then set_plot,'x'
if(strupcase(!d.name eq 'X')) then begin
			i=0
		while(!d.window ne -1) do begin
			wdelete 
			i=i+1
		if i>20 then begin
			print,'!!!! Warning : Breaking out of infinite loop'
			break
		endif
		endwhile
endif
end

