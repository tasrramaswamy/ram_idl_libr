pro rat_plot_13ch_4c,X1,Y1,$
	dev=dev,ps_name=ps_name,ps_append=ps_append,$
	xtit=xtit,ytit=ytit,tit=tit,xlabel=xlabel, leg=leg,$
	colors=colors,ct=ct,xrange=xrange,yrange=yrange,lines=lines,$
	xmin=xmin,ymin=ymin,xtick=xtick,ytick=ytick,ps_open=ps_open,$
	linet=linet
	
;
;
;
;
;Notes : THis program expects one-dimensional X array and 13 channel Y array
;
; ## 01/28/10 Updated to count the number of channels, instead of a constant(13)
; ## 01/26/11 Program modified to check if rows of Y1 array represent channels,
;		otherwise transpose Y1		
;## 01/26/11  Device option added. Set dev='ps' and ps_name='NAME-OF-PS_FILE'
;		default filename is 'idl.ps'
;## 02/16/11 Use 5 colors instead of 4
;## 02/16/11 Added append capablity to ps file.
;## 03/09/12 Added "ps_open" keyword. When set, it keeps the PS device open to
;		facilitate over-plotting.


;ps_append will print the plot on the next page.
Y = Y1 & X = X1
siz = size(Y)
dim_row = siz(1)
dim_col = siz(2)

if (dim_col gt dim_row) then Y =transpose(Y)  ;Assume data has more points than channels
siz = size(Y)
n_ch = siz(2)

if(~KEYWORD_SET(dev)) then dev='X'
if (~KEYWORD_SET(xrange)) then begin 
	xmin1=min(X,/Nan,max=xmax1)
	xrange=[xmin1,xmax1]
	xstyle1=0
endif else xstyle1=1
if (~KEYWORD_SET(yrange)) then begin 
	ymin1=min(Y,/Nan,max=ymax1)
	yrange=[ymin1,ymax1]
	ystyle1=0
endif else ystyle1=1
if (~KEYWORD_SET(xmin)) then xmin =6
if (~KEYWORD_SET(ymin)) then ymin =5
if (~KEYWORD_SET(thick)) then thick=1.5
if (~KEYWORD_SET(xtick)) then xtick =!x.ticks
if (~KEYWORD_SET(ytick)) then ytick =!Y.ticks
if (~KEYWORD_SET(xtit)) then xtit=!X.title
if (~KEYWORD_SET(ytit)) then ytit=!Y.title
if (~KEYWORD_SET(tit)) then tit=!P.title

if ~KEYWORD_SET(colors) then $
	COLORS = [ fltarr(3)+1,fltarr(3)+2, fltarr(3)+3, fltarr(3)+5, 4 ]
if (n_elements(lines) eq 0) then lines1 = indgen(13) mod 3 else  lines1=lines

dev=STRUPCASE(dev)

if(dev ne'PS') then rat_refresh_dev else begin
	if(KEYWORD_SET(ps_append)) then rat_erase else begin
		if(~KEYWORD_SET(ps_name)) then ps_name='idl.ps'
		set_plot,'PS'
		rat_refresh_dev,ps_name=ps_name
	endelse; for ps_append
endelse; for dev

if ~KEYWORD_SET(ct) then begin
	loadct,38
	ct_data = read_ascii('~/IDL_LIBR/colors/qual_brewer_colors6.tbl',comment=';')
	ct=ct_data.field1
	tvlct,r,g,b,/get
	r1=ct(0,*) & g1 = ct(1,*) &   b1 = ct(2,*)
	nrecs=n_elements(b1)
	r(1:nrecs) = r1 & g(1:nrecs)=g1 & b(1:nrecs)= b1
	tvlct,r,g,b
endif else loadct,ct

if(~KEYWORD_SET(leg)) then begin
	leg=strarr(n_ch)
 	for i=1,n_ch do leg(i-1) = 'Ch. '+string(format='(I2)',i)
endif

PLOT,X,Y(*,0),/nodata,/noerase,xtitle=xtit,ytitle=ytit,title=tit,$
	xrange=xrange,yrange=yrange,xticks=xtick,yticks=ytick,$
	xminor=xmin,yminor=ymin,xtickn=xlabel,xstyle=xstyle1,ystyle=ystyle1
for i=0,n_ch-1 do $
	oplot,x,y(*,i),color=colors(i),lines=lines1(i),thick=thick1

 legend,leg,colors=colors(0:n_ch-1),linestyle=lines1(0:n_ch-1)
	
if (dev ne 'X') then begin
	if(KEYWORD_SET(ps_open) or KEYWORD_SET(ps_append)) then begin
		print,'%%%%% PS FILE STILL OPEN '
		print,'close ps device'
	endif else begin
		device,/close
		print,'---PS device closed --'
	endelse
endif
end
