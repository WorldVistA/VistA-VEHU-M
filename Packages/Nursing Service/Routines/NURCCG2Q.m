NURCCG2Q ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,1,0)
 ;;=2451^assess S/S of sleep-pattern disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,2,0)
 ;;=2394^medicate as prescribed by MD^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,3,0)
 ;;=870^assess length of time and time of day naps are taken^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,4,0)
 ;;=871^assess length of time patient is awake at night^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,5,0)
 ;;=873^discuss pros/cons of napping^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,6,0)
 ;;=872^increase daytime activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,7,0)
 ;;=874^decrease stimulants from [time] until [time]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,8,0)
 ;;=875^avoid stimulants and foods difficult to digest at bedtime^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,9,0)
 ;;=876^schedule tests to allow for uninterrupted periods of sleep^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,10,0)
 ;;=877^limit amount of fluids after [time]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,11,0)
 ;;=878^listen to pt if pt appears anxious or needs to talk^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,12,0)
 ;;=879^offer comfort measures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,13,0)
 ;;=2466^schedule rest periods early in the day^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,14,0)
 ;;=2477^assist with the use and care of respiratory equipment^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,15,0)
 ;;=2481^teach patient and S/O^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,16,0)
 ;;=2751^assess usual sleep pattern^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,1,17,0)
 ;;=2971^[Extra Order]^3^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,858,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,858,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,859,0)
 ;;=environmental changes, social cues^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,860,0)
 ;;=Acute Myocardial Infarction^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,1,0)
 ;;=340^Pain, Chest^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,2,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,3,0)
 ;;=339^Cardiac Output, Decreased (Electrical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,4,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,5,0)
 ;;=344^Knowledge Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,6,0)
 ;;=558^Spiritual Distress^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,7,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,8,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,9,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,10,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,11,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,12,0)
 ;;=1362^Cardiac Output, Decreased (Mechanical Factors)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,860,1,13,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,861,0)
 ;;=illness, psychologic stress^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,862,0)
 ;;=identifies techniques to fall asleep^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,862,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,862,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,863,0)
 ;;=falls asleep within one hour of going to bed^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,863,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,863,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,864,0)
 ;;=sleeps for 90 minute period without awakening^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,864,9)
 ;;=D EN5^NURCCPU0
