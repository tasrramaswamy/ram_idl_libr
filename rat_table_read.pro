pro rat_table_read,fname,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,n_lines=n_lines,$
	;columns=columns, nrows=nrows, $
	;                nmax=nmax, double=double, $
	;                text=text, head=head,$
	stop1=stop1,_EXTRA=_EXTRA

;+
;This procedure reads the ACF files(format is specified beloe).
; FORMAT  = year day daynumber acf_chan01 acf_chan02.....acf_chan13
;-
; ##04/25/12 Tranpose the last variable if it contains only one column
para=N_params()
no_para = para-1	; Number of variables (parameters) called from main program

idx_para = indgen(no_para-1) ; index of the called variables, except last variable


d=READ_TABLE( fname,_extra=_extra)

data_dim = size(D,/dimensions)
n_rows = data_dim[0]
n_lines = data_dim[1]

idx_rows_data = indgen(n_rows)

excess_rows = rat_1notin2(idx_rows_data,idx_para)

;Transpose excess rows if it has only one row.
for i= 0 , no_para-2 do begin
	temp= transpose(D[i,*])
	case i of
	0:	x1 = temp
	1:	x2 = temp
	2:	x3=temp
	3:	x4=temp
	4:	x5=temp
	5:	x6=temp
	6:	x7=temp
	7:	x8=temp
	8:	x9=temp
	9:	x10=temp
	endcase

endfor

extra_val = D[excess_rows,*]

;Trnapose the array if it has only one dimension
if(n_elements(excess_rows) eq 1) then extra_val = transpose(extra_val)
case i of 
1:	x2 = extra_val
2:	x3 = extra_val
3:	x4 = extra_val
4:	x5 = extra_val
5:	x6 = extra_val
6:	x7= extra_val
7:	x8= extra_val
8:	x9= extra_val
9:	x10= extra_val
endcase

if(KEYWORD_SET(stop1)) then stop
end
