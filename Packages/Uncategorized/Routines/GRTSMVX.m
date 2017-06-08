%GRTS ;27-Feb-84;Send Routines or Globals to another CPU with %GRTR ISM VAX ; 09 JAN 85  2:07 PM
 S DSP=0,DIR="S" D ^%GRTINI ;DIR = Direction, DSP = display
S S END="U ME W "" **Sent**"",! U DEV",NOSEND="Nothing chosen to send"
 S TSYNC="F K=1:1:MAX W SYNC,RET R X:2 I X=SYNC Q"  ;TSYNC = sync test. Sender writes "SYNC" for MAX number of times
 ;reads it back over the same line and Quits when he read" SYNC"
 S CHK="S CHK1=0 F L=1:1:$L(X) S CHK1=CHK1+$A(X,L)" ;error check adds $A'S ofcharacters
 S RNUM="S CHK1=J_""^""_CHK1"
 ; RNUM appends record # to end of checksum
 S ENQU="S TO=A F B=1:1:TRIES X BUFLUSH W ENQ,RET R A:T1 Q:A=AA  S JJ=$P(A,""^"",2),ERROR=B=TRIES W:ERROR ""(%)ERROR(%)"",RET I JJ=J!(JJ=J-1) I A[ACK!(A[NAK) X @($P(A,""(%)"",2)_""J"") Q"
 S ACKJ="Q:TO=""""&(J=JJ)  S:J'=JJ AGAIN=1"
 ;I got an ACK of J or J-1
 S NAKJ="S AGAIN=1"
 ;I got NAK of J
 ;ENQU runs if ACK is wrong from RCVR.
 ; tries for another ACK from RCVR
 ;if it gets one 1st try then must have been garbled; go on. If not right
 ;on 2nd try find out problem.
 ;TO= Got here by timeout
 ;TO,ACK J -> No Resend
 ;TO,NAK J -> Resend J
 ;TO, ACK J-1 -> Resend J
 ;'TO,ACK J ->No Resend
 ;'TO,NAK J -> Resend J
 ;'TO,ACK J-1 -> Resend J
 S SEND="F K=1:1:TRIES S (B,AGAIN)=0 W $S(DONE&EOR:EOT,EOR:ETX,ERROR:""ERROR"",1:X),RET Q:EOR!ERROR  X CHK,RNUM W CHK1,RET S ERROR=K=TRIES,AA=ACK_""^""_J R A:T1 Q:A=AA  S AGAIN=A=(NAK_""^""_J) X:'AGAIN ENQU Q:'AGAIN"
 ;K = # retries after NAK. B = # ENQS, J = record number 
 ;Write data read for ACK check ACK and J. If NAK_J, retry, Else do ENQU.
 W ! U DEV G @(DIR_MOD)
SR ; Routine Send
 S RB="U ME W ""Routine "",N,"" being transferred"" U DEV"
 S RTSEND="F J=1:1 S X=$T(+J),EOR=X="""" X SEND Q:ERROR!EOR  X:DSP WX"
 ;RTSEND S X=N (Routine name or line) sets Y=next line EOR, (end of
 ;routine) if Y="" Xecutes SEND, displays if wanted
 X "S N=$O(^UTILITY($J,0)) Q:N=""""  F I=1:1 S EOR=0,M=$O(^UTILITY($J,N)),DONE=M="""" X TSYNC Q:K=MAX  ZL @N S X=N,J=0 X SEND X:'DSP RB X RTSEND X:'DSP END Q:DONE  S N=M"
 ;
 ; ABOVE LINE sets N=routine name to be sent M=next one. DONE flag if
 ;M=""
 ;executes TSYNC ZLoads Routine to be sent, Tells sender (RB), 
 ;Xecutes RTSEND and END
 G TCHECK
SG ;GLOBAL SEND
 S GB="U ME W ""Global "",N,"" being transferred"" U DEV",N=$O(^UTILITY($J,"")),OS="" G TCHECK:N=""
 F I=1:1 S M=$O(^UTILITY($J,N)),DONE=M="" S:N["(" OS=$E(N,1,$L(N)-1) X TSYNC Q:K=MAX  X:'DSP GB D GLSND Q:Y'=""  X:'DSP END Q:DONE  S N=M
 ;
 ;Above line SETS M=next global in ^UTILITY list, DONE flag set if M=""
 ;Sets  Xecutes TSYNC, displays if wanted, Does GLSND and
 ;Xecutes END if DONE sending Global
 ;
 G TCHECK
GLSND S (EOR,A)=0,Y="",N="^"_N,NM=$P(N,"(",1) ;NM = GBL NAME
 Q:'$D(@N)  S OS=NM_"(",N=N_"("""")",X=NM,DUN=$O(@N),D1=DUN="",(BEG,LVL)=1 D STR^%GRTZO S (OS(LVL))=OS_DUN,(UP,DUN)=0 I '($D(@NM)#10) D ^%GRTZO S X=ZO
 ;SET UP FOR ^%GRTZO TRAVERSAL
GLS0 I D1 F J=1:1 X SEND G:ERROR!EOR GLSQ X:DSP WX S X=@X,J=J+1 X SEND G:ERROR GLSQ X:DSP WX S EOR=1,X="",D1=0
GLS1 F J=1:1 S EOR=X="" X SEND Q:ERROR!EOR  X:DSP WX S X=@X,J=J+1 X SEND Q:ERROR  X:DSP WX D ^%GRTZO S X=ZO
 ;
 ;Above:  Xecute SEND, display if wanted X=@X, 
GLSQ Q
TCHECK ; TRANSMISSION ERROR DETECTION
 K ^UTILITY($J) U ME W !!,$S(K=MAX:NOLINK,X'="":NOSYNC,1:GOOD),!!!
 C DEV
 K
 Q
