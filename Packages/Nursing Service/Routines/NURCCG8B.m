NURCCG8B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,5,0)
 ;;=4386^BP [specify systolic/diastolic HIGH] to [specify LOW]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,6,0)
 ;;=4387^pulse [specify range] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,7,0)
 ;;=4388^respirations [specify range]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,8,0)
 ;;=15502^temperature=[specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,9,0)
 ;;=15684^B/P lying [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,10,0)
 ;;=15685^B/P sitting [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,1,11,0)
 ;;=15686^B/P standing [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4409,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4409,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4412,0)
 ;;=systemic vascular resistance [specify range]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4413,0)
 ;;=assess,monitor & document by location,duration,frequency q[]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4413,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4413,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4417,0)
 ;;=instruct patient to report pain as soon as possible^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4417,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4417,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4424,0)
 ;;=teach splinting to decrease pain^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4424,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4424,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4427,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^202^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,1,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,2,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,3,0)
 ;;=1458^myocardial oxygen demand is minimized^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,4,0)
 ;;=4462^maintain fluid/electrolyte balance WNL for pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,5,0)
 ;;=4392^maintain fluid/electrolytes WNL for patient^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,7,0)
 ;;=4498^maintain baseline heart rhythm/NSR^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,8,0)
 ;;=4522^[Extra Goal]^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,4427,1,9,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4427,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,0)
 ;;=assess,monitor,document V/S^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,1,0)
 ;;=1595^B/P lying and standing q[frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,2,0)
 ;;=4432^pulse q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,3,0)
 ;;=4434^respirations q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,4,0)
 ;;=2952^temperature per[route] q[ frequency ]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,5,0)
 ;;=384^weight q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,1,6,0)
 ;;=337^I&O q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4428,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4428,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4430,0)
 ;;=assess heart sounds q[frequency]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4430,4)
 ;;=monitor, document &
 ;;^UTILITY("^GMRD(124.2,",$J,4430,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,4430,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4432,0)
 ;;=pulse q[frequency]^3^NURSC^11^1^^^T
