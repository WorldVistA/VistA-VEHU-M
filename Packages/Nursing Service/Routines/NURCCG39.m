NURCCG39 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1113,0)
 ;;=language barriers^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1114,0)
 ;;=inability to understand^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1115,0)
 ;;=impaired articulation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1116,0)
 ;;=tissue damage-hearing loss^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1117,0)
 ;;=preserves individual integrity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1117,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1117,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1118,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^28^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,0)
 ;;=^124.21PI^20^20
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,1,0)
 ;;=758^individual/environment conditions which impose a risk^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,2,0)
 ;;=759^biological^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,3,0)
 ;;=903^chemical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,4,0)
 ;;=760^developmental^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,5,0)
 ;;=761^physiologic^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,6,0)
 ;;=762^psychologic perception^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,7,0)
 ;;=763^people provider^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,8,0)
 ;;=765^loss of motor ability from disease/injury/aging/restraints^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,9,0)
 ;;=766^sensory loss from disease/injury/aging/restraints^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,10,0)
 ;;=767^cognitive deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,11,0)
 ;;=768^perceptual deficit^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,12,0)
 ;;=769^adverse effects of chemicals/drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,13,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,14,0)
 ;;=770^self-mutilation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,15,0)
 ;;=771^nonadherence/noncompliance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,16,0)
 ;;=772^infestation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,17,0)
 ;;=773^clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,18,0)
 ;;=774^unfamiliar setting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,19,0)
 ;;=775^physical restraints/barriers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,1,20,0)
 ;;=798^medical protocols^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1118,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1119,0)
 ;;=achieves reduced number of incontinent episodes, <[ ]X/day^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1119,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1119,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1120,0)
 ;;=is continent of stool^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1120,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1120,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1121,0)
 ;;=verbalizes knowledge of available assistive devices^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1121,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1121,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1122,0)
 ;;=maintains skin integrity of perineal area^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1122,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1122,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1123,0)
 ;;=evaluate diet^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1123,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1123,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1124,0)
 ;;=observe for behaviors indicating a desire to defecate^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1124,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1124,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1125,0)
 ;;=provide for regular evacuations at [times]^3^NURSC^11^1^^^T
