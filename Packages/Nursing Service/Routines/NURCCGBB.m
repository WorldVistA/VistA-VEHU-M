NURCCGBB ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,4,0)
 ;;=1403^Anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,5,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,6,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,7,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,8,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,9,0)
 ;;=1417^Mobility, Impaired Physical^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,1,10,0)
 ;;=2397^Gas Exchange, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7706,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,0)
 ;;=Defining Characteristics^2^NURSC^12^95^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7717,1,1,0)
 ;;=4206^communication (verbal or coded) of pain descriptors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,1,2,0)
 ;;=4192^alteration in muscle tone (may span from listless to rigid)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,1,3,0)
 ;;=4197^distractive behavior(moaning,crying,pacing,restlessness,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,1,4,0)
 ;;=4200^facial mask of pain(grimace,eyes lackluster,beaten look,etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,1,5,0)
 ;;=4202^narrowed focus(altered time perception,withdrawn etc)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7717,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7723,0)
 ;;=Knowledge Deficit^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7723,1,0)
 ;;=^124.21PI^7^4
 ;;^UTILITY("^GMRD(124.2,",$J,7723,1,1,0)
 ;;=7724^Etiology/Related and/or Risk Factors^2^NURSC^108
 ;;^UTILITY("^GMRD(124.2,",$J,7723,1,2,0)
 ;;=7732^Related Problems^2^NURSC^91
 ;;^UTILITY("^GMRD(124.2,",$J,7723,1,5,0)
 ;;=15569^Goals/Expected Outcomes^2^NURSC^310
 ;;^UTILITY("^GMRD(124.2,",$J,7723,1,7,0)
 ;;=15591^Nursing Intervention/Orders^2^NURSC^313
 ;;^UTILITY("^GMRD(124.2,",$J,7723,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7723,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7723,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7723,"TD",0)
 ;;=^^1^1^2890801^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,7723,"TD",1,0)
 ;;=Lack of specific information.
 ;;^UTILITY("^GMRD(124.2,",$J,7724,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^108^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7724,1,0)
 ;;=^124.21PI^9^4
 ;;^UTILITY("^GMRD(124.2,",$J,7724,1,2,0)
 ;;=1669^lack of recall^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7724,1,4,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7724,1,8,0)
 ;;=15567^newly diagnosed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7724,1,9,0)
 ;;=15568^change in therapy made^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7724,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7732,0)
 ;;=Related Problems^2^NURSC^7^91^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7732,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,7732,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7732,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7732,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7744,0)
 ;;=initiate unit specific withdrawal procedures [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7744,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7744,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7756,0)
 ;;=[Extra Goal]^3^NURSC^9^140^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7756,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7756,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7803,0)
 ;;=[Extra Order]^3^NURSC^11^143^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7803,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,7803,10)
 ;;=D EN1^NURCCPU3
