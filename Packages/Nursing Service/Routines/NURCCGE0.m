NURCCGE0 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,13,0)
 ;;=1045^pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,14,0)
 ;;=1046^decrease strength and endurance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,15,0)
 ;;=1047^age^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,16,0)
 ;;=1048^nutritionally deprived^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,17,0)
 ;;=798^medical protocols^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,18,0)
 ;;=207^depression, severe anxiety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,1,19,0)
 ;;=159^cognitive limitation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12405,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12407,0)
 ;;=provide pleasant enviroment during meal times^3^NURSC^11^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12407,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12407,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12419,0)
 ;;=initiate consult(s)^2^NURSC^11^5^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12419,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12419,1,1,0)
 ;;=296^Dietetic Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12419,1,2,0)
 ;;=2579^Social Work Service^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12419,1,3,0)
 ;;=2580^VNA^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12419,1,4,0)
 ;;=1928^Occupational Therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12419,5)
 ;;=to:
 ;;^UTILITY("^GMRD(124.2,",$J,12419,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12419,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12419,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12437,0)
 ;;=[Extra Order]^3^NURSC^11^202^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12437,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12437,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12440,0)
 ;;=Defining Characteristics^2^NURSC^12^143^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12440,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,12440,1,1,0)
 ;;=12443^body weight 20% or more under ideal^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,12440,1,2,0)
 ;;=12444^reported food intake under RDA^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,12440,1,3,0)
 ;;=12446^reported/observed lack of food^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,12440,1,4,0)
 ;;=12447^sore/inflammed bucal cavity^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,12440,1,5,0)
 ;;=12448^lack of interest in food^3^NURSC^6
 ;;^UTILITY("^GMRD(124.2,",$J,12440,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^165^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,1,0)
 ;;=806^free from injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,2,0)
 ;;=807^maintains ROM in all joints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,3,0)
 ;;=808^maintains independent ambulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,4,0)
 ;;=12607^[Extra Goal]^3^NURSC^202
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,5,0)
 ;;=10704^verbalizes acceptance of limitations^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,6,0)
 ;;=15678^achieves independent w/c mobility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,7,0)
 ;;=15679^achieves w/c mobility with [min/mod/max] assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,8,0)
 ;;=15682^ambulates [#]ft. with [min/mod/max] assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,9,0)
 ;;=11592^demonstrates correct use of assistive devices [specify]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12442,1,10,0)
 ;;=15683^demonstrates ability to pace activity with rest periods^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12442,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12443,0)
 ;;=body weight 20% or more under ideal^3^NURSC^^6^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12444,0)
 ;;=reported food intake under RDA^3^NURSC^^6^^^T
