IBDEI0PK ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12231,1,3,0)
 ;;=3^THER/PHOPH/DIAG INJECTION
 ;;^UTILITY(U,$J,358.3,12232,0)
 ;;=90471^^60^723^2^^^^1
 ;;^UTILITY(U,$J,358.3,12232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12232,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,12232,1,3,0)
 ;;=3^IMMUNIZATION ADMIN,SINGLE
 ;;^UTILITY(U,$J,358.3,12233,0)
 ;;=90472^^60^723^3^^^^1
 ;;^UTILITY(U,$J,358.3,12233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12233,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,12233,1,3,0)
 ;;=3^IMMUNIZATION ADMIN,EA ADDL
 ;;^UTILITY(U,$J,358.3,12234,0)
 ;;=10120^^60^724^1^^^^1
 ;;^UTILITY(U,$J,358.3,12234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12234,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,12234,1,3,0)
 ;;=3^INCISION & REMOVE FB
 ;;^UTILITY(U,$J,358.3,12235,0)
 ;;=81002^^60^725^2^^^^1
 ;;^UTILITY(U,$J,358.3,12235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12235,1,2,0)
 ;;=2^81002
 ;;^UTILITY(U,$J,358.3,12235,1,3,0)
 ;;=3^URINALYSIS BY DIP STICK
 ;;^UTILITY(U,$J,358.3,12236,0)
 ;;=82948^^60^725^1^^^^1
 ;;^UTILITY(U,$J,358.3,12236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12236,1,2,0)
 ;;=2^82948
 ;;^UTILITY(U,$J,358.3,12236,1,3,0)
 ;;=3^FINGERSTICK, GLUCOSE
 ;;^UTILITY(U,$J,358.3,12237,0)
 ;;=81025^^60^725^3^^^^1
 ;;^UTILITY(U,$J,358.3,12237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12237,1,2,0)
 ;;=2^81025
 ;;^UTILITY(U,$J,358.3,12237,1,3,0)
 ;;=3^URINE PREGNANCY TEST BY DIPSTICK
 ;;^UTILITY(U,$J,358.3,12238,0)
 ;;=J1642^^60^726^1^^^^1
 ;;^UTILITY(U,$J,358.3,12238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12238,1,2,0)
 ;;=2^J1642
 ;;^UTILITY(U,$J,358.3,12238,1,3,0)
 ;;=3^HEP LOCK FLUSH PER 10U
 ;;^UTILITY(U,$J,358.3,12239,0)
 ;;=A4670^^60^727^1^^^^1
 ;;^UTILITY(U,$J,358.3,12239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12239,1,2,0)
 ;;=2^A4670
 ;;^UTILITY(U,$J,358.3,12239,1,3,0)
 ;;=3^AUTOMATIC BP MONITOR,DIAL
 ;;^UTILITY(U,$J,358.3,12240,0)
 ;;=3511F^^60^727^3^^^^1
 ;;^UTILITY(U,$J,358.3,12240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12240,1,2,0)
 ;;=2^3511F
 ;;^UTILITY(U,$J,358.3,12240,1,3,0)
 ;;=3^CHLMYD/GONRH TSTS DOCD DONE
 ;;^UTILITY(U,$J,358.3,12241,0)
 ;;=S4989^^60^727^4^^^^1
 ;;^UTILITY(U,$J,358.3,12241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12241,1,2,0)
 ;;=2^S4989
 ;;^UTILITY(U,$J,358.3,12241,1,3,0)
 ;;=3^CONTRACEPT IUD
 ;;^UTILITY(U,$J,358.3,12242,0)
 ;;=94760^^60^727^5^^^^1
 ;;^UTILITY(U,$J,358.3,12242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12242,1,2,0)
 ;;=2^94760
 ;;^UTILITY(U,$J,358.3,12242,1,3,0)
 ;;=3^MEASURE BLOOD OXYGEN LEVEL
 ;;^UTILITY(U,$J,358.3,12243,0)
 ;;=99000^^60^727^7^^^^1
 ;;^UTILITY(U,$J,358.3,12243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12243,1,2,0)
 ;;=2^99000
 ;;^UTILITY(U,$J,358.3,12243,1,3,0)
 ;;=3^SPECIMEN HANDLING OFFICE-LAB
 ;;^UTILITY(U,$J,358.3,12244,0)
 ;;=2010F^^60^727^8^^^^1
 ;;^UTILITY(U,$J,358.3,12244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12244,1,2,0)
 ;;=2^2010F
 ;;^UTILITY(U,$J,358.3,12244,1,3,0)
 ;;=3^VITAL SIGNS RECORDED
 ;;^UTILITY(U,$J,358.3,12245,0)
 ;;=2001F^^60^727^9^^^^1
 ;;^UTILITY(U,$J,358.3,12245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12245,1,2,0)
 ;;=2^2001F
 ;;^UTILITY(U,$J,358.3,12245,1,3,0)
 ;;=3^WEIGHT RECORD
 ;;^UTILITY(U,$J,358.3,12246,0)
 ;;=99450^^60^727^2^^^^1
 ;;^UTILITY(U,$J,358.3,12246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12246,1,2,0)
 ;;=2^99450
 ;;^UTILITY(U,$J,358.3,12246,1,3,0)
 ;;=3^BASIC LIFE/DISABILITY EXAM
 ;;^UTILITY(U,$J,358.3,12247,0)
 ;;=99075^^60^727^6^^^^1
 ;;^UTILITY(U,$J,358.3,12247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12247,1,2,0)
 ;;=2^99075
 ;;
 ;;$END ROU IBDEI0PK
