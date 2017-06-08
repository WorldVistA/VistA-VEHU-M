NURCCG5F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2153,1,2,0)
 ;;=2155^being non-judgmental^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2153,1,3,0)
 ;;=2156^encouraging discussion of events/stress symptoms^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2153,1,4,0)
 ;;=2157^support realistic assessment of life situation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2153,5)
 ;;=by
 ;;^UTILITY("^GMRD(124.2,",$J,2153,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2153,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2153,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2154,0)
 ;;=making frequent intermittent contacts to offer support^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2155,0)
 ;;=being non-judgmental^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2156,0)
 ;;=encouraging discussion of events/stress symptoms^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2157,0)
 ;;=support realistic assessment of life situation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2158,0)
 ;;=encourage participation in self help groups [specify] ^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2158,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2158,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2159,0)
 ;;=teach^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,1,0)
 ;;=2160^anger control^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,2,0)
 ;;=2161^response to loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,3,0)
 ;;=2162^stages of grief^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,4,0)
 ;;=2163^stress reduction/relaxation assertiveness^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,5,0)
 ;;=2164^holistic health practices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,6,0)
 ;;=2165^leisure skills^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,7,0)
 ;;=2166^medication information^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,1,8,0)
 ;;=2167^refer to appropriate community resource^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2159,5)
 ;;=the following
 ;;^UTILITY("^GMRD(124.2,",$J,2159,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2159,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2159,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2160,0)
 ;;=anger control^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2161,0)
 ;;=response to loss^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2162,0)
 ;;=stages of grief^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2163,0)
 ;;=stress reduction/relaxation assertiveness^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2164,0)
 ;;=holistic health practices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2165,0)
 ;;=leisure skills^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2166,0)
 ;;=medication information^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2167,0)
 ;;=refer to appropriate community resource^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2168,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^58^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2168,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,2168,1,1,0)
 ;;=2169^impaired judgement^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2168,1,2,0)
 ;;=2170^memory loss^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2168,1,3,0)
 ;;=2171^physiologic changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2168,1,4,0)
 ;;=1322^sleep deprivation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2168,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2169,0)
 ;;=impaired judgement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2170,0)
 ;;=memory loss^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2171,0)
 ;;=physiologic changes^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2172,0)
 ;;=Related Problems^2^NURSC^7^45^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,2172,1,1,0)
 ;;=2173^Potential For Violence (Self/Others)^3^NURSC^1^0
