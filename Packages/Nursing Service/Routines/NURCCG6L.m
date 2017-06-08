NURCCG6L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,2746,0)
 ;;=normal sinus rhythm^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2747,0)
 ;;=teach patient^2^NURSC^11^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,2747,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,2747,1,1,0)
 ;;=1080^risk factors, preventive measures for CAD^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2747,1,2,0)
 ;;=1079^avoidance of Valsalva maneuver^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2747,1,3,0)
 ;;=1006^about critical care environment and routines^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2747,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,2747,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2747,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2748,0)
 ;;=free from edema/swelling^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2749,0)
 ;;=actions to take to prevent cross-infection^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2750,0)
 ;;=personal hygiene measures as indicated [specify]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2751,0)
 ;;=assess usual sleep pattern^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2751,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,2751,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,2751,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2752,0)
 ;;=Infection Potential (Specific to Integumentary System)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2753,0)
 ;;=how to contact someone for help^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2754,0)
 ;;=self care during manic episode^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2755,0)
 ;;=identification of behaviors leading to manic episode^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2756,0)
 ;;=treatments^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2757,0)
 ;;=Diabetes Mellitus^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,1,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,2,0)
 ;;=361^Skin Integrity, Impairment Of (Actual)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,3,0)
 ;;=362^Skin Integrity, Impairment Of (Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,4,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,5,0)
 ;;=349^Nutrition, Alteration in:(More Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,6,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,7,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,8,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,9,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,10,0)
 ;;=751^Family Processes, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,11,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,12,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2757,1,13,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,2758,0)
 ;;=Pain, Acute^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,2758,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,2758,1,1,0)
 ;;=2763^Etiology/Related and/or Risk Factors^2^NURSC^40^0
 ;;^UTILITY("^GMRD(124.2,",$J,2758,1,2,0)
 ;;=2764^Goals/Expected Outcomes^2^NURSC^40^0
 ;;^UTILITY("^GMRD(124.2,",$J,2758,1,3,0)
 ;;=2765^Nursing Intervention/Orders^2^NURSC^170^0
 ;;^UTILITY("^GMRD(124.2,",$J,2758,1,4,0)
 ;;=3154^Related Problems^2^NURSC^65^0
 ;;^UTILITY("^GMRD(124.2,",$J,2758,1,5,0)
 ;;=4205^Defining Characteristics^2^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,2758,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,2758,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,2758,10)
 ;;=D EN3^NURCCPU1
