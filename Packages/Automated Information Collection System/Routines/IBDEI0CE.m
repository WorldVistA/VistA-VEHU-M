IBDEI0CE ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5524,1,2,0)
 ;;=2^15782
 ;;^UTILITY(U,$J,358.3,5524,1,3,0)
 ;;=3^Dermabrasion,Regional,Not Face
 ;;^UTILITY(U,$J,358.3,5525,0)
 ;;=15783^^26^352^5^^^^1
 ;;^UTILITY(U,$J,358.3,5525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5525,1,2,0)
 ;;=2^15783
 ;;^UTILITY(U,$J,358.3,5525,1,3,0)
 ;;=3^Dermabrasion,Superficial
 ;;^UTILITY(U,$J,358.3,5526,0)
 ;;=15786^^26^352^3^^^^1
 ;;^UTILITY(U,$J,358.3,5526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5526,1,2,0)
 ;;=2^15786
 ;;^UTILITY(U,$J,358.3,5526,1,3,0)
 ;;=3^Dermabrasion,Single Lesion
 ;;^UTILITY(U,$J,358.3,5527,0)
 ;;=15787^^26^352^4^^^^1
 ;;^UTILITY(U,$J,358.3,5527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5527,1,2,0)
 ;;=2^15787
 ;;^UTILITY(U,$J,358.3,5527,1,3,0)
 ;;=3^Dermabrasion,4 Addl Lesions
 ;;^UTILITY(U,$J,358.3,5528,0)
 ;;=96900^^26^353^7^^^^1
 ;;^UTILITY(U,$J,358.3,5528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5528,1,2,0)
 ;;=2^96900
 ;;^UTILITY(U,$J,358.3,5528,1,3,0)
 ;;=3^Ultraviolet Light Therapy
 ;;^UTILITY(U,$J,358.3,5529,0)
 ;;=96910^^26^353^5^^^^1
 ;;^UTILITY(U,$J,358.3,5529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5529,1,2,0)
 ;;=2^96910
 ;;^UTILITY(U,$J,358.3,5529,1,3,0)
 ;;=3^Photochemotherapy w/ UV-B
 ;;^UTILITY(U,$J,358.3,5530,0)
 ;;=96912^^26^353^4^^^^1
 ;;^UTILITY(U,$J,358.3,5530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5530,1,2,0)
 ;;=2^96912
 ;;^UTILITY(U,$J,358.3,5530,1,3,0)
 ;;=3^Photochemotherapy w/ UV-A
 ;;^UTILITY(U,$J,358.3,5531,0)
 ;;=96567^^26^353^6^^^^1
 ;;^UTILITY(U,$J,358.3,5531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5531,1,2,0)
 ;;=2^96567
 ;;^UTILITY(U,$J,358.3,5531,1,3,0)
 ;;=3^Photodynamic Tx Skin
 ;;^UTILITY(U,$J,358.3,5532,0)
 ;;=96920^^26^353^1^^^^1
 ;;^UTILITY(U,$J,358.3,5532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5532,1,2,0)
 ;;=2^96920
 ;;^UTILITY(U,$J,358.3,5532,1,3,0)
 ;;=3^Laser Tx Skin < 250 sq cm
 ;;^UTILITY(U,$J,358.3,5533,0)
 ;;=96921^^26^353^2^^^^1
 ;;^UTILITY(U,$J,358.3,5533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5533,1,2,0)
 ;;=2^96921
 ;;^UTILITY(U,$J,358.3,5533,1,3,0)
 ;;=3^Laser Tx Skin 250-500 sq cm
 ;;^UTILITY(U,$J,358.3,5534,0)
 ;;=96922^^26^353^3^^^^1
 ;;^UTILITY(U,$J,358.3,5534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5534,1,2,0)
 ;;=2^96922
 ;;^UTILITY(U,$J,358.3,5534,1,3,0)
 ;;=3^Laser Tx Skin > 500 sq cm
 ;;^UTILITY(U,$J,358.3,5535,0)
 ;;=13151^^26^354^1^^^^1
 ;;^UTILITY(U,$J,358.3,5535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5535,1,2,0)
 ;;=2^13151
 ;;^UTILITY(U,$J,358.3,5535,1,3,0)
 ;;=3^Complex Repair Face;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5536,0)
 ;;=13152^^26^354^2^^^^1
 ;;^UTILITY(U,$J,358.3,5536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5536,1,2,0)
 ;;=2^13152
 ;;^UTILITY(U,$J,358.3,5536,1,3,0)
 ;;=3^Complex Repair Face;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5537,0)
 ;;=13153^^26^354^3^^^^1
 ;;^UTILITY(U,$J,358.3,5537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5537,1,2,0)
 ;;=2^13153
 ;;^UTILITY(U,$J,358.3,5537,1,3,0)
 ;;=3^Complex Repair Face;Ea Addl 5 cm
 ;;^UTILITY(U,$J,358.3,5538,0)
 ;;=13131^^26^355^1^^^^1
 ;;^UTILITY(U,$J,358.3,5538,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5538,1,2,0)
 ;;=2^13131
 ;;^UTILITY(U,$J,358.3,5538,1,3,0)
 ;;=3^Complex Repair Nk/Hd/Ft;1.1 to 2.5 cm
 ;;^UTILITY(U,$J,358.3,5539,0)
 ;;=13132^^26^355^2^^^^1
 ;;^UTILITY(U,$J,358.3,5539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5539,1,2,0)
 ;;=2^13132
 ;;^UTILITY(U,$J,358.3,5539,1,3,0)
 ;;=3^Complex Repair Nk/Hd/Ft;2.6 to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5540,0)
 ;;=13133^^26^355^3^^^^1
 ;;
 ;;$END ROU IBDEI0CE
