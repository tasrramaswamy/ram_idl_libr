;This function gets individual bits in a byt
;bits should be specified from LSB

function rat_get_bits,byt,bits=bits ,stop1=stop1,str=str
str1 = rat_binary(byt,nbits=8,/array)
	
;Store as integer array with LSB stored in element 0
b_arr = reverse(fix(str1))

out1 = b_arr[bits-1]

rev_out1  = reverse(out1)

if(~KEYWORD_SET(str)) then ret_val = byte(poly(2d,rev_out1)) $
	else begin
	str_out1 = string(out1,/print)
	str_out = strcompress(str_out1,/remove_all)
	ret_val = str_out
endelse

if(KEYWORD_SET(stop1)) then stop
return,ret_val

end

