NURCCG8G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4497,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4498,0)
 ;;=maintain baseline heart rhythm/NSR^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4498,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4498,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4499,0)
 ;;=[etiology]^3^NURSC^^122^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4500,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^208^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,0)
 ;;=^124.21PI^14^10
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,2,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,4,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,6,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,7,0)
 ;;=4430^assess heart sounds q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,8,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,10,0)
 ;;=4433^assess assistance needed with ADL q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,11,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,12,0)
 ;;=4560^assess,monitor lab values: lytes, BUN, creatinine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,13,0)
 ;;=4563^initiate lethal dysrhythmia protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,1,14,0)
 ;;=4737^[Extra Order]^3^NURSC^29
 ;;^UTILITY("^GMRD(124.2,",$J,4500,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4500,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4501,0)
 ;;=[etiology]^3^NURSC^^123^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4502,0)
 ;;=maintains fluid/electrolyte balance^2^NURSC^9^3^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4502,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,4502,1,1,0)
 ;;=1519^balanced I/O, urine ouput WNL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4502,1,5,0)
 ;;=4557^stable B/P^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4502,1,6,0)
 ;;=1520^decreased edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4502,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4502,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4502,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4504,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^208^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4504,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4504,1,1,0)
 ;;=4505^[Extra Goal]^3^NURSC^269
 ;;^UTILITY("^GMRD(124.2,",$J,4504,1,2,0)
 ;;=4506^[Extra Goal]^3^NURSC^270
 ;;^UTILITY("^GMRD(124.2,",$J,4504,1,3,0)
 ;;=4507^[Extra Goal]^3^NURSC^271
 ;;^UTILITY("^GMRD(124.2,",$J,4504,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4505,0)
 ;;=[Extra Goal]^3^NURSC^9^269^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4505,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4505,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4506,0)
 ;;=[Extra Goal]^3^NURSC^9^270^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4506,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4506,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4507,0)
 ;;=[Extra Goal]^3^NURSC^9^271^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4507,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4507,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4508,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^209^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4508,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4508,1,1,0)
 ;;=4511^[Extra Order]^3^NURSC^276
 ;;^UTILITY("^GMRD(124.2,",$J,4508,1,2,0)
 ;;=4512^[Extra Order]^3^NURSC^277
 ;;^UTILITY("^GMRD(124.2,",$J,4508,1,3,0)
 ;;=4524^[Extra Order]^3^NURSC^278
 ;;^UTILITY("^GMRD(124.2,",$J,4508,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4508,9)
 ;;=D EN1^NURCCPU2
