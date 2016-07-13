function get_varlist,ncdf_fname,dim_append,dim_match,dim_list,dim_trans
nc1 =  ncdf_open(ncdf_fname)
dim1 = ncdf_dimid(nc1,dim_append)
if(dim1 lt 0) then Message,dim_append + ' not found in netCDF file'
if(nc1 gt 0) then begin
	 n_vars = (ncdf_inquire(nc1)).nvars
	 var_list=strarr(n_vars)
	 dim_match=intarr(n_vars)-1
	 dim_list = list()
	 dim_trans = list()
	 for i =0,n_vars-1 do begin
		 vardet = ncdf_varinq(nc1,i)
		 var_ndims = vardet.Ndims
		  var_list[i]=vardet.name
		  dim_list.add,vardet.dim
		  temp = where(vardet.Dim eq dim1,n_match)
		  if(n_match eq 1) then begin
			  dim_match[i]=temp
			  if(temp eq 0) then dim_trans.add,1 else begin
				  case var_ndims of
				2:  dim_trans.add,[1,0]
				else: dim_trans.add,[temp,rat_1notin2(vardet.dim,temp)]
				endcase
			endelse
		 endif else  begin
			  print,vardet.name + ' will not be appended'
			  dim_trans.add,-1
		endelse

	 endfor
	 ncdf_close,nc1
endif else Message,ncdf_varname+' not valid netCDF file'
return,var_list
end

;---------------------------------------------------------------------

pro rat_ncdf_multiread,file_list,var_list,dim_append=dim_append
kk = 0 & n_files = n_elements(file_list)
ncdf_varlist = get_varlist(file_list[0],dim_append,dim_match,dim_list,dim_t)
if(n_elements(ncdf_varlist) eq 0) then $
	Message,'No valid variable names in netCDF files'
if(n_elements(var_list) eq 0) then begin
	var_list_in = list(ncdf_varlist,/extract) 
	dim_list_in = dim_list
	dim_t_in  = dim_t
	dim_match_in = dim_match
endif else begin
	if(~isa(var_list,'LIST')) then var_list = list(var_list,/extract)
	var_list_in = list()
	dim_list_in = list()
	dim_t = List()
	dim_match_in = list()
	foreach elem,varlist,idx do begin
		if(var_list.count(elem) eq 1) then begin
			var_list_in.add,elem 
			dim_list_in.add,dim_list[idx]
			;			dim_t_in, dim_t[idx]
			dim_t_in.add, dim_t[idx]
			dim_match_in.add,dim_match[idx]
		endif else print,'Warning :'+elem+' not found in netCDF'
	endforeach
endelse

foreach file,file_list,idx_file do begin
	nc1 = ncdf_open(file)
	if(nc1 lt 0) then begin
		print,'Warning : '+file +'not valid netCDF file'
		break
	endif
	foreach elem,var_list_in,i do begin
		if ( idx_file eq 0) then begin
			varid =  NCDF_VARID( nc1, elem )
			if(varid eq 0) then continue
			ncdf_varget,nc1,varid,temp
			if(dim_match[i] gt 0) then $
				;	temp = transpose(temp,dim_t[i].ToArray())
				temp = transpose(temp,dim_t[i]-1)
			(SCOPE_VARFETCH(elem, LEVEL=-1,/ENTER))=temp
			delvar,temp,varid
		endif else begin 
			varid =  NCDF_VARID( nc1, elem )
			if(varid eq 0) then continue
			ncdf_varget,nc1,varid,temp
			if(dim_match[i] lt 0) then continue
			;	if(dim_match[i] gt 0) then temp = transpose(temp,dim_t_in[i].ToArray())
			if(dim_match[i] gt 0) then temp = transpose(temp,dim_t_in[i]-1)
			arr = SCOPE_VARFETCH(elem, LEVEL=-1)
			(SCOPE_VARFETCH(elem, LEVEL=-1,/ENTER))=[arr,temp]
			delvar,temp,varid,arr
		endelse
	endforeach
	ncdf_close,nc1
endforeach
end
