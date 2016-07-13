;+
; This program copies variables from current function to calling function.
;The variables from current function can also be copied to any 
;other function in the calling stack using LEVEL keyword.
;Use Level=-1 to copy variables to calling function
;Positive level values indicate absolute position from MAIN(level=1)
;Refer to SCOPE_TRACEBACK routines for more help on function calls
;-

pro rat_tx ,list1,level=level,all=all,stop1=stop1,$
	COMMON_NAME=COMMON_NAME
np=n_params()
if(~KEYWORD_SET(all) and np eq 0 and ~KEYWORD_SET(COMMON_NAME)) then $
	 Message,'Set "all" KEYWORD or provide list of variables as argument'

if(n_elements(level) eq 0) then level=-1 
if(level eq 0) then level=-1
if(level lt 0) then level =level-1
endelse

;Retrive only variables from COMMON block, if COMMON_NAME parameter is specified
if(KEYWORD_SET(COMMON_NAME)) then var_list = scope_varname(level=-1,COMMON=COMMON_NAME) $
	else var_list = scope_varname(level=-1)

;CONVERT arrays to list
var_list = list(var_list,/extract)

if(n_elements(list1) eq 0) then list1=var_list else begin
	;If variable list is supplied, then verify variable list 
	if(isa(list1,'LIST') ne 1) then list1= list(list1,/extract)
	list2=list1
	foreach elem,list2 do begin
	if(var_list.count(elem) eq 0) then  list1.delete,elem
	endforeach
endelse	


foreach elem,list1,idx do begin
	;If a variable is "undefined", then IDL will throw an error if try to assign
	;"undefined"
	; The following condition takes care of the problem
	if n_elements(scope_varfetch(elem,level=-1)) eq 0 then begin
		print,'Warning :'+elem+' is undefined'
		continue
	endif
	(scope_varfetch(elem,level=level,/enter)) = scope_varfetch(elem,level=-1)
endforeach

if(KEYWORD_SET(stop1)) then stop

end
