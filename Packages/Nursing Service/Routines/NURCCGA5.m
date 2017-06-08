NURCCGA5 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,17,0)
 ;;=573^surgery^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,1,18,0)
 ;;=1116^tissue damage-hearing loss^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5782,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5801,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^80^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5801,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,5801,1,3,0)
 ;;=5804^utilizes an effective mechanism (system) for communication^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5801,1,4,0)
 ;;=5805^communicates needs within capacity to staff and family^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,5801,1,5,0)
 ;;=5850^[Extra Goal]^3^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,5801,1,6,0)
 ;;=15547^demonstrates understanding of spoken words and gestures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5801,1,7,0)
 ;;=2242^uses assertive communication techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5801,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5804,0)
 ;;=utilizes an effective mechanism (system) for communication^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5804,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5804,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5805,0)
 ;;=communicates needs within capacity to staff and family^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5805,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5805,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^73^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,0)
 ;;=^124.21PI^13^9
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,4,0)
 ;;=5819^[Extra Order]^3^NURSC^120
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,5,0)
 ;;=15550^assess ability to speak, read, hear, write and understand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,6,0)
 ;;=15551^assess ability to comprehend simple commands^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,7,0)
 ;;=15552^assess ability to comprehend complex ideas^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,8,0)
 ;;=15553^speak slowly in a normal tone^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,9,0)
 ;;=15674^decrease external noise and distractions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,10,0)
 ;;=15675^validate non-verbal communication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,12,0)
 ;;=15676^teach adaptive techniques for communicating^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,1,13,0)
 ;;=15677^seek consultation from [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5807,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5819,0)
 ;;=[Extra Order]^3^NURSC^11^120^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5819,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5819,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5820,0)
 ;;=Defining Characteristics^2^NURSC^12^74^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5820,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,5820,1,1,0)
 ;;=4346^unable to speak dominant language^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5820,1,2,0)
 ;;=4347^incessant verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5820,1,3,0)
 ;;=4348^inability to speak in sentences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5820,1,4,0)
 ;;=4349^inability to modulate speech, find words, name words etc.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5820,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5825,0)
 ;;=Mobility, Impaired Physical^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5825,1,0)
 ;;=^124.21PI^7^5
 ;;^UTILITY("^GMRD(124.2,",$J,5825,1,1,0)
 ;;=5826^Etiology/Related and/or Risk Factors^2^NURSC^81
 ;;^UTILITY("^GMRD(124.2,",$J,5825,1,3,0)
 ;;=5851^Nursing Intervention/Orders^2^NURSC^74
 ;;^UTILITY("^GMRD(124.2,",$J,5825,1,4,0)
 ;;=5874^Related Problems^2^NURSC^70
