NURCCG2I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,15,0)
 ;;=771^nonadherence/noncompliance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,16,0)
 ;;=772^infestation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,17,0)
 ;;=773^clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,18,0)
 ;;=774^unfamiliar setting^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,19,0)
 ;;=775^physical restraints/barriers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,1,20,0)
 ;;=798^medical protocols^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,755,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,756,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^16^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,756,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,756,1,1,0)
 ;;=776^remains free from injuries^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,756,1,2,0)
 ;;=777^verbalizes how to prevent injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,756,1,3,0)
 ;;=2881^[Extra Goal]^3^NURSC^58^0
 ;;^UTILITY("^GMRD(124.2,",$J,756,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,757,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^13^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,1,0)
 ;;=778^inspect for external factors which produce injury q [freq.]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,2,0)
 ;;=779^observe for adverse effects of chemical agents/treatments^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,3,0)
 ;;=780^identify and eliminate potential sources of injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,4,0)
 ;;=781^provide physically safe environment^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,5,0)
 ;;=782^protect with restraints [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,6,0)
 ;;=783^provide restraint care q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,7,0)
 ;;=784^teach patient regarding health maintenance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,8,0)
 ;;=785^teach S/O regarding potential for injury^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,9,0)
 ;;=786^assure understanding of informed consent^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,10,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,1,11,0)
 ;;=2968^[Extra Order]^3^NURSC^51^0
 ;;^UTILITY("^GMRD(124.2,",$J,757,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,757,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,758,0)
 ;;=individual/environment conditions which impose a risk^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,759,0)
 ;;=biological^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,760,0)
 ;;=developmental^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,761,0)
 ;;=physiologic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,762,0)
 ;;=psychologic perception^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,763,0)
 ;;=people provider^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,764,0)
 ;;=psychologic^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,765,0)
 ;;=loss of motor ability from disease/injury/aging/restraints^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,766,0)
 ;;=sensory loss from disease/injury/aging/restraints^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,767,0)
 ;;=cognitive deficit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,768,0)
 ;;=perceptual deficit^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,769,0)
 ;;=adverse effects of chemicals/drugs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,770,0)
 ;;=self-mutilation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,771,0)
 ;;=nonadherence/noncompliance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,772,0)
 ;;=infestation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,773,0)
 ;;=clothing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,774,0)
 ;;=unfamiliar setting^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,775,0)
 ;;=physical restraints/barriers^3^NURSC^^1^^^T
