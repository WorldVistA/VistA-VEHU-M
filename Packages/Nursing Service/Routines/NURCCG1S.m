NURCCG1S ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,643,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,643,1,1,0)
 ;;=646^Etiology/Related and/or Risk Factors^2^NURSC^16^0
 ;;^UTILITY("^GMRD(124.2,",$J,643,1,2,0)
 ;;=2442^Related Problems^2^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,643,1,3,0)
 ;;=2443^Goals/Expected Outcomes^2^NURSC^67^0
 ;;^UTILITY("^GMRD(124.2,",$J,643,1,4,0)
 ;;=2444^Nursing Intervention/Orders^2^NURSC^61^0
 ;;^UTILITY("^GMRD(124.2,",$J,643,1,5,0)
 ;;=4215^Defining Characteristics^2^NURSC^33
 ;;^UTILITY("^GMRD(124.2,",$J,643,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,643,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,643,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,643,"TD",0)
 ;;=^^1^1^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,643,"TD",1,0)
 ;;=The state of changed sexual health in an individual.
 ;;^UTILITY("^GMRD(124.2,",$J,644,0)
 ;;=home maintenance management, impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,645,0)
 ;;=knowledge deficit [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,646,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^16^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,1,0)
 ;;=2726^altered body structure or function^3^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,2,0)
 ;;=2727^conflicts with sexual orientation or varient preferences^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,3,0)
 ;;=2728^fear of pregnancy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,4,0)
 ;;=2729^fear of acquiring a sexually transmitted disease^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,5,0)
 ;;=2730^illness or medical treatment^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,6,0)
 ;;=2731^impaired relationship with S/O^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,7,0)
 ;;=2732^ineffective or absent role models^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,8,0)
 ;;=2733^knowledge deficit about responses to health transitions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,9,0)
 ;;=2734^skill deficit relating to health related transitions^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,10,0)
 ;;=607^lack of privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,1,11,0)
 ;;=2735^lack of S/O^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,646,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,647,0)
 ;;=Abdominal Aortic Aneurysm Repair^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,1,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,2,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,3,0)
 ;;=124^Gas Exchange, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,4,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,5,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,6,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,7,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,8,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,647,1,9,0)
 ;;=340^Pain, Chest^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,0)
 ;;=Angina/Chest Pain^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,1,0)
 ;;=340^Pain, Chest^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,2,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,3,0)
 ;;=15^Health Maintenance, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,4,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,5,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,648,1,6,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
