NURCCG54 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1999,1,3,0)
 ;;=2002^role functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1999,1,4,0)
 ;;=1817^environment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1999,1,5,0)
 ;;=2004^interaction patterns^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1999,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2000,0)
 ;;=health status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2001,0)
 ;;=socioeconomic status^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2002,0)
 ;;=role functioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2003,0)
 ;;=job^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2004,0)
 ;;=interaction patterns^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2005,0)
 ;;=view of life^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2006,0)
 ;;=leisure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2007,0)
 ;;=leisure activities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2008,0)
 ;;=threat to self-concept^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2009,0)
 ;;=threat of death^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2010,0)
 ;;=unconscious conflict about essential values and goals^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2011,0)
 ;;=participates in activities promoting adaption to loss^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2011,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2011,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2012,0)
 ;;=unmet needs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2013,0)
 ;;=participates in activities promoting adaption to change^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2013,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2013,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2014,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^49^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,1,0)
 ;;=2015^explore source and purpose of negative statements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,2,0)
 ;;=2016^contract pt not to reply negatively to compliments^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,3,0)
 ;;=2017^focus on strengths/identify weaknesses^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,4,0)
 ;;=2035^encourage expression of feelings and be accepting of them^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,5,0)
 ;;=2050^arrange for community support group visit if needed^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,6,0)
 ;;=2051^encourage patient to become involved in helping others^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,7,0)
 ;;=2055^positively reinforce for effort at adaption^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,8,0)
 ;;=2056^do not support denial^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,9,0)
 ;;=2057^teach^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,1,10,0)
 ;;=3004^[Extra Order]^3^NURSC^90^0
 ;;^UTILITY("^GMRD(124.2,",$J,2014,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2014,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2015,0)
 ;;=explore source and purpose of negative statements^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2015,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2015,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2016,0)
 ;;=contract pt not to reply negatively to compliments^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2016,5)
 ;;=for one whole day
 ;;^UTILITY("^GMRD(124.2,",$J,2016,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2016,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2017,0)
 ;;=focus on strengths/identify weaknesses^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,1,0)
 ;;=2019^hobbies^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,2,0)
 ;;=2020^school^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2017,1,3,0)
 ;;=2021^skills^3^NURSC^1^0
