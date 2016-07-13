function rat_dev_sdev,val
	;This program returns the deviation of values from standard deviation
m = moment(val ,/Nan, sdev = std_dev1)
mean1 = m[0]
dev1 = (val - mean1 ) /std_dev1

return,dev1

end
