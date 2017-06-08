NURCCGEA ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12866,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12866,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12869,0)
 ;;=[Extra Order]^3^NURSC^11^379^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12869,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12869,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12873,0)
 ;;=[Extra Order]^3^NURSC^11^380^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12873,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12873,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12877,0)
 ;;=keep side rails up & padded with bed in lowest position^3^NURSC^11^12^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12877,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12877,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12878,0)
 ;;=perform neuro/VS checks after seizure (LOC,orientation,etc)^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12878,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12878,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12879,0)
 ;;=document type of seizure activity^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12879,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12879,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12881,0)
 ;;=stay with patient during/after seizure activity^3^NURSC^11^68^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,12881,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12881,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12891,0)
 ;;=Related Problems^2^NURSC^7^148^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12891,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,12891,1,1,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12891,5)
 ;;=see
 ;;^UTILITY("^GMRD(124.2,",$J,12891,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12893,0)
 ;;=Defining Characteristics^2^NURSC^12^150^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12893,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,12893,1,1,0)
 ;;=4263^cognitive, effective, and psychomotor factors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12893,1,2,0)
 ;;=4265^integrative dysfunction^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12893,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12896,0)
 ;;=Self Concept, Disturbance In^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12896,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12896,1,1,0)
 ;;=12897^Etiology/Related and/or Risk Factors^2^NURSC^173
 ;;^UTILITY("^GMRD(124.2,",$J,12896,1,2,0)
 ;;=12903^Related Problems^2^NURSC^149
 ;;^UTILITY("^GMRD(124.2,",$J,12896,1,3,0)
 ;;=12912^Goals/Expected Outcomes^2^NURSC^171
 ;;^UTILITY("^GMRD(124.2,",$J,12896,1,4,0)
 ;;=12924^Nursing Intervention/Orders^2^NURSC^145
 ;;^UTILITY("^GMRD(124.2,",$J,12896,1,5,0)
 ;;=12962^Defining Characteristics^2^NURSC^90
 ;;^UTILITY("^GMRD(124.2,",$J,12896,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12896,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12896,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12896,"TD",0)
 ;;=^^2^2^2890307^^^
 ;;^UTILITY("^GMRD(124.2,",$J,12896,"TD",1,0)
 ;;=A disruption in the way one perceives one's body image, self-esteem,
 ;;^UTILITY("^GMRD(124.2,",$J,12896,"TD",2,0)
 ;;=role performance, and/or personal identity.
 ;;^UTILITY("^GMRD(124.2,",$J,12897,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^173^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12897,1,0)
 ;;=^124.21PI^5^1
 ;;^UTILITY("^GMRD(124.2,",$J,12897,1,5,0)
 ;;=12902^perception of loss of control^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,12897,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12902,0)
 ;;=perception of loss of control^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12903,0)
 ;;=Related Problems^2^NURSC^7^149^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12903,1,0)
 ;;=^124.21PI^8^8
