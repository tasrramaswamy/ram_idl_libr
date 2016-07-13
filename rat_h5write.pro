
pro rat_h5write , hdf5_file_ID , field_name , data
;***********************************************************
;This routine writes a dataset(variable) to HDF5 file
;The HDF5 file is assumed to be open, and hdf5_file_id contains
; the HDF5 file identifier
;***********************************************************

;; get data type and space, needed to create the dataset

datatype_id = H5T_IDL_CREATE(data)
if (n_elements(data) gt 1) then $
dataspace_id = H5S_CREATE_SIMPLE(size(data,/DIMENSIONS)) $
 else $
  dataspace_id = H5S_CREATE_SCALAR()

;; create dataset in the output file
dataset_id = H5D_CREATE(hdf5_file_id,$
field_name,datatype_id,dataspace_id)

;; write data to dataset
H5D_WRITE,dataset_id,data

;; close all open identifiers except hdf5 file identifier
H5D_CLOSE,dataset_id
H5S_CLOSE,dataspace_id
H5T_CLOSE,datatype_id

end

