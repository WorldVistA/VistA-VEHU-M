NURCCGB9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7610,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^278^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,1,0)
 ;;=7682^assess for stage of withdrawal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,2,0)
 ;;=7744^initiate unit specific withdrawal procedures [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,3,0)
 ;;=7883^provide Ed material/discussion re addiction/med complication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,4,0)
 ;;=8025^involve in 1:1 and groups discussing consequences use/abuse^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,5,0)
 ;;=8143^assist to identify resources to maintain substance free life^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7610,1,6,0)
 ;;=8274^[Extra Order]^3^NURSC^114
 ;;^UTILITY("^GMRD(124.2,",$J,7610,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7610,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7622,0)
 ;;=refer for appropriate consults^2^NURSC^11^20^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,7622,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,7622,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7622,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7622,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7632,0)
 ;;=Pain, Acute^2^NURSC^2^6^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7632,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7632,1,1,0)
 ;;=7634^Etiology/Related and/or Risk Factors^2^NURSC^107
 ;;^UTILITY("^GMRD(124.2,",$J,7632,1,2,0)
 ;;=7671^Goals/Expected Outcomes^2^NURSC^105
 ;;^UTILITY("^GMRD(124.2,",$J,7632,1,3,0)
 ;;=7689^Nursing Intervention/Orders^2^NURSC^182
 ;;^UTILITY("^GMRD(124.2,",$J,7632,1,4,0)
 ;;=7706^Related Problems^2^NURSC^90
 ;;^UTILITY("^GMRD(124.2,",$J,7632,1,5,0)
 ;;=7717^Defining Characteristics^2^NURSC^95
 ;;^UTILITY("^GMRD(124.2,",$J,7632,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7632,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7632,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7632,"TD",0)
 ;;=^^2^2^2890825^^^
 ;;^UTILITY("^GMRD(124.2,",$J,7632,"TD",1,0)
 ;;=A state of discomfort that can last from one second to as long as 
 ;;^UTILITY("^GMRD(124.2,",$J,7632,"TD",2,0)
 ;;=six months.
 ;;^UTILITY("^GMRD(124.2,",$J,7634,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^107^^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,0)
 ;;=^124.21PI^16^14
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,1,0)
 ;;=630^fatigue^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,2,0)
 ;;=2777^immobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,3,0)
 ;;=2778^inflammation injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,4,0)
 ;;=2779^ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,5,0)
 ;;=2780^muscle spasms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,6,0)
 ;;=2781^muscle tension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,9,0)
 ;;=2784^procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,10,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,11,0)
 ;;=2786^tissue damage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,12,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,13,0)
 ;;=2152^fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,14,0)
 ;;=2403^depression^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7634,1,15,0)
 ;;=2787^hostility/anger^3^NURSC^1
