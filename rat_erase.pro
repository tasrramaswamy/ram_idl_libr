pro rat_erase,dummy,colors_13 = colors_13
;+ Set the post script file to next page and reset window parameters
;-

erase
!p.multi=0
!p.title=''
rat_win_reset
if(KEYWORD_SET(colors_13)) then rat_load_12ch_colors

end

