NURCCG1B ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,454,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,454,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,455,0)
 ;;=tracheostomy care q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,455,5)
 ;;=as ordered or per protocol
 ;;^UTILITY("^GMRD(124.2,",$J,455,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,455,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,456,0)
 ;;=provide patient teaching (Gas Exchange, Impaired)^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,1,0)
 ;;=457^discuss risk factors [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,2,0)
 ;;=458^disease process^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,3,0)
 ;;=459^medications^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,4,0)
 ;;=460^pulmonary hygiene^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,5,0)
 ;;=461^signs of infection (for reporting to health care provider)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,6,0)
 ;;=462^inhalation equipment and oxygen therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,7,0)
 ;;=463^fire and safety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,8,0)
 ;;=464^ventilator use, cleaning, assembly, and back-up equipment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,9,0)
 ;;=465^suctioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,10,0)
 ;;=466^emergency care^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,1,11,0)
 ;;=2712^tracheostomy care q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,456,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,456,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,456,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,456,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,457,0)
 ;;=discuss risk factors [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,458,0)
 ;;=disease process^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,459,0)
 ;;=medications^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,460,0)
 ;;=pulmonary hygiene^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,461,0)
 ;;=signs of infection (for reporting to health care provider)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,462,0)
 ;;=inhalation equipment and oxygen therapy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,463,0)
 ;;=fire and safety^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,464,0)
 ;;=ventilator use, cleaning, assembly, and back-up equipment^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,465,0)
 ;;=suctioning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,466,0)
 ;;=emergency care^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,467,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^11^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,1,0)
 ;;=477^chronic disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,2,0)
 ;;=478^immunosuppression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,3,0)
 ;;=93^inadequate support system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,4,0)
 ;;=480^inadequate primary defenses^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,5,0)
 ;;=481^inadequate secondary defenses^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,6,0)
 ;;=482^malnutrition^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,7,0)
 ;;=483^medical procedures^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,8,0)
 ;;=484^pharmaceutical agents^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,9,0)
 ;;=485^tissue destruction and increased environmental exposure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,10,0)
 ;;=309^trauma^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,11,0)
 ;;=448^blood flow, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,12,0)
 ;;=486^oxygen flow, altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,467,1,13,0)
 ;;=487^mucous membrane trauma (suctioning/bronchoscopy)^3^NURSC^1^0
