NURCCGEF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13077,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13077,1,1,0)
 ;;=13079^[Extra Order]^3^NURSC^381
 ;;^UTILITY("^GMRD(124.2,",$J,13077,1,2,0)
 ;;=13082^[Extra Order]^3^NURSC^382
 ;;^UTILITY("^GMRD(124.2,",$J,13077,1,3,0)
 ;;=13084^[Extra Order]^3^NURSC^383
 ;;^UTILITY("^GMRD(124.2,",$J,13077,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13077,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13079,0)
 ;;=[Extra Order]^3^NURSC^11^381^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13079,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13079,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13082,0)
 ;;=[Extra Order]^3^NURSC^11^382^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13082,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13082,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13084,0)
 ;;=[Extra Order]^3^NURSC^11^383^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13084,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13084,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13089,0)
 ;;=[Extra Goal]^3^NURSC^9^224^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13089,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13089,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13090,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^147^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,0)
 ;;=^124.21PI^39^6
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,33,0)
 ;;=13570^[Extra Order]^3^NURSC^240
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,34,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,35,0)
 ;;=4818^assess,monitor,document sputum color/consistancy/amount q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,36,0)
 ;;=329^administer bronchodilators as ordered^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,37,0)
 ;;=4768^turn,cough,deep breath q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13090,1,39,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13090,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13090,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13151,0)
 ;;=[Extra Order]^3^NURSC^11^235^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13151,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13151,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13157,0)
 ;;=Defining Characteristics^2^NURSC^12^152^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,1,0)
 ;;=4036^cough effective with or without sputum^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,2,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,3,0)
 ;;=4038^breath sounds abnormal ie., wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,4,0)
 ;;=4039^cough ineffective with or without wheezing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,1,6,0)
 ;;=1468^tachypnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13157,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13164,0)
 ;;=Tissue Perfusion, Alteration In^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13164,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13164,1,1,0)
 ;;=13165^Etiology/Related and/or Risk Factors^2^NURSC^176
 ;;^UTILITY("^GMRD(124.2,",$J,13164,1,2,0)
 ;;=13170^Related Problems^2^NURSC^152
 ;;^UTILITY("^GMRD(124.2,",$J,13164,1,3,0)
 ;;=13174^Goals/Expected Outcomes^2^NURSC^174
 ;;^UTILITY("^GMRD(124.2,",$J,13164,1,4,0)
 ;;=13192^Nursing Intervention/Orders^2^NURSC^195
 ;;^UTILITY("^GMRD(124.2,",$J,13164,1,5,0)
 ;;=13275^Defining Characteristics^2^NURSC^153
 ;;^UTILITY("^GMRD(124.2,",$J,13164,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13164,9)
 ;;=D EN2^NURCCPU3
