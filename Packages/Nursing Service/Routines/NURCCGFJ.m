NURCCGFJ ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,14520,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14520,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14521,0)
 ;;=instruct S/O(s) how to assess/assist w/reality orientation^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14521,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14521,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14537,0)
 ;;=provide information (community resources,respite care,etc.)^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14537,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14537,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14538,0)
 ;;=instruct S/O(s) how to assess/assist with ADL activities^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14538,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14538,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14539,0)
 ;;=provide reality orientation activities [specify]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14539,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14539,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14540,0)
 ;;=structured activities to promote independence [specify]^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14540,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14540,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14542,0)
 ;;=collaborate with S/O(s) to maintain safe environment^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14542,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,14542,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14550,0)
 ;;=Defining Characteristics^2^NURSC^12^170^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14550,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14550,1,1,0)
 ;;=4158^behavior pattern or usual response to stimuli is changed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14550,1,2,0)
 ;;=4162^sensory acuity is reported or measured as changed ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14550,1,3,0)
 ;;=4165^problem-solving  abilities are changed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14550,1,4,0)
 ;;=4167^disoriented in time, place or with persons^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14550,1,5,0)
 ;;=4172^body image alteration^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14550,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14556,0)
 ;;=Gas Exchange, Impaired^2^NURSC^2^7^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,14556,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,14556,1,1,0)
 ;;=14557^Etiology/Related and/or Risk Factors^2^NURSC^194
 ;;^UTILITY("^GMRD(124.2,",$J,14556,1,2,0)
 ;;=14562^Related Problems^2^NURSC^166
 ;;^UTILITY("^GMRD(124.2,",$J,14556,1,3,0)
 ;;=14569^Goals/Expected Outcomes^2^NURSC^191
 ;;^UTILITY("^GMRD(124.2,",$J,14556,1,4,0)
 ;;=14595^Nursing Intervention/Orders^2^NURSC^160
 ;;^UTILITY("^GMRD(124.2,",$J,14556,1,5,0)
 ;;=14665^Defining Characteristics^2^NURSC^171
 ;;^UTILITY("^GMRD(124.2,",$J,14556,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,14556,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,14556,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,14556,"TD",0)
 ;;=^^3^3^2910822^^
 ;;^UTILITY("^GMRD(124.2,",$J,14556,"TD",1,0)
 ;;=The individual experiences decreased passage of gases (oxygen,
 ;;^UTILITY("^GMRD(124.2,",$J,14556,"TD",2,0)
 ;;=carbon dioxide) between the alveoli of the lungs and the vascular
 ;;^UTILITY("^GMRD(124.2,",$J,14556,"TD",3,0)
 ;;=system.
 ;;^UTILITY("^GMRD(124.2,",$J,14557,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^194^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,14557,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,14557,1,1,0)
 ;;=447^alveoli-capillary membrane changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14557,1,2,0)
 ;;=448^blood flow, altered^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,14557,1,3,0)
 ;;=449^oxygen carrying capacity of blood altered^3^NURSC^1
