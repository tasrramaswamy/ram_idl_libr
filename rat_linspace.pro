FUNCTION RAT_LINSPACE, min, max, div ,double=double
	A=min & B = max & N = div
if(~kEYWORD_SET(double)) then gen = findgen(n) else begin

	gen=dindgen(N)
	a = double(A)
	b=double(b)
	n = double(n)
endelse
L = gen / (N - 1.0) * (B - A) + A
return, L
END
