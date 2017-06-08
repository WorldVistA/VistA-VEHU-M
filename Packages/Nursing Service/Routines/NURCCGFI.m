NURCCGFI ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14482,1,14,0)
 ;;=3163^conveys attitude of own worth/positive body image^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14482,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14492,0)
 ;;=participates in self care/health maintenance activities^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14492,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14492,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14493,0)
 ;;=[Extra Goal]^3^NURSC^9^246^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14493,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14493,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14495,0)
 ;;=attains/maintains orientation time,place,person,situation^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14495,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14495,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14496,0)
 ;;=is maintained in/returns to a safe environment^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14496,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14496,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14499,0)
 ;;=attends/participates in structured activities^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14499,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14499,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14502,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^159^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,0)
 ;;=^124.21PI^18^13
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,1,0)
 ;;=14503^assess ability/perform self care health maintenance actions^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,2,0)
 ;;=14504^assist w/performance self care health maintenance actions^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,4,0)
 ;;=15005^[Extra Order]^3^NURSC^257
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,5,0)
 ;;=169^assess knowledge base^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,7,0)
 ;;=14520^assess level of orientation q[frequency]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,8,0)
 ;;=14521^instruct S/O(s) how to assess/assist w/reality orientation^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,12,0)
 ;;=14537^provide information (community resources,respite care,etc.)^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,13,0)
 ;;=14538^instruct S/O(s) how to assess/assist with ADL activities^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,14,0)
 ;;=14539^provide reality orientation activities [specify]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,15,0)
 ;;=14540^structured activities to promote independence [specify]^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,16,0)
 ;;=3185^teach patient safe transfers from bed to W/C to commode^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,17,0)
 ;;=14542^collaborate with S/O(s) to maintain safe environment^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14502,1,18,0)
 ;;=3187^teach healthy food choices/preparation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14502,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14502,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14503,0)
 ;;=assess ability/perform self care health maintenance actions^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14503,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14503,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14504,0)
 ;;=assist w/performance self care health maintenance actions^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14504,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14504,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14513,0)
 ;;=[Extra Order]^3^NURSC^11^252^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14513,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14513,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14520,0)
 ;;=assess level of orientation q[frequency]^3^NURSC^11^3^^^T
