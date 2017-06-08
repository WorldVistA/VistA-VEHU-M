NURCCG2N ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,2,0)
 ;;=840^provide comfort/preventive measures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,3,0)
 ;;=847^avoid irritants/noxious stimuli/oral irritants^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,4,0)
 ;;=848^encourage adequate food and fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,5,0)
 ;;=287^passive/active ROM q[frequency]hrs.^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,6,0)
 ;;=849^up in chair q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,7,0)
 ;;=431^ambulate with assistance q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,8,0)
 ;;=850^provide stoma care q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,9,0)
 ;;=851^teach how to maintain skin integrity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,10,0)
 ;;=852^teach radiation therapy precautions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,11,0)
 ;;=289^refer for appropriate consults^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,1,12,0)
 ;;=2970^[Extra Order]^3^NURSC^53^0
 ;;^UTILITY("^GMRD(124.2,",$J,831,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,831,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,832,0)
 ;;=Related Problems^2^NURSC^7^15^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,832,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,832,1,1,0)
 ;;=837^Tissue integrity, impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,832,1,2,0)
 ;;=838^Skin integrity, impairment, actual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,832,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,832,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,833,0)
 ;;=maintains intact skin^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,833,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,833,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,834,0)
 ;;=maintains normal skin color and temperature^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,834,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,834,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,835,0)
 ;;=identifies relevant risk factors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,835,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,835,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,836,0)
 ;;=verbalizes preventive measures^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,836,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,836,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,837,0)
 ;;=Tissue integrity, impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,838,0)
 ;;=Skin integrity, impairment, actual^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,839,0)
 ;;=perform skin assessment q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,839,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,839,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,840,0)
 ;;=provide comfort/preventive measures^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,1,0)
 ;;=841^sheepskin^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,2,0)
 ;;=842^alternating pressure pads^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,3,0)
 ;;=843^overhead bars^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,4,0)
 ;;=844^reposition q[frequency]hrs^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,5,0)
 ;;=845^massage bony prominence [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,840,1,6,0)
 ;;=846^other^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,840,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,840,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,840,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,840,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,841,0)
 ;;=sheepskin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,842,0)
 ;;=alternating pressure pads^3^NURSC^^1^^^T
