pro rat_name_side,stop1=stop1
p_name = rat_get_pro_name(-2,stop1=stop1)
XYOUTS, 0.99, 0.09, /norm,'   !8'+p_name+'!6',$
	orient=90, chars=0.8
if(KEYWORD_SET(stop1)) then  stop
return
end
