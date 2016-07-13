
function rat_get_brewer_colors,n_colors,idx,div=div,seq=seq,qual=qual,pal=pal,$
	stop1=stop1
	HOME_DIR = getenv('HOME')
	if(KEYWORD_SET(div)) then type='div'
	if(KEYWORD_SET(seq)) then type='seq'
	if(KEYWORD_SET(qual)) then type='qua'
	str_type=''
	case n_params() of 
		0:	begin & n_colors=8 & idx=0 & end
			1:	 idx=1 
			else :dum=0
		endcase
		if(~KEYWORD_SET(pal)) then begin
			nos = '_'+strcompress(string(indgen(15)) ,/remove_all)

			case type of
				'div':	begin
					str_type='Diverging'
					nos1=nos[3:11]
					choices=['BrBG'+nos1,'PiYG'+nos1,'PRGn'+nos1,'PuOr'+nos1,'RdBu'+nos1,'RdGy'+nos1,$
						'RdYlBu'+nos1,'RdYlGn'+nos1,'Spectral'+nos1]
				end

				'seq':  begin
					str_type='Sequential'
					nos2=nos[3:9]
					choices=['BuGn'+nos2,'BuPu'+nos2,'GnBu'+nos2,'OrRd'+nos2,'PuBu'+nos2,$
						'PuBuGn'+nos2,'PuRd'+nos2,'RdPu'+nos2,'YlGn'+nos2,'YlGnBu'+nos2,'YlOrBr'+nos2,$
						'YlOrRd'+nos2, 'Blues'+nos2,'Greens'+nos2,'Greys'+nos2,'Oranges'+nos2,$
						'Purples'+nos2,'Reds'+nos2]
				end

				'qua':	begin
					str_type='Qualitative'
					nos3= nos[3:8]
					choices=['Accent'+nos3,'Dark2'+nos3,'Paired'+nos3,'Pastel1'+nos3,'Pastel2'+nos3,$
						'Set1'+nos3,'Set2'+nos3,'Set3'+nos3]

				end
			endcase
			str_cols ='*_'+ strcompress(string(n_colors),/remove_all)
			idx_m = where(strmatch(choices,str_cols) eq 1)
			pal = choices[idx_m[idx]]
		endif
 rgb_arr = rat_read_h5(HOME_DIR+'/IDL_LIBR/colors/colorbrewer.h5',pal)
 print,'Loading Brewer '+str_type+' Colors :'+pal
 if(n_elements(n_colors) eq 0) then n_colors=(size(rgb_arr,/dimensions))[1]
if(KEYWORD_SET(stop1)) then stop
return,rgb_arr

end











	end
