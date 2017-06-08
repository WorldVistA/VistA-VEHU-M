NURCCGCN ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,15,0)
 ;;=2787^hostility/anger^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10023,1,17,0)
 ;;=2788^altered thought process^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10023,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^135^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,1,0)
 ;;=2789^verbalizes when in pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,2,0)
 ;;=2790^free of objective signs of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,3,0)
 ;;=2791^identifies factors that influence pain experience^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,4,0)
 ;;=2792^identifies appropriate pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,5,0)
 ;;=2793^demonstrates use of pain relief measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,6,0)
 ;;=2794^patient/S.O. administers medications appropriately^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,7,0)
 ;;=2795^verbalizes effect of pain relief interventions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,8,0)
 ;;=10053^verbalizes comfort or pain as appropriate^3^NURSC^9
 ;;^UTILITY("^GMRD(124.2,",$J,10045,1,9,0)
 ;;=10111^[Extra Goal]^3^NURSC^168
 ;;^UTILITY("^GMRD(124.2,",$J,10045,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10053,0)
 ;;=verbalizes comfort or pain as appropriate^3^NURSC^9^9^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10053,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10053,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10054,0)
 ;;=[Extra Goal]^3^NURSC^9^167^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10054,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10054,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^188^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,0)
 ;;=^124.21PI^16^15
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,1,0)
 ;;=2797^assess pain episode using 0 (no) to 10 (worst) scale^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,2,0)
 ;;=2798^assess pain (location, duration) q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,3,0)
 ;;=2799^monitor stimulus responses to pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,4,0)
 ;;=2801^instruct to report pain as soon as possible^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,5,0)
 ;;=2803^support verbalization of pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,7,0)
 ;;=2805^teach splinting of the incision to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,8,0)
 ;;=2827^teach the purpose and use of analgesics^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,9,0)
 ;;=2854^administer pharmacological agents as ordered/per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,10,0)
 ;;=2855^teach techniques of massage to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,11,0)
 ;;=2856^teach positioning techniques to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,12,0)
 ;;=2857^teach breathing exercises to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,13,0)
 ;;=2858^teach distraction techniques to minimize pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,14,0)
 ;;=2859^teach the use of imagery to decrease pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,15,0)
 ;;=628^teach relaxation techniques^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,1,16,0)
 ;;=10728^[Extra Order]^3^NURSC^179
 ;;^UTILITY("^GMRD(124.2,",$J,10055,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10055,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10071,0)
 ;;=[Extra Order]^3^NURSC^11^170^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10071,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10071,10)
 ;;=D EN1^NURCCPU3
