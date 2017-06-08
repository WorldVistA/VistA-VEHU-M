NURCCGAE ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,6088,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6099,0)
 ;;=[Extra Goal]^3^NURSC^9^122^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6099,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6099,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6100,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^172^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6100,1,0)
 ;;=^124.21PI^33^5
 ;;^UTILITY("^GMRD(124.2,",$J,6100,1,14,0)
 ;;=332^out of bed q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6100,1,18,0)
 ;;=432^provide for relief of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6100,1,31,0)
 ;;=6158^[Extra Order]^3^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,6100,1,32,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6100,1,33,0)
 ;;=16563^cough/turn/deep breathe q[specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,6100,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6100,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6158,0)
 ;;=[Extra Order]^3^NURSC^11^126^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6158,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,6158,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6159,0)
 ;;=Defining Characteristics^2^NURSC^12^79^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6159,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6159,1,1,0)
 ;;=1465^dyspnea^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6159,1,2,0)
 ;;=996^shortness of breath^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6159,1,3,0)
 ;;=4077^abnormal arterial blood gases^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6159,1,4,0)
 ;;=4079^respiratory depth changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6159,1,5,0)
 ;;=4040^cyanosis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6159,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6165,0)
 ;;=Skin Integrity, Impairment Of (Actual)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,6165,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,6165,1,1,0)
 ;;=6166^Etiology/Related and/or Risk Factors^2^NURSC^86
 ;;^UTILITY("^GMRD(124.2,",$J,6165,1,2,0)
 ;;=6184^Goals/Expected Outcomes^2^NURSC^85
 ;;^UTILITY("^GMRD(124.2,",$J,6165,1,3,0)
 ;;=6194^Nursing Intervention/Orders^2^NURSC^77
 ;;^UTILITY("^GMRD(124.2,",$J,6165,1,4,0)
 ;;=6223^Related Problems^2^NURSC^74
 ;;^UTILITY("^GMRD(124.2,",$J,6165,1,5,0)
 ;;=6227^Defining Characteristics^2^NURSC^80
 ;;^UTILITY("^GMRD(124.2,",$J,6165,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,6165,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,6165,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,6165,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,6165,"TD",1,0)
 ;;=A state in which the individual's skin is adversely altered.
 ;;^UTILITY("^GMRD(124.2,",$J,6166,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^86^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,0)
 ;;=^124.21PI^17^14
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,2,0)
 ;;=1768^hyperthermia or hypothermia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,3,0)
 ;;=825^mechanical factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,4,0)
 ;;=826^physical immobilization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,5,0)
 ;;=1771^pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,6,0)
 ;;=1773^restraint^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,7,0)
 ;;=1774^shearing factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,8,0)
 ;;=1776^alteration in skin turgor (change in elasticity)^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,9,0)
 ;;=1778^altered nutritional state (e.g. obesity,emaciation)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,10,0)
 ;;=1780^altered metabolic state^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,11,0)
 ;;=1781^edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,6166,1,12,0)
 ;;=1783^excretions/secretions^3^NURSC^1
