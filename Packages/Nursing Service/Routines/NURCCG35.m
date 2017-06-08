NURCCG35 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,6,0)
 ;;=1073^evaluate for stress management^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1054,1,7,0)
 ;;=2976^[Extra Order]^3^NURSC^59^0
 ;;^UTILITY("^GMRD(124.2,",$J,1054,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1054,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1055,0)
 ;;=SMA-6^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1056,0)
 ;;=SMA-12^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1057,0)
 ;;=PT/PTT q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1057,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1057,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1057,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1058,0)
 ;;=x-ray^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1059,0)
 ;;=verbalizes level of comfort/pain^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1059,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1059,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1060,0)
 ;;=provide for personal hygiene^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1060,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1060,1,1,0)
 ;;=1064^bathe and turn patient q [frequency] hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1060,1,2,0)
 ;;=1066^assist with self-care as indicated/ordered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1060,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1060,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1060,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1060,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1061,0)
 ;;=demonstrates maximal functional ability ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1061,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1061,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1062,0)
 ;;=has a relaxed facial expression^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1062,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1062,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1063,0)
 ;;=assess level, location and severity of pain q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1063,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1063,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1064,0)
 ;;=bathe and turn patient q [frequency] hrs.^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1065,0)
 ;;=provide appropriate medical treatment per protocol^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1065,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1065,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1066,0)
 ;;=assist with self-care as indicated/ordered^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1067,0)
 ;;=offer commode q [frequency] hrs. while providing privacy^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1067,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1067,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1068,0)
 ;;=support pain management^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1068,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1068,1,1,0)
 ;;=1069^reposition q[frequency]hrs^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1068,1,2,0)
 ;;=1070^splinting q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1068,5)
 ;;=with appropriate
 ;;^UTILITY("^GMRD(124.2,",$J,1068,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1068,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1068,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1069,0)
 ;;=reposition q[frequency]hrs^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1070,0)
 ;;=splinting q [frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1071,0)
 ;;=arrange activities for psychological support^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1071,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1071,10)
 ;;=D EN1^NURCCPU3
