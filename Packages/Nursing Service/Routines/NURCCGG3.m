NURCCGG3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15210,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15210,1,1,0)
 ;;=2560^public meal programs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15210,1,2,0)
 ;;=2561^family support^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15210,1,3,0)
 ;;=2562^social welfare programs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15210,1,4,0)
 ;;=2563^self-care ability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15210,5)
 ;;=through:
 ;;^UTILITY("^GMRD(124.2,",$J,15210,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15210,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15210,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15215,0)
 ;;=[Extra Goal]^3^NURSC^9^254^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15215,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15215,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^166^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,0)
 ;;=^124.21PI^22^19
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,1,0)
 ;;=2565^assess food source and abilities to prepare meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,2,0)
 ;;=2566^assess eating patterns, satiety levels^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,3,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,4,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,5,0)
 ;;=2567^assess need for calorie count q[specify frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,7,0)
 ;;=2571^minimize noxious stimuli in environment^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,8,0)
 ;;=2572^restrict liquid intake to [ ]cc before meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,9,0)
 ;;=2573^provide nourishment at [ ] am and [ ] pm^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,10,0)
 ;;=2574^frequent cool clear liquids [ ]cc every [ ] hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,11,0)
 ;;=2575^elevate head to [ ] degrees for [ ] min. after meals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,12,0)
 ;;=2576^provide rest periods after meals for [ ] hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,13,0)
 ;;=2577^provide financial resource contact for food purchase^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,15,0)
 ;;=2539^provide pt. education resources on nutrition as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,16,0)
 ;;=2581^teach suppression of vomiting reflex^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,17,0)
 ;;=15668^[Extra Order]^3^NURSC^265
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,18,0)
 ;;=15302^assess,monitor,document laboratory values^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,20,0)
 ;;=289^refer for appropriate consults^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,21,0)
 ;;=4959^administer medications as ordered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,1,22,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15216,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15239,0)
 ;;=[Extra Order]^3^NURSC^11^260^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15239,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15239,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15240,0)
 ;;=Defining Characteristics^2^NURSC^12^177^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15240,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15240,1,1,0)
 ;;=15241^body weight 20% or more under ideal^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15240,1,2,0)
 ;;=15242^reported food intake under RDA^3^NURSC^8
 ;;^UTILITY("^GMRD(124.2,",$J,15240,1,3,0)
 ;;=15243^reported/observed lack of food^3^NURSC^8
