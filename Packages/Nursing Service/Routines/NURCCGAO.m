NURCCGAO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6539,1,5,0)
 ;;=6612^Defining Characteristics^2^NURSC^86
 ;;^UTILITY("^GMRD(124.2,",$J,6539,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6539,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6539,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6540,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^92^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,0)
 ;;=^124.21PI^10^6
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,1,0)
 ;;=1569^deviation affecting access, intake, absorption of fluids^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,2,0)
 ;;=1570^excessive loss through normal routes (e.g., diarrhea)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,4,0)
 ;;=1572^extremes of weight^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,7,0)
 ;;=1575^medications^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,9,0)
 ;;=2645^failure of regulatory mechanisms^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6540,1,10,0)
 ;;=6550^loss of fluids though abnormal routes (G.I. bleed)^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6540,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6550,0)
 ;;=loss of fluids though abnormal routes (G.I. bleed)^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6551,0)
 ;;=Related Problems^2^NURSC^7^78^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6551,1,0)
 ;;=^124.21PI^7^2
 ;;^UTILITY("^GMRD(124.2,",$J,6551,1,3,0)
 ;;=1578^Oral Mucous Membrane, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6551,1,7,0)
 ;;=438^Hypotension^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6551,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6558,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^91^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6558,1,0)
 ;;=^124.21PI^3^2
 ;;^UTILITY("^GMRD(124.2,",$J,6558,1,1,0)
 ;;=6559^maintains fluid/electrolyte balance:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6558,1,3,0)
 ;;=6655^[Extra Goal]^3^NURSC^129
 ;;^UTILITY("^GMRD(124.2,",$J,6558,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,0)
 ;;=maintains fluid/electrolyte balance:^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,1,0)
 ;;=6560^balanced I/O^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,2,0)
 ;;=1582^skin turgor normal^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,3,0)
 ;;=1583^weight is greater than [lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,4,0)
 ;;=1584^weight is less than [lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,5,0)
 ;;=1432^lab data (e.g. CBC, differential) is WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,6,0)
 ;;=1585^moist mucous membranes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,1,7,0)
 ;;=1586^urine and specific gravity WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,6559,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6559,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6559,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6560,0)
 ;;=balanced I/O^3^NURSC^^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6570,0)
 ;;=[Extra Goal]^3^NURSC^9^128^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6570,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6570,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^79^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,0)
 ;;=^124.21PI^25^20
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,1,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,2,0)
 ;;=1591^assess skin turgor and oral mucous membrane^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,3,0)
 ;;=1592^report urinary output if less than [ ]cc/hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,5,0)
 ;;=1594^assess for presence/amt. of edema q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6571,1,6,0)
 ;;=1595^B/P lying and standing q[frequency]hrs^3^NURSC^1
