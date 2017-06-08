NURCCGB5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7457,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7457,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7486,0)
 ;;=teach patient^2^NURSC^11^9^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,0)
 ;;=^124.21PI^11^9
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,1,0)
 ;;=1558^S/S of fluid overload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,2,0)
 ;;=1559^taking and recording blood pressure as indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,3,0)
 ;;=7489^sodium/protein restrictions^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,4,0)
 ;;=1561^shift of body weight q 15-30 minutes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,5,0)
 ;;=1563^elevate extremities  [ ] (i.e., RL, LL, RA, LA)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,6,0)
 ;;=1564^prevent leg or ankle crossing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,7,0)
 ;;=1565^use of antihypertensives^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,8,0)
 ;;=2947^avoid constrictive clothing^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7486,1,11,0)
 ;;=15528^weigh qd @ home (avoid 4# wt gain between tx)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,5)
 ;;=the following
 ;;^UTILITY("^GMRD(124.2,",$J,7486,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7486,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7486,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7489,0)
 ;;=sodium/protein restrictions^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7496,0)
 ;;=refer for appropriate consults^2^NURSC^11^19^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,2,0)
 ;;=297^Chaplain Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,3,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,4,0)
 ;;=1927^Physical Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,5,0)
 ;;=1929^Corrective Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,6,0)
 ;;=2649^Respiratory Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,7,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,1,8,0)
 ;;=2718^Speech Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,5)
 ;;=specifically
 ;;^UTILITY("^GMRD(124.2,",$J,7496,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7496,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7496,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7507,0)
 ;;=[Extra Order]^3^NURSC^11^139^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7507,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7507,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7508,0)
 ;;=Defining Characteristics^2^NURSC^12^93^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,1,0)
 ;;=4053^shortness of breath, orthopnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,2,0)
 ;;=4054^abnormal breath sounds; crackles (rales), wheezes (rhonchi)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,3,0)
 ;;=4056^BP, CVP, PAP changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,4,0)
 ;;=4059^changes in mental status; restlessness, anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,5,0)
 ;;=988^oliguria^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,1,6,0)
 ;;=4064^weight gain, edema, anasarca^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7508,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7515,0)
 ;;=verbalizes knowledge use/abuse causes withdrawal syndrome^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7515,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7515,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7516,0)
 ;;=Infection Potential^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7516,1,0)
 ;;=^124.21PI^3^3
