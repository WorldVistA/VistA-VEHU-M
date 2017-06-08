NURCCGH8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,3,0)
 ;;=1405^Depressive Behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,4,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,6,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,1,7,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15959,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15960,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^328^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15960,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15960,1,1,0)
 ;;=15961^expresses feelings and concerns ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15960,1,2,0)
 ;;=15972^[Extra Goal]^3^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,15960,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15961,0)
 ;;=expresses feelings and concerns ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15961,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15961,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15962,0)
 ;;=[Extra Goal]^3^NURSC^9^30^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15962,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15962,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15963,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^330^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15963,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15963,1,1,0)
 ;;=15966^[Extra Order]^3^NURSC^21
 ;;^UTILITY("^GMRD(124.2,",$J,15963,1,2,0)
 ;;=2032^monitor anxiety level/occurrence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15963,1,3,0)
 ;;=15965^explain procedures and expectations prior to interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15963,1,4,0)
 ;;=1735^teach expected side effects of drug therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15963,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15963,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15964,0)
 ;;=[Extra Order]^3^NURSC^11^14^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15964,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15964,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15965,0)
 ;;=explain procedures and expectations prior to interventions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15965,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15965,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15966,0)
 ;;=[Extra Order]^3^NURSC^11^21^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15966,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15966,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15967,0)
 ;;=General Self-Care Deficit^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15967,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15967,1,1,0)
 ;;=15968^Defining Characteristics^2^NURSC^68
 ;;^UTILITY("^GMRD(124.2,",$J,15967,1,2,0)
 ;;=15969^Etiology/Related and/or Risk Factors^2^NURSC^309
 ;;^UTILITY("^GMRD(124.2,",$J,15967,1,3,0)
 ;;=15970^Goals/Expected Outcomes^2^NURSC^329
 ;;^UTILITY("^GMRD(124.2,",$J,15967,1,4,0)
 ;;=15973^Nursing Intervention/Orders^2^NURSC^331
 ;;^UTILITY("^GMRD(124.2,",$J,15967,1,5,0)
 ;;=137^Related Problems^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,15967,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15967,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15967,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15968,0)
 ;;=Defining Characteristics^2^NURSC^12^68^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15968,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15968,1,1,0)
 ;;=4112^inability to dress & groom self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15968,1,2,0)
 ;;=4113^inability to feed self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15968,1,3,0)
 ;;=4114^inability to toilet self^3^NURSC^1
