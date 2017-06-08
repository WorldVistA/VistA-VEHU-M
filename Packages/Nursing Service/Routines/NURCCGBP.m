NURCCGBP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,8378,1,2,0)
 ;;=1820^S/S of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8378,1,3,0)
 ;;=2750^personal hygiene measures as indicated [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8378,1,7,0)
 ;;=2941^evaluate effectiveness of teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8378,1,8,0)
 ;;=2942^implement teaching plan based on readiness/ability to learn^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8378,1,9,0)
 ;;=2943^involve S/O in teaching plan^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,8378,5)
 ;;=including:
 ;;^UTILITY("^GMRD(124.2,",$J,8378,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8378,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8378,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8398,0)
 ;;=[Extra Order]^3^NURSC^11^149^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8398,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8398,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8400,0)
 ;;=assess,monitor,document peak flow q[specify] ^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8400,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8400,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8425,0)
 ;;=bronchial hygiene:^2^NURSC^11^26^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8425,1,0)
 ;;=^124.21PI^8^5
 ;;^UTILITY("^GMRD(124.2,",$J,8425,1,1,0)
 ;;=8426^vibration q [specify] hrs^3^NURSC^27
 ;;^UTILITY("^GMRD(124.2,",$J,8425,1,2,0)
 ;;=8427^postural drainage q [specify] hrs^3^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,8425,1,3,0)
 ;;=4767^cough/turn/deep breathe q[specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8425,1,5,0)
 ;;=430^percussion q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8425,1,8,0)
 ;;=8433^deep breathe q [specify]^3^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,8425,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,8425,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8425,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8425,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8426,0)
 ;;=vibration q [specify] hrs^3^NURSC^^27^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8427,0)
 ;;=postural drainage q [specify] hrs^3^NURSC^^26^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8433,0)
 ;;=deep breathe q [specify]^3^NURSC^^26^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8434,0)
 ;;=[Extra Order]^3^NURSC^11^150^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8434,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,8434,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,8440,0)
 ;;=Defining Characteristics^2^NURSC^12^102^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,8440,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,8447,0)
 ;;=Breathing Pattern, Ineffective^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,8447,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,8447,1,1,0)
 ;;=8448^Etiology/Related and/or Risk Factors^2^NURSC^116
 ;;^UTILITY("^GMRD(124.2,",$J,8447,1,2,0)
 ;;=8457^Related Problems^2^NURSC^98
 ;;^UTILITY("^GMRD(124.2,",$J,8447,1,3,0)
 ;;=8462^Goals/Expected Outcomes^2^NURSC^114
 ;;^UTILITY("^GMRD(124.2,",$J,8447,1,4,0)
 ;;=8474^Nursing Intervention/Orders^2^NURSC^184
 ;;^UTILITY("^GMRD(124.2,",$J,8447,1,5,0)
 ;;=8552^Defining Characteristics^2^NURSC^103
 ;;^UTILITY("^GMRD(124.2,",$J,8447,7)
 ;;=D EN3^NURCCPU0
