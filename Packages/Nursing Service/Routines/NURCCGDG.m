NURCCGDG ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,11595,1,10,0)
 ;;=11605^teach measures to maintain/improve circulation^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,11595,1,13,0)
 ;;=11608^instruct/assist with ROM [specify]^3^NURSC^56
 ;;^UTILITY("^GMRD(124.2,",$J,11595,1,14,0)
 ;;=12042^[Extra Order]^3^NURSC^194
 ;;^UTILITY("^GMRD(124.2,",$J,11595,1,15,0)
 ;;=15620^teach use & care of adpative equipment^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,11595,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11595,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11604,0)
 ;;=assess tissue tolerance^3^NURSC^11^4^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11604,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11604,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11605,0)
 ;;=teach measures to maintain/improve circulation^3^NURSC^11^5^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11605,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11605,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11608,0)
 ;;=instruct/assist with ROM [specify]^3^NURSC^11^56^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,11608,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11608,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11617,0)
 ;;=[Extra Order]^3^NURSC^11^189^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,11617,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,11617,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11618,0)
 ;;=Related Problems^2^NURSC^7^135^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11618,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11618,1,1,0)
 ;;=819^skin integrity, impairment of^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11618,1,2,0)
 ;;=820^tissue perfusion, alteration in ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11618,1,3,0)
 ;;=821^gas exchange, impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11618,1,4,0)
 ;;=822^constipation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11618,1,5,0)
 ;;=823^injury, potential for^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11618,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,11618,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,0)
 ;;=Defining Characteristics^2^NURSC^12^135^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,11624,1,1,0)
 ;;=4337^decreased muscle strength,control and/or mass^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,1,2,0)
 ;;=4339^impaired coordination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,1,3,0)
 ;;=4340^imposed restriction of movement including mechanical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,1,4,0)
 ;;=4341^limited range of motion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,1,5,0)
 ;;=1769^impaired physical mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,11624,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11630,0)
 ;;=[Extra Problem]^2^NURSC^2^27^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,11630,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11630,1,1,0)
 ;;=11631^Etiology/Related and/or Risk Factors^2^NURSC^274
 ;;^UTILITY("^GMRD(124.2,",$J,11630,1,2,0)
 ;;=11635^Goals/Expected Outcomes^2^NURSC^286
 ;;^UTILITY("^GMRD(124.2,",$J,11630,1,3,0)
 ;;=11639^Nursing Intervention/Orders^2^NURSC^290
 ;;^UTILITY("^GMRD(124.2,",$J,11630,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,11630,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,11630,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,11631,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^274^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,11631,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,11631,1,1,0)
 ;;=11633^[etiology]^3^NURSC^58
 ;;^UTILITY("^GMRD(124.2,",$J,11631,1,2,0)
 ;;=11634^[etiology]^3^NURSC^59
 ;;^UTILITY("^GMRD(124.2,",$J,11631,1,3,0)
 ;;=12168^[etiology]^3^NURSC^117
 ;;^UTILITY("^GMRD(124.2,",$J,11631,7)
 ;;=D EN4^NURCCPU1
