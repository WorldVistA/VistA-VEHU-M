PRSTAIM ; HISC/REL - MailMan Utilities ;7/26/93  09:39
 ;;3.5;PAID;;Jan 26, 1995
H ; List Mail Messages
 S XMAN="" F I=0:0 S I=$O(^TMP($J,"B",I)) Q:I'>0  S XMZ=^TMP($J,"B",I) D BOT:$Y>(IOSL-5) Q:XMAN[U  D H0
 K I,X,X1,XMAN,XMR,XMSUB,XMZ,Y Q
H0 G:'$D(^XMB(3.9,XMZ,0)) ERR S XMR=^XMB(3.9,XMZ,0),XMSUB=$P(XMR,U,1)
 W !,I," " W "Subj: ",XMSUB,"  " D H1 Q
H1 S X=$P(XMR,U,3) I X>20000 D DT W Y
 E  W X
 S X1=$S($D(^XMB(3.9,XMZ,2,0)):$P(^(0),U,4),1:0) W "  ",X1," Line" W:X1'=1 "s" Q
 ;
ERR K ^XMB(3.7,XMDUZ,2,XMK,1,XMZ) Q
BOT S:'$D(IOST) IOST="C" Q:$E(IOST,1)'="C"  S XMAN=0 W !,*7,"Press return to continue or ""^"" to escape  " R XMAN:DTIME S:'$T XMAN=U Q:XMAN[U  W @IOF Q
DT S Y=$E(X,6,7)_" "_$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec",U,$E(X,4,5))_" "_$E(X,2,3) S:X\1'=X %=$P(X,".",2)_"0000",Y=Y_" "_$E(%,1,2)_":"_$E(%,3,4) Q
QU ; Help prompt for message selection
 W !!,"Enter the numbers of the messages you wish to Install, separated by"
 W !,"commas:   for example,  '1,3,5,7'"
 W !!,"You may specify a range of numbers by separating the beginning and ending"
 W !,"numbers with a dash:   for example,   '1-9'."
 W !!,"You may specify combinations of the above, by putting ranges where numbers"
 W !,"would go:  for example,  '1-3,5,9-12' would Install messages 1,2,3,5,9,10,11,12." Q
