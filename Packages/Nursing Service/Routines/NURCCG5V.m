NURCCG5V ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2350,1,5,0)
 ;;=2358^define statements that are confusing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2350,5)
 ;;=and include the following:
 ;;^UTILITY("^GMRD(124.2,",$J,2350,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2350,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2350,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2351,0)
 ;;=discuss goals and alternatives^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2352,0)
 ;;=provide positive reinforcement when initiates conversation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2353,0)
 ;;=reports feeling less depressed^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2353,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2353,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2354,0)
 ;;=listen/chart patterns & symbols used in conversing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2355,0)
 ;;=sets small goals for accomplishing tasks^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2355,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2355,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2356,0)
 ;;=discuss concrete realities^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2357,0)
 ;;=reports experiencing success in meeting goals^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2357,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2357,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2358,0)
 ;;=define statements that are confusing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2359,0)
 ;;=reports a return to own normal sleep pattern^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2359,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2359,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2360,0)
 ;;=makes one positive statement about self q [frequency]^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2360,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2360,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2361,0)
 ;;=monitor/assist with grooming & hygiene as necessary^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2361,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2361,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2362,0)
 ;;=demonstrates problem solving skills^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2362,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2362,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2363,0)
 ;;=developes plan to deal with contributing factors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2363,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2363,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2364,0)
 ;;=identifies three alternative methods to deal with stressors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2364,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2364,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2365,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^66^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,1,0)
 ;;=2366^alienation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,2,0)
 ;;=2367^crisis, maturational or situational^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,3,0)
 ;;=2052^genetic factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,4,0)
 ;;=2348^hormonal imbalances and/or changes^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,5,0)
 ;;=2369^neurotransmitter dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,6,0)
 ;;=2371^toxic substance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,1,7,0)
 ;;=2372^very strong dependency needs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2365,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2366,0)
 ;;=alienation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2367,0)
 ;;=crisis, maturational or situational^3^NURSC^^1^^^T
