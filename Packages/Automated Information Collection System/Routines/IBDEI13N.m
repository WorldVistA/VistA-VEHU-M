IBDEI13N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19399,0)
 ;;=626.5^^105^1231^38
 ;;^UTILITY(U,$J,358.3,19399,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19399,1,4,0)
 ;;=4^626.5
 ;;^UTILITY(U,$J,358.3,19399,1,5,0)
 ;;=5^Ovulation Bleeding
 ;;^UTILITY(U,$J,358.3,19399,2)
 ;;=Ovulation Bleeding^270570
 ;;^UTILITY(U,$J,358.3,19400,0)
 ;;=625.2^^105^1231^39
 ;;^UTILITY(U,$J,358.3,19400,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19400,1,4,0)
 ;;=4^625.2
 ;;^UTILITY(U,$J,358.3,19400,1,5,0)
 ;;=5^Ovulation Pain
 ;;^UTILITY(U,$J,358.3,19400,2)
 ;;=Ovulation Pain^265259
 ;;^UTILITY(U,$J,358.3,19401,0)
 ;;=614.9^^105^1231^42
 ;;^UTILITY(U,$J,358.3,19401,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19401,1,4,0)
 ;;=4^614.9
 ;;^UTILITY(U,$J,358.3,19401,1,5,0)
 ;;=5^Pelvic inflammatory disease
 ;;^UTILITY(U,$J,358.3,19401,2)
 ;;=^3537
 ;;^UTILITY(U,$J,358.3,19402,0)
 ;;=789.30^^105^1231^40
 ;;^UTILITY(U,$J,358.3,19402,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19402,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,19402,1,5,0)
 ;;=5^Pelvic Mass
 ;;^UTILITY(U,$J,358.3,19402,2)
 ;;=Pelvic Mass^917
 ;;^UTILITY(U,$J,358.3,19403,0)
 ;;=622.7^^105^1231^44
 ;;^UTILITY(U,$J,358.3,19403,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19403,1,4,0)
 ;;=4^622.7
 ;;^UTILITY(U,$J,358.3,19403,1,5,0)
 ;;=5^Polyp of Cervix
 ;;^UTILITY(U,$J,358.3,19403,2)
 ;;=Polyp of Cervix^79612
 ;;^UTILITY(U,$J,358.3,19404,0)
 ;;=627.1^^105^1231^45
 ;;^UTILITY(U,$J,358.3,19404,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19404,1,4,0)
 ;;=4^627.1
 ;;^UTILITY(U,$J,358.3,19404,1,5,0)
 ;;=5^Postmenopausal bleeding
 ;;^UTILITY(U,$J,358.3,19404,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,19405,0)
 ;;=V24.2^^105^1231^46
 ;;^UTILITY(U,$J,358.3,19405,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19405,1,4,0)
 ;;=4^V24.2
 ;;^UTILITY(U,$J,358.3,19405,1,5,0)
 ;;=5^Postpartum
 ;;^UTILITY(U,$J,358.3,19405,2)
 ;;=Postpartum^114052
 ;;^UTILITY(U,$J,358.3,19406,0)
 ;;=V22.2^^105^1231^47
 ;;^UTILITY(U,$J,358.3,19406,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19406,1,4,0)
 ;;=4^V22.2
 ;;^UTILITY(U,$J,358.3,19406,1,5,0)
 ;;=5^Pregnancy Status
 ;;^UTILITY(U,$J,358.3,19406,2)
 ;;=Pregnancy Status^97923
 ;;^UTILITY(U,$J,358.3,19407,0)
 ;;=627.0^^105^1231^48
 ;;^UTILITY(U,$J,358.3,19407,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19407,1,4,0)
 ;;=4^627.0
 ;;^UTILITY(U,$J,358.3,19407,1,5,0)
 ;;=5^Premenopausal menorrhagia
 ;;^UTILITY(U,$J,358.3,19407,2)
 ;;=^270575
 ;;^UTILITY(U,$J,358.3,19408,0)
 ;;=625.4^^105^1231^49
 ;;^UTILITY(U,$J,358.3,19408,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19408,1,4,0)
 ;;=4^625.4
 ;;^UTILITY(U,$J,358.3,19408,1,5,0)
 ;;=5^Premenstrual tension
 ;;^UTILITY(U,$J,358.3,19408,2)
 ;;=^98014
 ;;^UTILITY(U,$J,358.3,19409,0)
 ;;=302.70^^105^1231^51
 ;;^UTILITY(U,$J,358.3,19409,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19409,1,4,0)
 ;;=4^302.70
 ;;^UTILITY(U,$J,358.3,19409,1,5,0)
 ;;=5^Sexual dysfunction, psychosexual
 ;;^UTILITY(U,$J,358.3,19409,2)
 ;;=^100647
 ;;^UTILITY(U,$J,358.3,19410,0)
 ;;=599.0^^105^1231^55
 ;;^UTILITY(U,$J,358.3,19410,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19410,1,4,0)
 ;;=4^599.0
 ;;^UTILITY(U,$J,358.3,19410,1,5,0)
 ;;=5^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,19410,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,19411,0)
 ;;=218.9^^105^1231^56
 ;;^UTILITY(U,$J,358.3,19411,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,19411,1,4,0)
 ;;=4^218.9
 ;;^UTILITY(U,$J,358.3,19411,1,5,0)
 ;;=5^Uterine Fibroids
 ;;^UTILITY(U,$J,358.3,19411,2)
 ;;=Uterine Fibroids^68944
 ;;^UTILITY(U,$J,358.3,19412,0)
 ;;=618.1^^105^1231^57
 ;;^UTILITY(U,$J,358.3,19412,1,0)
 ;;=^358.31IA^5^2
 ;;
 ;;$END ROU IBDEI13N
