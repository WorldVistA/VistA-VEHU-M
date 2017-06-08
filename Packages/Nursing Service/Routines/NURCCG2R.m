NURCCG2R ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,864,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,865,0)
 ;;=sleeps for 4-5 hours without awakening^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,865,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,865,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,866,0)
 ;;=sleeps 7-9 hours without awakening^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,866,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,866,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,867,0)
 ;;=falls asleep within minutes if awakened^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,867,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,867,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,868,0)
 ;;=states feels rested after sleep^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,868,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,868,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,869,0)
 ;;=states feels less tense, less anxious after sleep^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,869,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,869,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,870,0)
 ;;=assess length of time and time of day naps are taken^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,870,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,870,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,870,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,871,0)
 ;;=assess length of time patient is awake at night^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,871,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,871,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,871,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,872,0)
 ;;=increase daytime activity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,872,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,872,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,873,0)
 ;;=discuss pros/cons of napping^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,873,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,873,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,874,0)
 ;;=decrease stimulants from [time] until [time]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,874,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,874,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,875,0)
 ;;=avoid stimulants and foods difficult to digest at bedtime^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,875,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,875,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,876,0)
 ;;=schedule tests to allow for uninterrupted periods of sleep^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,876,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,876,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,877,0)
 ;;=limit amount of fluids after [time]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,877,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,877,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,878,0)
 ;;=listen to pt if pt appears anxious or needs to talk^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,878,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,878,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,879,0)
 ;;=offer comfort measures^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,879,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,879,1,1,0)
 ;;=880^back rub^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,879,1,2,0)
 ;;=881^warm milk^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,879,1,3,0)
 ;;=882^soft music^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,879,1,4,0)
 ;;=883^analgesic for pain^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,879,5)
 ;;=such as:
 ;;^UTILITY("^GMRD(124.2,",$J,879,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,879,9)
 ;;=D EN2^NURCCPU2
