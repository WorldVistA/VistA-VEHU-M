NURCCG47 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1571,0)
 ;;=extremes of ages^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1572,0)
 ;;=extremes of weight^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1573,0)
 ;;=factors influencing fluid needs (e.g., hypermetabolic state)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1574,0)
 ;;=knowledge deficiency related to fluid volume^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1575,0)
 ;;=medications^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1576,0)
 ;;=Related Problems^2^NURSC^7^30^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,1,0)
 ;;=1404^Diarrhea^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,2,0)
 ;;=1577^Hyperthermia^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,3,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,4,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,5,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1576,1,6,0)
 ;;=1579^Swallowing, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1576,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1577,0)
 ;;=Hyperthermia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1578,0)
 ;;=Oral Mucous Membrane, Alteration In^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1579,0)
 ;;=Swallowing, Impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1580,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^39^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1580,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1580,1,1,0)
 ;;=1581^maintains fluid/electrolyte balance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1580,1,2,0)
 ;;=1587^expresses understanding of fluid intake requirements^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1580,1,3,0)
 ;;=2904^[Extra Goal]^3^NURSC^84^0
 ;;^UTILITY("^GMRD(124.2,",$J,1580,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1581,0)
 ;;=maintains fluid/electrolyte balance^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,1,0)
 ;;=1519^balanced I/O, urine ouput WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,2,0)
 ;;=1582^skin turgor normal^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,3,0)
 ;;=1583^weight is greater than [lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,4,0)
 ;;=1584^weight is less than [lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,5,0)
 ;;=1432^lab data (e.g. CBC, differential) is WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,6,0)
 ;;=1585^moist mucous membranes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,1,7,0)
 ;;=1586^urine and specific gravity WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,1581,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1581,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1581,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1582,0)
 ;;=skin turgor normal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1583,0)
 ;;=weight is greater than [lbs/kgs]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1584,0)
 ;;=weight is less than [lbs/kgs]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1585,0)
 ;;=moist mucous membranes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1586,0)
 ;;=urine and specific gravity WNL^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1587,0)
 ;;=expresses understanding of fluid intake requirements^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1587,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1587,1,1,0)
 ;;=1588^stress, heat, fever, and decreased thirst^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1587,1,2,0)
 ;;=1589^loss from diarrhea, vomiting, diuresis and/or diaphoesis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1587,5)
 ;;=due to
