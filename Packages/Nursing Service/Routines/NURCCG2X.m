NURCCG2X ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,942,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,942,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,943,0)
 ;;=use digital stimulation to relax sphincter^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,943,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,943,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,944,0)
 ;;=maintains personal integrity and self worth^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,944,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,944,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,945,0)
 ;;=teach patient to respond immediately to elimination urge^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,945,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,945,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,946,0)
 ;;=teach adverse effects of habitual use of enemas, laxatives^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,946,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,946,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,947,0)
 ;;=free from complications related to immobility/hemostasis^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,947,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,947,1,1,0)
 ;;=949^absence of DVT^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,947,1,2,0)
 ;;=950^absence of pulmonary emboli^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,947,1,3,0)
 ;;=951^extremities freely moveable^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,947,5)
 ;;=as witnessed by absence of
 ;;^UTILITY("^GMRD(124.2,",$J,947,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,947,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,947,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,948,0)
 ;;=teach about normal bowel pattern^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,948,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,948,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,949,0)
 ;;=absence of DVT^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,950,0)
 ;;=absence of pulmonary emboli^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,951,0)
 ;;=extremities freely moveable^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,952,0)
 ;;=teach when to seek medical attention^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,952,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,952,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,953,0)
 ;;=relates risk factors of CAD^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,953,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,953,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,954,0)
 ;;=describes preventive measures related to CAD^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,954,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,954,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,955,0)
 ;;=teach side effects of many medications maybe constipation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,955,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,955,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,956,0)
 ;;=attach to cardiac monitor; obtain rhythm strip^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,956,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,956,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,957,0)
 ;;=teach to attempt defecation [ ]hr/s after meal and @ [ ]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,957,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,957,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,958,0)
 ;;=document history of pain^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,958,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,958,1,1,0)
 ;;=959^location^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,958,1,2,0)
 ;;=960^quality^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,958,1,3,0)
 ;;=961^intensity^3^NURSC^1^0
