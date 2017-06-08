NURCCGC5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9437,1,4,0)
 ;;=9469^Nursing Intervention/Orders^2^NURSC^107
 ;;^UTILITY("^GMRD(124.2,",$J,9437,1,5,0)
 ;;=9510^Defining Characteristics^2^NURSC^112
 ;;^UTILITY("^GMRD(124.2,",$J,9437,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9437,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9437,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^128^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,1,0)
 ;;=1569^deviation affecting access, intake, absorption of fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,2,0)
 ;;=1570^excessive loss through normal routes (e.g., diarrhea)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,3,0)
 ;;=1571^extremes of ages^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,4,0)
 ;;=1572^extremes of weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,5,0)
 ;;=1573^factors influencing fluid needs (e.g., hypermetabolic state)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,6,0)
 ;;=1574^knowledge deficiency related to fluid volume^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,7,0)
 ;;=1575^medications^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,8,0)
 ;;=2644^actual loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,9,0)
 ;;=2645^failure of regulatory mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,1,10,0)
 ;;=2646^loss of fluids though abnormal routes (indwelling tubes)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9438,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,0)
 ;;=Related Problems^2^NURSC^7^109^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,1,0)
 ;;=1404^Diarrhea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,2,0)
 ;;=1577^Hyperthermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,3,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,4,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,5,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,1,6,0)
 ;;=1579^Swallowing, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9449,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9456,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^126^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9456,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,9456,1,1,0)
 ;;=9457^maintains fluid/electrolyte balance:^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9456,1,2,0)
 ;;=9465^maintains fluid intake requirements^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9456,1,3,0)
 ;;=9545^[Extra Goal]^3^NURSC^159
 ;;^UTILITY("^GMRD(124.2,",$J,9456,1,4,0)
 ;;=9245^vital signs WNL or returns to baseline^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9456,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9457,0)
 ;;=maintains fluid/electrolyte balance:^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,1,0)
 ;;=6560^balanced I/O^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,2,0)
 ;;=1582^skin turgor normal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,3,0)
 ;;=9460^weight is maintained WNL for pt, [specify weight range] ^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,4,0)
 ;;=9461^weight loss no greater than 0.5 kgs/day^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,5,0)
 ;;=517^lab data (e.g. BUN, creatinine) is normal or baseline^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,6,0)
 ;;=1585^moist mucous membranes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9457,1,7,0)
 ;;=1586^urine and specific gravity WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9457,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,9457,7)
 ;;=D EN4^NURCCPU1
