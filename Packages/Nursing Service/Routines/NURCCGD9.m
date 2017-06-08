NURCCGD9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11348,0)
 ;;=[Extra Goal]^3^NURSC^9^359^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11348,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11348,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11349,0)
 ;;=[Extra Goal]^3^NURSC^9^360^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11349,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11349,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11350,0)
 ;;=[Extra Goal]^3^NURSC^9^361^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11350,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11350,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11351,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^288^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11351,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11351,1,1,0)
 ;;=11352^[Extra Order]^3^NURSC^366
 ;;^UTILITY("^GMRD(124.2,",$J,11351,1,2,0)
 ;;=11353^[Extra Order]^3^NURSC^367
 ;;^UTILITY("^GMRD(124.2,",$J,11351,1,3,0)
 ;;=11355^[Extra Order]^3^NURSC^368
 ;;^UTILITY("^GMRD(124.2,",$J,11351,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11351,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11352,0)
 ;;=[Extra Order]^3^NURSC^11^366^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11352,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11352,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11353,0)
 ;;=[Extra Order]^3^NURSC^11^367^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11353,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11353,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11354,0)
 ;;=discusses own role in preventing recurrence^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11354,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11354,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11355,0)
 ;;=[Extra Order]^3^NURSC^11^368^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11355,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11355,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11356,0)
 ;;=Tissue Perfusion, Alteration In^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11356,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11356,1,1,0)
 ;;=11357^Etiology/Related and/or Risk Factors^2^NURSC^153
 ;;^UTILITY("^GMRD(124.2,",$J,11356,1,2,0)
 ;;=11362^Related Problems^2^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,11356,1,3,0)
 ;;=11366^Goals/Expected Outcomes^2^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,11356,1,4,0)
 ;;=11382^Nursing Intervention/Orders^2^NURSC^193
 ;;^UTILITY("^GMRD(124.2,",$J,11356,1,5,0)
 ;;=11428^Defining Characteristics^2^NURSC^132
 ;;^UTILITY("^GMRD(124.2,",$J,11356,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11356,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11356,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11356,"TD",0)
 ;;=^^3^3^2910830^^
 ;;^UTILITY("^GMRD(124.2,",$J,11356,"TD",1,0)
 ;;=The state in which an individual experiences a decrease of
 ;;^UTILITY("^GMRD(124.2,",$J,11356,"TD",2,0)
 ;;=nutrition and oxygenation at the cellular level due to deficit
 ;;^UTILITY("^GMRD(124.2,",$J,11356,"TD",3,0)
 ;;=in capillary blood supply.
 ;;^UTILITY("^GMRD(124.2,",$J,11357,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^153^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11357,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,11357,1,1,0)
 ;;=1822^interruption of arterial flow^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11357,1,2,0)
 ;;=1823^interruption of venous flow^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11357,1,3,0)
 ;;=1824^exchange problems - hypervolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11357,1,4,0)
 ;;=1825^exchange problems - hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11357,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11362,0)
 ;;=Related Problems^2^NURSC^7^132^1^^T^1
