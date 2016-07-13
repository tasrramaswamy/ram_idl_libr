function fill_val_nan,arr
out=arr

	idx1=where(out le 0.,count)
        if (count gt 0) then out(idx1)= !values.F_Nan
      
return,out
stop
end
