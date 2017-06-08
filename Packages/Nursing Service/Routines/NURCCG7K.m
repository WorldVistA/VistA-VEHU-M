NURCCG7K ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,3194,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,3194,1,1,0)
 ;;=3195^Etiology/Related and/or Risk Factors^2^NURSC^77
 ;;^UTILITY("^GMRD(124.2,",$J,3194,1,2,0)
 ;;=3200^Goals/Expected Outcomes^2^NURSC^77
 ;;^UTILITY("^GMRD(124.2,",$J,3194,1,3,0)
 ;;=3212^Nursing Intervention/Orders^2^NURSC^70
 ;;^UTILITY("^GMRD(124.2,",$J,3194,1,4,0)
 ;;=3219^Related Problems^2^NURSC^67
 ;;^UTILITY("^GMRD(124.2,",$J,3194,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3194,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,3194,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^77^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,3195,1,1,0)
 ;;=1042^paralysis/plegia, loss of limb, quadri, para, hemi, mono^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,1,2,0)
 ;;=3196^mechanical immobilization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,1,3,0)
 ;;=3197^prescribed immobilization^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,1,4,0)
 ;;=3198^severe pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,1,5,0)
 ;;=2610^altered levels of consciousness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3195,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3196,0)
 ;;=mechanical immobilization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3197,0)
 ;;=prescribed immobilization^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3198,0)
 ;;=severe pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3199,0)
 ;;=good basic health habits^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3200,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^77^1^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,1,0)
 ;;=3201^performs at highest level of functioning [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,2,0)
 ;;=3202^maintains muscle tone and strength^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,3,0)
 ;;=807^maintains ROM in all joints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,4,0)
 ;;=1532^maintains intact skin^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,5,0)
 ;;=3204^maintains bowel function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,6,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,7,0)
 ;;=3206^maintains adequate bladder function^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,8,0)
 ;;=3207^uses assistive devices [specify] correctly/consistently^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,9,0)
 ;;=3208^participates in social and occupational activities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,10,0)
 ;;=3209^verbalizes accurate knowledge of decisions/treatment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,11,0)
 ;;=2664^remains free of urinary tract infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,12,0)
 ;;=3211^remains free of injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,3200,1,13,0)
 ;;=1006312^[Extra Goal]^3^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,3200,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3201,0)
 ;;=performs at highest level of functioning [specify]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3201,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3201,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3202,0)
 ;;=maintains muscle tone and strength^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3202,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3202,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3204,0)
 ;;=maintains bowel function^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3204,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,3204,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,3205,0)
 ;;=maintain clear bilateral non-labored respirations^3^NURSC^9^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,3205,9)
 ;;=D EN5^NURCCPU0
