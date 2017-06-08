NURCCG1Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,615,0)
 ;;=relates confidence to resume satisfying sexual activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,615,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,615,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,616,0)
 ;;=relates ability to resume satisfying sexual activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,616,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,616,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,617,0)
 ;;=identifies stressors in life related to sexual dysfunction^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,617,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,617,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,618,0)
 ;;=elicit personal information about sexual history^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,618,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,618,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,619,0)
 ;;=provide privacy and assure confidentiality^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,619,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,619,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,620,0)
 ;;=establish a trusting relationship^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,620,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,620,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,621,0)
 ;;=discuss sexual activity limitations^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,621,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,621,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,622,0)
 ;;=discuss the varied etiologies of impotence^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,1,0)
 ;;=630^fatigue^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,2,0)
 ;;=631^alcohol consumption^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,3,0)
 ;;=632^prostatitis/urethritis^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,4,0)
 ;;=207^depression, severe anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,5,0)
 ;;=633^anger^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,622,1,6,0)
 ;;=634^ignorance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,622,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,622,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,622,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,622,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,623,0)
 ;;=discuss ways to enhance sexual expression^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,623,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,623,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,624,0)
 ;;=teach sexual physiology as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,624,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,624,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,625,0)
 ;;=teach the likelihood of adverse effects^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,625,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,625,1,1,0)
 ;;=459^medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,625,1,2,0)
 ;;=635^therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,625,1,3,0)
 ;;=573^surgery^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,625,5)
 ;;=from
 ;;^UTILITY("^GMRD(124.2,",$J,625,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,625,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,625,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,626,0)
 ;;=provide information regarding altered body structure^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,626,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,626,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,627,0)
 ;;=teach possible reconstructive surgical intervention^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,627,9)
 ;;=D EN2^NURCCPU2
