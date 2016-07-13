pro rat_ncdf_multiread,ncfile,list1,__silent=__silent,stop1=stop1
if(~file_test(ncfile)) then begin
	print,"_________________________________________________"
	message,'		ERROR: FILE DOES NOT EXIST'
	print,"_________________________________________________"
endif
;Read the list of variables in netCDF file
nc1 =  ncdf_open(ncfile)
nc_inq = ncdf_inquire(nc1)
n_vars = nc_inq.Nvars
n_dims = nc_inq.Ndims
list_nc_vars=strarr(n_vars) & list_nc_dims = strarr(n_dims)
for i =0,n_vars-1 do begin
	list_nc_vars[i]=(ncdf_varinq(nc1,i)).name
endfor
ncdf_close,nc1
;Check if all elements in the list are in netCDF file
if(n_elements(list1) eq 0) then list1=list_nc_vars $
	else begin
	list2 = list(list1)
	foreach item,list1 do begin
		qq = where(list_nc_vars eq item,n_match)
		if(n_match ne 1) then list2.remove,item
	endforeach
	list1 =list2.toarray()

endelse

nc1 = ncdf_open(ncfile)
ret_list=list()
foreach elem,list1,i do begin

	;Read variable ID
	varid =  NCDF_VARID( nc1, elem )
	;Get variable dimension attributes
	dim_att = (NCDF_VARINQ(nc1,varid)).dim
	if(varid lt 0) then begin
		if(~KEYWORD_SET(__silent)) then print,elem+' not found'
	endif
	ncdf_varget,nc1,varid,temp
	(SCOPE_VARFETCH(elem, LEVEL=-1,/ENTER))=temp
	delvar,temp,varid
	endforeach
	ncdf_close,nc1
	if(KEYWORD_SET(stop1)) then stop
end
