pro rat_print_size,a,b,c,d,e,f
	np = n_params(0)
	str_type = ['Undefined','Byte','Integer','Long',$
		'Float','Double','Complex float','String',$
		'Structure','Double Complex','Pointer',$
		'Object reference','Unsigned integer',$
		'Unsigned long','64-bit integer',$
		'Unsigned 64-bit integer']
	s_type=''
	str1=''
	for i = 0 , np-1 do begin
		name=''
		str1=''
		case i of 
		0: begin name=scope_varname(a,level=-1)& arr = a & end
		1: begin name=scope_varname(b,level=-1)& arr=b & end
		2: begin name=scope_varname(c,level=-1)& arr=c & end
		3: begin name=scope_varname(d,level=-1)& arr=d & end
		4: begin name=scope_varname(e,level=-1)& arr=e & end
		5: begin name=scope_varname(f,level=-1)& arr=f & end
		endcase
		n_dim = size(arr,/n_dimensions)
		dim = size(arr,/dimensions)
		type = size(arr,/type)
		s_type = str_type[type]
		s_dim=strcompress(string(dim[0]))
		for i =1 , n_dim-1 do begin s_dim=s_dim+'X'
			s_dim = s_dim+strcompress(string(dim[i]))
		endfor
		str1 = name+' =  '+s_type+'['+s_dim +']'
		print,str1
	endfor
end
