function rat_read_h5_fill, file, path ,fill_val=fill_val,$
	stop1=stop1
  fid = h5f_open(file)
  did = h5d_open(fid, path)
  data = h5d_read(did)
  fill_val_id= H5A_OPEN_NAME(did, "_FillValue") 
  fill_val = (H5A_READ(fill_val_id))[0]
  h5a_close,fill_val_id
  h5d_close, did
  h5f_close, fid
  if(n_elements(fill_val) gt 0) then begin
	  bad_idx = where(data le fill_val,n_bad)
	  if(n_bad gt 0) then data[bad_idx] = !values.F_Nan
  endif
  if(KEYWORD_SET(stop1)) then stop
  return, data
end
