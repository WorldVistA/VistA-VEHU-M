NURCCG8A ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4403,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4404,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^201^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4404,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4404,1,1,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4404,1,2,0)
 ;;=330^elevate head of bed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4404,1,3,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4404,1,4,0)
 ;;=4461^cough and deep breath q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4404,1,5,0)
 ;;=4483^[Extra Order]^3^NURSC^42
 ;;^UTILITY("^GMRD(124.2,",$J,4404,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4404,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4405,0)
 ;;=electrophysiological disturbance/impulse formation/conduct^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4406,0)
 ;;=[Extra Problem]^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4406,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4406,1,1,0)
 ;;=4408^Etiology/Related and/or Risk Factors^2^NURSC^205
 ;;^UTILITY("^GMRD(124.2,",$J,4406,1,2,0)
 ;;=4457^Goals/Expected Outcomes^2^NURSC^206
 ;;^UTILITY("^GMRD(124.2,",$J,4406,1,3,0)
 ;;=4459^Nursing Intervention/Orders^2^NURSC^205
 ;;^UTILITY("^GMRD(124.2,",$J,4406,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4406,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4406,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^202^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,1,0)
 ;;=4413^assess,monitor & document by location,duration,frequency q[]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,2,0)
 ;;=4417^instruct patient to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,3,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,4,0)
 ;;=4424^teach splinting to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,5,0)
 ;;=3149^assess for S/S of increased anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,6,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,7,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,8,0)
 ;;=1562^apply antiemboli hose q [frequency] hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,9,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,1,10,0)
 ;;=4569^[Extra Order]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4407,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4408,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^205^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4408,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4408,1,1,0)
 ;;=4484^[etiology]^3^NURSC^21
 ;;^UTILITY("^GMRD(124.2,",$J,4408,1,2,0)
 ;;=4486^[etiology]^3^NURSC^25
 ;;^UTILITY("^GMRD(124.2,",$J,4408,1,3,0)
 ;;=4487^[etiology]^3^NURSC^26
 ;;^UTILITY("^GMRD(124.2,",$J,4408,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,0)
 ;;=assess,monitor,document hemodynamics ^2^NURSC^11^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,1,0)
 ;;=4382^Cardiac Output (CO) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,2,0)
 ;;=4380^Cardiac Index (CI) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,3,0)
 ;;=4412^systemic vascular resistance [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,4,0)
 ;;=4384^PAWP pulmonary artery wedge pressure [specify range]^3^NURSC^1
