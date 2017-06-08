NURCCGAP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,7,0)
 ;;=6578^monitor laboratory data q[frequency]:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,8,0)
 ;;=1601^encourage fluid intake of [amt]cc/24hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,10,0)
 ;;=1602^limit foods acting as diuretics (sugar, alcohol,caffeine)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,11,0)
 ;;=1603^maintain activity level commensurate with health state^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,12,0)
 ;;=1604^give verbal/written directions for desired fluid amts.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,13,0)
 ;;=1605^include patient and S/O in recording I/O^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,14,0)
 ;;=1606^normal saline irrigation to gastric tube q[ ]hrs.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,15,0)
 ;;=1607^offer mouth swabs if NPO or on gastric tube q [ ] hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,16,0)
 ;;=1608^weigh dressings to record wound loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,17,0)
 ;;=1609^replace fluids [ ]cc for [ ]cc drainage q[ ]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,19,0)
 ;;=1614^give small, frequent amts. of clear liquids if nauseated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,21,0)
 ;;=321^TPR q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,23,0)
 ;;=6611^[Extra Order]^3^NURSC^134
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,24,0)
 ;;=335^mouth care q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,25,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6578,0)
 ;;=monitor laboratory data q[frequency]:^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6578,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,6578,1,1,0)
 ;;=1597^CBC^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6578,1,2,0)
 ;;=1598^electrolytes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6578,1,3,0)
 ;;=1599^total serum protein^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6578,1,4,0)
 ;;=1600^urine specific gravity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6578,4)
 ;;=assess, document &
 ;;^UTILITY("^GMRD(124.2,",$J,6578,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,6578,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6578,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6578,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6611,0)
 ;;=[Extra Order]^3^NURSC^11^134^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6611,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6611,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6612,0)
 ;;=Defining Characteristics^2^NURSC^12^86^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,0)
 ;;=^124.21PI^9^6
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,2,0)
 ;;=4072^intake altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,3,0)
 ;;=4073^thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,6,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,7,0)
 ;;=4199^skin turgor decreased^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,8,0)
 ;;=4201^urine output altered (diluted, increased or decreased)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,1,9,0)
 ;;=9584^loss of blood from gastrointestinal tract^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6612,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6621,0)
 ;;=Tissue Perfusion, Alteration in^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6621,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,6621,1,1,0)
 ;;=6622^Etiology/Related and/or Risk Factors^2^NURSC^259
 ;;^UTILITY("^GMRD(124.2,",$J,6621,1,2,0)
 ;;=6624^Goals/Expected Outcomes^2^NURSC^270
 ;;^UTILITY("^GMRD(124.2,",$J,6621,1,3,0)
 ;;=6628^Nursing Intervention/Orders^2^NURSC^272
 ;;^UTILITY("^GMRD(124.2,",$J,6621,7)
 ;;=D EN3^NURCCPU0
