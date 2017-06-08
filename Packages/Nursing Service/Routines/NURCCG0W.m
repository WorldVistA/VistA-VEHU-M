NURCCG0W ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,343,"TD",0)
 ;;=^^2^2^2890306^^
 ;;^UTILITY("^GMRD(124.2,",$J,343,"TD",1,0)
 ;;=The state in which the individual is at risk because the body
 ;;^UTILITY("^GMRD(124.2,",$J,343,"TD",2,0)
 ;;=temperature is reduced below the individual's normal range.
 ;;^UTILITY("^GMRD(124.2,",$J,344,0)
 ;;=Knowledge Deficit^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,344,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,344,1,1,0)
 ;;=1668^Etiology/Related and/or Risk Factors^2^NURSC^44^0
 ;;^UTILITY("^GMRD(124.2,",$J,344,1,2,0)
 ;;=1673^Related Problems^2^NURSC^32^0
 ;;^UTILITY("^GMRD(124.2,",$J,344,1,3,0)
 ;;=1675^Goals/Expected Outcomes^2^NURSC^43^0
 ;;^UTILITY("^GMRD(124.2,",$J,344,1,4,0)
 ;;=1705^Nursing Intervention/Orders^2^NURSC^41^0
 ;;^UTILITY("^GMRD(124.2,",$J,344,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,344,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,344,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,344,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,344,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,345,0)
 ;;=Tissue Integrity, Impaired^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,345,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,345,1,1,0)
 ;;=1759^Etiology/Related and/or Risk Factors^2^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,345,1,2,0)
 ;;=1772^Related Problems^2^NURSC^35^0
 ;;^UTILITY("^GMRD(124.2,",$J,345,1,3,0)
 ;;=1777^Goals/Expected Outcomes^2^NURSC^46^0
 ;;^UTILITY("^GMRD(124.2,",$J,345,1,4,0)
 ;;=1796^Nursing Intervention/Orders^2^NURSC^43^0
 ;;^UTILITY("^GMRD(124.2,",$J,345,1,5,0)
 ;;=4302^Defining Characteristics^2^NURSC^51
 ;;^UTILITY("^GMRD(124.2,",$J,345,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,345,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,345,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,345,"TD",0)
 ;;=^^1^1^2890306^^
 ;;^UTILITY("^GMRD(124.2,",$J,345,"TD",1,0)
 ;;=State of tissue damage.
 ;;^UTILITY("^GMRD(124.2,",$J,346,0)
 ;;=Tissue Perfusion, Alteration In^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,346,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,346,1,1,0)
 ;;=1821^Etiology/Related and/or Risk Factors^2^NURSC^48^0
 ;;^UTILITY("^GMRD(124.2,",$J,346,1,2,0)
 ;;=1826^Related Problems^2^NURSC^36^0
 ;;^UTILITY("^GMRD(124.2,",$J,346,1,3,0)
 ;;=1827^Goals/Expected Outcomes^2^NURSC^47^0
 ;;^UTILITY("^GMRD(124.2,",$J,346,1,4,0)
 ;;=1841^Nursing Intervention/Orders^2^NURSC^168^0
 ;;^UTILITY("^GMRD(124.2,",$J,346,1,5,0)
 ;;=4304^Defining Characteristics^2^NURSC^52
 ;;^UTILITY("^GMRD(124.2,",$J,346,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,346,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,346,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,346,"TD",0)
 ;;=^^3^3^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,346,"TD",1,0)
 ;;=The state in which an individual experiences a decrease of
 ;;^UTILITY("^GMRD(124.2,",$J,346,"TD",2,0)
 ;;=nutrition and oxygenation at the cellular level due to deficit
 ;;^UTILITY("^GMRD(124.2,",$J,346,"TD",3,0)
 ;;=in capillary blood supply.
 ;;^UTILITY("^GMRD(124.2,",$J,347,0)
 ;;=Appetite, Altered^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,347,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,347,1,1,0)
 ;;=2399^Etiology/Related and/or Risk Factors^2^NURSC^67^0
 ;;^UTILITY("^GMRD(124.2,",$J,347,1,2,0)
 ;;=2408^Goals/Expected Outcomes^2^NURSC^66^0
 ;;^UTILITY("^GMRD(124.2,",$J,347,1,3,0)
 ;;=2521^Nursing Intervention/Orders^2^NURSC^62^0
 ;;^UTILITY("^GMRD(124.2,",$J,347,1,4,0)
 ;;=2542^Related Problems^2^NURSC^55^0
 ;;^UTILITY("^GMRD(124.2,",$J,347,1,5,0)
 ;;=4044^Defining Characteristics^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,347,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,347,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,347,10)
 ;;=D EN3^NURCCPU1
