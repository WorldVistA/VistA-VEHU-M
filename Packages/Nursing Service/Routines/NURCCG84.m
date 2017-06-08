NURCCG84 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4329,1,2,0)
 ;;=4085^frequency^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4329,1,3,0)
 ;;=4334^bladder distention^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4329,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4330,0)
 ;;=Defining Characteristics^2^NURSC^12^53^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4330,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4330,1,1,0)
 ;;=4332^diminished sleep, distractability, grandiositsy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4330,1,2,0)
 ;;=4333^hyperactivity, speech pressure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4330,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4331,0)
 ;;=absence of urine output^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4332,0)
 ;;=diminished sleep, distractability, grandiositsy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4333,0)
 ;;=hyperactivity, speech pressure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4334,0)
 ;;=bladder distention^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4335,0)
 ;;=Defining Characteristics^2^NURSC^12^56^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4335,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4335,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4335,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4335,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4335,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4335,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4335,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4336,0)
 ;;=Defining Characteristics^2^NURSC^12^57^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4336,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4336,1,1,0)
 ;;=4338^consistent inattention to stimuli on an affected side^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4336,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4337,0)
 ;;=decreased muscle strength,control and/or mass^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4338,0)
 ;;=consistent inattention to stimuli on an affected side^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4339,0)
 ;;=impaired coordination^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4340,0)
 ;;=imposed restriction of movement including mechanical^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4341,0)
 ;;=limited range of motion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4342,0)
 ;;=Defining Characteristics^2^NURSC^12^58^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4342,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,4342,1,1,0)
 ;;=4343^involuntary passage of stool^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4342,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4343,0)
 ;;=involuntary passage of stool^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4345,0)
 ;;=Defining Characteristics^2^NURSC^12^59^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4345,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4345,1,1,0)
 ;;=4346^unable to speak dominant language^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4345,1,2,0)
 ;;=4347^incessant verbalization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4345,1,3,0)
 ;;=4348^inability to speak in sentences^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4345,1,4,0)
 ;;=4349^inability to modulate speech, find words, name words etc.^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4345,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4346,0)
 ;;=unable to speak dominant language^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4347,0)
 ;;=incessant verbalization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4348,0)
 ;;=inability to speak in sentences^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4349,0)
 ;;=inability to modulate speech, find words, name words etc.^3^NURSC^^1^^^T
