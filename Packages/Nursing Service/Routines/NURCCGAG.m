NURCCGAG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6231,1,4,0)
 ;;=6270^Defining Characteristics^2^NURSC^81
 ;;^UTILITY("^GMRD(124.2,",$J,6231,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6231,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6231,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6231,"TD",0)
 ;;=^^1^1^2900529^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,6231,"TD",1,0)
 ;;=Lack of specific information
 ;;^UTILITY("^GMRD(124.2,",$J,6232,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^87^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,1,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,2,0)
 ;;=160^information misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,3,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,4,0)
 ;;=162^lack of recall^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,5,0)
 ;;=163^lack of interest in learning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,6,0)
 ;;=164^patient's request for no information^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6232,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6240,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^86^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6240,1,0)
 ;;=^124.21PI^9^3
 ;;^UTILITY("^GMRD(124.2,",$J,6240,1,1,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6240,1,2,0)
 ;;=2437^expresses appropriate knowledge base for self care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6240,1,9,0)
 ;;=6304^[Extra Goal]^3^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,6240,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6252,0)
 ;;=[Extra Goal]^3^NURSC^9^124^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6252,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6252,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6253,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^173^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6253,1,0)
 ;;=^124.21PI^9^3
 ;;^UTILITY("^GMRD(124.2,",$J,6253,1,1,0)
 ;;=169^assess knowledge base^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6253,1,8,0)
 ;;=6269^[Extra Order]^3^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,6253,1,9,0)
 ;;=7411^instruct patient & S/O^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6253,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6253,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6269,0)
 ;;=[Extra Order]^3^NURSC^11^129^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6269,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6269,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6270,0)
 ;;=Defining Characteristics^2^NURSC^12^81^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6270,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6270,1,1,0)
 ;;=4270^request for information^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6270,1,2,0)
 ;;=4272^statement of misconception^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6270,1,3,0)
 ;;=4275^verbalization of the problem^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6270,1,4,0)
 ;;=4322^inadequate performance of test or inadequate verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6270,1,5,0)
 ;;=4323^inappropriate/exagerated behaviors ie.,hysterical,agitated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6270,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6276,0)
 ;;=Pain, Acute^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6276,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6276,1,1,0)
 ;;=6277^Etiology/Related and/or Risk Factors^2^NURSC^88
 ;;^UTILITY("^GMRD(124.2,",$J,6276,1,2,0)
 ;;=6295^Goals/Expected Outcomes^2^NURSC^87
