NURCCGCP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10107,1,4,0)
 ;;=10237^[Extra Goal]^3^NURSC^169
 ;;^UTILITY("^GMRD(124.2,",$J,10107,1,5,0)
 ;;=15922^free of objective S/S of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10107,1,6,0)
 ;;=15923^able to carry out ADLs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10107,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10111,0)
 ;;=[Extra Goal]^3^NURSC^9^168^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10111,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10111,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^115^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,0)
 ;;=^124.21PI^14^8
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,7,0)
 ;;=10786^[Extra Order]^3^NURSC^180
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,8,0)
 ;;=15924^analgesics/antiemetics as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,9,0)
 ;;=15925^titrate analgesics/antiemetics as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,10,0)
 ;;=15926^provide activity for patients as tolerated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,11,0)
 ;;=15927^encourage activity as tolerated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,12,0)
 ;;=15928^assist to maintain correct positioning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,13,0)
 ;;=815^range of motion exercise as appropriate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,1,14,0)
 ;;=1679^provide skin care q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10112,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10121,0)
 ;;=[Extra Order]^3^NURSC^11^171^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10121,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10121,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10122,0)
 ;;=Related Problems^2^NURSC^7^118^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,3,0)
 ;;=1383^Activity Intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,4,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,5,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,6,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,7,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,8,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,1,9,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10122,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10182,0)
 ;;=identifies S/S of infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10182,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10182,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,0)
 ;;=Defining Characteristics^2^NURSC^12^121^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10199,1,1,0)
 ;;=4185^verbal report of pain experienced for more than 6 months^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10199,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10205,0)
 ;;=Knowledge Deficit^2^NURSC^2^9^1^^T
