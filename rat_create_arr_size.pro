function rat_create_arr_size ,arr, type=type
;+  
;This function creates an array of the size of input raay. The default type 
;of the output array is type of the input array. It can be overloaded by setting type to "FLOAT"
;"INTEGER", "STR", "DOUBLE","LONG"
;-


n_dim =size(arr,/n_dimensions)
dim=size(arr,/dimensions)
type_arr = size(arr,/type)

if(KEYWORD_SET(type)) then type=strupcase(type) else begin
	case type_arr of 
		2: type="INTEGER"
		3: type="LONG"
		5: type="DOUBLE"
		7: type="STR"
		else: type="FLOAT"
	endcase
endelse

if(n_dim ne 0 ) then begin
case type of 
	"INTEGER": 	out_arr = intarr(dim)
	"LONG" : 	out_arr = lonarr(dim)
	"STR" :		out_arr = strarr(dim)
	"DOUBLE":	out_arr = dblarr(dim)
	else:		out_arr = fltarr(dim)

endcase
endif else out_arr =-1

return,out_arr
end


