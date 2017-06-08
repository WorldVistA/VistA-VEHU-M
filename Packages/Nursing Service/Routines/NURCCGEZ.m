NURCCGEZ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,3,0)
 ;;=2346^crises, situational & maturational (separation,death,loss)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,4,0)
 ;;=458^disease process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,5,0)
 ;;=2052^genetic factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,6,0)
 ;;=2348^hormonal imbalances and/or changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,8,0)
 ;;=2369^neurotransmitter dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^184^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,0)
 ;;=^124.21PI^13^12
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,1,0)
 ;;=2256^interacts with an assigned staff member [ ] min/shift^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,2,0)
 ;;=2260^interacts with another patient [ ] times per shift^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,3,0)
 ;;=2264^attends and participates in assigned groups^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,4,0)
 ;;=2353^reports feeling less depressed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,5,0)
 ;;=2355^sets small goals for accomplishing tasks^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,6,0)
 ;;=2357^reports experiencing success in meeting goals^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,7,0)
 ;;=2289^attends to own ADL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,8,0)
 ;;=14013^reports a return to own normal sleep,eating,energy patterns^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,9,0)
 ;;=2360^makes one positive statement about self q [frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,11,0)
 ;;=14016^develops plan to deal with contributing factors^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,12,0)
 ;;=2364^identifies three alternative methods to deal with stressors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14005,1,13,0)
 ;;=14230^[Extra Goal]^3^NURSC^243
 ;;^UTILITY("^GMRD(124.2,",$J,14005,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14013,0)
 ;;=reports a return to own normal sleep,eating,energy patterns^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14013,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14013,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14016,0)
 ;;=develops plan to deal with contributing factors^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14016,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14016,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^154^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,1,0)
 ;;=14020^assist to identify causative, contributing factors^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,2,0)
 ;;=2368^monitor for suicide potential^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,3,0)
 ;;=2370^monitor ADL^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,4,0)
 ;;=14023^assist to develop a plan to deal with contributing factors^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,5,0)
 ;;=14024^assess for potential for self harm q[specify] hrs^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,6,0)
 ;;=14025^help in defining,setting,meeting realistic goals [specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,7,0)
 ;;=2377^reinforce task completion^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,8,0)
 ;;=14027^implement measures to deal with alterations in health^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,9,0)
 ;;=2378^teach relaxation techniques^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,10,0)
 ;;=1974^teach problem solving skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,11,0)
 ;;=1975^teach assertiveness skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14019,1,12,0)
 ;;=2041^teach/review medication use^3^NURSC^1
