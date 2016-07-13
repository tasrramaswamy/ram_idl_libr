function rat_binary , number ,array=array , nbits=nbits,stop1=stop1
	inp = number
str_b = string(number,format='(B0)')
l = strlen(str_b)
if(KEYWORD_SET(nbits)) then begin
		n1 = string(nbits,format='(I2)')
		case 1 of
		(nbits gt l) : begin
			n_pad = string( nbits-l ,format='(I2.2)')
			f1 = '(I'+n_pad+'.'+n_pad+')'
			str_b = string(0,format=f1)+str_b
			end 
		(nbits lt l) : $
			MESSAGE,/continue,'Number cannot be accurately'+$
			' represented in '+n1+' bits'
		else :
	endcase
endif
if(KEYWORD_SET(array)) then begin
	l = strlen(str_b)
	str1 = strarr(l)
	for i = 0,l-1 do str1[i] = strmid(str_b,i,1)
endif else str1 = str_b
if(KEYWORD_SET(stop1)) then stop
return,str1
end


