pro rat_transpose_arr , x1, x2, x3,x4, x5, x6, x7, x8, x9, x10 , x11
;+
; This routine transposes all the arrays 
;-
nparam = n_params()

for i =0 , nparam-1 do begin
	case i of 
	0 : x1 = transpose(x1)
	1 : x2 = transpose(x2)
	2 : x3 = transpose(x3)
	3 : x4 = transpose(x4)
	4 : x5 = transpose(x5)
	5 : x6 = transpose(x6)
	6 : x7 = transpose(x7)
	7 : x8 = transpose(x8)
	8 : x9 = transpose(x9)
	9 : x10 = transpose(x10)
	10: x11 = transpose(x11)
	endcase
endfor

end

