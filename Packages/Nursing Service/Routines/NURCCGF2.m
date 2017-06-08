NURCCGF2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14064,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14064,1,3,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14064,1,4,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14064,1,5,0)
 ;;=2197^Thought Processes, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14064,5)
 ;;=, see:
 ;;^UTILITY("^GMRD(124.2,",$J,14064,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14073,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^185^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,1,0)
 ;;=2199^will not destroy property during hospitalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,2,0)
 ;;=2200^will not harm himself or others during hospitalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,3,0)
 ;;=14081^seeks assistance to prevent self destructive behavior^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,4,0)
 ;;=14083^identifies self destructive thoughts and/or behaviors^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,5,0)
 ;;=14085^seeks assistance in coping with self destructive thoughts^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,6,0)
 ;;=2204^writes plan identifying coping/behavior control strategies^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,7,0)
 ;;=2419^writes plan identifying impulses to harm self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14073,1,8,0)
 ;;=14286^[Extra Goal]^3^NURSC^244
 ;;^UTILITY("^GMRD(124.2,",$J,14073,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,0)
 ;;=Related Problems^2^NURSC^7^162^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,1,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,2,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,3,0)
 ;;=1944^Grieving, Dysfunctional^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,4,0)
 ;;=2257^Home Maintenance Management, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,5,0)
 ;;=2078^Hopelessness ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,7,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,8,0)
 ;;=1990^Social Interaction, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,9,0)
 ;;=1919^Spiritual Distress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,10,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,1,11,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14077,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14081,0)
 ;;=seeks assistance to prevent self destructive behavior^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14081,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14081,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14083,0)
 ;;=identifies self destructive thoughts and/or behaviors^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14083,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14083,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14085,0)
 ;;=seeks assistance in coping with self destructive thoughts^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14085,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14085,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14092,0)
 ;;=[Extra Goal]^3^NURSC^9^241^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14092,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14092,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14097,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^155^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,0)
 ;;=^124.21PI^12^11
 ;;^UTILITY("^GMRD(124.2,",$J,14097,1,1,0)
 ;;=2206^encourage pt. to identify anger and verbalize feelings^3^NURSC^1
