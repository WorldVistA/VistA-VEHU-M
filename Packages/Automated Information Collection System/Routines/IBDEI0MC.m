IBDEI0MC ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10608,0)
 ;;=H0036^^45^568^14^^^^1
 ;;^UTILITY(U,$J,358.3,10608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10608,1,2,0)
 ;;=2^H0036
 ;;^UTILITY(U,$J,358.3,10608,1,3,0)
 ;;=3^Community Psych Sup Tx,F2F,per 15Min
 ;;^UTILITY(U,$J,358.3,10609,0)
 ;;=H0032^^45^568^27^^^^1
 ;;^UTILITY(U,$J,358.3,10609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10609,1,2,0)
 ;;=2^H0032
 ;;^UTILITY(U,$J,358.3,10609,1,3,0)
 ;;=3^MH Svc Plan Development by Non MD
 ;;^UTILITY(U,$J,358.3,10610,0)
 ;;=H0033^^45^568^32^^^^1
 ;;^UTILITY(U,$J,358.3,10610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10610,1,2,0)
 ;;=2^H0033
 ;;^UTILITY(U,$J,358.3,10610,1,3,0)
 ;;=3^ORAL MED ADM DIRECT OBSERVE
 ;;^UTILITY(U,$J,358.3,10611,0)
 ;;=90791^^45^569^1^^^^1
 ;;^UTILITY(U,$J,358.3,10611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10611,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,10611,1,3,0)
 ;;=3^PSYCH DIAGNOSTIC EVALUATION
 ;;^UTILITY(U,$J,358.3,10612,0)
 ;;=90792^^45^569^2^^^^1
 ;;^UTILITY(U,$J,358.3,10612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10612,1,2,0)
 ;;=2^90792
 ;;^UTILITY(U,$J,358.3,10612,1,3,0)
 ;;=3^PSYCH DIAG EVAL W/MED SRVCS
 ;;^UTILITY(U,$J,358.3,10613,0)
 ;;=90847^^45^570^1^^^^1
 ;;^UTILITY(U,$J,358.3,10613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10613,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,10613,1,3,0)
 ;;=3^FAMILY PSYTX W/PATIENT
 ;;^UTILITY(U,$J,358.3,10614,0)
 ;;=90849^^45^570^3^^^^1
 ;;^UTILITY(U,$J,358.3,10614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10614,1,2,0)
 ;;=2^90849
 ;;^UTILITY(U,$J,358.3,10614,1,3,0)
 ;;=3^MULTIPLE FAMILY GROUP PSYTX
 ;;^UTILITY(U,$J,358.3,10615,0)
 ;;=90853^^45^570^2^^^^1
 ;;^UTILITY(U,$J,358.3,10615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10615,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,10615,1,3,0)
 ;;=3^GROUP PSYCHOTHERAPY
 ;;^UTILITY(U,$J,358.3,10616,0)
 ;;=99509^^45^571^11^^^^1
 ;;^UTILITY(U,$J,358.3,10616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10616,1,2,0)
 ;;=2^99509
 ;;^UTILITY(U,$J,358.3,10616,1,3,0)
 ;;=3^HOME VISIT DAY LIFE ACTIVITY
 ;;^UTILITY(U,$J,358.3,10617,0)
 ;;=99510^^45^571^12^^^^1
 ;;^UTILITY(U,$J,358.3,10617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10617,1,2,0)
 ;;=2^99510
 ;;^UTILITY(U,$J,358.3,10617,1,3,0)
 ;;=3^HOME VISIT, SING/M/FAM COUNS
 ;;^UTILITY(U,$J,358.3,10618,0)
 ;;=99600^^45^571^10^^^^1
 ;;^UTILITY(U,$J,358.3,10618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10618,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,10618,1,3,0)
 ;;=3^HOME CASE MANAGEMENT
 ;;^UTILITY(U,$J,358.3,10619,0)
 ;;=99600^^45^571^15^^^^1
 ;;^UTILITY(U,$J,358.3,10619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10619,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,10619,1,3,0)
 ;;=3^UNLISTED HOME VISIT
 ;;^UTILITY(U,$J,358.3,10620,0)
 ;;=99347^^45^571^1^^^^1
 ;;^UTILITY(U,$J,358.3,10620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10620,1,2,0)
 ;;=2^99347
 ;;^UTILITY(U,$J,358.3,10620,1,3,0)
 ;;=3^Home Visit w/ E&M,Est Pt,Problem Focused
 ;;^UTILITY(U,$J,358.3,10621,0)
 ;;=99348^^45^571^2^^^^1
 ;;^UTILITY(U,$J,358.3,10621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10621,1,2,0)
 ;;=2^99348
 ;;^UTILITY(U,$J,358.3,10621,1,3,0)
 ;;=3^Home Visit w/ E&M,Est Pt,Exp Prob Focus
 ;;^UTILITY(U,$J,358.3,10622,0)
 ;;=99349^^45^571^3^^^^1
 ;;^UTILITY(U,$J,358.3,10622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10622,1,2,0)
 ;;=2^99349
 ;;^UTILITY(U,$J,358.3,10622,1,3,0)
 ;;=3^Home Visit w/ E&M,Est Pt,Detailed
 ;;^UTILITY(U,$J,358.3,10623,0)
 ;;=99350^^45^571^4^^^^1
 ;;^UTILITY(U,$J,358.3,10623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10623,1,2,0)
 ;;=2^99350
 ;;
 ;;$END ROU IBDEI0MC
