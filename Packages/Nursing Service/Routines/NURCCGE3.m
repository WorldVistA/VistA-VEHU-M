NURCCGE3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12588,1,3,0)
 ;;=4165^problem-solving  abilities are changed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12588,1,4,0)
 ;;=4167^disoriented in time, place or with persons^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12588,1,5,0)
 ;;=4172^body image alteration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12588,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12591,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^167^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12591,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12591,1,1,0)
 ;;=12594^maintains fluid/electrolyte balance^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12591,1,2,0)
 ;;=12604^expresses understanding of fluid intake requirements^2^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12591,1,3,0)
 ;;=12751^[Extra Goal]^3^NURSC^204
 ;;^UTILITY("^GMRD(124.2,",$J,12591,1,4,0)
 ;;=15347^decreased diarrhea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12591,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,0)
 ;;=maintains fluid/electrolyte balance^2^NURSC^9^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,1,0)
 ;;=1519^balanced I/O, urine ouput WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,2,0)
 ;;=1582^skin turgor normal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,3,0)
 ;;=1583^weight is greater than [lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,4,0)
 ;;=1584^weight is less than [lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,5,0)
 ;;=1432^lab data (e.g. CBC, differential) is WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,6,0)
 ;;=1585^moist mucous membranes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,1,7,0)
 ;;=1586^urine and specific gravity WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,12594,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12594,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12594,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12604,0)
 ;;=expresses understanding of fluid intake requirements^2^NURSC^9^4^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12604,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,12604,1,1,0)
 ;;=1588^stress, heat, fever, and decreased thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12604,1,2,0)
 ;;=1589^loss from diarrhea, vomiting, diuresis and/or diaphoesis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12604,5)
 ;;=due to
 ;;^UTILITY("^GMRD(124.2,",$J,12604,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12604,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12604,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12607,0)
 ;;=[Extra Goal]^3^NURSC^9^202^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12607,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12607,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12608,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^141^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,0)
 ;;=^124.21PI^25^6
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,1,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,2,0)
 ;;=12611^measure diarrhea/vomitus and include on I&O record  ^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,8,0)
 ;;=1601^encourage fluid intake of [amt]cc/24hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,9,0)
 ;;=12630^eliminate diarrheal stimulating food ie.,chocolate,coffee^3^NURSC^35
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,23,0)
 ;;=13052^[Extra Order]^3^NURSC^233
 ;;^UTILITY("^GMRD(124.2,",$J,12608,1,25,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12608,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12608,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12610,0)
 ;;=[Extra Problem]^2^NURSC^2^29^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,12610,1,0)
 ;;=^124.21PI^3^3
