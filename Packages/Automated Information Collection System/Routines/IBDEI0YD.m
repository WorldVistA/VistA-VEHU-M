IBDEI0YD ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16742,1,1,0)
 ;;=1^82805
 ;;^UTILITY(U,$J,358.3,16742,1,3,0)
 ;;=3^BLOOD GASES W/02 SATURATION
 ;;^UTILITY(U,$J,358.3,16743,0)
 ;;=36620^^85^1008^2
 ;;^UTILITY(U,$J,358.3,16743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16743,1,1,0)
 ;;=1^36620
 ;;^UTILITY(U,$J,358.3,16743,1,3,0)
 ;;=3^ARTERIAL LINE INSERTION
 ;;^UTILITY(U,$J,358.3,16744,0)
 ;;=31502^^85^1008^10^^^^1
 ;;^UTILITY(U,$J,358.3,16744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16744,1,1,0)
 ;;=1^31502
 ;;^UTILITY(U,$J,358.3,16744,1,3,0)
 ;;=3^TRACH CHANGE
 ;;^UTILITY(U,$J,358.3,16745,0)
 ;;=31500^^85^1008^7^^^^1
 ;;^UTILITY(U,$J,358.3,16745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16745,1,1,0)
 ;;=1^31500
 ;;^UTILITY(U,$J,358.3,16745,1,3,0)
 ;;=3^INSERT EMERGENCY AIRWAY
 ;;^UTILITY(U,$J,358.3,16746,0)
 ;;=92950^^85^1008^6^^^^1
 ;;^UTILITY(U,$J,358.3,16746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16746,1,1,0)
 ;;=1^92950
 ;;^UTILITY(U,$J,358.3,16746,1,3,0)
 ;;=3^HEART/LUNG RESUSCITATION CPR
 ;;^UTILITY(U,$J,358.3,16747,0)
 ;;=94003^^85^1008^12^^^^1
 ;;^UTILITY(U,$J,358.3,16747,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16747,1,1,0)
 ;;=1^94003
 ;;^UTILITY(U,$J,358.3,16747,1,3,0)
 ;;=3^VENT MANAGEMENT,INPT
 ;;^UTILITY(U,$J,358.3,16748,0)
 ;;=94668^^85^1008^1^^^^1
 ;;^UTILITY(U,$J,358.3,16748,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16748,1,1,0)
 ;;=1^94668
 ;;^UTILITY(U,$J,358.3,16748,1,3,0)
 ;;=3^AIRWAY CLEARANCE,CHEST WALL
 ;;^UTILITY(U,$J,358.3,16749,0)
 ;;=94667^^85^1008^5^^^^1
 ;;^UTILITY(U,$J,358.3,16749,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16749,1,1,0)
 ;;=1^94667
 ;;^UTILITY(U,$J,358.3,16749,1,3,0)
 ;;=3^CUPPING,INIT DEMO AND/OR EVAL
 ;;^UTILITY(U,$J,358.3,16750,0)
 ;;=78598^^85^1008^8^^^^1
 ;;^UTILITY(U,$J,358.3,16750,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16750,1,1,0)
 ;;=1^78598
 ;;^UTILITY(U,$J,358.3,16750,1,3,0)
 ;;=3^QUANT DIFF PULM PERF & VENT W/ IMG
 ;;^UTILITY(U,$J,358.3,16751,0)
 ;;=78597^^85^1008^9^^^^1
 ;;^UTILITY(U,$J,358.3,16751,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16751,1,1,0)
 ;;=1^78597
 ;;^UTILITY(U,$J,358.3,16751,1,3,0)
 ;;=3^QUANT DIFF PULM PERFUSION W/ IMG
 ;;^UTILITY(U,$J,358.3,16752,0)
 ;;=36600^^85^1009^1^^^^1
 ;;^UTILITY(U,$J,358.3,16752,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16752,1,1,0)
 ;;=1^36600
 ;;^UTILITY(U,$J,358.3,16752,1,3,0)
 ;;=3^WITHDRAWAL OF ARTERIAL BLOOD
 ;;^UTILITY(U,$J,358.3,16753,0)
 ;;=97535^^85^1010^6^^^^1
 ;;^UTILITY(U,$J,358.3,16753,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16753,1,1,0)
 ;;=1^97535
 ;;^UTILITY(U,$J,358.3,16753,1,3,0)
 ;;=3^SELF CARE/HOME MGMT ED,EA 15MIN
 ;;^UTILITY(U,$J,358.3,16754,0)
 ;;=94620^^85^1010^3^^^^1
 ;;^UTILITY(U,$J,358.3,16754,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16754,1,1,0)
 ;;=1^94620
 ;;^UTILITY(U,$J,358.3,16754,1,3,0)
 ;;=3^PULM STRESS TEST,SIMPLE
 ;;^UTILITY(U,$J,358.3,16755,0)
 ;;=94760^^85^1010^5^^^^1
 ;;^UTILITY(U,$J,358.3,16755,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16755,1,1,0)
 ;;=1^94760
 ;;^UTILITY(U,$J,358.3,16755,1,3,0)
 ;;=3^PULSE OX,SINGLE
 ;;^UTILITY(U,$J,358.3,16756,0)
 ;;=94761^^85^1010^4^^^^1
 ;;^UTILITY(U,$J,358.3,16756,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16756,1,1,0)
 ;;=1^94761
 ;;^UTILITY(U,$J,358.3,16756,1,3,0)
 ;;=3^PULSE OX,MULTIPLE
 ;;^UTILITY(U,$J,358.3,16757,0)
 ;;=94762^^85^1010^2^^^^1
 ;;^UTILITY(U,$J,358.3,16757,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16757,1,1,0)
 ;;=1^94762
 ;;^UTILITY(U,$J,358.3,16757,1,3,0)
 ;;=3^NOCTURNAL OXIMETRY
 ;;^UTILITY(U,$J,358.3,16758,0)
 ;;=94664^^85^1010^1^^^^1
 ;;^UTILITY(U,$J,358.3,16758,1,0)
 ;;=^358.31IA^3^2
 ;;
 ;;$END ROU IBDEI0YD
