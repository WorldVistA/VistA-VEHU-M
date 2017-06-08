NURCCG14 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;2/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,18,0)
 ;;=15377^determine communication for expressing needs [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,19,0)
 ;;=15380^divide tasks into the smallest steps possible^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,20,0)
 ;;=15373^facilitate patient control over activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,21,0)
 ;;=15362^monitor for S/S of increased intracranial pressure^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,22,0)
 ;;=15365^teach appropriate positioning for activity^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,1,23,0)
 ;;=255^teach safe use of adaptive equipment [specify]^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,373,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,373,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,374,0)
 ;;=assess bowel history^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,374,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,374,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,375,0)
 ;;=determine a method for communicating the need for toileting^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,375,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,375,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,376,0)
 ;;=maintain records to determine bowel patterns^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,376,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,376,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,377,0)
 ;;=promote elimination by encouraging appropriate activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,377,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,377,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,378,0)
 ;;=allow sufficient time to toilet^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,378,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,378,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,379,0)
 ;;=avoid using indwelling and condom catheters^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,379,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,379,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,380,0)
 ;;=provide for safe, clear pathway to toilet area^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,380,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,380,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,381,0)
 ;;=provide for privacy as well as safety^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,381,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,381,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,382,0)
 ;;=provide for continual practice at specified intervals^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,382,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,382,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,383,0)
 ;;=provide for adaptive equipment as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,383,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,383,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,384,0)
 ;;=weight q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,384,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,384,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,384,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,385,0)
 ;;=observe for anxiety; use calm, confident manner^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,385,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,385,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,386,0)
 ;;=incentive spirometer q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,386,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,386,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,387,0)
 ;;=suction q[frequency] and/or PRN^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,387,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,387,10)
 ;;=D EN1^NURCCPU3
