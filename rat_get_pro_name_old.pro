function rat_get_pro_name,dummy
;+
; This program returns the name of the idl program.
;-
; This is modified from Matt's code plot_name_side.pro
HELP, /traceback, calls=LEVELS
N_LEV = n_elements(LEVELS)
STR_NAME = LEVELS(N_LEV-1)
;
; Find location of end of string, then extract program name
;
N_END = STRPOS(LEVELS(N_LEV-1), ')')
CASE 1 OF
;
   ((STRMID(STR_NAME,(N_END-1),1) EQ '1') AND $
    (STRMID(STR_NAME,(N_END-2),1) EQ ' ') AND $
                             (N_LEV EQ 2)):  PROG_NAME = '$MAIN$'
;
   ((N_LEV EQ 2) AND (N_END EQ -1)):  PROG_NAME = '$MAIN$'
;
   ((STRMID(STR_NAME,(N_END-1),1) EQ '1') AND $
    (STRMID(STR_NAME,(N_END-2),1) EQ ' ') AND $
                             (N_LEV GT 2)):  BEGIN
      STR_NAME = LEVELS(N_LEV-2)
      N_PROG1 = STRPOS(STR_NAME, '<')
      N_PROG2 = STRPOS(STR_NAME, '(')
      PROG_NAME = STRMID(STR_NAME, (N_PROG1+1), (N_PROG2-N_PROG1-1))
   END
;
   ELSE:  BEGIN
      IF (STRPOS(STR_NAME, '<') EQ -1) THEN STR_NAME = LEVELS(N_LEV-2)
      N_PROG1 = STRPOS(STR_NAME, '<')
      N_PROG2 = STRPOS(STR_NAME, '(')
      PROG_NAME = STRMID(STR_NAME, (N_PROG1+1), (N_PROG2-N_PROG1-1))
   END
ENDCASE

print,prog_name
;stop
return,prog_name
end
