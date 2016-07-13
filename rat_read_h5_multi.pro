
function rat_read_h5_multi , hash_var_path ,file_list
out=hash()
inp_var_list = hash_var_path.keys()
foreach path,hash_var_path,idx do begin
	foreach file,file_list,idx_file do begin
		temp = rat_read_h5(file,path)
		if (idx_file eq 0) then data_arr = temp  else begin
			if (SIZE(temp,/n_dimensions) eq 2) then $
				data_arr = [[data_arr],[temp]] else $
				 data_arr =[[[data_arr]],[[temp]]]
		 endelse
	 endforeach
;	 stop
out[idx ] =data_arr	 
 endforeach

return, out
end
