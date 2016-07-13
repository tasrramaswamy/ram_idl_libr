function rat_mad , X, median1=median1
	;+
;This function returns Mean absolute deviation of a set of values.
;
;MAD is defined as the median of the absolute deviations from 
;the data's median
;
;-
	; ## 12/31/12 Added median keyword
X1  = X
med1 = median(X1)
dev_med1 = X1 - med1
adev =abs(dev_med1)
mad1 = median(adev)
median1 =med1
return,mad1
end

