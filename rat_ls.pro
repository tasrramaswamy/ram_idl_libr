pro rat_ls ,DIR,str1


;+
;This program lists the files that match a particular pattern
;in a directory. 
;The default pattern is "*.pro"
;The default directory is "/omihome/rtiruchi/IDL_LIBR/RAT/"
;-


nparam1 = n_params(0)
cd , current=curr_dir1
curr_dir1 = curr_dir1+'/'

home_dir= getenv('HOME')

;print,curr_dir1
;stop
case nparam1 of 

0 : begin
	STR1='*.pro'
	DIR=home_dir+'/IDL_LIBR/RAT/'
    end

1 : begin
	a=DIR
	slash_b00 = strmatch(a,'/')
	if( slash_b00 eq 1 ) then begin
		DIR =a 
		STR1 ='*.pro'
	endif else begin
		DIR = curr_dir1
		STR1=a
	endelse
	end
endcase
list=''
fname = dir + str1
list = file_search(fname,count=n_files)
print,list
print,'-------------------------------------------------------------'
print,'Number of files: n_files'
print,''


stop

end

