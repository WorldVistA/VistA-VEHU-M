NURCCG43 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,1,0)
 ;;=1519^balanced I/O, urine ouput WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,2,0)
 ;;=1520^decreased edema^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,3,0)
 ;;=1521^decreased thirst^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,4,0)
 ;;=1522^body weight is approximately [lbs/kgs]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,5,0)
 ;;=1523^stable B/P greater than [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,6,0)
 ;;=1524^stable B/P less than [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,7,0)
 ;;=1525^stable CVP greater than [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,8,0)
 ;;=1526^stable CVP less than [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,9,0)
 ;;=1527^PCW/PAD greater than [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,10,0)
 ;;=1528^PCW/PAD less than [ ]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,1,11,0)
 ;;=1529^breath sounds free of crackles^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,1518,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1518,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1518,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1519,0)
 ;;=balanced I/O, urine ouput WNL^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1520,0)
 ;;=decreased edema^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1521,0)
 ;;=decreased thirst^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1522,0)
 ;;=body weight is approximately [lbs/kgs]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1523,0)
 ;;=stable B/P greater than [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1524,0)
 ;;=stable B/P less than [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1525,0)
 ;;=stable CVP greater than [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1526,0)
 ;;=stable CVP less than [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1527,0)
 ;;=PCW/PAD greater than [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1528,0)
 ;;=PCW/PAD less than [ ]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1529,0)
 ;;=breath sounds free of crackles^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1530,0)
 ;;=expresses knowledge of fluid and dietary restrictions^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1530,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1530,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1531,0)
 ;;=relates at least 2 factors/methods of preventing edema^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1531,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1531,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1532,0)
 ;;=maintains intact skin^3^NURSC^9^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1532,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1532,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1533,0)
 ;;=conserves energy^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1533,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1533,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1534,0)
 ;;=maintains adequate circulation^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1534,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,1534,1,1,0)
 ;;=1535^healthy skin color and turgor^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1534,1,2,0)
 ;;=1536^free from pain in extremities^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1534,1,3,0)
 ;;=1537^normal response to stimuli^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1534,5)
 ;;=as evidenced by:
 ;;^UTILITY("^GMRD(124.2,",$J,1534,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1534,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1534,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1535,0)
 ;;=healthy skin color and turgor^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1535,9)
 ;;=D EN5^NURCCPU0
