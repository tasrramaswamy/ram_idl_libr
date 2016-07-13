pro rat_close_dev,file
dev=strupcase(!D.NAME)
if(N_elements(file) eq 0) then file='idl.png'
if(dev eq 'Z') then rat_z2png,file else $
	if(dev eq 'PS') then device

CASE dev of
'PS': begin
		unit = fstat(!D.UNIT)
		ps_name=unit.name
		device,/close
		print,'Closing ...'+ps_name
		cgFixPS, ps_name
	end
'Z': rat_z2png,file
else : dummy=0
endcase

end
