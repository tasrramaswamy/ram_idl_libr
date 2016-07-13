pro rat_arr_read ,fname,list,x1,x2,x3,x4,x5,x6,row=row,col=col,all=all,COMMENT=COMMENT,START=START
; This procedure is designed to get the contents of any column format ASCII file
;   and load each column into a vector.  If CHOICE = 0, all columns will be
;   returned as variables.  If an array of values is specified for CHOICE, only
;   those columns will be returned.
para=N_params()
n_list=para-2
k_a=KEYWORD_SET(all)
k_r=KEYWORD_SET(row)
k_c= KEYWORD_SET(col)
k_com=KEYWORD_SET(COMMENT)
k_s= KEYWORD_SET(START)
if (k_r and k_c ) then print,'Error in Input: Use either row or column'

case 1 of begin
	(k_s and k_comm): DATA=READ_ASCII(fname,RECORD_START=start,COMMENT_SYMBOL=COMMENT)
 	k_s:		  DATA=READ_ASCII(fname,COMMENT_SYMBOL=COMMENT)
	k_comm:		  DATA=READ_ASCII(fname,COMMENT_SYMBOL=COMMENT)
endcase
D=DATA.FIELD1	

if(k_a) then begin
	   x1=temporary(D)
 	   break
endif else begin
      
     if(k_r eq 0) then begin
	for i=1,n_list do begin 
		case i of begin
		1: X1=D(i-1,*)
 		2:X2=D(i-1,*)
		3:X3=D(i-1,*)
		4:X3=D(i-1,*)
		5:X3=D(i-1,*)
		6:X3=D(i-1,*)
		7:X3=D(i-1,*)
		8:X3=D(i-1,*)
		9:X3=D(i-1,*)
		endcase
	  endfor
		
	else  begin
         for i=1,n_list do begin
                case i of begin
                1: X1=D(*,i-1)
                2:X2=D(*,i-1)
                3:X3=D(*,i-1)
                4:X3=D(*,i-1)
                5:X3=D(*,i-1)
                6:X3=D(*,i-1)
                7:X3=D(*,i-1)
                8:X3=D(*,i-1)
                9:X3=D(*,i-1)
                endcase
          endfor
   	  
    
stop
end









