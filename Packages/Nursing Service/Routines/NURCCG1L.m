NURCCG1L ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,545,0)
 ;;=decreased hemoglobin^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,546,0)
 ;;=leukopenia^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,547,0)
 ;;=suppressed inflammatory response^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,548,0)
 ;;=normal sputum production^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,548,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,548,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,549,0)
 ;;=reduced risk of pulmonary infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,549,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,549,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,550,0)
 ;;=intact mucous membrane^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,550,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,550,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,551,0)
 ;;=optimal weight^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,551,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,551,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,552,0)
 ;;=optimal fluid balance^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,552,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,552,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,553,0)
 ;;=patient demonstrates knowledge^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,553,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,553,1,1,0)
 ;;=554^actions to take to prevent cross-infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,553,1,2,0)
 ;;=555^s/s of infection^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,553,5)
 ;;=of:
 ;;^UTILITY("^GMRD(124.2,",$J,553,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,553,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,553,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,554,0)
 ;;=actions to take to prevent cross-infection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,555,0)
 ;;=s/s of infection^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,556,0)
 ;;=temperature per[route] q[ frequency ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,556,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,556,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,557,0)
 ;;=turn/reposition q[frequency]hrs.^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,557,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,557,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,558,0)
 ;;=Spiritual Distress^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,558,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,558,1,1,0)
 ;;=559^Etiology/Related and/or Risk Factors^2^NURSC^14^0
 ;;^UTILITY("^GMRD(124.2,",$J,558,1,2,0)
 ;;=560^Goals/Expected Outcomes^2^NURSC^14^0
 ;;^UTILITY("^GMRD(124.2,",$J,558,1,3,0)
 ;;=561^Nursing Intervention/Orders^2^NURSC^11^0
 ;;^UTILITY("^GMRD(124.2,",$J,558,1,4,0)
 ;;=562^Related Problems^2^NURSC^11^0
 ;;^UTILITY("^GMRD(124.2,",$J,558,1,5,0)
 ;;=4266^Defining Characteristics^2^NURSC^45
 ;;^UTILITY("^GMRD(124.2,",$J,558,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,558,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,558,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,558,"TD",0)
 ;;=^^2^2^2910221^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,558,"TD",1,0)
 ;;=A disruption in the life principle that pervades a person's entire being
 ;;^UTILITY("^GMRD(124.2,",$J,558,"TD",2,0)
 ;;=and that integrates and transcends one's biologic and psychosocial nature.
 ;;^UTILITY("^GMRD(124.2,",$J,559,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^14^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,1,0)
 ;;=563^challenged belief value system^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,2,0)
 ;;=564^beliefs opposed by family, peers, health care providers^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,559,1,3,0)
 ;;=565^conflicts to belief system^3^NURSC^1^0
