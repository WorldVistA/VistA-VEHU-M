TELNETD ;(ALB ISC)/RPE-PROCESS MSM-NT TCP REQUEST [ 11/07/95  3:09 PM ]
 ;;
GO O 56 U 56::"TCP" S IK=$KEY
 W /SOCKET("",23)
 S X=^%ZOSF("VOL")
CHK S CHECK=0 I $G(^%ZIS(14.5,"LOGON",X))=1 S CHECK=1 H 60
 J GO^TELNETD
 I $G(CHECK) W "Logons temporarily disabled.",$C(13,10),! C 56 Q
 S %="MSM TCP "_$J,XMRPORT=$P(%," ",3),IOT="TCP",(IO,IO(0))=56,X=$E(%_"-INETTN",1,15)
 D SETENV^%ZOSV,DT^DICRW
 S X="ERR^ZU",@^%ZOSF("TRAP"),ER=0
 U 56:IK
 D ^ZU
R ;F  U IO R X:1 Q:'$T  U IO(0) W X ;Read from remote
L ;F  U IO(0) X ^%ZOSF("EOFF") R *X:0 Q:'$T  G:X=1 UQUIT U IO W *X,! ;Local
UQUIT ;;
CLOSE ;D ^%ZISC 
 ;Q
