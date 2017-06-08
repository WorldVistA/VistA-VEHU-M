NURCCG2O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,843,0)
 ;;=overhead bars^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,844,0)
 ;;=reposition q[frequency]hrs^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,845,0)
 ;;=massage bony prominence [frequency]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,846,0)
 ;;=other^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,847,0)
 ;;=avoid irritants/noxious stimuli/oral irritants^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,847,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,847,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,848,0)
 ;;=encourage adequate food and fluid intake^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,848,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,848,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,849,0)
 ;;=up in chair q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,849,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,849,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,850,0)
 ;;=provide stoma care q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,850,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,850,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,851,0)
 ;;=teach how to maintain skin integrity^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,851,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,851,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,852,0)
 ;;=teach radiation therapy precautions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,852,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,852,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,853,0)
 ;;=Substance Abuse, Alcohol^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,853,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,853,1,1,0)
 ;;=2043^Etiology/Related and/or Risk Factors^2^NURSC^55^0
 ;;^UTILITY("^GMRD(124.2,",$J,853,1,2,0)
 ;;=2044^Goals/Expected Outcomes^2^NURSC^54^0
 ;;^UTILITY("^GMRD(124.2,",$J,853,1,3,0)
 ;;=2046^Nursing Intervention/Orders^2^NURSC^50^0
 ;;^UTILITY("^GMRD(124.2,",$J,853,1,4,0)
 ;;=2048^Related Problems^2^NURSC^42^0
 ;;^UTILITY("^GMRD(124.2,",$J,853,1,5,0)
 ;;=4276^Defining Characteristics^2^NURSC^47
 ;;^UTILITY("^GMRD(124.2,",$J,853,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,853,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,853,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",0)
 ;;=^^7^7^2890307^^
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",1,0)
 ;;=A state which involves drinking of alcohol which occurs as follows:
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",2,0)
 ;;=  1) regular daily intervals, or regular weekend intervals or during
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",3,0)
 ;;=     binges, with difficulty stopping or reducing the amount of
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",4,0)
 ;;=     alcohol used,
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",5,0)
 ;;=  2) a pattern of pathological alcohol use extending for at least 1 
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",6,0)
 ;;=     month,
 ;;^UTILITY("^GMRD(124.2,",$J,853,"TD",7,0)
 ;;=  3) impaired social or occupational role functioning.
 ;;^UTILITY("^GMRD(124.2,",$J,854,0)
 ;;=Substance Abuse, Drugs^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,854,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,854,1,1,0)
 ;;=2113^Etiology/Related and/or Risk Factors^2^NURSC^57^0
 ;;^UTILITY("^GMRD(124.2,",$J,854,1,2,0)
 ;;=2119^Related Problems^2^NURSC^44^0
 ;;^UTILITY("^GMRD(124.2,",$J,854,1,3,0)
 ;;=2120^Goals/Expected Outcomes^2^NURSC^56^0
 ;;^UTILITY("^GMRD(124.2,",$J,854,1,4,0)
 ;;=2128^Nursing Intervention/Orders^2^NURSC^51^0
 ;;^UTILITY("^GMRD(124.2,",$J,854,1,5,0)
 ;;=4284^Defining Characteristics^2^NURSC^49
 ;;^UTILITY("^GMRD(124.2,",$J,854,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,854,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,854,10)
 ;;=D EN3^NURCCPU1
