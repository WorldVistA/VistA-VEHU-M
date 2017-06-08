NURCCG80 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4250,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4251,0)
 ;;=verbalized/observed discomfort in social situations^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4252,0)
 ;;=inability to receive/communicate a sense of belonging^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4253,0)
 ;;=Defining Characteristics^2^NURSC^12^43^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4253,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4253,1,1,0)
 ;;=4263^cognitive, effective, and psychomotor factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4253,1,2,0)
 ;;=4265^integrative dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4253,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4254,0)
 ;;=dysfunctional interaction with peers, family and/or others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4255,0)
 ;;=family reported a change of style or pattern of interaction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4256,0)
 ;;=observed use of unsuccessful socialization behaviors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4257,0)
 ;;=Defining Characteristics^2^NURSC^12^44^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,1,0)
 ;;=4258^absence of supportive/significant other(s)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,2,0)
 ;;=4259^preoccupation with thoughts, repetitive meaningless actions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,3,0)
 ;;=4260^seeks to be alone or exists in subculture^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,4,0)
 ;;=4261^shows behavior unaccepted by dominant cultural group^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,5,0)
 ;;=4262^expresses feeling of aloneness imposed by others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,1,6,0)
 ;;=4264^expresses feelings of rejection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4257,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4258,0)
 ;;=absence of supportive/significant other(s)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4259,0)
 ;;=preoccupation with thoughts, repetitive meaningless actions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4260,0)
 ;;=seeks to be alone or exists in subculture^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4261,0)
 ;;=shows behavior unaccepted by dominant cultural group^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4262,0)
 ;;=expresses feeling of aloneness imposed by others^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4263,0)
 ;;=cognitive, effective, and psychomotor factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4264,0)
 ;;=expresses feelings of rejection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4265,0)
 ;;=integrative dysfunction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4266,0)
 ;;=Defining Characteristics^2^NURSC^12^45^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4266,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4266,1,1,0)
 ;;=4267^anger toward God (as defined by the person)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4266,1,2,0)
 ;;=4269^expresses concern with meaning of life,death,belief systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4266,1,3,0)
 ;;=4271^questions meaning of suffering^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4266,1,4,0)
 ;;=4273^verbalizes inner conflict about beliefs/relationship w/God^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4266,1,5,0)
 ;;=4274^unable to choose/chooses not to participate in religion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4266,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4267,0)
 ;;=anger toward God (as defined by the person)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4268,0)
 ;;=Defining Characteristics^2^NURSC^12^46^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4268,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,4268,1,1,0)
 ;;=4270^request for information^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4268,1,2,0)
 ;;=4272^statement of misconception^3^NURSC^1
