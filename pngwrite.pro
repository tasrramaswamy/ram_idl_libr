pro pngwrite,fname
if (n_params() lt 1) then fname='curr_test.png'
device,decomposed=0
zz=tvrd()
tvlct,r_curr,g_curr,b_curr,/get
write_png,fname,zz,r_curr,g_curr,b_curr
end
