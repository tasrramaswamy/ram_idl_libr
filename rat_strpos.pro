function rat_strpos,str1,sub_str

loc_arr = [-1]

curr_loc=-1
str_len = strlen(str1)
repeat begin
curr_loc = strpos(str1,sub_str,curr_loc+1)
if(curr_loc ge 0) then loc_arr = [loc_arr,curr_loc]
endrep until(curr_loc le 0)
if(n_elements(loc_arr) gt 1) then loc_arr = loc_arr(where(loc_arr ge 0))
return,loc_arr
end
