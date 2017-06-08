NURCCGCO ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10072,0)
 ;;=Related Problems^2^NURSC^7^117^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,0)
 ;;=^124.21PI^9^6
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,1,0)
 ;;=1917^Self-Care Deficit [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,3,0)
 ;;=2376^Injury, Potential For^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10072,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10083,0)
 ;;=Defining Characteristics^2^NURSC^12^119^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10083,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,10083,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10083,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10083,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10083,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10083,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10089,0)
 ;;=Pain, Chronic^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10089,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10089,1,1,0)
 ;;=10090^Etiology/Related and/or Risk Factors^2^NURSC^138
 ;;^UTILITY("^GMRD(124.2,",$J,10089,1,2,0)
 ;;=10107^Goals/Expected Outcomes^2^NURSC^136
 ;;^UTILITY("^GMRD(124.2,",$J,10089,1,3,0)
 ;;=10112^Nursing Intervention/Orders^2^NURSC^115
 ;;^UTILITY("^GMRD(124.2,",$J,10089,1,4,0)
 ;;=10122^Related Problems^2^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,10089,1,5,0)
 ;;=10199^Defining Characteristics^2^NURSC^121
 ;;^UTILITY("^GMRD(124.2,",$J,10089,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10089,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10089,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10089,"TD",0)
 ;;=^^1^1^2890802^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,10089,"TD",1,0)
 ;;=A state of discomfort that continues for more than 6 months in duration.
 ;;^UTILITY("^GMRD(124.2,",$J,10090,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^138^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10090,1,0)
 ;;=^124.21PI^6^3
 ;;^UTILITY("^GMRD(124.2,",$J,10090,1,2,0)
 ;;=10092^tissue injury^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10090,1,4,0)
 ;;=1349^altered tissue perfusion, too little (ischemia, etc.)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10090,1,6,0)
 ;;=2778^inflammation injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10090,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,0)
 ;;=tissue injury^2^NURSC^^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,1,0)
 ;;=1343^inflammation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,2,0)
 ;;=1344^infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,3,0)
 ;;=309^trauma^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,4,0)
 ;;=1345^surgical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,5,0)
 ;;=1346^chemotherapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,6,0)
 ;;=1347^alcohol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,1,7,0)
 ;;=827^radiation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10092,5)
 ;;=due to
 ;;^UTILITY("^GMRD(124.2,",$J,10092,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10107,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^136^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10107,1,0)
 ;;=^124.21PI^6^4
 ;;^UTILITY("^GMRD(124.2,",$J,10107,1,1,0)
 ;;=1059^verbalizes level of comfort/pain^3^NURSC^2
