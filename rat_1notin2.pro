function rat_1notin2 , a, b , n_el ,idx=idx ,stop1=stop1
;+
; THis function returns the elements in first array 
;but not in the second.
;-
;REVISION :
;## 09/04/12 Added idx keyword to store the indicies of the elements
	;	of the output array
all_el = [a,b]
uniq_el = rat_uniq(all_el)
n_uniq_el = n_elements(uniq_el)
n_a = n_elements(a)
arr = dblarr(n_a) & id1 = fltarr(n_a)
k=0
for i = 0, n_uniq_el-1 do begin
	idx1 = where(a eq uniq_el[i],count1)
	idx2 = where(b eq uniq_el[i],count2)
	if(count1 eq 1 and count2 eq 0) then begin
		arr[k]=uniq_el[i]
		id1[k] = idx1
		k=k+1
	endif
endfor
;stop
if k ge 1 then begin
	arr = arr[0:k-1]
	id1 = id1[0:k-1]
	n_el = k
  endif else begin
	arr=0
	id1 = !values.F_Nan
	n_el = 0
endelse

 idx=id1
if(KEYWORD_SET(stop1)) then stop

return,arr
end


