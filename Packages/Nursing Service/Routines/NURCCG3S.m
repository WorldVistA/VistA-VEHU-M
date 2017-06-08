NURCCG3S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1355,0)
 ;;=prepare Isuprel drip for IV infusion^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1356,0)
 ;;=prepare for temporary cardiac pacemaker^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1357,0)
 ;;=lethal dysrhythmia (no pulse/respirations) interventions^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1357,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1357,1,1,0)
 ;;=1358^give precordial thump (see protocol)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1357,1,2,0)
 ;;=1359^defibrillate according to ACLS protocol^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1357,1,3,0)
 ;;=1360^call a 'code'^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1357,1,4,0)
 ;;=1361^follow CPR procedure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1357,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,1357,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1357,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1357,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1358,0)
 ;;=give precordial thump (see protocol)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1359,0)
 ;;=defibrillate according to ACLS protocol^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1360,0)
 ;;=call a 'code'^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1361,0)
 ;;=follow CPR procedure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1362,0)
 ;;=Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1362,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,1362,1,1,0)
 ;;=1369^Etiology/Related and/or Risk Factors^2^NURSC^37^0
 ;;^UTILITY("^GMRD(124.2,",$J,1362,1,2,0)
 ;;=1380^Related Problems^2^NURSC^27^0
 ;;^UTILITY("^GMRD(124.2,",$J,1362,1,3,0)
 ;;=1388^Goals/Expected Outcomes^2^NURSC^36^0
 ;;^UTILITY("^GMRD(124.2,",$J,1362,1,4,0)
 ;;=1391^Nursing Intervention/Orders^2^NURSC^33^0
 ;;^UTILITY("^GMRD(124.2,",$J,1362,1,5,0)
 ;;=4119^Defining Characteristics^2^NURSC^17
 ;;^UTILITY("^GMRD(124.2,",$J,1362,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,1362,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1362,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1363,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^36^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1363,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,1363,1,1,0)
 ;;=1367^blockage^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1363,1,2,0)
 ;;=1368^high urethral pressure caused by weak detrusor^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1363,1,3,0)
 ;;=1370^inhibition of reflex arc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1363,1,4,0)
 ;;=1371^strong sphincter^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1363,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1364,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^35^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,1,0)
 ;;=1263^achieves residual urine <[amt] cc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,2,0)
 ;;=1374^demonstrates an established voiding/cath pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,3,0)
 ;;=1381^states frequency for performance of management program^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,4,0)
 ;;=1382^states S/S of complications (infect./incontinence)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,5,0)
 ;;=980^verbalizes medication regimen^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,6,0)
 ;;=1384^maintains adequate bladder emptying^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,1,7,0)
 ;;=2900^[Extra Goal]^3^NURSC^79^0
 ;;^UTILITY("^GMRD(124.2,",$J,1364,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1365,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^32^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,0)
 ;;=^124.21PI^16^16
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,1,0)
 ;;=583^assess causative, contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1365,1,2,0)
 ;;=1390^record I/O until voiding <[amt]cc void/residual <[amt]cc^3^NURSC^1^0
