NURCCG1E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,499,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^12^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,499,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,499,1,1,0)
 ;;=503^alteration in conduction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,499,1,2,0)
 ;;=504^alteration in rate^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,499,1,3,0)
 ;;=505^alteration in rhythm^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,499,1,4,0)
 ;;=506^electrophysiological disturbances in impulse formation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,499,1,5,0)
 ;;=507^electrophysiological disturbances in cardiac conduction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,499,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,500,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,1,0)
 ;;=508^returns to and maintains NSR or pacing rhythm^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,2,0)
 ;;=509^maintains cardiac output^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,3,0)
 ;;=510^maintains therapeutic levels of antiarrhythmic agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,4,0)
 ;;=511^avoids toxicity/allergic reactions to drugs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,5,0)
 ;;=512^limits myocardial infarction area^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,6,0)
 ;;=513^avoids metabolic death^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,1,7,0)
 ;;=2877^[Extra Goal]^3^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,500,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,501,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^9^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,1,0)
 ;;=1216^heart rate/rhythm q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,2,0)
 ;;=1221^assess for presence of pulse deficit q[frequency] hrs.^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,3,0)
 ;;=1222^monitor for warning dysrhythmia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,4,0)
 ;;=1242^monitor for Lidocaine toxicity^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,5,0)
 ;;=1250^laboratory data^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,6,0)
 ;;=1258^warning ventricular dysrhythmia interventions ^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,7,0)
 ;;=1287^symptomatic bradycardia interventions ^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,8,0)
 ;;=1297^complete heart block interventions ^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,9,0)
 ;;=1357^lethal dysrhythmia (no pulse/respirations) interventions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,10,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,1,11,0)
 ;;=2964^[Extra Order]^3^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,501,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,501,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,502,0)
 ;;=Related Problems^2^NURSC^7^10^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,502,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,502,1,1,0)
 ;;=1394^Activity Intolerance (Circulatory System)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,502,1,2,0)
 ;;=1396^Fluid Volume Deficit (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,502,1,3,0)
 ;;=1397^Fluid Volume Excess (Actual/Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,502,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,503,0)
 ;;=alteration in conduction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,504,0)
 ;;=alteration in rate^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,505,0)
 ;;=alteration in rhythm^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,506,0)
 ;;=electrophysiological disturbances in impulse formation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,507,0)
 ;;=electrophysiological disturbances in cardiac conduction^3^NURSC^^1^^^T
