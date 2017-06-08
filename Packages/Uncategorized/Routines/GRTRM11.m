%GRTR ;27-Feb-84;Receive routines/globals from %GRTS;ISM ; 09 JAN 85  1:08 PM
 S DSP=0,DIR="R" D ^%GRTINI
R S GET="F K=1:1 R X:T1 S RSLT=$S('$T:-1,X=ENQ:0,X=ETX:2,X=""(%)ERROR(%)"":3,X=EOT:4,1:1),ERROR=RSLT=3 Q:RSLT>1  W:'RSLT XX,RET I RSLT R CHK1:T1 X CHK S XX=$S(OK:ACK,1:NAK)_""^""_J X BUFLUSH W XX,RET Q:OK"
 ;GET reads X (routine name or line, or Global Node or Global
 ;Data)  CHKs X, flushes buffer, Writes ACK
 ;REWRITES PREVIOUS ACK IF RCVS ENQ
 S CHK="S CHK2=0 F L=1:1:$L(X) S CHK2=CHK2+$A(X,L) S OK=CHK2=$P(CHK1,""^"",2)"
 ; Does checksum
 S REM="ZR:MOD=""R""&ERROR"
 ;REM ZRemoves routine if error
 S END="U ME W "" **Received**"",! U DEV"
 S RSYNC="F K=1:1:MAX R X:2 I X=SYNC W SYNC,RET Q"
 ; Reads from TSYNC on sender side
 U DEV G @(DIR_MOD)
RR ; Receive Routines
 S RB="U ME W ""Routine "",N,"" being transferred"" U DEV"
 ; Notify receiver
 S RTGET="F J=1:1 X GET Q:RSLT>1  X:DSP WX ZI X" ;GETs lines,
 ; Displays if wanted, ZInserts the line QUITS at end if not ERROR or NAK
 X "F I=1:1 X RSYNC Q:K=MAX  S J=0 X GET Q:ERROR  S N=X ZR  X:'DSP RB X RTGET ZR:ERROR  Q:ERROR  X:'DSP END ZS @N Q:RSLT=4"
 ;
 ; Above line Xecutes RSYNC, GET sets N=X (name) clears 
 ; routine buffer Xecutes RTGET 
 ;
 X REM D RCHECK Q
RG ; Receive Globals
 S GB="U ME W ""Global "",$P(X,""(""),"" being transferred"" U DEV"
 ; Notify receiver
 F I=1:1 X RSYNC Q:K=MAX  D GLGET Q:ERROR  X:'DSP END Q:RSLT=4
 ; Get the globals
RCHECK ; RECEPTION ERROR CHECK
 U ME W !!,$S(K=MAX:NOLINK,ERROR:NOSYNC,1:GOOD),!!!
 C DEV
 K
 Q
GLGET F J=1:1 X GET I RSLT'=-1 Q:RSLT>1  X:DSP WX X:'DSP&(J=1) GB S Y=X D GLGET2 Q:RSLT>1
 Q
GLGET2 S J=J+1 F Q=1:1 X GET I RSLT'=-1 X:DSP WX S @Y=X Q
 ; Uses GET to get global node name then GET's data and sets node here
 ; QUITs on ETX or EOT
