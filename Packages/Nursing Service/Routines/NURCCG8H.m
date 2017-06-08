NURCCG8H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4509,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^209^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4509,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4509,1,1,0)
 ;;=1050^myocardial ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4509,1,2,0)
 ;;=4353^anxiety/threat of death^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4509,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4510,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^209^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,1,0)
 ;;=4362^verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,3,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,4,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,5,0)
 ;;=2025^reports decrease in signs/symptoms of anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4510,1,6,0)
 ;;=4516^[Extra Goal]^3^NURSC^209
 ;;^UTILITY("^GMRD(124.2,",$J,4510,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4511,0)
 ;;=[Extra Order]^3^NURSC^11^276^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4511,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4511,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4512,0)
 ;;=[Extra Order]^3^NURSC^11^277^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4512,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4512,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4513,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^210^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,1,0)
 ;;=392^administer pain medication as needed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,2,0)
 ;;=4417^instruct patient to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,3,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,4,0)
 ;;=4424^teach splinting to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,5,0)
 ;;=3149^assess for S/S of increased anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,6,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4513,1,7,0)
 ;;=4533^[Extra Order]^3^NURSC^210
 ;;^UTILITY("^GMRD(124.2,",$J,4513,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4513,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4514,0)
 ;;=assess, monitor & record:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4514,1,1,0)
 ;;=4535^I&O, site & character q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,1,2,0)
 ;;=4538^skin turgor & oral mucous membranes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,1,3,0)
 ;;=1196^specific gravity q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,1,4,0)
 ;;=4545^VS & BP lying and standing q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,1,5,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4514,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4514,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4516,0)
 ;;=[Extra Goal]^3^NURSC^9^209^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4516,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4516,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4518,0)
 ;;=[Extra Goal]^3^NURSC^9^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4518,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4518,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4522,0)
 ;;=[Extra Goal]^3^NURSC^9^7^^^T
