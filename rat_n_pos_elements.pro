function rat_n_pos_elements ,a 
arr = a
a_arr = abs(arr)
n = n_elements(arr)
k=0
for i =0,n-1 do begin
	if(arr[i] eq a_arr[i]) then begin
		k=k+1
	endif
endfor

return,k
end
