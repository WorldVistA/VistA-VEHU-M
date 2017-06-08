ZVRKILL ; MAS VARIABLES 'CLEAN UP' ROUTINE - 4/23/90 - VFR
 ; CREATED BY VAL RYMANOWSKI
 ;
VAL1 ; This exit action kills the variables for the option SDAMISUSPENSELIST.
 K DHD,F,FLDS,FR,L,O,POP,TO,W,Z
 ;
VAL2 ; This exit action kills the variables for the option SD UNIQUE SSN.
 K D,DD,DGJ,DZ,POP,Z
 ;
VAL3 ; This exit action kills the variables for the option SDAMIS.
 K D,DVN,MDIV,POP,VAL,Z
 ;
VAL4 ; This exit action kills the variables for the option SDADDEDIT;
 ; for routines SDAMBAE, SDAMBAE1, SDAMBAE2, SDAMBAE3, and SDAMBAE4.
 K D0,D1,DFN,DIV,POP,SDIV,SDSCD,VA("BID"),VA("PID"),Z
 ;
VAL5 ; This exit action kills the variables for the options SD AMB PROC EDIT,
 ; SD AMB PROC LIST, and SD AMB PROC RAM DATA EDIT, for the routine
 ; SDAMBAE0.
 K %DT,%Y,D,DCC,DHD,F,FLDS,FR,J(1),L,O,POP,SDCNT0,TO,W,X1,Z,Z1
