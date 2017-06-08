NURCCG29 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,9,0)
 ;;=749^Social Isolation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,10,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,11,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,12,0)
 ;;=751^Family Processes, Alteration in^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,13,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,14,0)
 ;;=752^Diversional Activity Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,15,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,720,1,16,0)
 ;;=746^Depressive Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,0)
 ;;=Bipolar Disorder^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,1,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,2,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,3,0)
 ;;=748^Violence Potential, Directed At Others^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,4,0)
 ;;=747^Violence, Potential For, Self Directed^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,5,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,6,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,7,0)
 ;;=175^Noncompliance/Nonadherence [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,8,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,9,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,10,0)
 ;;=1832^Manic Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,721,1,11,0)
 ;;=746^Depressive Behavior^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,0)
 ;;=Depressive Disorder^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,0)
 ;;=^124.21PI^15^15
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,1,0)
 ;;=351^Constipation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,2,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,3,0)
 ;;=349^Nutrition, Alteration in:(More Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,4,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,5,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,6,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,7,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,8,0)
 ;;=49^Coping, Ineffective Family^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,9,0)
 ;;=745^Powerlessness^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,10,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,11,0)
 ;;=642^Sexual Dysfunction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,12,0)
 ;;=752^Diversional Activity Deficit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,13,0)
 ;;=50^Home Maintenance Management, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,14,0)
 ;;=748^Violence Potential, Directed At Others^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,722,1,15,0)
 ;;=372^Sleep Pattern Disturbance^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,723,0)
 ;;=Paranoid Disorder^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,723,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,723,1,1,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,723,1,2,0)
 ;;=348^Nutrition, Alteration in:(Less Than Required)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,723,1,3,0)
 ;;=749^Social Isolation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,723,1,4,0)
 ;;=750^Social Interaction, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,723,1,5,0)
 ;;=753^Thought Processes, Alteration In^2^NURSC^1^0
