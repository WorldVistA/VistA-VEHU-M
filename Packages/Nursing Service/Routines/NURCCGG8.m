NURCCGG8 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15315,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15315,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15317,0)
 ;;=strain urine, send sediment to Dr. for analysis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15318,0)
 ;;=G.U. follow-up^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15319,0)
 ;;=[Extra Order]^3^NURSC^11^429^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15319,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15319,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15320,0)
 ;;=per urine analysis^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15321,0)
 ;;=per urine culture^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15322,0)
 ;;=per clinical signs/symptoms [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15323,0)
 ;;=verbalizes understanding of medication regime^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15323,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15323,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15324,0)
 ;;=communicates an understanding of follow-up care^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15324,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15324,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15325,0)
 ;;=discuss options (hemo or peritoneal dialysis,transplant)PRN ^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15325,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15325,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15326,0)
 ;;=foul smelling urine^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15329,0)
 ;;=flank pain^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15330,0)
 ;;=spasticity increase^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15332,0)
 ;;=rationale for preventive practices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15333,0)
 ;;=promote optimal learning opportunity for pt/SO^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15333,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15333,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15334,0)
 ;;=pale, cool skin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15337,0)
 ;;=positive blood/urine culture^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15338,0)
 ;;=teach urinary management program [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15338,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15338,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15339,0)
 ;;=assess contributing factors for infection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15339,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15339,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15340,0)
 ;;=teach perineal hygiene^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15340,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15340,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15341,0)
 ;;=teach rationale for preventive practices^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15341,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15341,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15343,0)
 ;;=pt/SO report decreased anxiety re: renal failure& treatment^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15343,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15343,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15347,0)
 ;;=decreased diarrhea^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15347,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15347,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15348,0)
 ;;=directs/or performs treatment protocol^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15348,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15348,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15349,0)
 ;;=demonstrates increased tolerance to activity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15349,9)
 ;;=D EN5^NURCCPU0
