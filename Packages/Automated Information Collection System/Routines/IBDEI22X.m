IBDEI22X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.5)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.5,192,2,0)
 ;;=^358.52^2^2
 ;;^UTILITY(U,$J,358.5,192,2,1,0)
 ;;=DOB:^^^60^1^1^65^12^1
 ;;^UTILITY(U,$J,358.5,192,2,2,0)
 ;;=Age:^^^78^1^1^83^3^2
 ;;^UTILITY(U,$J,358.5,193,0)
 ;;=HEADER^248
 ;;^UTILITY(U,$J,358.5,193,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,193,2,1,0)
 ;;=NATIONAL MENTAL HEALTH - PSYCHOLOGIST^^^0^0
 ;;^UTILITY(U,$J,358.5,194,0)
 ;;=Patient name^249^5
 ;;^UTILITY(U,$J,358.5,194,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,194,2,1,0)
 ;;=Name:^^^1^1^1^7^30^1
 ;;^UTILITY(U,$J,358.5,195,0)
 ;;=SSN^249^6
 ;;^UTILITY(U,$J,358.5,195,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,195,2,1,0)
 ;;=SSN:^^^39^1^1^44^15^1
 ;;^UTILITY(U,$J,358.5,196,0)
 ;;=Age^249^7
 ;;^UTILITY(U,$J,358.5,196,2,0)
 ;;=^358.52^2^2
 ;;^UTILITY(U,$J,358.5,196,2,1,0)
 ;;=DOB:^^^60^1^1^65^12^1
 ;;^UTILITY(U,$J,358.5,196,2,2,0)
 ;;=Age:^^^78^1^1^83^3^2
 ;;^UTILITY(U,$J,358.5,197,0)
 ;;=HEADER^253
 ;;^UTILITY(U,$J,358.5,197,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,197,2,1,0)
 ;;=NATIONAL INPATIENT REHAB PHYSIATRY^^^0^0
 ;;^UTILITY(U,$J,358.5,198,0)
 ;;=Patient name^254^5
 ;;^UTILITY(U,$J,358.5,198,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,198,2,1,0)
 ;;=Name:^^^1^1^1^7^30^1
 ;;^UTILITY(U,$J,358.5,199,0)
 ;;=SSN^254^6
 ;;^UTILITY(U,$J,358.5,199,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,199,2,1,0)
 ;;=SSN:^^^39^1^1^44^15^1
 ;;^UTILITY(U,$J,358.5,200,0)
 ;;=Age^254^7
 ;;^UTILITY(U,$J,358.5,200,2,0)
 ;;=^358.52^2^2
 ;;^UTILITY(U,$J,358.5,200,2,1,0)
 ;;=DOB:^^^60^1^1^65^12^1
 ;;^UTILITY(U,$J,358.5,200,2,2,0)
 ;;=Age:^^^78^1^1^83^3^2
 ;;^UTILITY(U,$J,358.5,201,0)
 ;;=HEADER^258
 ;;^UTILITY(U,$J,358.5,201,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,201,2,1,0)
 ;;=NATIONAL REHAB PHYSIATRY^^^0^0
 ;;^UTILITY(U,$J,358.5,202,0)
 ;;=Patient name^259^5
 ;;^UTILITY(U,$J,358.5,202,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,202,2,1,0)
 ;;=Name:^^^1^1^1^7^30^1
 ;;^UTILITY(U,$J,358.5,203,0)
 ;;=SSN^259^6
 ;;^UTILITY(U,$J,358.5,203,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,203,2,1,0)
 ;;=SSN:^^^39^1^1^44^15^1
 ;;^UTILITY(U,$J,358.5,204,0)
 ;;=Age^259^7
 ;;^UTILITY(U,$J,358.5,204,2,0)
 ;;=^358.52^2^2
 ;;^UTILITY(U,$J,358.5,204,2,1,0)
 ;;=DOB:^^^60^1^1^65^12^1
 ;;^UTILITY(U,$J,358.5,204,2,2,0)
 ;;=Age:^^^78^1^1^83^3^2
 ;;^UTILITY(U,$J,358.5,205,0)
 ;;=HEADER^263
 ;;^UTILITY(U,$J,358.5,205,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,205,2,1,0)
 ;;=NATIONAL PREVENTIVE HEALTH^^^0^0
 ;;^UTILITY(U,$J,358.5,206,0)
 ;;=Patient name^264^5
 ;;^UTILITY(U,$J,358.5,206,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,206,2,1,0)
 ;;=Name:^^^1^1^1^7^30^1
 ;;^UTILITY(U,$J,358.5,207,0)
 ;;=SSN^264^6
 ;;^UTILITY(U,$J,358.5,207,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,207,2,1,0)
 ;;=SSN:^^^39^1^1^44^15^1
 ;;^UTILITY(U,$J,358.5,208,0)
 ;;=Age^264^7
 ;;^UTILITY(U,$J,358.5,208,2,0)
 ;;=^358.52^2^2
 ;;^UTILITY(U,$J,358.5,208,2,1,0)
 ;;=DOB:^^^60^1^1^65^12^1
 ;;^UTILITY(U,$J,358.5,208,2,2,0)
 ;;=Age:^^^78^1^1^83^3^2
 ;;^UTILITY(U,$J,358.5,209,0)
 ;;=HEADER^267
 ;;^UTILITY(U,$J,358.5,209,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,209,2,1,0)
 ;;=NATIONAL RADIATION THERAPY^^B^0^0
 ;;^UTILITY(U,$J,358.5,210,0)
 ;;=Patient name^271^5
 ;;^UTILITY(U,$J,358.5,210,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,210,2,1,0)
 ;;=Name:^^^1^1^1^7^30^1
 ;;^UTILITY(U,$J,358.5,211,0)
 ;;=SSN^271^6
 ;;^UTILITY(U,$J,358.5,211,2,0)
 ;;=^358.52^1^1
 ;;^UTILITY(U,$J,358.5,211,2,1,0)
 ;;=SSN:^^^39^1^1^44^15^1
 ;;^UTILITY(U,$J,358.5,212,0)
 ;;=Age^271^7
 ;;^UTILITY(U,$J,358.5,212,2,0)
 ;;=^358.52^2^2
 ;;^UTILITY(U,$J,358.5,212,2,1,0)
 ;;=DOB:^^^60^1^1^65^12^1
 ;;^UTILITY(U,$J,358.5,212,2,2,0)
 ;;=Age:^^^78^1^1^83^3^2
 ;;
 ;;$END ROU IBDEI22X
