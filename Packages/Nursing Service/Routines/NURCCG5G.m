NURCCG5G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,2,0)
 ;;=1420^Fear^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,3,0)
 ;;=1918^Social Isolation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,4,0)
 ;;=2174^Impaired Social Interaction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,6,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2172,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2173,0)
 ;;=Potential For Violence (Self/Others)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2174,0)
 ;;=Impaired Social Interaction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2175,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^57^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,1,0)
 ;;=2176^controls impulsive behavior dictated by hallucinations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,2,0)
 ;;=2177^dismisses internal voices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,3,0)
 ;;=2178^identifies delusional thoughts as unreal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,4,0)
 ;;=2179^initiates conversation with staff or other patients^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,5,0)
 ;;=2180^makes thoughts understandable to others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,6,0)
 ;;=2181^maintains good personal hygiene and grooming each morning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,1,7,0)
 ;;=2921^[Extra Goal]^3^NURSC^102^0
 ;;^UTILITY("^GMRD(124.2,",$J,2175,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2176,0)
 ;;=controls impulsive behavior dictated by hallucinations^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2176,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2176,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2177,0)
 ;;=dismisses internal voices^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2177,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2177,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2178,0)
 ;;=identifies delusional thoughts as unreal^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2178,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2178,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2179,0)
 ;;=initiates conversation with staff or other patients^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2179,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2179,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2180,0)
 ;;=makes thoughts understandable to others^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2180,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2180,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2181,0)
 ;;=maintains good personal hygiene and grooming each morning^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2181,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2181,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2182,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^53^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,0)
 ;;=^124.21PI^22^22
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,1,0)
 ;;=2183^observe for S/S of auditory hallucinations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,2,0)
 ;;=2304^ask what is going on with him at this time^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,3,0)
 ;;=2308^interrupt hallucinations; involve reality based activities ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,4,0)
 ;;=2311^assist pt. in identifying anxiety/its relation to behavior^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,5,0)
 ;;=2314^determine amount of control pt. has over hallucinations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,6,0)
 ;;=2315^develop plan with pt. to report impulsive behaviors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2182,1,7,0)
 ;;=2316^assign 1:1 as indicated^3^NURSC^1^0
