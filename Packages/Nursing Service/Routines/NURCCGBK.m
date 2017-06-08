NURCCGBK ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8131,1,1,0)
 ;;=8134^Etiology/Related and/or Risk Factors^2^NURSC^113
 ;;^UTILITY("^GMRD(124.2,",$J,8131,1,2,0)
 ;;=8176^Goals/Expected Outcomes^2^NURSC^111
 ;;^UTILITY("^GMRD(124.2,",$J,8131,1,3,0)
 ;;=8187^Nursing Intervention/Orders^2^NURSC^95
 ;;^UTILITY("^GMRD(124.2,",$J,8131,1,4,0)
 ;;=8241^Related Problems^2^NURSC^96
 ;;^UTILITY("^GMRD(124.2,",$J,8131,1,5,0)
 ;;=8245^Defining Characteristics^2^NURSC^100
 ;;^UTILITY("^GMRD(124.2,",$J,8131,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8131,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8131,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8131,"TD",0)
 ;;=^^3^3^2890802^^
 ;;^UTILITY("^GMRD(124.2,",$J,8131,"TD",1,0)
 ;;=A state in which the individual is at risk for injury as a result of
 ;;^UTILITY("^GMRD(124.2,",$J,8131,"TD",2,0)
 ;;=environmental conditions interacting with the individual's adaptive
 ;;^UTILITY("^GMRD(124.2,",$J,8131,"TD",3,0)
 ;;=and defensive resources.
 ;;^UTILITY("^GMRD(124.2,",$J,8134,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^113^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8134,1,0)
 ;;=^124.21PI^21^1
 ;;^UTILITY("^GMRD(124.2,",$J,8134,1,21,0)
 ;;=10897^neurological changes during hypo/hyperglycemic episodes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8134,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8142,0)
 ;;=[Extra Goal]^3^NURSC^9^228^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8142,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8142,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8143,0)
 ;;=assist to identify resources to maintain substance free life^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8143,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8143,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8176,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^111^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8176,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8176,1,1,0)
 ;;=776^remains free from injuries^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8176,1,2,0)
 ;;=777^verbalizes how to prevent injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8176,1,3,0)
 ;;=8337^[Extra Goal]^3^NURSC^146
 ;;^UTILITY("^GMRD(124.2,",$J,8176,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8183,0)
 ;;=monitor lab values^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8183,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,8183,1,1,0)
 ;;=4393^electrolytes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8183,1,2,0)
 ;;=4394^BUN [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8183,1,3,0)
 ;;=4395^creatinine [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8183,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8183,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8183,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8184,0)
 ;;=[Extra Goal]^3^NURSC^9^145^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8184,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,8184,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^95^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,0)
 ;;=^124.21PI^16^14
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,1,0)
 ;;=778^inspect for external factors which produce injury q [freq.]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,2,0)
 ;;=779^observe for adverse effects of chemical agents/treatments^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,3,0)
 ;;=780^identify and eliminate potential sources of injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,5,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,7,0)
 ;;=784^teach patient regarding health maintenance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8187,1,8,0)
 ;;=785^teach S/O regarding potential for injury^3^NURSC^1
