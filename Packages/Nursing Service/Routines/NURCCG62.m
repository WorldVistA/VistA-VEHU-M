NURCCG62 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,1,0)
 ;;=2721^assess causative, contributing factors^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,2,0)
 ;;=619^provide privacy and assure confidentiality^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,3,0)
 ;;=620^establish a trusting relationship^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,4,0)
 ;;=2722^assist with identifying current stressors in life^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,5,0)
 ;;=2723^provide information regarding an altered body function^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,6,0)
 ;;=2724^adapt plan to patient's lifestyle^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,7,0)
 ;;=2725^discuss relationship problems^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,8,0)
 ;;=2736^assist with methods for dispersing sexual energy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,9,0)
 ;;=2737^teach patient and/or S/O ^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,10,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,1,11,0)
 ;;=3017^[Extra Order]^3^NURSC^103^0
 ;;^UTILITY("^GMRD(124.2,",$J,2444,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2444,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2445,0)
 ;;=verbalizes acceptance of self-limitations in sex matters^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2445,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2445,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2446,0)
 ;;=verbalizes confidence/ability to resume satisfactory sex^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2446,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2446,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2447,0)
 ;;=verbalizes knowledge of methods of contraception^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2447,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2447,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2448,0)
 ;;=verbalizes methods to prevent sexually transmitted diseases^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2448,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2448,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2449,0)
 ;;=identifies stressors related to altered sexual pattern^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2449,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2449,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2450,0)
 ;;=identifies practices that conserve energy when having sex ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2450,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2450,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2451,0)
 ;;=assess S/S of sleep-pattern disturbance^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,1,0)
 ;;=2452^early morning headache^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,2,0)
 ;;=2453^increasing irritability ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,3,0)
 ;;=2454^restlessness, changes in position^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,4,0)
 ;;=2455^disorientation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,5,0)
 ;;=1245^lethargy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,6,0)
 ;;=2456^listlessness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,7,0)
 ;;=2457^mild fleeting nystagmus^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,8,0)
 ;;=2458^slight hand tremors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,9,0)
 ;;=2459^ptosis of eyelids^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,10,0)
 ;;=2460^dark circles under the eyes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,11,0)
 ;;=2461^frequent yawning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2451,1,12,0)
 ;;=2462^loud snoring^3^NURSC^1^0
