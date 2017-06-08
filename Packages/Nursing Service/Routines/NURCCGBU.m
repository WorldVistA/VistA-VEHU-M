NURCCGBU ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8789,0)
 ;;=Knowledge Deficit^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8789,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,8789,1,1,0)
 ;;=8790^Etiology/Related and/or Risk Factors^2^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,8789,1,2,0)
 ;;=8803^Related Problems^2^NURSC^102
 ;;^UTILITY("^GMRD(124.2,",$J,8789,1,3,0)
 ;;=8810^Goals/Expected Outcomes^2^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,8789,1,4,0)
 ;;=8847^Nursing Intervention/Orders^2^NURSC^101
 ;;^UTILITY("^GMRD(124.2,",$J,8789,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8789,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8789,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8789,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,8789,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,8790,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^120^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,1,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,2,0)
 ;;=1669^lack of recall^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,3,0)
 ;;=1670^misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,4,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,5,0)
 ;;=1671^perceptual limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,6,0)
 ;;=1672^disinterest in learning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8790,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8803,0)
 ;;=Related Problems^2^NURSC^7^102^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8803,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,8803,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8803,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8803,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8810,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^118^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,0)
 ;;=^124.21PI^12^6
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,1,0)
 ;;=8813^verbalizes knowledge of respiratory equipment used at home^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,5,0)
 ;;=8819^verbalizes facts about diet^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,6,0)
 ;;=8821^verbalizes primary side effects of medications [specify]^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,8,0)
 ;;=8830^verbalizes S/S indicating need to contact health provider^2^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,9,0)
 ;;=8838^demonstrates correct use of metered dose inhaler^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8810,1,12,0)
 ;;=8969^[Extra Goal]^3^NURSC^152
 ;;^UTILITY("^GMRD(124.2,",$J,8810,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8813,0)
 ;;=verbalizes knowledge of respiratory equipment used at home^3^NURSC^9^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8813,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8813,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8819,0)
 ;;=verbalizes facts about diet^3^NURSC^9^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8819,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8819,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8821,0)
 ;;=verbalizes primary side effects of medications [specify]^3^NURSC^9^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8821,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8821,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8830,0)
 ;;=verbalizes S/S indicating need to contact health provider^2^NURSC^9^7^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8830,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,8830,1,1,0)
 ;;=8832^change in sputum^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,8830,1,3,0)
 ;;=8835^increasing shortness of breath^3^NURSC^7
