NURCCG23 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,697,1,2,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,697,1,3,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,697,1,4,0)
 ;;=643^Sexual Pattern, Altered^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,0)
 ;;=Urolithiasis^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,1,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,2,0)
 ;;=357^Urinary Elimination, Alteration In Pattern^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,3,0)
 ;;=341^Fluid Volume Excess (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,4,0)
 ;;=699^Fear^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,5,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,6,0)
 ;;=2758^Pain, Acute^2^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,698,1,7,0)
 ;;=346^Tissue Perfusion, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,699,0)
 ;;=Fear^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,699,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,699,1,1,0)
 ;;=1895^Etiology/Related and/or Risk Factors^2^NURSC^50^0
 ;;^UTILITY("^GMRD(124.2,",$J,699,1,2,0)
 ;;=1897^Goals/Expected Outcomes^2^NURSC^49^0
 ;;^UTILITY("^GMRD(124.2,",$J,699,1,3,0)
 ;;=1898^Nursing Intervention/Orders^2^NURSC^45^0
 ;;^UTILITY("^GMRD(124.2,",$J,699,1,4,0)
 ;;=1899^Related Problems^2^NURSC^38^0
 ;;^UTILITY("^GMRD(124.2,",$J,699,1,5,0)
 ;;=4183^Defining Characteristics^2^NURSC^29
 ;;^UTILITY("^GMRD(124.2,",$J,699,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,699,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,699,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,699,"TD",0)
 ;;=^^2^2^2890307^^
 ;;^UTILITY("^GMRD(124.2,",$J,699,"TD",1,0)
 ;;=Fear is a feeling of dread related to an identified source which the
 ;;^UTILITY("^GMRD(124.2,",$J,699,"TD",2,0)
 ;;=person validates.
 ;;^UTILITY("^GMRD(124.2,",$J,700,0)
 ;;=Amputation^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,1,0)
 ;;=741^Self Concept, Disturbance In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,2,0)
 ;;=364^Injury Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,3,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,4,0)
 ;;=1567^Fluid Volume Deficit (Actual/Potential)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,5,0)
 ;;=558^Spiritual Distress^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,6,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,7,0)
 ;;=50^Home Maintenance Management, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,8,0)
 ;;=742^Coping, Ineffective Individual^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,9,0)
 ;;=687^Anxiety^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,10,0)
 ;;=744^Grieving, Dysfunctional^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,11,0)
 ;;=16^Knowledge Deficit [specify]^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,12,0)
 ;;=338^Activity Intolerance (Circulatory System)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,700,1,13,0)
 ;;=345^Tissue Integrity, Impaired^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,701,0)
 ;;=Carpal Tunnel Syndrome^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,701,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,701,1,1,0)
 ;;=641^Infection Potential^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,701,1,2,0)
 ;;=371^Sensory-Perceptual, Alteration In^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,701,1,3,0)
 ;;=365^Mobility, Impaired Physical^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,701,1,4,0)
 ;;=366^Pain, Chronic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,701,1,5,0)
 ;;=51^Self-Care Deficit [Specify]^2^NURSC^1^0
