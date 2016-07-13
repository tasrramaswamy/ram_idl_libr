pro rat_help,fname
;+
;This program prints the COMMENT lines that are enclosed between markers ";+" and ";-"
;-
hdir= getenv('HOME')
new_dir=hdir+'/IDL_LIBR/RAT/'
CD,new_dir,current=old_dir
openr,lun,fname,/get_lun
;openw,lun_out,'rat_help.tmp',/get_lun
a=''
m=string(10000,1000)
start_comment =';+'
end_comment=';-'
start_b00 = -1
end_b00 = -1
kount_lines=0
while(~eof(lun) and (end_b00 ne 1) ) do begin
readf,lun,a
s_match = strmatch(a,start_comment) ; start match
e_match = strmatch(a,end_comment)  ; end match
if(s_match eq 1) then  start_b00 = 1 


if(e_match eq 1 ) then end_b00 = 1

if(start_b00 eq 1) then begin
		print,a
		kount_lines +=1
	endif

if(kount_lines gt 15) then begin
	print,' %%%%   ABORTING HELP %%%%%'
	print,'More than 15 lines limit , End of help not found'
	break
endif
endwhile
CD,old_dir
free_lun,lun
;stop
end


