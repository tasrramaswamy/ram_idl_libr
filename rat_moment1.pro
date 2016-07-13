function rat_moment1 , ARRAY , DIMENSION , NAN=NAN , DOUBLE = DOUBLE ,$
	std_dev=std_dev , var = var,kurt = kurt,skew=skew , stop1=stop1,$
	mdev = mdev

;+
;This function calculates moment across a single dimension of the array.

;-

; ON_ERROR,2
S = SIZE(ARRAY,/STR)
n_dim = S.N_DIMENSIONS
dim = S.DIMENSIONS

IF S.N_ELEMENTS EQ 1 THEN RETURN, array[0]
IF S.N_ELEMENTS EQ 0 THEN $
	MESSAGE,'Variable must be an array, name= ARRAY'
;
IF N_PARAMS() EQ 1 THEN BEGIN
	IF KEYWORD_SET(NAN) THEN NPTS = TOTAL(FINITE(ARRAY) ) $
		ELSE NPTS = N_ELEMENTS(ARRAY)
	IF NPTS EQ 0 THEN begin
		avg_arr = !VALUES.F_NAN 
		var = avg_arr & std_dev =var
		skew = var & kurt = var
		mdev1 = var
	endif ELSE begin
		mom = moment(ARRAY , mdev = mdev1,/NAN , /double)
		avg_arr = mom[0]
		var = mom[1]
		std_dev = sqrt(var)
		skew = mom[2]
		kurt = mom[3]
	endelse

ENDIF ELSE BEGIN
	IF ((DIMENSION GE 0) AND (DIMENSION LT S.N_DIMENSIONS)) THEN BEGIN
		case n_dim of
			1:      PAD_ARRAY = reform(ARRAY ,dim[0],1,1,1)
			2:      PAD_ARRAY = reform(ARRAY ,dim[0],dim[1],1,1)
			3:      PAD_ARRAY = reform(ARRAY ,dim[0],dim[1],dim[2],1)
			4:      PAD_ARRAY = ARRAY
		endcase
		dim1 = size(PAD_ARRAY,/DIMENSIONS)
		av1 = avg(ARRAY,dimension ,/nan,/double)
		;		std_dev =rat_create_arr_size(av1)
		case dimension of 
			0:   begin
				avg_arr  = dblarr(dim1[1],dim1[2],dim1[3])
				kurt = avg_arr & std_dev = avg_arr & skew =kurt & var = kurt
				mdev1 = kurt
				for j = 0,dim1[1]-1 do begin
					for k = 0,dim1[2]-1 do begin
						for l = 0 ,dim1[2]-1 do begin
							temp = moment(rat_finite(pad_array[*,j,k,l]),mdev = mdev2,/double)
							std_dev[j,k,l] = sqrt(temp[1])
							avg_arr[j,k,l] = temp[0]
							var[j,k,l] = temp[1]
							skew[j,k,l] = temp[2]
							kurt[j,k,l] = temp[3]
							mdev1[j,k,l] = mdev2
						endfor
					endfor
				endfor
			end
			1:  begin 
				avg_arr  = dblarr(dim1[0],dim1[2],dim1[3])
				kurt = avg_arr & std_dev = avg_arr & skew =kurt & var = kurt
				mdev1=kurt
				for i = 0,dim1[0]-1 do begin
					for k = 0,dim1[2]-1 do begin
						for l = 0 ,dim1[2]-1 do begin
							temp = moment(rat_finite(pad_array[i,*,k,l]),mdev = mdev2,/double)
							std_dev[i,k,l] = sqrt(temp[1])
							avg_arr[i,k,l] = temp[0]
							var[i,k,l] = temp[1]
							skew[i,k,l] = temp[2]
							kurt[i,k,l] = temp[3]
							mdev1[i,k,l] = mdev2
						endfor
					endfor
				endfor
			end
			2:  begin
				avg_arr  = dblarr(dim1[0],dim1[1],dim1[3])
				kurt = avg_arr & std_dev = avg_arr & skew =kurt & var = kurt
				mdev1=kurt
				for i = 0,dim1[0]-1 do begin
					for j = 0,dim1[1]-1 do begin
						for l = 0 ,dim1[2]-1 do begin
							temp = moment(rat_finite(pad_array[i,j,*,l]),mdev=mdev2,/double)
							std_dev[i,j,l] = sqrt(temp[1])
							avg_arr[i,j,l] = temp[0]
							var[i,j,l] = temp[1]
							skew[i,j,l] = temp[2]
							kurt[i,j,l] = temp[3]
							mdev1[i,j,l] = mdev2
						endfor
					endfor
				endfor
			end
			3:  begin
				avg_arr  = dblarr(dim1[0],dim1[1],dim1[2])
				kurt = avg_arr & std_dev = avg_arr & skew =kurt & var = kurt
				mdev1=kurt
				for i = 0,dim1[0]-1 do begin
					for j = 0,dim1[1]-1 do begin
						for k = 0,dim1[2]-1 do begin
							temp = moment(rat_finite(pad_array[i,j,k,*]),mdev = mdev2,/double)
							std_dev[i,j,k] = sqrt(temp[1])
							avg_arr[i,j,k] = temp[0]
							var[i,j,k] = temp[1]
							skew[i,j,k] = temp[2]
							kurt[i,j,k] = temp[3]
							mdev1[i,j,k] = mdev2
						endfor
					endfor
				endfor
			end
		endcase

		var = reform(var)
		skew = reform(skew)
		kurt = reform(kurt)
		avg_arr = reform(avg_arr)
		mdev1 = reform(mdev1)
	endif
endelse

mdev = mdev1
if(KEYWORD_SET(stop1)) then stop
return,avg_arr
end

