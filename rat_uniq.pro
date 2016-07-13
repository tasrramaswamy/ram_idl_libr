;+
;Returns unique elements in an array
;
;SYNTAX:
; Result = rat_uniq(Array, index=index)
;
; IF "index" KEYWORD is set the function returns indices of
; 	the first occurances of each unique element
;-
function rat_uniq,arr,index=index
;function rat_uniq,arr,/row

idx = uniq(arr,sort(arr))
uniq1 = arr(idx)

if(KEYWORD_SET(index)) then r = idx else r = uniq1

return,r


;The functionality of this program has been changed



; This function is not working
;arr1 = arr
;arr2 = rat_uniq(arr1,/sorted)
;
;n_dim = SIZE(arr,/N_DIMENSIONS)
;dim = SIZE(arr,/DIMENSIONS)
;    s_idx = sort(arr)
;    a_idx2d = array_indices(arr,s_idx)
;    sorted = arr(a_idx2d(0,*),a_idx2d(1,*))
;if(KEYWORD_SET(sorted)) then r = sorted	 else r = a_idx2d
;stop
;return,r
end

