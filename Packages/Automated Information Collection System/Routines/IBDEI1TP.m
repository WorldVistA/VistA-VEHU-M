IBDEI1TP ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32124,1,3,0)
 ;;=3^Local Infection of Skin/Subcutaneous Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,32124,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,32124,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,32125,0)
 ;;=L11.0^^182^1981^9
 ;;^UTILITY(U,$J,358.3,32125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32125,1,3,0)
 ;;=3^Acquired Keratosis Follicularis
 ;;^UTILITY(U,$J,358.3,32125,1,4,0)
 ;;=4^L11.0
 ;;^UTILITY(U,$J,358.3,32125,2)
 ;;=^5009091
 ;;^UTILITY(U,$J,358.3,32126,0)
 ;;=L20.0^^182^1981^90
 ;;^UTILITY(U,$J,358.3,32126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32126,1,3,0)
 ;;=3^Besnier's Prurigo
 ;;^UTILITY(U,$J,358.3,32126,1,4,0)
 ;;=4^L20.0
 ;;^UTILITY(U,$J,358.3,32126,2)
 ;;=^5009107
 ;;^UTILITY(U,$J,358.3,32127,0)
 ;;=L20.81^^182^1981^87
 ;;^UTILITY(U,$J,358.3,32127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32127,1,3,0)
 ;;=3^Atopic Neurodermatitis
 ;;^UTILITY(U,$J,358.3,32127,1,4,0)
 ;;=4^L20.81
 ;;^UTILITY(U,$J,358.3,32127,2)
 ;;=^5009108
 ;;^UTILITY(U,$J,358.3,32128,0)
 ;;=L20.82^^182^1981^150
 ;;^UTILITY(U,$J,358.3,32128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32128,1,3,0)
 ;;=3^Flexural Eczema
 ;;^UTILITY(U,$J,358.3,32128,1,4,0)
 ;;=4^L20.82
 ;;^UTILITY(U,$J,358.3,32128,2)
 ;;=^5009109
 ;;^UTILITY(U,$J,358.3,32129,0)
 ;;=L20.84^^182^1981^163
 ;;^UTILITY(U,$J,358.3,32129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32129,1,3,0)
 ;;=3^Intrinsic Eczema
 ;;^UTILITY(U,$J,358.3,32129,1,4,0)
 ;;=4^L20.84
 ;;^UTILITY(U,$J,358.3,32129,2)
 ;;=^5009111
 ;;^UTILITY(U,$J,358.3,32130,0)
 ;;=L20.89^^182^1981^85
 ;;^UTILITY(U,$J,358.3,32130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32130,1,3,0)
 ;;=3^Atopic Dermatitis NEC
 ;;^UTILITY(U,$J,358.3,32130,1,4,0)
 ;;=4^L20.89
 ;;^UTILITY(U,$J,358.3,32130,2)
 ;;=^5009112
 ;;^UTILITY(U,$J,358.3,32131,0)
 ;;=L20.9^^182^1981^86
 ;;^UTILITY(U,$J,358.3,32131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32131,1,3,0)
 ;;=3^Atopic Dermatitis,Unspec
 ;;^UTILITY(U,$J,358.3,32131,1,4,0)
 ;;=4^L20.9
 ;;^UTILITY(U,$J,358.3,32131,2)
 ;;=^5009113
 ;;^UTILITY(U,$J,358.3,32132,0)
 ;;=L21.8^^182^1981^263
 ;;^UTILITY(U,$J,358.3,32132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32132,1,3,0)
 ;;=3^Seborrheic Dermatitis NEC
 ;;^UTILITY(U,$J,358.3,32132,1,4,0)
 ;;=4^L21.8
 ;;^UTILITY(U,$J,358.3,32132,2)
 ;;=^303310
 ;;^UTILITY(U,$J,358.3,32133,0)
 ;;=L21.9^^182^1981^264
 ;;^UTILITY(U,$J,358.3,32133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32133,1,3,0)
 ;;=3^Seborrheic Dermatitis,Unspec
 ;;^UTILITY(U,$J,358.3,32133,1,4,0)
 ;;=4^L21.9
 ;;^UTILITY(U,$J,358.3,32133,2)
 ;;=^188703
 ;;^UTILITY(U,$J,358.3,32134,0)
 ;;=L23.7^^182^1981^30
 ;;^UTILITY(U,$J,358.3,32134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32134,1,3,0)
 ;;=3^Allergic Contact Dermatitis d/t Plants
 ;;^UTILITY(U,$J,358.3,32134,1,4,0)
 ;;=4^L23.7
 ;;^UTILITY(U,$J,358.3,32134,2)
 ;;=^5009122
 ;;^UTILITY(U,$J,358.3,32135,0)
 ;;=L23.9^^182^1981^31
 ;;^UTILITY(U,$J,358.3,32135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32135,1,3,0)
 ;;=3^Allergic Contact Dermatitis,Unspec
 ;;^UTILITY(U,$J,358.3,32135,1,4,0)
 ;;=4^L23.9
 ;;^UTILITY(U,$J,358.3,32135,2)
 ;;=^5009125
 ;;^UTILITY(U,$J,358.3,32136,0)
 ;;=L24.9^^182^1981^164
 ;;^UTILITY(U,$J,358.3,32136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32136,1,3,0)
 ;;=3^Irritant Contact Dermatitis,Unspec
 ;;^UTILITY(U,$J,358.3,32136,1,4,0)
 ;;=4^L24.9
 ;;^UTILITY(U,$J,358.3,32136,2)
 ;;=^5009136
 ;;^UTILITY(U,$J,358.3,32137,0)
 ;;=L25.9^^182^1981^115
 ;;^UTILITY(U,$J,358.3,32137,1,0)
 ;;=^358.31IA^4^2
 ;;
 ;;$END ROU IBDEI1TP
