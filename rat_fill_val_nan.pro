function rat_fill_val_nan,arr , index = index, lt0 = lt0 , fill_val=fill_val
out=arr 
 
        size1 = size(out)
        dim = size1(0)
 	typ = size1(n_elements(size1)-2 )
	
; typ =2 is integer
;typ = 4 is float
;typ = 5 is double
if(~KEYWORD_SET(fill_val)) then begin
    case typ of 
2: f_value = 0
4:f_value = !values.F_Nan
5:f_value = !values.D_Nan
endcase
endif    else f_value = fill_val
if(~KEYWORD_SET(index)) then begin
	if(KEYWORD_SET(lt0)) then idx1 = where(out lt 0.0, count) $
		else idx1 = where(out le 0.0, count)
	endif else begin
         idx1 = index
	 count = n_elements(index)
endelse
if (count gt 1) then begin
case dim of 

1:	begin        
         out(idx1)= f_value
  	end
2:  	begin
       idx2d = array_indices(out,idx1)
       out[idx2d[0,*],idx2d[1,*]] =  f_value
       end
3:   begin
	idx2d = array_indices(out,idx1)
      out[idx2d[0,*],idx2d[1,*],idx2d[2,*]] = f_value
	end
endcase
endif	
return,out


stop




end
