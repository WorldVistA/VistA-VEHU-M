NURCCGE2 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,7,0)
 ;;=1324^disease of sensory end organs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,8,0)
 ;;=1325^peripheral neuropathy: age related^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,9,0)
 ;;=1326^diabetes (disease related)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,10,0)
 ;;=1327^alcohol (disease related)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,1,11,0)
 ;;=1328^vascular (disease related)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12489,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12512,0)
 ;;=[Extra Goal]^3^NURSC^9^201^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12512,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12512,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12532,0)
 ;;=[Extra Order]^3^NURSC^11^204^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12532,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12532,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12533,0)
 ;;=[Extra Goal]^3^NURSC^9^93^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12533,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12533,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12550,0)
 ;;=Fluid Volume Deficit (Actual/Potential)^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12550,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12550,1,1,0)
 ;;=12552^Etiology/Related and/or Risk Factors^2^NURSC^169
 ;;^UTILITY("^GMRD(124.2,",$J,12550,1,2,0)
 ;;=12576^Related Problems^2^NURSC^145
 ;;^UTILITY("^GMRD(124.2,",$J,12550,1,3,0)
 ;;=12591^Goals/Expected Outcomes^2^NURSC^167
 ;;^UTILITY("^GMRD(124.2,",$J,12550,1,4,0)
 ;;=12608^Nursing Intervention/Orders^2^NURSC^141
 ;;^UTILITY("^GMRD(124.2,",$J,12550,1,5,0)
 ;;=12662^Defining Characteristics^2^NURSC^146
 ;;^UTILITY("^GMRD(124.2,",$J,12550,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12550,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12550,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^169^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,0)
 ;;=^124.21PI^10^6
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,2,0)
 ;;=1570^excessive loss through normal routes (e.g., diarrhea)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,5,0)
 ;;=1573^factors influencing fluid needs (e.g., hypermetabolic state)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,6,0)
 ;;=1574^knowledge deficiency related to fluid volume^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,8,0)
 ;;=2644^actual loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,9,0)
 ;;=2645^failure of regulatory mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,1,10,0)
 ;;=2646^loss of fluids though abnormal routes (indwelling tubes)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12552,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,0)
 ;;=Related Problems^2^NURSC^7^145^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,1,0)
 ;;=1404^Diarrhea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,2,0)
 ;;=1577^Hyperthermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,3,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,4,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,5,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,1,6,0)
 ;;=1579^Swallowing, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12576,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12588,0)
 ;;=Defining Characteristics^2^NURSC^12^145^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12588,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12588,1,1,0)
 ;;=4158^behavior pattern or usual response to stimuli is changed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12588,1,2,0)
 ;;=4162^sensory acuity is reported or measured as changed ^3^NURSC^1
