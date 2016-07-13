pro rat_h4_fields ,file

if(~file_test(file)) then $
    MESSAGE,'****I/O ERROR : Input Filename does not exist : '+file

fileID = HDF_SD_Start(file, /read) 



