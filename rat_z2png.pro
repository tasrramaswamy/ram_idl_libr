pro rat_z2png , fname , nodelete=nodelete
np=n_params()
if(np eq 0) then fname='idl.png'
thisDev=!D.NAME
if(thisDev ne 'Z') then begin
		message,'Current Device Not Z BUffer'
endif
if(file_test(fname) eq 1) then begin
	print,'%%% WARNING :'+ fname+' already exists'
	if(~KEYWORD_SET(nodelete)) then file_delete ,fname
endif
 img=tvrd()
 tvlct,r,g,b,/get
 ; outfile=(strsplit(file,'.',/ext))[0]+'.png'
 print,'Printing Zbuffer to '+fname
 write_png,fname,img,r,g,b
end

