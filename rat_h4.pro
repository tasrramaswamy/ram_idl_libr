

function rat_h4, hdf_file
compile_opt idl2

;check to see if the HDF-4 file is valid
if hdf_file eq !null || ~hdf_ishdf(hdf_file) then begin
    message, 'Not an HDF4 file. Returning.', /info
    return, 0
endif

;initialize HDF SD interface
hdf_id = hdf_sd_start(hdf_file, /read)
    if ~hdf_id then return, 0

;retrieve HDF datasets and attributes
hdf_sd_fileinfo, hdf_id, n_sds, n_attr
var_index = lonarr(n_sds)
var_name = strarr(n_sds)

;loop through datasets to get index values and names of datasets
for i = 0, n_sds-1 do begin
    var_id = hdf_sd_select(hdf_id, i)
    hdf_sd_getinfo, var_id, name=vn
    var_index[i] = hdf_sd_nametoindex(hdf_id, vn)
    var_name[i] = vn
endfor

hdf_sd_end, hdf_id
sd_info = {index:var_index, name:var_name}
return, sd_info

end
