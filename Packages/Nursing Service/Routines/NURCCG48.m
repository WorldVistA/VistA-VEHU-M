NURCCG48 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1587,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1587,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1587,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1588,0)
 ;;=stress, heat, fever, and decreased thirst^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1589,0)
 ;;=loss from diarrhea, vomiting, diuresis and/or diaphoesis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1590,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^36^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,0)
 ;;=^124.21PI^23^23
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,1,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,2,0)
 ;;=1591^assess skin turgor and oral mucous membrane^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,3,0)
 ;;=1592^report urinary output if less than [ ]cc/hr^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,4,0)
 ;;=1593^gastric pH q [ ] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,5,0)
 ;;=1594^assess for presence/amt. of edema q[frequency]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,6,0)
 ;;=1595^B/P lying and standing q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,7,0)
 ;;=1596^laboratory data q [frequency]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,8,0)
 ;;=1601^encourage fluid intake of [amt]cc/24hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,9,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,10,0)
 ;;=1602^limit foods acting as diuretics (sugar, alcohol,caffeine)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,11,0)
 ;;=1603^maintain activity level commensurate with health state^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,12,0)
 ;;=1604^give verbal/written directions for desired fluid amts.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,13,0)
 ;;=1605^include patient and S/O in recording I/O^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,14,0)
 ;;=1606^normal saline irrigation to gastric tube q[ ]hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,15,0)
 ;;=1607^offer mouth swabs if NPO or on gastric tube q [ ] hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,16,0)
 ;;=1608^weigh dressings to record wound loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,17,0)
 ;;=1609^replace fluids [ ]cc for [ ]cc drainage q[ ]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,18,0)
 ;;=1610^initiate febrile protocol^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,19,0)
 ;;=1614^give small, frequent amts. of clear liquids if nauseated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,20,0)
 ;;=1615^teach patient^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,21,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,22,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,1,23,0)
 ;;=2991^[Extra Order]^3^NURSC^76^0
 ;;^UTILITY("^GMRD(124.2,",$J,1590,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1590,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1591,0)
 ;;=assess skin turgor and oral mucous membrane^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1591,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,1591,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1591,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1592,0)
 ;;=report urinary output if less than [ ]cc/hr^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1592,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1592,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1593,0)
 ;;=gastric pH q [ ] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1593,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,1593,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1593,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1594,0)
 ;;=assess for presence/amt. of edema q[frequency]^3^NURSC^11^3^^^T
