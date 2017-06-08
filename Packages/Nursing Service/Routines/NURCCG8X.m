NURCCG8X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4739,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4739,1,1,0)
 ;;=4692^demonstrates skills & verbalizes knowledge in:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4739,1,2,0)
 ;;=4744^[Extra Goal]^3^NURSC^215
 ;;^UTILITY("^GMRD(124.2,",$J,4739,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4740,0)
 ;;=[Extra Goal]^3^NURSC^9^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4740,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4740,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4741,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^222^1^1^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4741,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4741,1,1,0)
 ;;=4745^[etiology]^3^NURSC^10
 ;;^UTILITY("^GMRD(124.2,",$J,4741,1,2,0)
 ;;=4747^[etiology]^3^NURSC^11
 ;;^UTILITY("^GMRD(124.2,",$J,4741,1,3,0)
 ;;=4774^[etiology]^3^NURSC^79
 ;;^UTILITY("^GMRD(124.2,",$J,4741,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^226^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,0)
 ;;=^124.21PI^13^12
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,1,0)
 ;;=325^ABGs/pulse oximetry q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,2,0)
 ;;=4428^assess,monitor,document V/S^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,3,0)
 ;;=4650^activity: chair q[frequency] or ambulate q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,4,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,5,0)
 ;;=2702^bronchial hygiene q[frequency]hrs^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,6,0)
 ;;=387^suction q[frequency] and/or PRN^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,7,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,8,0)
 ;;=4768^turn,cough,deep breath q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,10,0)
 ;;=4477^assess level of consciousness q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,11,0)
 ;;=429^reposition/turn q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,12,0)
 ;;=4443^assess weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,1,13,0)
 ;;=4851^[Extra Order]^3^NURSC^48
 ;;^UTILITY("^GMRD(124.2,",$J,4742,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4742,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4743,0)
 ;;=[etiology]^3^NURSC^^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4744,0)
 ;;=[Extra Goal]^3^NURSC^9^215^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4744,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4744,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4745,0)
 ;;=[etiology]^3^NURSC^^10^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4746,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^227^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,1,0)
 ;;=4713^implement health teaching protocol^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,2,0)
 ;;=4751^explain diagnostic procedures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,3,0)
 ;;=4753^teach self-BP if indicated^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,4,0)
 ;;=4754^avoid excessive temperatures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,5,0)
 ;;=4756^caution regarding potential drug interactions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,6,0)
 ;;=4761^seek care for S/S ie.,dizziness,headache,blurred vision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,7,0)
 ;;=4762^teach complications of anti-hypertensive drugs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,8,0)
 ;;=1894^avoid constrictive clothing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,9,0)
 ;;=1868^avoid prolonged sitting/standing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4746,1,10,0)
 ;;=4880^[Extra Order]^3^NURSC^49
