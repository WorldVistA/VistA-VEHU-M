IBDEI192 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22147,1,5,0)
 ;;=5^Obesity
 ;;^UTILITY(U,$J,358.3,22147,2)
 ;;=^84823
 ;;^UTILITY(U,$J,358.3,22148,0)
 ;;=278.01^^125^1388^39
 ;;^UTILITY(U,$J,358.3,22148,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22148,1,4,0)
 ;;=4^278.01
 ;;^UTILITY(U,$J,358.3,22148,1,5,0)
 ;;=5^Morbid Obesity
 ;;^UTILITY(U,$J,358.3,22148,2)
 ;;=^84844
 ;;^UTILITY(U,$J,358.3,22149,0)
 ;;=250.80^^125^1388^10
 ;;^UTILITY(U,$J,358.3,22149,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22149,1,4,0)
 ;;=4^250.80
 ;;^UTILITY(U,$J,358.3,22149,1,5,0)
 ;;=5^DM Type II with LE Ulcer
 ;;^UTILITY(U,$J,358.3,22149,2)
 ;;=DM Type II with LE Ulcer^267846^707.10
 ;;^UTILITY(U,$J,358.3,22150,0)
 ;;=250.00^^125^1388^5
 ;;^UTILITY(U,$J,358.3,22150,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22150,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,22150,1,5,0)
 ;;=5^DM Type II Dm W/O Complications
 ;;^UTILITY(U,$J,358.3,22150,2)
 ;;=^33605
 ;;^UTILITY(U,$J,358.3,22151,0)
 ;;=250.40^^125^1388^6
 ;;^UTILITY(U,$J,358.3,22151,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22151,1,4,0)
 ;;=4^250.40
 ;;^UTILITY(U,$J,358.3,22151,1,5,0)
 ;;=5^DM Type II Dm with Nephropathy
 ;;^UTILITY(U,$J,358.3,22151,2)
 ;;=^267837^583.81
 ;;^UTILITY(U,$J,358.3,22152,0)
 ;;=250.50^^125^1388^9
 ;;^UTILITY(U,$J,358.3,22152,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22152,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,22152,1,5,0)
 ;;=5^DM Type II w/ PDR
 ;;^UTILITY(U,$J,358.3,22152,2)
 ;;=DM Type II w/ PDR^267839^362.02
 ;;^UTILITY(U,$J,358.3,22153,0)
 ;;=250.60^^125^1388^7
 ;;^UTILITY(U,$J,358.3,22153,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22153,1,4,0)
 ;;=4^250.60
 ;;^UTILITY(U,$J,358.3,22153,1,5,0)
 ;;=5^DM Type II Dm with Neuropathy
 ;;^UTILITY(U,$J,358.3,22153,2)
 ;;=^267841^357.2
 ;;^UTILITY(U,$J,358.3,22154,0)
 ;;=250.70^^125^1388^8
 ;;^UTILITY(U,$J,358.3,22154,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22154,1,4,0)
 ;;=4^250.70
 ;;^UTILITY(U,$J,358.3,22154,1,5,0)
 ;;=5^DM Type II Dm with Peripheral Vasc Dis
 ;;^UTILITY(U,$J,358.3,22154,2)
 ;;=^267843^443.81
 ;;^UTILITY(U,$J,358.3,22155,0)
 ;;=250.01^^125^1388^4
 ;;^UTILITY(U,$J,358.3,22155,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22155,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,22155,1,5,0)
 ;;=5^DM Type I DM W/O Complications
 ;;^UTILITY(U,$J,358.3,22155,2)
 ;;=^33586
 ;;^UTILITY(U,$J,358.3,22156,0)
 ;;=272.0^^125^1388^22
 ;;^UTILITY(U,$J,358.3,22156,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22156,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,22156,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,22156,2)
 ;;=Hypercholesterolemia, Pure^59973
 ;;^UTILITY(U,$J,358.3,22157,0)
 ;;=272.1^^125^1388^28
 ;;^UTILITY(U,$J,358.3,22157,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22157,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,22157,1,5,0)
 ;;=5^Hypertriglyceridemia, Pure
 ;;^UTILITY(U,$J,358.3,22157,2)
 ;;=Hypertriglyceridemia, Pure^101303
 ;;^UTILITY(U,$J,358.3,22158,0)
 ;;=272.2^^125^1388^24
 ;;^UTILITY(U,$J,358.3,22158,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22158,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,22158,1,5,0)
 ;;=5^Hyperlipidemia, Mixed
 ;;^UTILITY(U,$J,358.3,22158,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,22159,0)
 ;;=275.42^^125^1388^21
 ;;^UTILITY(U,$J,358.3,22159,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22159,1,4,0)
 ;;=4^275.42
 ;;^UTILITY(U,$J,358.3,22159,1,5,0)
 ;;=5^Hypercalcemia
 ;;^UTILITY(U,$J,358.3,22159,2)
 ;;=^59932
 ;;^UTILITY(U,$J,358.3,22160,0)
 ;;=275.41^^125^1388^29
 ;;^UTILITY(U,$J,358.3,22160,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22160,1,4,0)
 ;;=4^275.41
 ;;
 ;;$END ROU IBDEI192
