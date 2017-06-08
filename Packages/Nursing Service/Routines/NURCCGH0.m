NURCCGH0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,9,0)
 ;;=1095^sensory overload/monitoring^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,1,10,0)
 ;;=1094^surgery involving cerebral hemisphere^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15857,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15858,0)
 ;;=[Extra Goal]^3^NURSC^9^19^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15858,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15858,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15859,0)
 ;;=[Extra Order]^3^NURSC^11^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15859,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15859,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15860,0)
 ;;=Thought Process, Alteration In^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15860,1,0)
 ;;=^124.21PI^8^4
 ;;^UTILITY("^GMRD(124.2,",$J,15860,1,5,0)
 ;;=15865^Goals/Expected Outcomes^2^NURSC^320
 ;;^UTILITY("^GMRD(124.2,",$J,15860,1,6,0)
 ;;=4291^Defining Characteristics^2^NURSC^50
 ;;^UTILITY("^GMRD(124.2,",$J,15860,1,7,0)
 ;;=2168^Etiology/Related and/or Risk Factors^2^NURSC^58
 ;;^UTILITY("^GMRD(124.2,",$J,15860,1,8,0)
 ;;=15866^Nursing Intervention/Orders^2^NURSC^322
 ;;^UTILITY("^GMRD(124.2,",$J,15860,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15860,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15860,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15861,0)
 ;;=improvement displayed by increased attention span^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15861,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15861,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15862,0)
 ;;=improvement demonstrated by decreased irritability^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15862,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15862,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15863,0)
 ;;=improvement demonstrated by decreased aggressiveness^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15863,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15863,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15864,0)
 ;;=improvement demonstrated by increased level of orientation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15864,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15864,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15865,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^320^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15865,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15865,1,1,0)
 ;;=15863^improvement demonstrated by decreased aggressiveness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15865,1,2,0)
 ;;=15864^improvement demonstrated by increased level of orientation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15865,1,3,0)
 ;;=15862^improvement demonstrated by decreased irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15865,1,4,0)
 ;;=15861^improvement displayed by increased attention span^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15865,1,5,0)
 ;;=15887^[Extra Goal]^3^NURSC^24
 ;;^UTILITY("^GMRD(124.2,",$J,15865,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^322^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,1,0)
 ;;=15867^control level of sensory stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,2,0)
 ;;=15509^assess for alterations in thought processes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,3,0)
 ;;=15869^reorient as necessary^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,4,0)
 ;;=15870^use simple instructions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,5,0)
 ;;=3250^encourage participation in self care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15866,1,6,0)
 ;;=15872^[Extra Order]^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,15866,7)
 ;;=D EN4^NURCCPU1
