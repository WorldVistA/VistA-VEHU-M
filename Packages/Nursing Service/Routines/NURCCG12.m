NURCCG12 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,367,0)
 ;;=Cognitive Impairment^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,367,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,367,1,1,0)
 ;;=1081^Etiology/Related and/or Risk Factors^2^NURSC^26^0
 ;;^UTILITY("^GMRD(124.2,",$J,367,1,2,0)
 ;;=1082^Goals/Expected Outcomes^2^NURSC^25^0
 ;;^UTILITY("^GMRD(124.2,",$J,367,1,3,0)
 ;;=1083^Nursing Intervention/Orders^2^NURSC^22^0
 ;;^UTILITY("^GMRD(124.2,",$J,367,1,4,0)
 ;;=4134^Defining Characteristics^2^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,367,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,367,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,367,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,367,"TD",0)
 ;;=^^2^2^2890803^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,367,"TD",1,0)
 ;;=A state of altered awareness of objects of thought or perscription
 ;;^UTILITY("^GMRD(124.2,",$J,367,"TD",2,0)
 ;;=including all aspects of perceiving, thinking, remembering.
 ;;^UTILITY("^GMRD(124.2,",$J,368,0)
 ;;=Communication Impaired^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,368,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,368,1,1,0)
 ;;=1098^Etiology/Related and/or Risk Factors^2^NURSC^27^0
 ;;^UTILITY("^GMRD(124.2,",$J,368,1,2,0)
 ;;=1099^Goals/Expected Outcomes^2^NURSC^26^0
 ;;^UTILITY("^GMRD(124.2,",$J,368,1,3,0)
 ;;=1100^Nursing Intervention/Orders^2^NURSC^23^0
 ;;^UTILITY("^GMRD(124.2,",$J,368,1,4,0)
 ;;=4345^Defining Characteristics^2^NURSC^59
 ;;^UTILITY("^GMRD(124.2,",$J,368,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,368,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,368,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,368,"TD",0)
 ;;=^^2^2^2890803^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,368,"TD",1,0)
 ;;=The state in which an individual experiences a decreased or absent
 ;;^UTILITY("^GMRD(124.2,",$J,368,"TD",2,0)
 ;;=ability to use or understand language in human interaction.
 ;;^UTILITY("^GMRD(124.2,",$J,369,0)
 ;;=Knowledge Deficit for Cognitive-Sensory Problems^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,369,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,369,1,1,0)
 ;;=1301^Etiology/Related and/or Risk Factors^2^NURSC^33^0
 ;;^UTILITY("^GMRD(124.2,",$J,369,1,2,0)
 ;;=1302^Goals/Expected Outcomes^2^NURSC^32^0
 ;;^UTILITY("^GMRD(124.2,",$J,369,1,3,0)
 ;;=1303^Nursing Intervention/Orders^2^NURSC^29^0
 ;;^UTILITY("^GMRD(124.2,",$J,369,1,5,0)
 ;;=5351^Defining Characteristics^2^NURSC^64
 ;;^UTILITY("^GMRD(124.2,",$J,369,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,369,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,369,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,369,"TD",0)
 ;;=^^1^1^2890303^^^
 ;;^UTILITY("^GMRD(124.2,",$J,369,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,370,0)
 ;;=Neglect, Unilateral^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,370,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,370,1,1,0)
 ;;=1305^Etiology/Related and/or Risk Factors^2^NURSC^34^0
 ;;^UTILITY("^GMRD(124.2,",$J,370,1,2,0)
 ;;=1306^Goals/Expected Outcomes^2^NURSC^33^0
 ;;^UTILITY("^GMRD(124.2,",$J,370,1,3,0)
 ;;=1307^Nursing Intervention/Orders^2^NURSC^30^0
 ;;^UTILITY("^GMRD(124.2,",$J,370,1,4,0)
 ;;=4336^Defining Characteristics^2^NURSC^57
 ;;^UTILITY("^GMRD(124.2,",$J,370,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,370,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,370,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,370,"TD",0)
 ;;=^^2^2^2890302^^
 ;;^UTILITY("^GMRD(124.2,",$J,370,"TD",1,0)
 ;;=The state in which an individual is inattentive to a perceptually
 ;;^UTILITY("^GMRD(124.2,",$J,370,"TD",2,0)
 ;;=affected side.
 ;;^UTILITY("^GMRD(124.2,",$J,371,0)
 ;;=Sensory-Perceptual, Alteration In^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,371,1,0)
 ;;=^124.21PI^4^4
