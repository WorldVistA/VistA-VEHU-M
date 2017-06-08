NURCCGEG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13164,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13164,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,13164,"TD",1,0)
 ;;=The state in which an individual experiences a decrease of
 ;;^UTILITY("^GMRD(124.2,",$J,13164,"TD",2,0)
 ;;=nutrition and oxygenation at the cellular level due to deficit
 ;;^UTILITY("^GMRD(124.2,",$J,13164,"TD",3,0)
 ;;=in capillary blood supply.
 ;;^UTILITY("^GMRD(124.2,",$J,13165,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^176^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13165,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13165,1,1,0)
 ;;=1822^interruption of arterial flow^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13165,1,2,0)
 ;;=1823^interruption of venous flow^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13165,1,3,0)
 ;;=1824^exchange problems - hypervolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13165,1,4,0)
 ;;=1825^exchange problems - hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13165,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13170,0)
 ;;=Related Problems^2^NURSC^7^152^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13170,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13170,1,1,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13170,1,2,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13170,1,3,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13170,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13174,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^174^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,0)
 ;;=^124.21PI^13^9
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,2,0)
 ;;=13176^maintains physical mobility^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,4,0)
 ;;=13178^communicates awareness of reportable S/S^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,6,0)
 ;;=13185^communicates awareness of ways to decrease recurrent TIA^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,7,0)
 ;;=13186^exhibits improved tissue perfusion as evidenced by:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,8,0)
 ;;=13187^avoids problems of impaired mobility^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,10,0)
 ;;=13430^[Extra Goal]^3^NURSC^233
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,11,0)
 ;;=15501^verbalizes plan of follow-up care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,12,0)
 ;;=15511^demonstrates gradual improvement in visual/spatial episodes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13174,1,13,0)
 ;;=776^remains free from injuries^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13174,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13176,0)
 ;;=maintains physical mobility^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13176,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13176,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13178,0)
 ;;=communicates awareness of reportable S/S^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13178,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13178,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13185,0)
 ;;=communicates awareness of ways to decrease recurrent TIA^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13185,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13185,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13186,0)
 ;;=exhibits improved tissue perfusion as evidenced by:^2^NURSC^9^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13186,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13186,1,1,0)
 ;;=15489^absence or reduction in syncope^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13186,1,2,0)
 ;;=15490^improved mental status^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13186,1,3,0)
 ;;=15492^improved motor/sensory function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13186,7)
 ;;=D EN4^NURCCPU1
