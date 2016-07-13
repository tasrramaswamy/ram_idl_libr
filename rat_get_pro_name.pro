;+
;Stacks the names of routines with MAIN at the bottom
;if Level is zero :default case. Pop the topmost routine name
;;level <0 : pops the name corresponding to the level.
;-

function rat_get_pro_name, level,stop1=stop1


;get the name of IDL routines from help command.
;The names are stored in a stack, which means most recent IDL routine name 
; is in the top
help,calls=level_name_stack,/traceback
n_levels = n_elements(level_name_stack)-1

;Exclude the name of current IDL routine , and reverse the order of stack(recent item on top) 
; and store in an array

names_arr = reverse(level_name_stack[1:n_levels])
np = n_params()
if(np eq 0) then inp=-1 else inp=level
if(inp eq 0) then inp=-1


if(inp le 0) then str1 =names_arr[inp] else begin
	idx = inp+1
	str1 = names_arr[idx]
endelse
ret_str=''
;pos1 = strpos(str1,'MAIN')
pos1 = strpos(str1,'<')
if(pos1 lt 0) then ret_str=str1   else begin
	pos2 = strpos(str1,'<')
	pos3 = strpos(str1,'(')
	str2 =strmid(str1,pos2+1,pos3-pos2-1)
	ret_str = ret_str+str2
endelse
if(keyword_set(stop1)) then stop
return,strcompress(ret_str)
end
	
