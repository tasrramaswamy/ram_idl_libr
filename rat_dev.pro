function rat_dev,val, dev_med=dev_med
	;This program returns the normalized deviation of values from the mean or median
avg1 = mean(val ,/Nan)
med1 = median(val)	;median treats NAN as missing value

dev1 = (val - avg1 ) /avg1
dev2 = (val - med1)/ med1
dev_med = dev2
return,dev1

end
