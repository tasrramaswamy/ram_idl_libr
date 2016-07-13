;+
;Returns unique elements in an array
;
;SYNTAX:
; Result = rat_uniq(Array, index=index)
;
; IF "index" KEYWORD is set the function returns indices of
; 	the first occurances of each unique element
;-
function rat_uniq2,arr,index_list=index_list,index_first = index_first
;function rat_uniq,arr,/row

idx = uniq(arr,sort(arr))
uniq1 = arr(idx)
index_first = idx
dummy =[]
if(arg_present(index_list)) then begin
	 print,'Calculating list for alIl index values'
	index_list=list()
	foreach elem,uniq1,index do begin
		id_list= where(arr eq elem , n_match)
		if(n_match gt 0) then $
			index_list.add,id_list else index_list.add,dummy
	endforeach
endif

return,uniq1
end
