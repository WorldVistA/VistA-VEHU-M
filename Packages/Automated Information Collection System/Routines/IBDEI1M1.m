IBDEI1M1 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28573,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28573,1,2,0)
 ;;=2^196.0
 ;;^UTILITY(U,$J,358.3,28573,1,5,0)
 ;;=5^Head/Face & Neck
 ;;^UTILITY(U,$J,358.3,28573,2)
 ;;=^267314
 ;;^UTILITY(U,$J,358.3,28574,0)
 ;;=196.2^^163^1803^3
 ;;^UTILITY(U,$J,358.3,28574,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28574,1,2,0)
 ;;=2^196.2
 ;;^UTILITY(U,$J,358.3,28574,1,5,0)
 ;;=5^Intra-Abdominal
 ;;^UTILITY(U,$J,358.3,28574,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,28575,0)
 ;;=196.6^^163^1803^4
 ;;^UTILITY(U,$J,358.3,28575,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28575,1,2,0)
 ;;=2^196.6
 ;;^UTILITY(U,$J,358.3,28575,1,5,0)
 ;;=5^Intrapelvic
 ;;^UTILITY(U,$J,358.3,28575,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,28576,0)
 ;;=196.1^^163^1803^5
 ;;^UTILITY(U,$J,358.3,28576,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28576,1,2,0)
 ;;=2^196.1
 ;;^UTILITY(U,$J,358.3,28576,1,5,0)
 ;;=5^Intrathoracic
 ;;^UTILITY(U,$J,358.3,28576,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,28577,0)
 ;;=196.5^^163^1803^2.5
 ;;^UTILITY(U,$J,358.3,28577,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28577,1,2,0)
 ;;=2^196.5
 ;;^UTILITY(U,$J,358.3,28577,1,5,0)
 ;;=5^Inguin Reg & Low Limb
 ;;^UTILITY(U,$J,358.3,28577,2)
 ;;=^267318
 ;;^UTILITY(U,$J,358.3,28578,0)
 ;;=196.8^^163^1803^6
 ;;^UTILITY(U,$J,358.3,28578,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28578,1,2,0)
 ;;=2^196.8
 ;;^UTILITY(U,$J,358.3,28578,1,5,0)
 ;;=5^Multiple Sites
 ;;^UTILITY(U,$J,358.3,28578,2)
 ;;=^267320
 ;;^UTILITY(U,$J,358.3,28579,0)
 ;;=209.71^^163^1803^8
 ;;^UTILITY(U,$J,358.3,28579,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28579,1,2,0)
 ;;=2^209.71
 ;;^UTILITY(U,$J,358.3,28579,1,5,0)
 ;;=5^Sec Neuroendo Tu Di/Lym
 ;;^UTILITY(U,$J,358.3,28579,2)
 ;;=^338218
 ;;^UTILITY(U,$J,358.3,28580,0)
 ;;=209.72^^163^1803^9.1
 ;;^UTILITY(U,$J,358.3,28580,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28580,1,2,0)
 ;;=2^209.72
 ;;^UTILITY(U,$J,358.3,28580,1,5,0)
 ;;=5^Sec Neuroendo Tu-liver
 ;;^UTILITY(U,$J,358.3,28580,2)
 ;;=^338219
 ;;^UTILITY(U,$J,358.3,28581,0)
 ;;=209.73^^163^1803^9.2
 ;;^UTILITY(U,$J,358.3,28581,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28581,1,2,0)
 ;;=2^209.73
 ;;^UTILITY(U,$J,358.3,28581,1,5,0)
 ;;=5^Sec Neuroendo Tu-Bone
 ;;^UTILITY(U,$J,358.3,28581,2)
 ;;=^338220
 ;;^UTILITY(U,$J,358.3,28582,0)
 ;;=209.74^^163^1803^9.3
 ;;^UTILITY(U,$J,358.3,28582,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28582,1,2,0)
 ;;=2^209.74
 ;;^UTILITY(U,$J,358.3,28582,1,5,0)
 ;;=5^Sec Neuroendo Tu-Perito
 ;;^UTILITY(U,$J,358.3,28582,2)
 ;;=^338221
 ;;^UTILITY(U,$J,358.3,28583,0)
 ;;=161.3^^163^1804^1
 ;;^UTILITY(U,$J,358.3,28583,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28583,1,2,0)
 ;;=2^161.3
 ;;^UTILITY(U,$J,358.3,28583,1,5,0)
 ;;=5^Arytenoid
 ;;^UTILITY(U,$J,358.3,28583,2)
 ;;=^267132
 ;;^UTILITY(U,$J,358.3,28584,0)
 ;;=161.0^^163^1804^2
 ;;^UTILITY(U,$J,358.3,28584,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28584,1,2,0)
 ;;=2^161.0
 ;;^UTILITY(U,$J,358.3,28584,1,5,0)
 ;;=5^Glottis
 ;;^UTILITY(U,$J,358.3,28584,2)
 ;;=^267129
 ;;^UTILITY(U,$J,358.3,28585,0)
 ;;=161.2^^163^1804^3
 ;;^UTILITY(U,$J,358.3,28585,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28585,1,2,0)
 ;;=2^161.2
 ;;^UTILITY(U,$J,358.3,28585,1,5,0)
 ;;=5^Subglottis
 ;;^UTILITY(U,$J,358.3,28585,2)
 ;;=^267131
 ;;^UTILITY(U,$J,358.3,28586,0)
 ;;=161.1^^163^1804^4
 ;;^UTILITY(U,$J,358.3,28586,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,28586,1,2,0)
 ;;=2^161.1
 ;;^UTILITY(U,$J,358.3,28586,1,5,0)
 ;;=5^Supraglottis
 ;;^UTILITY(U,$J,358.3,28586,2)
 ;;=^267130
 ;;^UTILITY(U,$J,358.3,28587,0)
 ;;=161.8^^163^1804^2.5
 ;;
 ;;$END ROU IBDEI1M1
