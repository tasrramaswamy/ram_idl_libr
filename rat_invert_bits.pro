function rat_invert_bits , inp ,stop1=stop1
on_error,2
;Check if input is a string
type1 = size(inp,/type)

if(type1 ne 7 ) then begin
	MESSAGE,'inp String Expected'
endif 
n = n_elements(inp)

if (n eq 1) then begin
	len = strlen(inp)
	inp1 = strarr(len)
	for i = 0, len-1 do inp1[i] = strmid(inp,i,1)
endif else inp1 = inp

i_inp = fix(inp1)
i_out = i_inp
;  switch array around for convenience
idx_1 = where(i_inp eq 1,c_1)
idx_0 = where(i_inp eq 0,c_0)
if(c_1 gt 0) then i_out[idx_1] =0
if(c_0 gt 0) then i_out[idx_0] = 1
str_out = string(i_out)
if(n eq 1 ) then begin
	str_out1 = str_out
	str_out = ''
	for i = 0, n_elements(i_out)-1 do $
		str_out = str_out+string(i_out[i],format='(I1)')
endif

if(KEYWORD_SET(stop1)) then stop
return,str_out
end


