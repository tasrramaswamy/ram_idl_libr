function rt_last_value,a
n=n_elements(a)
if(n eq 0) then begin
	print,'%%% ERROR %%%%'
	print,'Array Does not exist'
	Message,'Array Does not exist'
endif
l=-9999.0
if (n gt 0) then l =a(n-1)
return,l
end 
