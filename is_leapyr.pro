function is_leapyr, year
year=fix(year)

leapyr=intarr(n_elements(year))
for i=0,n_elements(year)-1 do begin
year1=year(i)
if (year1 mod 4 eq 0) then begin
	if (year1 mod 100  ne 0) then leapyr(i)=1 else begin
			if (year1 mod 400 eq 0) then leapyr(i)=1 
			endelse
endif
endfor
if n_elements(year) eq 1 then return,leapyr(0) else return,leapyr
end
