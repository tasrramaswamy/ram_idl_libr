pro rat_arr_read ,fname,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,$
		idx=idx,row=row,COMMENT=COMMENT,START=START,$
	rows_read = rows_read, cols_read =cols_read, stop1=stop1
;+ 
;This procedure is designed to read arrays  from an  ASCII file. If ROW keyword
;is set it reads rows else it reads columns. If only one variable is passed then 
;it reads the entire data array.The IDX keyword can be used only to read select
;rows or columns.
;-

para=N_params()
no_para=para-1

k_idx=KEYWORD_SET(idx)

if (~KEYWORD_SET(COMMENT)) then comment=';'
if(~KEYWORD_SET(START)) then d_start =0 else d_start = start-1

if(k_idx) then begin
	idx=idx-1
	if(n_elements(idx) ne no_para) then begin
			print,'Incorrect parameters: Number of variables should match indexes'
			goto,err_sig
           endif
    endif



DATA=READ_ASCII(fname,DATA_START=d_start,COMMENT_SYMBOL=COMMENT)

D=DATA.(0)	

;if((k_row eq 1 or k_col eq 1) and k_idx eq 0) then k_a =1
less = 0
pad = 0 
all = 0
n_list = 0
rows_read = 0
cols_read =0

if(KEYWORD_SET(idx)) then n_list = n_elements(idx) else n_list = no_para

data_dim = size(D,/dimensions)
data_no_dim = size(D,/n_dimensions)

if(no_para eq 1 and ~KEYWORD_SET(idx)) then all=1 
if(n_list gt data_dim(k_idx)) then n_list = data_dim(k_idx)

if(all) then begin
	   x1=temporary(D)
 	   rows_read = data_dim(0)
	  if (data_no_dim gt 1) then cols_read = data_dim(1)
endif else begin
      
     case (KEYWORD_SET(row)) of 
	1:  begin
		for i=1,n_list do begin
		  if(k_idx) then idx1 = idx(i-1) else idx1 = i-1	
 	             case i of 
  	                1:X1=D(*,idx1)
	                2:X2=D(*,idx1)
        	        3:X3=D(*,idx1)
                	4:X4=D(*,idx1)
	                5:X5=D(*,idx1)
        	        6:X6=D(*,idx1)
                	7:X7=D(*,idx1)
	                8:X8=D(*,idx1)
        	        9:X9=D(*,idx1)
                	endcase
		     endfor
		     rows_read = n_list
		     cols_read = data_dim(1)
   	  	   end
      else: begin
		for i=1,n_list do begin 
		   if(k_idx) then idx1 = idx(i-1) else idx1 = i-1				
	            case i of 
			1:X1=D(idx1,*)
 		 	2:X2=D(idx1,*)
 			3:X3=D(idx1,*)
			4:X4=D(idx1,*)
			5:X5=D(idx1,*)
			6:X6=D(idx1,*)
			7:X7=D(idx1,*)
			8:X8=D(idx1,*)
			9:X9=D(idx1,*)
			endcase
		     endfor
		     rows_read = data_dim(0)
		     cols_read = n_list
		 end

      endcase

endelse	 
if(KEYWORD_SET(stop1)) then  stop

err_sig: return
end









