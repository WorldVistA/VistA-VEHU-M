NURCCGC9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9562,0)
 ;;=initiate consult(s):^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9562,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,9562,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9562,1,2,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9562,1,3,0)
 ;;=2580^VNA^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9562,1,4,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9562,5)
 ;;=to:
 ;;^UTILITY("^GMRD(124.2,",$J,9562,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9562,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9562,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9569,0)
 ;;=[Extra Order]^3^NURSC^11^162^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9569,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9569,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9570,0)
 ;;=Defining Characteristics^2^NURSC^12^113^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9570,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,9570,1,1,0)
 ;;=9571^body weight 20% or more under ideal^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9570,1,2,0)
 ;;=9572^reported food intake under RDA^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9570,1,3,0)
 ;;=9573^reported/observed lack of food^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9570,1,4,0)
 ;;=9574^sore/inflammed bucal cavity^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9570,1,5,0)
 ;;=9575^lack of interest in food^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9570,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9571,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9572,0)
 ;;=reported food intake under RDA^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9573,0)
 ;;=reported/observed lack of food^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9574,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9575,0)
 ;;=lack of interest in food^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9576,0)
 ;;=Knowledge Deficit^2^NURSC^2^8^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9576,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,9576,1,1,0)
 ;;=9577^Etiology/Related and/or Risk Factors^2^NURSC^130
 ;;^UTILITY("^GMRD(124.2,",$J,9576,1,2,0)
 ;;=9586^Related Problems^2^NURSC^111
 ;;^UTILITY("^GMRD(124.2,",$J,9576,1,3,0)
 ;;=9589^Goals/Expected Outcomes^2^NURSC^128
 ;;^UTILITY("^GMRD(124.2,",$J,9576,1,4,0)
 ;;=9610^Nursing Intervention/Orders^2^NURSC^109
 ;;^UTILITY("^GMRD(124.2,",$J,9576,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9576,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9576,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9576,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,9576,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,9577,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^130^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,1,0)
 ;;=161^lack of exposure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,2,0)
 ;;=162^lack of recall^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,3,0)
 ;;=160^information misinterpretation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,4,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,6,0)
 ;;=163^lack of interest in learning^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,8,0)
 ;;=15299^no information requested by patient^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9577,1,9,0)
 ;;=15300^[etiology]^3^NURSC^157
 ;;^UTILITY("^GMRD(124.2,",$J,9577,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9584,0)
 ;;=loss of blood from gastrointestinal tract^3^NURSC^^1^^^T
