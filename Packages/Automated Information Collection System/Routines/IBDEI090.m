IBDEI090 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3753,1,5,0)
 ;;=5^Cont/Exp Hazard Sub NEC
 ;;^UTILITY(U,$J,358.3,3753,2)
 ;;=^336815
 ;;^UTILITY(U,$J,358.3,3754,0)
 ;;=310.0^^11^167^1
 ;;^UTILITY(U,$J,358.3,3754,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3754,1,2,0)
 ;;=2^310.0
 ;;^UTILITY(U,$J,358.3,3754,1,5,0)
 ;;=5^Frontal Lobe Syndrome
 ;;^UTILITY(U,$J,358.3,3754,2)
 ;;=^265201
 ;;^UTILITY(U,$J,358.3,3755,0)
 ;;=310.1^^11^167^3
 ;;^UTILITY(U,$J,358.3,3755,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3755,1,2,0)
 ;;=2^310.1
 ;;^UTILITY(U,$J,358.3,3755,1,5,0)
 ;;=5^Personality Chg d/t TBI/Lesion
 ;;^UTILITY(U,$J,358.3,3755,2)
 ;;=^331953
 ;;^UTILITY(U,$J,358.3,3756,0)
 ;;=310.2^^11^167^4
 ;;^UTILITY(U,$J,358.3,3756,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3756,1,2,0)
 ;;=2^310.2
 ;;^UTILITY(U,$J,358.3,3756,1,5,0)
 ;;=5^Postconcussion Syndrome
 ;;^UTILITY(U,$J,358.3,3756,2)
 ;;=^265160
 ;;^UTILITY(U,$J,358.3,3757,0)
 ;;=310.81^^11^167^5
 ;;^UTILITY(U,$J,358.3,3757,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3757,1,2,0)
 ;;=2^310.81
 ;;^UTILITY(U,$J,358.3,3757,1,5,0)
 ;;=5^Pseudobulbar Affect
 ;;^UTILITY(U,$J,358.3,3757,2)
 ;;=^340506
 ;;^UTILITY(U,$J,358.3,3758,0)
 ;;=310.89^^11^167^2
 ;;^UTILITY(U,$J,358.3,3758,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3758,1,2,0)
 ;;=2^310.89
 ;;^UTILITY(U,$J,358.3,3758,1,5,0)
 ;;=5^Mental D/O d/t Brain Damage,Oth Spec
 ;;^UTILITY(U,$J,358.3,3758,2)
 ;;=^268320
 ;;^UTILITY(U,$J,358.3,3759,0)
 ;;=388.43^^12^168^55
 ;;^UTILITY(U,$J,358.3,3759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3759,1,3,0)
 ;;=3^388.43
 ;;^UTILITY(U,$J,358.3,3759,1,4,0)
 ;;=4^Impairm Auditory Discrim
 ;;^UTILITY(U,$J,358.3,3759,2)
 ;;=^269533
 ;;^UTILITY(U,$J,358.3,3760,0)
 ;;=780.4^^12^168^48
 ;;^UTILITY(U,$J,358.3,3760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3760,1,3,0)
 ;;=3^780.4
 ;;^UTILITY(U,$J,358.3,3760,1,4,0)
 ;;=4^Dizziness And Giddiness
 ;;^UTILITY(U,$J,358.3,3760,2)
 ;;=^35946
 ;;^UTILITY(U,$J,358.3,3761,0)
 ;;=381.9^^12^168^51
 ;;^UTILITY(U,$J,358.3,3761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3761,1,3,0)
 ;;=3^381.9
 ;;^UTILITY(U,$J,358.3,3761,1,4,0)
 ;;=4^Eustachian Tube Dis Nos
 ;;^UTILITY(U,$J,358.3,3761,2)
 ;;=^269394
 ;;^UTILITY(U,$J,358.3,3762,0)
 ;;=381.81^^12^168^49
 ;;^UTILITY(U,$J,358.3,3762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3762,1,3,0)
 ;;=3^381.81
 ;;^UTILITY(U,$J,358.3,3762,1,4,0)
 ;;=4^Dysfunct Eustachian Tube
 ;;^UTILITY(U,$J,358.3,3762,2)
 ;;=^259074
 ;;^UTILITY(U,$J,358.3,3763,0)
 ;;=381.60^^12^168^66
 ;;^UTILITY(U,$J,358.3,3763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3763,1,3,0)
 ;;=3^381.60
 ;;^UTILITY(U,$J,358.3,3763,1,4,0)
 ;;=4^Obstr Eustach Tube Nos
 ;;^UTILITY(U,$J,358.3,3763,2)
 ;;=^259070
 ;;^UTILITY(U,$J,358.3,3764,0)
 ;;=381.7^^12^168^76
 ;;^UTILITY(U,$J,358.3,3764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3764,1,3,0)
 ;;=3^381.7
 ;;^UTILITY(U,$J,358.3,3764,1,4,0)
 ;;=4^Patulous Eustachian Tube
 ;;^UTILITY(U,$J,358.3,3764,2)
 ;;=^269391
 ;;^UTILITY(U,$J,358.3,3765,0)
 ;;=386.40^^12^168^58
 ;;^UTILITY(U,$J,358.3,3765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3765,1,3,0)
 ;;=3^386.40
 ;;^UTILITY(U,$J,358.3,3765,1,4,0)
 ;;=4^Labyrinthine Fistula Nos
 ;;^UTILITY(U,$J,358.3,3765,2)
 ;;=^269496
 ;;^UTILITY(U,$J,358.3,3766,0)
 ;;=388.42^^12^168^53
 ;;^UTILITY(U,$J,358.3,3766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3766,1,3,0)
 ;;=3^388.42
 ;;^UTILITY(U,$J,358.3,3766,1,4,0)
 ;;=4^Hyperacusis
 ;;^UTILITY(U,$J,358.3,3766,2)
 ;;=^264043
 ;;^UTILITY(U,$J,358.3,3767,0)
 ;;=380.4^^12^168^54
 ;;^UTILITY(U,$J,358.3,3767,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI090
