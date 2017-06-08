NURCCG7X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4201,0)
 ;;=urine output altered (diluted, increased or decreased)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4202,0)
 ;;=narrowed focus(altered time perception,withdrawn etc)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4203,0)
 ;;=disorderly surroundings i.e.,unwashed clothes, cooking equip^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4204,0)
 ;;=Defining Characteristics^2^NURSC^12^30^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4204,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4204,1,1,0)
 ;;=4207^actual or perceived limitation imposed by disease/therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4204,1,2,0)
 ;;=4208^alteration in achieving perceived sex roles^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4204,1,3,0)
 ;;=4210^alteration in relationship with self or significant other^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4204,1,4,0)
 ;;=4211^alteration or inability to achieve desired self satisfaction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4204,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,0)
 ;;=Defining Characteristics^2^NURSC^12^31^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4205,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4205,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4206,0)
 ;;=communication (verbal or coded) of pain descriptors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4207,0)
 ;;=actual or perceived limitation imposed by disease/therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4208,0)
 ;;=alteration in achieving perceived sex roles^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4209,0)
 ;;=Defining Characteristics^2^NURSC^12^32^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4209,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4209,1,1,0)
 ;;=4212^decreased appetite^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4209,1,2,0)
 ;;=4213^decreased affect^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4209,1,3,0)
 ;;=4214^decreased response to stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4209,1,4,0)
 ;;=4216^decreased verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4209,1,5,0)
 ;;=4218^passive behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4209,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4210,0)
 ;;=alteration in relationship with self or significant other^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4211,0)
 ;;=alteration or inability to achieve desired self satisfaction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4212,0)
 ;;=decreased appetite^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4213,0)
 ;;=decreased affect^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4214,0)
 ;;=decreased response to stimuli^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4215,0)
 ;;=Defining Characteristics^2^NURSC^12^33^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4215,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4215,1,1,0)
 ;;=4217^identification of sexual difficulties^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4215,1,2,0)
 ;;=4219^limitations or changes in sexual patterns^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4215,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4216,0)
 ;;=decreased verbalization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4217,0)
 ;;=identification of sexual difficulties^3^NURSC^^1^^^T
