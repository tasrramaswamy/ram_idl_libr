pro   rat_read_he4 ,filename , input_swath_name, var_list

fid = EOS_SW_OPEN(filenmae,/READ)

;Get the number and names of swaths
nswath = EOS_SW_INQSWATH(filenmae, swathlist)

;Convert single string to array of strings
swath_names = STRSPLIT(swathlist,',',/extract)

sw_n = where(swath_names eq input_swath_name, n_match)

if (n_match eq 0) then $
	MESSAGE,$
	input_swath_name+'not found. List of available swaths :'+$
	swath_names


swathID = EOS_SW_ATTACH(fid,swath_nameset(sw_n) )

foreach var,varlist do begin
	status = eos_sw_readattr(swathID, var ,data)
	(scope_varfetch(var,/enter , level=-1)) = data
endforeach

status = EOS_SW_DETACH(swathID)
status = EOS_SW_CLOSE(fid)

end
