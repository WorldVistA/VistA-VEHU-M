NURCCGC6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,9457,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9457,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9460,0)
 ;;=weight is maintained WNL for pt, [specify weight range] ^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9461,0)
 ;;=weight loss no greater than 0.5 kgs/day^3^NURSC^^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9465,0)
 ;;=maintains fluid intake requirements^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,9465,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,9465,1,1,0)
 ;;=1588^stress, heat, fever, and decreased thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9465,1,2,0)
 ;;=1589^loss from diarrhea, vomiting, diuresis and/or diaphoesis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9465,5)
 ;;=due to
 ;;^UTILITY("^GMRD(124.2,",$J,9465,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9465,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9465,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9468,0)
 ;;=[Extra Goal]^3^NURSC^9^158^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9468,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,9468,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^107^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,0)
 ;;=^124.21PI^25^21
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,1,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,2,0)
 ;;=1591^assess skin turgor and oral mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,3,0)
 ;;=1592^report urinary output if less than [ ]cc/hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,4,0)
 ;;=1593^gastric pH q [ ] hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,5,0)
 ;;=1594^assess for presence/amt. of edema q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,6,0)
 ;;=1595^B/P lying and standing q[frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,8,0)
 ;;=1601^encourage fluid intake of [amt]cc/24hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,9,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,10,0)
 ;;=1602^limit foods acting as diuretics (sugar, alcohol,caffeine)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,11,0)
 ;;=1603^maintain activity level commensurate with health state^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,12,0)
 ;;=1604^give verbal/written directions for desired fluid amts.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,13,0)
 ;;=1605^include patient and S/O in recording I/O^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,14,0)
 ;;=1606^normal saline irrigation to gastric tube q[ ]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,15,0)
 ;;=1607^offer mouth swabs if NPO or on gastric tube q [ ] hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,16,0)
 ;;=1608^weigh dressings to record wound loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,17,0)
 ;;=1609^replace fluids [ ]cc for [ ]cc drainage q[ ]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,19,0)
 ;;=1614^give small, frequent amts. of clear liquids if nauseated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,21,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,23,0)
 ;;=9745^[Extra Order]^3^NURSC^165
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,24,0)
 ;;=3149^assess for S/S of increased anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,1,25,0)
 ;;=15274^assess,report signs and symptoms of metabolic acidosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,9469,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9509,0)
 ;;=[Extra Order]^3^NURSC^11^161^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,9509,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,9509,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,9510,0)
 ;;=Defining Characteristics^2^NURSC^12^112^1^^T^1
