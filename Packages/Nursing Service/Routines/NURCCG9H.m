NURCCG9H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4992,0)
 ;;=[Extra Order]^3^NURSC^11^305^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4992,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4992,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4993,0)
 ;;=[Extra Goal]^3^NURSC^9^34^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4993,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4993,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4994,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^248^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4994,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4994,1,1,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4994,1,2,0)
 ;;=5005^review factors that aggravate or alleviate pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4994,1,3,0)
 ;;=4599^teach pain control interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4994,1,4,0)
 ;;=5035^[Extra Order]^3^NURSC^34
 ;;^UTILITY("^GMRD(124.2,",$J,4994,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4994,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4995,0)
 ;;=Manic Behavior^2^NURSC^8^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4995,1,0)
 ;;=^124.21PI^5^2
 ;;^UTILITY("^GMRD(124.2,",$J,4995,1,4,0)
 ;;=5390^Manic Behavior^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4995,1,5,0)
 ;;=5576^[Extra Problem]^2^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,4997,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^249^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,0)
 ;;=^124.21PI^14^13
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,1,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,2,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,4,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,5,0)
 ;;=4430^assess heart sounds q[frequency]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,6,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,7,0)
 ;;=4433^assess assistance needed with ADL q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,8,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,9,0)
 ;;=4438^monitor lab values^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,10,0)
 ;;=5016^[Extra Order]^3^NURSC^227
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,11,0)
 ;;=283^administer oxygen/cannula at [specify]L/min or mask at [ ]%^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,12,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,13,0)
 ;;=5021^assess for S/S of weakness or fatigue q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,1,14,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4997,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4998,0)
 ;;=reports/demonstrates return to usual sleep pattern^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4998,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4998,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4999,0)
 ;;=decrease in motor behavior^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4999,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4999,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5000,0)
 ;;=maintains/attains usual body weight^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5000,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5000,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5001,0)
 ;;=demonstrates ability to complete a structured activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5001,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5001,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5002,0)
 ;;=develops plan to manage mood changes^3^NURSC^9^1^^^T
