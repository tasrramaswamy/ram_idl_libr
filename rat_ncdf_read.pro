pro rat_ncdf_read,ncfile,list1,__silent=__silent,stop1=stop1
if(~file_test(ncfile)) then begin
	print,"_________________________________________________"
	message,'		ERROR: FILE DOES NOT EXIST'
	print,"_________________________________________________"
endif
if(n_elements(list1) eq 0) then begin
	nc1 =  ncdf_open(ncfile)
	nc_inq = ncdf_inquire(nc1)
	n_vars = nc_inq.Nvars
	list1=strarr(n_vars)
	for i =0,n_vars-1 do begin
		list1[i]=(ncdf_varinq(nc1,i)).name
	endfor
	ncdf_close,nc1
endif

nc1 = ncdf_open(ncfile)
ret_list=list()
foreach elem,list1,i do begin
	varid =  NCDF_VARID( nc1, elem )
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
