NURCCG5B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2104,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2105,0)
 ;;=give patient positive reinforcement^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2105,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2105,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2106,0)
 ;;=encourage patient to ventilate feelings ^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2106,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2106,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2107,0)
 ;;=establish an after care follow-up plan before discharge^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2107,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2107,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2108,0)
 ;;=ask patient to list all support resources by [date]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2108,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2108,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2109,0)
 ;;=reinforce need for follow-up care or support^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2109,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2109,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2110,0)
 ;;=verbalizes cause of withdrawl symptoms^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2110,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2110,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2111,0)
 ;;=verbalizes impact alcohol had on life style^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2111,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2111,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2112,0)
 ;;=verbalizes support systems to be used after discharge^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2112,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2112,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2113,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^57^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,1,0)
 ;;=2114^subculture lifestyle^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,2,0)
 ;;=2054^peer pressure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,3,0)
 ;;=2115^low frustration tolerance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,4,0)
 ;;=2116^emotional immaturity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,5,0)
 ;;=2117^need to escape^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2113,1,6,0)
 ;;=2118^reinforced 'highs'^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2113,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2114,0)
 ;;=subculture lifestyle^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2115,0)
 ;;=low frustration tolerance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2116,0)
 ;;=emotional immaturity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2117,0)
 ;;=need to escape^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2118,0)
 ;;=reinforced 'highs'^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2119,0)
 ;;=Related Problems^2^NURSC^7^44^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2119,5)
 ;;=,see
 ;;^UTILITY("^GMRD(124.2,",$J,2119,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2120,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^56^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,1,0)
 ;;=2121^free of S/S of substance withdrawl within [# of days] days^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,2,0)
 ;;=2122^verbalizes no anxiety towards being drug free by [date]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,3,0)
 ;;=2123^verbalizes 3 changes in lifestyle^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,4,0)
 ;;=2124^identifies 3 past behaviors which lead to drug abuse^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2120,1,5,0)
 ;;=2125^discusses feelings of loss re: giving up drugs by [date]^3^NURSC^1^0
