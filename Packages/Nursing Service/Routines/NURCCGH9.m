NURCCGH9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15968,1,4,0)
 ;;=4110^inability to wash body,obtain water & regulate water temp^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15968,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15969,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^309^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15969,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15969,1,1,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15969,1,2,0)
 ;;=132^bed rest or immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15969,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15970,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^329^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15970,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15970,1,1,0)
 ;;=2499^independence in dressing/grooming^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15970,1,2,0)
 ;;=15982^[Extra Goal]^3^NURSC^32
 ;;^UTILITY("^GMRD(124.2,",$J,15970,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15972,0)
 ;;=[Extra Goal]^3^NURSC^9^31^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15972,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15972,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15973,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^331^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15973,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,15973,1,1,0)
 ;;=15974^assist with ADLs q shift^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15973,1,2,0)
 ;;=15975^[Extra Order]^3^NURSC^270
 ;;^UTILITY("^GMRD(124.2,",$J,15973,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15973,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15974,0)
 ;;=assist with ADLs q shift^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15974,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15974,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15975,0)
 ;;=[Extra Order]^3^NURSC^11^270^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15975,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15975,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15976,0)
 ;;=Skin Integrity, Impaired^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15976,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15976,1,1,0)
 ;;=4231^Defining Characteristics^2^NURSC^38
 ;;^UTILITY("^GMRD(124.2,",$J,15976,1,2,0)
 ;;=15977^Etiology/Related and/or Risk Factors^2^NURSC^310
 ;;^UTILITY("^GMRD(124.2,",$J,15976,1,3,0)
 ;;=15979^Goals/Expected Outcomes^2^NURSC^330
 ;;^UTILITY("^GMRD(124.2,",$J,15976,1,4,0)
 ;;=15983^Nursing Intervention/Orders^2^NURSC^332
 ;;^UTILITY("^GMRD(124.2,",$J,15976,1,5,0)
 ;;=1764^Related Problems^2^NURSC^34
 ;;^UTILITY("^GMRD(124.2,",$J,15976,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15976,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15976,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15977,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^310^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15977,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,15977,1,1,0)
 ;;=15978^IV catheter^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15977,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15978,0)
 ;;=IV catheter^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15979,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^330^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15979,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,15979,1,1,0)
 ;;=15980^IV site remains free from signs of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15979,1,2,0)
 ;;=15981^IV remains patent while in place^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15979,1,3,0)
 ;;=12395^[Extra Goal]^3^NURSC^199
 ;;^UTILITY("^GMRD(124.2,",$J,15979,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15980,0)
 ;;=IV site remains free from signs of infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15980,9)
 ;;=D EN5^NURCCPU0
