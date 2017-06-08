NURCCGFN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14619,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14631,0)
 ;;=assess for complications of mechanical ventilation^2^NURSC^11^15^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14631,1,1,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,1,2,0)
 ;;=439^tube displacement^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,1,3,0)
 ;;=440^GI bleed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,1,4,0)
 ;;=441^pneumothorax^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,1,5,0)
 ;;=442^subcutaneous emphysema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,5)
 ;;=; monitor and document:
 ;;^UTILITY("^GMRD(124.2,",$J,14631,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14631,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14631,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14641,0)
 ;;=bronchial hygiene q[frequency]hrs^2^NURSC^11^15^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,14641,1,0)
 ;;=^124.21PI^9^4
 ;;^UTILITY("^GMRD(124.2,",$J,14641,1,3,0)
 ;;=2705^postural drainage q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14641,1,4,0)
 ;;=430^percussion q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14641,1,8,0)
 ;;=4766^vibrations q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14641,1,9,0)
 ;;=4767^cough/turn/deep breathe q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14641,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14641,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14641,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14655,0)
 ;;=refer for appropriate consults^2^NURSC^11^79^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,14655,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14655,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14655,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14664,0)
 ;;=[Extra Order]^3^NURSC^11^253^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14664,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14664,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14665,0)
 ;;=Defining Characteristics^2^NURSC^12^171^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,1,0)
 ;;=4099^confusion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,2,0)
 ;;=4100^irritability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,4,0)
 ;;=4103^somnolence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,5,0)
 ;;=4104^hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,1,6,0)
 ;;=4105^hypoxia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14665,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14672,0)
 ;;=Infection Potential^2^NURSC^2^10^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14672,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,14672,1,1,0)
 ;;=14673^Etiology/Related and/or Risk Factors^2^NURSC^195
 ;;^UTILITY("^GMRD(124.2,",$J,14672,1,2,0)
 ;;=14703^Goals/Expected Outcomes^2^NURSC^192
