NURCCGB3 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7420,"TD",1,0)
 ;;=The state in which an individual experiences increased fluid retention
 ;;^UTILITY("^GMRD(124.2,",$J,7420,"TD",2,0)
 ;;=and edema.
 ;;^UTILITY("^GMRD(124.2,",$J,7421,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^104^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7421,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7421,1,1,0)
 ;;=1509^compromised regulatory mechanism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7421,1,2,0)
 ;;=1510^excess fluid intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7421,1,3,0)
 ;;=1511^excess sodium intake^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7421,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,0)
 ;;=Related Problems^2^NURSC^7^88^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,1,0)
 ;;=1513^Cardiac Output, Decreased (Electical Factors)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,2,0)
 ;;=1514^Cardiac Output, Decreased (Mechanical Factors)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,3,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,4,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,5,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,1,6,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7425,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7432,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^82^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,1,0)
 ;;=7433^maintains optimum fluid/electrolyte balance^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,2,0)
 ;;=1530^expresses knowledge of fluid and dietary restrictions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,3,0)
 ;;=1531^relates at least 2 factors/methods of preventing edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,4,0)
 ;;=833^maintains intact skin^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,5,0)
 ;;=1533^conserves energy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,6,0)
 ;;=7449^maintains adequate circulation^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,7,0)
 ;;=7557^[Extra Goal]^3^NURSC^137
 ;;^UTILITY("^GMRD(124.2,",$J,7432,1,9,0)
 ;;=16562^compliance with prescribed treatment program^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7432,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,0)
 ;;=maintains optimum fluid/electrolyte balance^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,1,0)
 ;;=6560^balanced I/O^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,2,0)
 ;;=1520^decreased edema^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,3,0)
 ;;=1521^decreased thirst^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,4,0)
 ;;=1522^body weight is approximately [lbs/kgs]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,5,0)
 ;;=1523^stable B/P greater than [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,6,0)
 ;;=1524^stable B/P less than [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,7,0)
 ;;=1525^stable CVP greater than [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,8,0)
 ;;=1526^stable CVP less than [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,9,0)
 ;;=1527^PCW/PAD greater than [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,10,0)
 ;;=1528^PCW/PAD less than [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,1,11,0)
 ;;=1529^breath sounds free of crackles^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,7433,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7433,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7433,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7449,0)
 ;;=maintains adequate circulation^2^NURSC^9^2^1^^T^1
