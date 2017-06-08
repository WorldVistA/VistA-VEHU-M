NURCCG8D ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,1,0)
 ;;=2566^assess eating patterns, satiety levels^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,2,0)
 ;;=4811^initiate consult to dietary service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,3,0)
 ;;=2573^provide nourishment at [ ] am and [ ] pm^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,4,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,5,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,6,0)
 ;;=4820^reinforce dietary & fluid restrictions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,1,7,0)
 ;;=4651^[Extra Order]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4450,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4450,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4451,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^12^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4451,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4451,1,1,0)
 ;;=4453^Etiology/Related and/or Risk Factors^2^NURSC^206
 ;;^UTILITY("^GMRD(124.2,",$J,4451,1,2,0)
 ;;=4455^Goals/Expected Outcomes^2^NURSC^205
 ;;^UTILITY("^GMRD(124.2,",$J,4451,1,3,0)
 ;;=4460^Nursing Intervention/Orders^2^NURSC^206
 ;;^UTILITY("^GMRD(124.2,",$J,4451,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4451,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4451,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4453,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^206^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4453,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4453,1,1,0)
 ;;=419^anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4453,1,2,0)
 ;;=421^decreased lung expansion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4453,1,3,0)
 ;;=211^pain, discomfort^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4453,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4455,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^205^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4455,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4455,1,1,0)
 ;;=424^remains free from S/S of hypoxia and hypercapnia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4455,1,2,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4455,1,3,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4455,1,4,0)
 ;;=4469^[Extra Goal]^3^NURSC^208
 ;;^UTILITY("^GMRD(124.2,",$J,4455,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4457,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^206^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4457,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4457,1,1,0)
 ;;=4488^[Extra Goal]^3^NURSC^266
 ;;^UTILITY("^GMRD(124.2,",$J,4457,1,2,0)
 ;;=4489^[Extra Goal]^3^NURSC^267
 ;;^UTILITY("^GMRD(124.2,",$J,4457,1,3,0)
 ;;=4491^[Extra Goal]^3^NURSC^268
 ;;^UTILITY("^GMRD(124.2,",$J,4457,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4459,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^205^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4459,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4459,1,1,0)
 ;;=4494^[Extra Order]^3^NURSC^273
 ;;^UTILITY("^GMRD(124.2,",$J,4459,1,2,0)
 ;;=4495^[Extra Order]^3^NURSC^274
 ;;^UTILITY("^GMRD(124.2,",$J,4459,1,3,0)
 ;;=4496^[Extra Order]^3^NURSC^275
 ;;^UTILITY("^GMRD(124.2,",$J,4459,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4459,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4460,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^206^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,1,0)
 ;;=4461^cough and deep breath q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,2,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4460,1,3,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
