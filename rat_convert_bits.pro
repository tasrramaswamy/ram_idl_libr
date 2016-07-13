function rat_convert_bits,bit_arr,string=string,float=float,integer=integer,$
	long=long,uint=uint,stop1=stop1,invert=invert


inp=reform(bit_arr)
;if(KEYWORD_SET(invert)) then r_inp = reverse(inp) $ 
;	else r_inp=inp
 r_inp = reverse(inp)
if(KEYWORD_SET(float)) then ret= float(r_inp,0)
if(KEYWORD_SET(integer)) then ret= fix(r_inp,0)
if(KEYWORD_SET(long)) then ret= long(r_inp,0)
if(KEYWORD_SET(uint)) then ret= uint(r_inp,0)
if(n_elements(ret) eq 0) then ret=r_inp
if(KEYWORD_SET(stop1)) then stop
return,ret

end



