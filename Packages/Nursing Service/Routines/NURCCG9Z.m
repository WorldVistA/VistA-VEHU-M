NURCCG9Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5378,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5378,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5379,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5380,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^263^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5380,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5380,1,1,0)
 ;;=5381^[Extra Order]^3^NURSC^315
 ;;^UTILITY("^GMRD(124.2,",$J,5380,1,2,0)
 ;;=5383^[Extra Order]^3^NURSC^316
 ;;^UTILITY("^GMRD(124.2,",$J,5380,1,3,0)
 ;;=5387^[Extra Order]^3^NURSC^317
 ;;^UTILITY("^GMRD(124.2,",$J,5380,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5380,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5381,0)
 ;;=[Extra Order]^3^NURSC^11^315^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5381,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5381,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5382,0)
 ;;=reported food intake under RDA^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5383,0)
 ;;=[Extra Order]^3^NURSC^11^316^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5383,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5383,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5384,0)
 ;;=reported/observed lack of food^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5387,0)
 ;;=[Extra Order]^3^NURSC^11^317^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5387,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5387,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5388,0)
 ;;=sore/inflammed bucal cavity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5389,0)
 ;;=lack of interest in food^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5390,0)
 ;;=Manic Behavior^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5390,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,5390,1,1,0)
 ;;=5394^Etiology/Related and/or Risk Factors^2^NURSC^253
 ;;^UTILITY("^GMRD(124.2,",$J,5390,1,2,0)
 ;;=5399^Goals/Expected Outcomes^2^NURSC^262
 ;;^UTILITY("^GMRD(124.2,",$J,5390,1,4,0)
 ;;=7413^Nursing Intervention/Orders^2^NURSC^277
 ;;^UTILITY("^GMRD(124.2,",$J,5390,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5390,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5390,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5392,0)
 ;;=Defining Characteristics^2^NURSC^12^67^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5392,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,5392,1,1,0)
 ;;=5397^weight 20% over ideal for height/frame^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5392,1,2,0)
 ;;=5401^triceps skinfold greater than 15mm in male^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5392,1,3,0)
 ;;=5431^sedentary activity level^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5392,1,5,0)
 ;;=5534^eating in response to cues other than hunger^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5392,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5393,0)
 ;;=teach catheterization technique/care q [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5393,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,5393,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5394,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^253^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5394,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5394,1,1,0)
 ;;=15602^bipolar disorder^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5394,1,2,0)
 ;;=15603^family history^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5394,1,3,0)
 ;;=15604^antidepressant medications^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5394,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5397,0)
 ;;=weight 20% over ideal for height/frame^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5399,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^262^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5399,1,0)
 ;;=^124.21PI^7^7
