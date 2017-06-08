NURCCG2L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,10,0)
 ;;=816^reposition/turn q[frequency]^3^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,11,0)
 ;;=817^utilize devices [specify] to facilitate mobility^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,12,0)
 ;;=818^limit activities as set by medical protocols & as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,13,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,1,14,0)
 ;;=2969^[Extra Order]^3^NURSC^52^0
 ;;^UTILITY("^GMRD(124.2,",$J,801,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,801,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,802,0)
 ;;=Related Problems^2^NURSC^7^14^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,802,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,802,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,802,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,802,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,802,1,4,0)
 ;;=822^constipation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,802,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,802,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,802,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,803,0)
 ;;=intolerance to activity; decreased strength and endurance^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,804,0)
 ;;=musculoskeletal impairment^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,805,0)
 ;;=neuromuscular impairment^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,806,0)
 ;;=free from injury^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,806,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,806,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,807,0)
 ;;=maintains ROM in all joints^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,807,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,807,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,808,0)
 ;;=maintains independent ambulation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,808,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,808,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,809,0)
 ;;=assess mobility, limitations q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,809,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,809,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,810,0)
 ;;=assess risks if mobile^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,810,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,810,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,811,0)
 ;;=protect from injury as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,811,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,811,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,812,0)
 ;;=prior to restraints, teach purpose^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,812,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,812,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,813,0)
 ;;=perimeter protection^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,813,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,813,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,814,0)
 ;;=adjust environment as appropriate^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,814,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,814,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,815,0)
 ;;=range of motion exercise as appropriate q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,815,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,815,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,816,0)
 ;;=reposition/turn q[frequency]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,816,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,816,10)
 ;;=D EN1^NURCCPU3
