IBDEI17C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21262,0)
 ;;=35471^^117^1326^30^^^^1
 ;;^UTILITY(U,$J,358.3,21262,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21262,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,21262,1,3,0)
 ;;=3^Perc Angioplasty, Renal/Visc
 ;;^UTILITY(U,$J,358.3,21263,0)
 ;;=36215^^117^1326^42^^^^1
 ;;^UTILITY(U,$J,358.3,21263,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21263,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,21263,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,21264,0)
 ;;=36011^^117^1326^43^^^^1
 ;;^UTILITY(U,$J,358.3,21264,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21264,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,21264,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jugular)
 ;;^UTILITY(U,$J,358.3,21265,0)
 ;;=36245^^117^1326^39^^^^1
 ;;^UTILITY(U,$J,358.3,21265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21265,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,21265,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,21266,0)
 ;;=36246^^117^1326^40^^^^1
 ;;^UTILITY(U,$J,358.3,21266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21266,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,21266,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,21267,0)
 ;;=36247^^117^1326^41^^^^1
 ;;^UTILITY(U,$J,358.3,21267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21267,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,21267,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelv/LE Artery
 ;;^UTILITY(U,$J,358.3,21268,0)
 ;;=75962^^117^1326^59^^^^1
 ;;^UTILITY(U,$J,358.3,21268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21268,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,21268,1,3,0)
 ;;=3^Translum Ball Angioplasty,Peripheral Artery, Rad S&I
 ;;^UTILITY(U,$J,358.3,21269,0)
 ;;=75964^^117^1326^1^^^^1
 ;;^UTILITY(U,$J,358.3,21269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21269,1,2,0)
 ;;=2^75964
 ;;^UTILITY(U,$J,358.3,21269,1,3,0)
 ;;=3^     Each Add Artery (W/75962)
 ;;^UTILITY(U,$J,358.3,21270,0)
 ;;=75791^^117^1326^10^^^^1
 ;;^UTILITY(U,$J,358.3,21270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21270,1,2,0)
 ;;=2^75791
 ;;^UTILITY(U,$J,358.3,21270,1,3,0)
 ;;=3^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,21271,0)
 ;;=37220^^117^1326^22^^^^1
 ;;^UTILITY(U,$J,358.3,21271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21271,1,2,0)
 ;;=2^37220
 ;;^UTILITY(U,$J,358.3,21271,1,3,0)
 ;;=3^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,21272,0)
 ;;=37221^^117^1326^20^^^^1
 ;;^UTILITY(U,$J,358.3,21272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21272,1,2,0)
 ;;=2^37221
 ;;^UTILITY(U,$J,358.3,21272,1,3,0)
 ;;=3^Iliac Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,21273,0)
 ;;=37222^^117^1326^23^^^^1
 ;;^UTILITY(U,$J,358.3,21273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21273,1,2,0)
 ;;=2^37222
 ;;^UTILITY(U,$J,358.3,21273,1,3,0)
 ;;=3^Iliac Revasc,ea add Vessel
 ;;^UTILITY(U,$J,358.3,21274,0)
 ;;=37223^^117^1326^21^^^^1
 ;;^UTILITY(U,$J,358.3,21274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21274,1,2,0)
 ;;=2^37223
 ;;^UTILITY(U,$J,358.3,21274,1,3,0)
 ;;=3^Iliac Revasc w/Stent,Add-on
 ;;^UTILITY(U,$J,358.3,21275,0)
 ;;=37224^^117^1326^17^^^^1
 ;;^UTILITY(U,$J,358.3,21275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21275,1,2,0)
 ;;=2^37224
 ;;^UTILITY(U,$J,358.3,21275,1,3,0)
 ;;=3^Fem/Popl Revas w/TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,21276,0)
 ;;=37225^^117^1326^16^^^^1
 ;;^UTILITY(U,$J,358.3,21276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21276,1,2,0)
 ;;=2^37225
 ;;^UTILITY(U,$J,358.3,21276,1,3,0)
 ;;=3^Fem/Popl Revas w/Ather
 ;;^UTILITY(U,$J,358.3,21277,0)
 ;;=37226^^117^1326^18^^^^1
 ;;
 ;;$END ROU IBDEI17C
