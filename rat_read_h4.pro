function rat_read_h4 , file , datasetName

if(~file_test(file)) then $
	MESSAGE,'****I/O ERROR : Input Filename does not exist : '+file

fileID = HDF_SD_Start(file, /read) 

if( fileID eq -1) then $
	  MESSAGE,'****ERROR : Problem openening input file : '+file 

  ;Get dataset index for  the datasetname
dataset_index = HDF_SD_NameToIndex(fileID, datasetName)

;Display Error if not possible
if (dataset_index eq -1) then $
	MESSAGE,"*** Unable to find the dataset "+datasetName

;Get the dataset ID for the dataset index
datasetID = HDF_SD_Select(fileID, dataset_index) 

;Retrieve the data from the HDF file into the variable data
HDF_SD_GetData, datasetID,data

;Ending access to the dataset ID
HDF_SD_ENDACCESS, datasetID

;CLosing HDF file
HDF_SD_END, fileID

return, data

end 
