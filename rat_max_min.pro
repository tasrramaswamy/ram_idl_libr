pro rat_max_min,x,min,max



diff_1 = ts_diff(x,1)
diff_2 = ts_diff(x,2)

diff_1_norm = diff_1 / max(diff_1)
diff_2_norm = diff_2 / max(diff_2)


sign_1 = diff_1_norm / abs(diff_1_norm)
sign_2 = diff_2_norm / abs(diff_2_norm)

idx_1_pos = where(sign_1 eq 1)
idx_1_neg = where(sign_1 eq -1)

rat_common_days,idx_1_pos,idx_1_neg+1,c1,c2
rat_common_days,idx_1_neg,idx_1_pos+1,d1,d2

stop

end
