pro rat_print_fonts,dev=dev

PROG_NAME=rat_get_pro_name(0)
if(~KEYWORD_SET(dev)) then dev='X' 
dev=strupcase(dev)
if(dev eq 'X') then rat_window else $
	make_ps,'idl_font_type.ps'


	for i=0,20 do begin
	case i of 
	
	 3 :  str2 = 	'Simplex Roman' 	
	4 : str2= 	'Simplex Greek' 	
	5 : str2=	'Duplex Roman' 	
	6 : str2=	'Complex Roman' 	
	7 : str2=	'Complex Greek' 	
	8 : str2=	'Complex Italian' 	
	9 : str2=	'Math Font' 	
	10 : str2=	'Special Characters' 	
	11 : str2= 	'Gothic English'
	12 : str2=	'Simplex Script'
	13 : str2=	'Complex Script'
	14 : str2=	'Gothic Italian'
	15 : str2=	'Gothic German'
	16 : str2=	'Cyrillic'
	17 : str2=	'Triplex Roman'
	18 : str2=	'Triplex Italian'
	20 : str2=	'Miscellaneous'
	else: str2=''
	endcase
	if(str2 eq '') then continue else kount=i
	stri = strcompress(string(kount),/remove_all)
	str1 = '!'+stri
	str3 ='abcdefg ABCDEFG'
	string1 = stri+'   '+str2 + '   '+str1+str3+' !X'
	if kount le 10 then x1 = 0.07 else x1 = 0.5
	y1 = 0.85 - (0.05*(kount-3)) 
	if(kount gt 10 ) then y1=y1+0.45
	print,x1,y1,string1
	xyouts,x1,y1,string1,chars=1.3
endfor
xyouts,0.2,0.2,'End with !!X to revert back to original type',chars=1.5
plot_name_side
if(dev ne 'X') then device,/close
stop
end

