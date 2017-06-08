NURCCG03 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,16,"TD",0)
 ;;=^^1^1^2900529^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,16,"TD",1,0)
 ;;=Lack of specific information
 ;;^UTILITY("^GMRD(124.2,",$J,17,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,1,0)
 ;;=20^altered communication^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,2,0)
 ;;=21^cognition impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,3,0)
 ;;=22^development tasks impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,4,0)
 ;;=23^ineffective family/individual coping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,5,0)
 ;;=24^lack of ability to make judgement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,6,0)
 ;;=25^lack of growth of fine motor skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,7,0)
 ;;=140^alteration in comfort related to pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,8,0)
 ;;=141^external locus of control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,9,0)
 ;;=80^family process, alteration in^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,10,0)
 ;;=142^health beliefs (lack of perceived health threat)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,11,0)
 ;;=645^knowledge deficit [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,12,0)
 ;;=143^inaccessibility to adequate health care services^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,13,0)
 ;;=144^religious beliefs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,1,14,0)
 ;;=98^substance abuse^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,17,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,18,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,1,0)
 ;;=26^maintains a state of wellness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,2,0)
 ;;=31^maintains or regains optimal level of mobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,3,0)
 ;;=32^remains/regains orientation to time, place and space^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,4,0)
 ;;=33^communicates within capacity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,5,0)
 ;;=2489^follows treatment regime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,6,0)
 ;;=2490^maintains or regains ability for self-care in ADL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,7,0)
 ;;=30^tissue intact^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,1,8,0)
 ;;=2862^[Extra Goal]^3^NURSC^33^0
 ;;^UTILITY("^GMRD(124.2,",$J,18,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,19,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,1,0)
 ;;=34^assess causative factors on admission^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,2,0)
 ;;=35^assist to maintain and manage health care^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,3,0)
 ;;=36^promote wellness through patient/family knowledge [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,4,0)
 ;;=149^promote wellness through past patterns of health care^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,5,0)
 ;;=150^discuss role of nutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,6,0)
 ;;=151^discuss role of exercise^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,7,0)
 ;;=152^discuss role of safety measures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,8,0)
 ;;=153^discuss role of stress management^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,9,0)
 ;;=154^discuss role of social support systems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,10,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,1,11,0)
 ;;=2953^[Extra Order]^3^NURSC^23^0
 ;;^UTILITY("^GMRD(124.2,",$J,19,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,19,9)
 ;;=D EN1^NURCCPU2
