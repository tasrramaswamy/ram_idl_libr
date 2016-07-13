pro rat_load_grads_colors,dummy

home_dir=getenv('HOME')
COLORS = [ fltarr(11)+1,fltarr(11)+2, fltarr(11)+3, 4 ]
loadct,38
ct_data = read_ascii(home_dir+'/IDL_LIBR/colors/grads_color.tbl',comment=';')
ct=ct_data.field1
tvlct,r,g,b,/get
r1=ct(0,*) & g1 = ct(1,*) &   b1 = ct(2,*)
nrecs=n_elements(b1)
r(1:nrecs) = r1 & g(1:nrecs)=g1 & b(1:nrecs)= b1
tvlct,r,g,b
print,'Number of colors : '+string(nrecs)
end
