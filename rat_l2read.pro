pro rat_l2read,f
COMMOn vars_h5,toz,ler340,lat,lon

p1='/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/LER340'
p4='/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/ColumnAmountO3'
p2='/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/Latitude'
p3='/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/Longitude'

;f='TOMS-N7_L2-N7TO3_1980m0601-o08100.he5'
toz = rat_read_h5(f,p4)
ler340 = rat_read_h5(f,p1)
lat = rat_read_h5(f,p2)
lon = rat_read_h5(f,p3)

end
