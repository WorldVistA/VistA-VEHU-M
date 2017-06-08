NURCCG42 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1503,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1503,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1504,0)
 ;;=absence of inflammation^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1504,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1504,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1505,0)
 ;;=absence of purulent drainage^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1505,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1505,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1506,0)
 ;;=absence of tenderness^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1506,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1506,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1507,0)
 ;;=return of skin integrity^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1507,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1507,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1508,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^39^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1508,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1508,1,1,0)
 ;;=1509^compromised regulatory mechanism^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1508,1,2,0)
 ;;=1510^excess fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1508,1,3,0)
 ;;=1511^excess sodium intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1508,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1509,0)
 ;;=compromised regulatory mechanism^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1510,0)
 ;;=excess fluid intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1511,0)
 ;;=excess sodium intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1512,0)
 ;;=Related Problems^2^NURSC^7^29^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,1,0)
 ;;=1513^Cardiac Output, Decreased (Electical Factors)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,2,0)
 ;;=1514^Cardiac Output, Decreased (Mechanical Factors)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,3,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,4,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,5,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1512,1,6,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1512,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1513,0)
 ;;=Cardiac Output, Decreased (Electical Factors)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1514,0)
 ;;=Cardiac Output, Decreased (Mechanical Factors)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1515,0)
 ;;=Tissue Perfusion, Alteration In^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1516,0)
 ;;=Tissue Integrity, Impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1517,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^38^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,1,0)
 ;;=1518^maintains optimum fluid/electrolyte balance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,2,0)
 ;;=1530^expresses knowledge of fluid and dietary restrictions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,3,0)
 ;;=1531^relates at least 2 factors/methods of preventing edema^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,4,0)
 ;;=1532^maintains intact skin^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,5,0)
 ;;=1533^conserves energy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,6,0)
 ;;=1534^maintains adequate circulation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,1,7,0)
 ;;=2903^[Extra Goal]^3^NURSC^82^0
 ;;^UTILITY("^GMRD(124.2,",$J,1517,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1518,0)
 ;;=maintains optimum fluid/electrolyte balance^2^NURSC^9^1^1^^T^1
