ZISLTRAN ;WILM/RJ - Micom Transparent Mode; 6-9-85
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 D 1^%ZISLVR I X=U W "No connection made." G E
 U IO(0) W !!,"Do not allow this program to tie up your command port for long periods of time."
 S A=1 U IO X:$D(^%ZOSF("ZNOFLOW")) ^("ZNOFLOW") U IO(0) X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD") W !!,"Type ""^"" to exit (RETURN not needed).",!!
 F I=0:0 R *X:0 S A=A+1 Q:X=94!(X=5)!(A>3000)  S:$T A=1 U IO W:$T $C(X) R *X:0 U IO(0) W:$T $C(X)
E W !,"Good-bye." X:$D(^%ZOSF("FLOW")) ^("FLOW") D CP^%ZISLDIS X ^%ZIS("C"),^%ZOSF("EON") K A,I,X,P,ZISLSITE,ZISLCPU,ZISLTYPE Q
