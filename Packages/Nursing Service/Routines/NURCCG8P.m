NURCCG8P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4631,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4631,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4631,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4632,0)
 ;;=[Extra Goal]^3^NURSC^9^29^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4632,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4632,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4633,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^214^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4633,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4633,1,1,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4633,1,2,0)
 ;;=2696^ventilation, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4633,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4634,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^215^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4634,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4634,1,1,0)
 ;;=4639^excessive Na intake related to metabolic needs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4634,1,2,0)
 ;;=2585^hereditary disposition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4634,1,3,0)
 ;;=4641^fluid volume excess^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4634,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4636,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^217^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,1,0)
 ;;=1846^peripheral pulses q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,2,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,3,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,4,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,5,0)
 ;;=4646^fluid restriction [specify amt]cc q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4636,1,6,0)
 ;;=4649^[Extra Order]^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,4636,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4636,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4637,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^217^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4637,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4637,1,1,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4637,1,2,0)
 ;;=4642^free of paradoxical breathing/respiratory alternans^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4637,1,3,0)
 ;;=4701^[Extra Goal]^3^NURSC^16
 ;;^UTILITY("^GMRD(124.2,",$J,4637,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4638,0)
 ;;=[Extra Goal]^3^NURSC^9^212^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4638,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4638,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4639,0)
 ;;=excessive Na intake related to metabolic needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4641,0)
 ;;=fluid volume excess^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4642,0)
 ;;=free of paradoxical breathing/respiratory alternans^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4642,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4642,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4643,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^218^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4643,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4643,1,1,0)
 ;;=4648^maintains caloric intake of [calories] day^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4643,1,2,0)
 ;;=2596^selects menu within dietary restrictions^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4643,1,3,0)
 ;;=4692^demonstrates skills & verbalizes knowledge in:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4643,1,4,0)
 ;;=4740^[Extra Goal]^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4643,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4644,0)
 ;;=[Extra Goal]^3^NURSC^9^2^^^T
