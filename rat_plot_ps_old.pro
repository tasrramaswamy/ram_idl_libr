;
PRO RAT_PLOT_PS, FILE_NAME, ORIENTATION , MULTI = MULTI , NO_ERASE = NO_ERASE,$
	PATH = path , colors_13 = colors_13,qual12=qual12,ct=ct,$
	xoffset=xoffset,yoffset=yoffset
;
; PLOT_FILE.PRO		Matthew DeLand				08/27/93
;
; This is a simple procedure to direct IDL Version 2 plot output to a PostScript
;   file;  The print file name can be specified, and the plot orientation can be
;   changed;  If these parameters are not present, default values will be used
;
;##  11/08/93  Changed default file name to lowercase for workstation use
;
;##  06/29/95  Set portrait plots to be full page if chosen
;
;##  01/24/97  Revise to use ORIENT=1 for full page portrait, ORIENT=2 for half
;##              page portrait
;
;##  11/24/04  PLOT_FIG.PRO modified for 'calab' to put output file into 
;##              '/figures' subdirectory of current location
;
;##  06/17/09 Get current directory and check if "figures" directory exits,
;		save in it , otherwise save in current directory and issue warning
PROG_NAME = rat_get_pro_name(0)

if(~KEYWORD_SET(xoffset)) then xoffset=1.0
if(~KEYWORD_SET(yoffset)) then yoffset=1.0
;
; Check number of parameters passed, then assign output file name
;
;##  11/24/04  Force output to go to '/figures' subdirectory
;
;##  03/10/11 capable of loading 13 channel colors  - RAT
N_IN = N_PARAMS(0)
;
if(n_in eq 0) then file_name='idl_plot.ps'
SET_PLOT, 'ps'
;
if(~keyword_set(path)) then begin
	CURR_DIR =''
	cd, current=CURR_DIR
	CURR_DIR =CURR_DIR+'/'
endif else CURR_DIR = path

;Check if filename has directory in it
pos1 = strpos(file_name,'/',/reverse_search) & pos2 = strpos(file_name,'\',/reverse_search)
pos = max(pos1,pos2)
if(pos le 0) then PS_DIR = CURR_DIR+'figures/' $
	else PS_DIR=strmid(file_name,0,pos)

if exists(PS_DIR) then print,'Printing in FIGURES directory' else begin 
	print,'WARNING : FIGURES directory does not exits, printing in current directory'
	PS_DIR = CURR_DIR+'/'
endelse
;IF (N_IN GE 1) THEN BEGIN
if(pos le 0) then  OUTFILE = PS_DIR+FILE_NAME else OUTFILE=FILE_NAME
;ENDIF ELSE BEGIN
;  OUTFILE = PS_DIR+'idl_plot.ps'
;ENDELSE
;Use MULTI keyword to add pages instead of creating file
file_exists = FILE_TEST(OUTFILE)

;if(file_exists) then days_old = rat_file_days_old(FILE_NAME) else days_old = -1
days_old = -1
if (keyword_set(MULTI)le 0 or days_old ne 0.0) then begin

	;
	; Default orientation for output file (1 parameter) is LANDSCAPE
	;
	;##  06/29/95  Make portrait plots full page
	;
	;##  01/24/97  Set portrait plots for full page or half page;  Tell user which
	;##              case has been chosen
	;
	IF (N_IN EQ 2) THEN BEGIN
		DEVICE, /portrait, /times, filename=OUTFILE
		IF (ORIENTATION EQ 1) THEN BEGIN
			PRINT, '%%  Portrait plot will be FULL page  %%'
			DEVICE, /inches, xsize=6.5, xoffset=xoffset, ysize=9.0, yoffset=yoffset
		ENDIF ELSE IF (ORIENTATION EQ 2) THEN BEGIN
			PRINT, '%%  Portrait plot will be HALF page  %%'
		ENDIF
		;
	ENDIF ELSE BEGIN
		DEVICE, /landscape, /times, filename=OUTFILE,$
			 xoffset=xoffset,yoffset=yoffset
	ENDELSE
	;DEVICE, ENCAPSULATED = 1
	DEVICE,/COLOR
endif else begin
	if(keyword_SET(NO_ERASE)) then erase else RAT_ERASE
endelse
if(KEYWORD_SET(ct)) then loadct,ct

if(KEYWORD_SET(colors_13)) then rat_load_12ch_colors
if(KEYWORD_SET(qual12)) then rat_load_qual12_colors
;
; Remind user that print file is open
;
;;PRINT,' '
PRINT,'@@@  Remember to CLOSE the output file before printing!!  @@@'
;;PRINT,' '
;
;stop
;RETURN
END
