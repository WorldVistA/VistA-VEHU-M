IBDEI0FW ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7338,0)
 ;;=23500^^33^452^10^^^^1
 ;;^UTILITY(U,$J,358.3,7338,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7338,1,2,0)
 ;;=2^23500
 ;;^UTILITY(U,$J,358.3,7338,1,3,0)
 ;;=3^CLAVICLE FX;CLOSED TXMT,W/O MANIPULATION
 ;;^UTILITY(U,$J,358.3,7339,0)
 ;;=23520^^33^452^40^^^^1
 ;;^UTILITY(U,$J,358.3,7339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7339,1,2,0)
 ;;=2^23520
 ;;^UTILITY(U,$J,358.3,7339,1,3,0)
 ;;=3^STERNOCLAVICLE FX;CLOSED TXMT,W/O MANIPULATION
 ;;^UTILITY(U,$J,358.3,7340,0)
 ;;=23540^^33^452^1^^^^1
 ;;^UTILITY(U,$J,358.3,7340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7340,1,2,0)
 ;;=2^23540
 ;;^UTILITY(U,$J,358.3,7340,1,3,0)
 ;;=3^ACROMIOCLAV DISLOC;CLOSED TXMT W/O MANIP
 ;;^UTILITY(U,$J,358.3,7341,0)
 ;;=23600^^33^452^20^^^^1
 ;;^UTILITY(U,$J,358.3,7341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7341,1,2,0)
 ;;=2^23600
 ;;^UTILITY(U,$J,358.3,7341,1,3,0)
 ;;=3^HUMERUS FX;CLOSED TXMT,W/O MANIP
 ;;^UTILITY(U,$J,358.3,7342,0)
 ;;=23650^^33^452^39^^^^1
 ;;^UTILITY(U,$J,358.3,7342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7342,1,2,0)
 ;;=2^23650
 ;;^UTILITY(U,$J,358.3,7342,1,3,0)
 ;;=3^SHOULDER DISLOC;CLOSED TXMT,W/MANIP W/O ANESTH
 ;;^UTILITY(U,$J,358.3,7343,0)
 ;;=24600^^33^452^13^^^^1
 ;;^UTILITY(U,$J,358.3,7343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7343,1,2,0)
 ;;=2^24600
 ;;^UTILITY(U,$J,358.3,7343,1,3,0)
 ;;=3^ELBOX DISLOC;CLOSED TXMT,W/O ANESTH
 ;;^UTILITY(U,$J,358.3,7344,0)
 ;;=24650^^33^452^36^^^^1
 ;;^UTILITY(U,$J,358.3,7344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7344,1,2,0)
 ;;=2^24650
 ;;^UTILITY(U,$J,358.3,7344,1,3,0)
 ;;=3^RADIAL HEAD/NECK FX;CLOSED TXMT,W/O MANIP
 ;;^UTILITY(U,$J,358.3,7345,0)
 ;;=25500^^33^452^37^^^^1
 ;;^UTILITY(U,$J,358.3,7345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7345,1,2,0)
 ;;=2^25500
 ;;^UTILITY(U,$J,358.3,7345,1,3,0)
 ;;=3^RADIAL SHAFT FX;CLOSED TXMT,W/O MANIP
 ;;^UTILITY(U,$J,358.3,7346,0)
 ;;=25535^^33^452^42^^^^1
 ;;^UTILITY(U,$J,358.3,7346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7346,1,2,0)
 ;;=2^25535
 ;;^UTILITY(U,$J,358.3,7346,1,3,0)
 ;;=3^ULNA FX;CLOSED TXMT,W/MANIP
 ;;^UTILITY(U,$J,358.3,7347,0)
 ;;=25560^^33^452^38^^^^1
 ;;^UTILITY(U,$J,358.3,7347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7347,1,2,0)
 ;;=2^25560
 ;;^UTILITY(U,$J,358.3,7347,1,3,0)
 ;;=3^RADIAL/ULNAR SHAFT FX;CLOSED TXMT,W/O MANIP
 ;;^UTILITY(U,$J,358.3,7348,0)
 ;;=26010^^33^452^16^^^^1
 ;;^UTILITY(U,$J,358.3,7348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7348,1,2,0)
 ;;=2^26010
 ;;^UTILITY(U,$J,358.3,7348,1,3,0)
 ;;=3^FINGER ABSCESS,DRAINAGE,SIMPLE
 ;;^UTILITY(U,$J,358.3,7349,0)
 ;;=26011^^33^452^15^^^^1
 ;;^UTILITY(U,$J,358.3,7349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7349,1,2,0)
 ;;=2^26011
 ;;^UTILITY(U,$J,358.3,7349,1,3,0)
 ;;=3^FINGER ABSCESS,DRAINAGE,COMPL
 ;;^UTILITY(U,$J,358.3,7350,0)
 ;;=26600^^33^452^31^^^^1
 ;;^UTILITY(U,$J,358.3,7350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7350,1,2,0)
 ;;=2^26600
 ;;^UTILITY(U,$J,358.3,7350,1,3,0)
 ;;=3^METACARPAL FX,CLOSED TXMT,W/O MANIP,EA BONE
 ;;^UTILITY(U,$J,358.3,7351,0)
 ;;=26605^^33^452^32^^^^1
 ;;^UTILITY(U,$J,358.3,7351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7351,1,2,0)
 ;;=2^26605
 ;;^UTILITY(U,$J,358.3,7351,1,3,0)
 ;;=3^METACARPAL FX;CLOSED TXMT,W/MANIP,EA BONE
 ;;^UTILITY(U,$J,358.3,7352,0)
 ;;=26641^^33^452^9^^^^1
 ;;^UTILITY(U,$J,358.3,7352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7352,1,2,0)
 ;;=2^26641
 ;;^UTILITY(U,$J,358.3,7352,1,3,0)
 ;;=3^CARPOMETACARPAL DISLOC;THUMB,W/MANIP
 ;;^UTILITY(U,$J,358.3,7353,0)
 ;;=26700^^33^452^30^^^^1
 ;;
 ;;$END ROU IBDEI0FW
