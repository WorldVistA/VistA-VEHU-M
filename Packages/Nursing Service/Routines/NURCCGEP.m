NURCCGEP ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13607,0)
 ;;=prevent complications of immobility^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13607,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13607,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13609,0)
 ;;=teach adaptive techniques for ADLs [specify]^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13609,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13609,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13613,0)
 ;;=teach enviromental adjustments to maintain safety^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13613,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13613,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13626,0)
 ;;=[Extra Order]^3^NURSC^11^241^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13626,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13626,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13627,0)
 ;;=Related Problems^2^NURSC^7^156^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13627,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13627,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13627,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13627,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13627,1,4,0)
 ;;=822^constipation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13627,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13627,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,13627,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,0)
 ;;=Defining Characteristics^2^NURSC^12^158^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13633,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13633,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13639,0)
 ;;=Communication Impaired^2^NURSC^2^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13639,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,13639,1,1,0)
 ;;=13640^Etiology/Related and/or Risk Factors^2^NURSC^182
 ;;^UTILITY("^GMRD(124.2,",$J,13639,1,2,0)
 ;;=13659^Goals/Expected Outcomes^2^NURSC^180
 ;;^UTILITY("^GMRD(124.2,",$J,13639,1,3,0)
 ;;=13665^Nursing Intervention/Orders^2^NURSC^151
 ;;^UTILITY("^GMRD(124.2,",$J,13639,1,4,0)
 ;;=13678^Defining Characteristics^2^NURSC^159
 ;;^UTILITY("^GMRD(124.2,",$J,13639,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13639,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13639,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13639,"TD",0)
 ;;=^^2^2^2890803^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,13639,"TD",1,0)
 ;;=The state in which an individual experiences a decreased or absent
 ;;^UTILITY("^GMRD(124.2,",$J,13639,"TD",2,0)
 ;;=ability to use or understand language in human interaction.
 ;;^UTILITY("^GMRD(124.2,",$J,13640,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^182^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13640,1,0)
 ;;=^124.21PI^16^5
 ;;^UTILITY("^GMRD(124.2,",$J,13640,1,6,0)
 ;;=1107^psychological barriers, psychosis, lack of stimuli^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13640,1,7,0)
 ;;=1108^inability to speak^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13640,1,8,0)
 ;;=92^impaired cognition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13640,1,15,0)
 ;;=1114^inability to understand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13640,1,16,0)
 ;;=1115^impaired articulation^3^NURSC^1
