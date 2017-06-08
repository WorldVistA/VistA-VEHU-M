NURCCG0U ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,329,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,329,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,330,0)
 ;;=elevate head of bed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,330,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,330,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,331,0)
 ;;=position to mobilize secretions q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,331,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,331,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,332,0)
 ;;=out of bed q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,332,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,332,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,333,0)
 ;;=chest percussion q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,333,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,333,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,334,0)
 ;;=pulmonary toilet q [frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,334,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,334,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,335,0)
 ;;=mouth care q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,335,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,335,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,336,0)
 ;;=provide adequate hydration and nutrition^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,336,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,336,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,337,0)
 ;;=I&O q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,337,4)
 ;;=assess, monitor, and document
 ;;^UTILITY("^GMRD(124.2,",$J,337,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,337,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,338,0)
 ;;=Activity Intolerance (Circulatory System)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,338,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,338,1,1,0)
 ;;=128^Etiology/Related and/or Risk Factors^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,338,1,2,0)
 ;;=131^Related Problems^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,338,1,3,0)
 ;;=129^Goals/Expected Outcomes^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,338,1,4,0)
 ;;=130^Nursing Intervention/Orders^2^NURSC^5^0
 ;;^UTILITY("^GMRD(124.2,",$J,338,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,338,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,338,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,338,"TD",0)
 ;;=^^3^3^2890301^^
 ;;^UTILITY("^GMRD(124.2,",$J,338,"TD",1,0)
 ;;=A state in which an individual has insufficient physiological or
 ;;^UTILITY("^GMRD(124.2,",$J,338,"TD",2,0)
 ;;=psychological energy to endure or complete required or desired 
 ;;^UTILITY("^GMRD(124.2,",$J,338,"TD",3,0)
 ;;=daily activities.
 ;;^UTILITY("^GMRD(124.2,",$J,339,0)
 ;;=Cardiac Output, Decreased (Electrical Factors)^2^NURSC^2^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,339,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,339,1,1,0)
 ;;=499^Etiology/Related and/or Risk Factors^2^NURSC^12^0
 ;;^UTILITY("^GMRD(124.2,",$J,339,1,2,0)
 ;;=502^Related Problems^2^NURSC^10^0
 ;;^UTILITY("^GMRD(124.2,",$J,339,1,3,0)
 ;;=500^Goals/Expected Outcomes^2^NURSC^12^0
 ;;^UTILITY("^GMRD(124.2,",$J,339,1,4,0)
 ;;=501^Nursing Intervention/Orders^2^NURSC^9^0
 ;;^UTILITY("^GMRD(124.2,",$J,339,1,5,0)
 ;;=4280^Defining Characteristics^2^NURSC^48
 ;;^UTILITY("^GMRD(124.2,",$J,339,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,339,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,339,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,339,"TD",0)
 ;;=^^3^3^2890302^^^
 ;;^UTILITY("^GMRD(124.2,",$J,339,"TD",1,0)
 ;;=A state in which the blood pumped by an individual's heart is
