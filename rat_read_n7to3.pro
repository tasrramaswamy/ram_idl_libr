pro rat_read_n7to3, file, field_list
a= {$
        gpqf : '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/GroundPixelQualityFlags',$
        lon: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/Latitude',$
        lat: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/Longitude',$
        raa: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/RelativeAzimuthAngle',$
        Sec: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/SecondsInDay',$
        sza: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/SolarZenithAngle',$
        time: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/Time',$
        vza: '/HDFEOS/SWATHS/TOMS Column Amount O3/Geolocation Fields/ViewingZenithAngle',$
        alg: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/AlgorithmFlags',$
        s3o3: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/ColumnAmountO3',$
        nval: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/NValue',$
        pqf:  '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/ProcessingQualityFlags',$
        qf: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/QualityFlags',$
        r340: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/Reflectivity340',$
        r380: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/Reflectivity380',$
        s1res: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/ResidualStep1',$
        s2res: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/ResidualStep2',$
        s1o3:  '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/StepOneO3',$
        s2o3:  '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/StepTwoO3',$
        wv: '/HDFEOS/SWATHS/TOMS Column Amount O3/Data Fields/Wavelength' }


;file = '/tis/TOMS/92130/N7TO3/1984/11/23/TOMS-N7_L2-N7TO3_1984m1123t0441-o30711_v001-2018m0308t195145.he5'

all_fields = tag_names(A)

if (n_elements(fields_list) eq 0) then begin
fields_list = all_fields
endif

for ii = 0 , n_elements(fields_list) -1 do begin
	(scope_varfetch(fields_list[ii],/enter, level=-1)) = h5_getdata(file, $
		a.(ii) )


endfor

end
