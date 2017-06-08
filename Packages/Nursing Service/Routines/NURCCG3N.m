NURCCG3N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1299,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^28^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,1,0)
 ;;=778^inspect for external factors which produce injury q [freq.]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,2,0)
 ;;=779^observe for adverse effects of chemical agents/treatments^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,3,0)
 ;;=780^identify and eliminate potential sources of injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,4,0)
 ;;=781^provide physically safe environment^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,5,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,7,0)
 ;;=784^teach patient regarding health maintenance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,8,0)
 ;;=785^teach S/O regarding potential for injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,9,0)
 ;;=786^assure understanding of informed consent^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,1,10,0)
 ;;=2983^[Extra Order]^3^NURSC^68^0
 ;;^UTILITY("^GMRD(124.2,",$J,1299,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1299,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1300,0)
 ;;=Related Problems^2^NURSC^7^25^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1300,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1300,1,1,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1300,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1301,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^33^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,1,0)
 ;;=159^cognitive limitation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,2,0)
 ;;=160^information misinterpretation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,3,0)
 ;;=161^lack of exposure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,4,0)
 ;;=163^lack of interest in learning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,5,0)
 ;;=162^lack of recall^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,6,0)
 ;;=164^patient's request for no information^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1301,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1302,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^32^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1302,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1302,1,1,0)
 ;;=167^verbalizes ability to make decisions on health care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1302,1,2,0)
 ;;=1304^verbalizes an appropriate knowledge base to be safe^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1302,1,3,0)
 ;;=2674^demonstrates ability to use assistive/adaptive devices [spe]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1302,1,4,0)
 ;;=2897^[Extra Goal]^3^NURSC^76^0
 ;;^UTILITY("^GMRD(124.2,",$J,1302,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1303,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^29^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,1,0)
 ;;=169^assess knowledge base^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,2,0)
 ;;=170^decide what patient needs to know^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,3,0)
 ;;=171^determine ability to learn and implement plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,4,0)
 ;;=172^implement teaching plan based on readiness/ability to learn^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,5,0)
 ;;=173^involve S/O in teaching plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,6,0)
 ;;=174^evaluate effectiveness of teaching plan^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1303,1,7,0)
 ;;=2984^[Extra Order]^3^NURSC^69^0
