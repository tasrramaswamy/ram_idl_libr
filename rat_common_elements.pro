function rat_common_elements,a,b,c,d,e,f,g,h,$
	n_common=n_common,stop1=stop1
;This function gets the common values in a and b and returns their
;indices in respective arrays

;Revisions:
;09/28/11 Added condition for no common elements(sub_a and sub_b set to -1)

np = n_params()
arr=dblarr(1)+!values.d_nan

switch np of 
	8:	begin & n_h = n_elements(h) & arr=[arr,rat_uniq(h)] & end
	7: 	begin & n_g = n_elements(g) & arr=[arr,rat_uniq(g)] & end
	6:	begin & n_f = n_elements(f) & arr=[arr,rat_uniq(f)] & end
	5:	begin & n_e = n_elements(e) & arr=[arr,rat_uniq(e)] & end
	4:	begin & n_d = n_elements(d) & arr=[arr,rat_uniq(d)] & end
	3:	begin & n_c = n_elements(c) & arr=[arr,rat_uniq(c)] & end
	2:	begin & n_b = n_elements(b) & arr=[arr,rat_uniq(b)] & end
	1:	begin & n_a = n_elements(a) & arr=[arr,rat_uniq(a)] & end
	else:	begin & arr =rat_uniq(rat_finite(arr)) & n_uniq =  n_elements(arr) & end
endswitch

idx_arr = intarr(n_uniq,np) & kount=-1
uniq_val = arr
for i =0 , n_uniq -1 do begin
	idx1 = !values.d_Nan
	switch np of 
	8: begin & idx =where(h eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	7: begin & idx =where(g eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	6: begin & idx =where(f eq uniq_val[i], count )& if(count eq 1) then idx1=[idx1,idx] else break & end
	5: begin & idx =where(e eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	4: begin & idx =where(d eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	3: begin & idx =where(c eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	2: begin & idx =where(b eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	1: begin & idx =where(a eq uniq_val[i], count) & if(count eq 1) then idx1=[idx1,idx] else break & end
	else: begin 
		id_fin = where(finite(idx1) eq 1,n_finite)
		if(n_finite gt 0) then begin
			temp = idx1[id_fin]
			kount=kount+1
			idx_arr[kount,*]=temp
		endif
		end
	endswitch
endfor
if(kount ge 0) then ret_arr = idx_arr[0:kount,*] else ret_arr=intarr(np)-1


if(KEYWORD_SET(stop1))	then stop
return,ret_arr
end
