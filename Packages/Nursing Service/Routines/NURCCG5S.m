NURCCG5S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2318,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2318,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2319,0)
 ;;=discusses two angry feelings related to loss^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2319,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2319,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2320,0)
 ;;=discusses two guilty feelings related to loss^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2320,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2320,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2321,0)
 ;;=works through stages of grief process^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2321,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2321,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2322,0)
 ;;=develop a trusting relationship with the patient^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2322,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2322,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2323,0)
 ;;=encourage patient to recall experiences^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2323,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2323,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2324,0)
 ;;=positively reinforce expression of feelings related to loss^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2324,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2324,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2325,0)
 ;;=assist to identify sources of anger^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2325,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2325,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2326,0)
 ;;=monitor behaviors indicative of unresolved anger^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2326,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2326,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2327,0)
 ;;=help identify strengths^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2327,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2327,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2328,0)
 ;;=recognize: pt. may be anxious about dismissing 'voices'^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2328,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2328,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2329,0)
 ;;=encourage reality testing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2329,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2329,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2330,0)
 ;;=provide chance to speak to others who cope with similar loss^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2330,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2330,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2331,0)
 ;;=teach: that delusional thoughts are hard to believe^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2331,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2331,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2332,0)
 ;;=relate delusional thought content to level of anxiety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2332,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2332,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2333,0)
 ;;=allow brief description of delusions; do not reinforce^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2333,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2333,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2334,0)
 ;;=teach manifestations of unresolved anger^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2334,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2334,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2335,0)
 ;;=teach healthy grieving process^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2335,9)
 ;;=D EN2^NURCCPU2
