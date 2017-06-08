NURCCG15 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,388,0)
 ;;=sputum culture as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,388,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,388,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,389,0)
 ;;=oxygen [numeric value]% per [flow rate]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,389,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,389,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,389,"TD",0)
 ;;=^^2^2^2890803^
 ;;^UTILITY("^GMRD(124.2,",$J,389,"TD",1,0)
 ;;=40%
 ;;^UTILITY("^GMRD(124.2,",$J,389,"TD",2,0)
 ;;=VENTURI MASK
 ;;^UTILITY("^GMRD(124.2,",$J,390,0)
 ;;=humidity as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,390,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,390,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,391,0)
 ;;=explain procedures; be reassuring^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,391,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,391,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,392,0)
 ;;=administer pain medication as needed^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,392,5)
 ;;=;monitor & document effects
 ;;^UTILITY("^GMRD(124.2,",$J,392,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,392,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,393,0)
 ;;=splint incision while providing pulmonary toilet^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,393,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,393,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,394,0)
 ;;=teach methods to reduce pain, such as splinting^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,394,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,394,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,395,0)
 ;;=provide patient teaching (Airway Clearance, Ineffective)^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,395,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,395,1,1,0)
 ;;=397^anatomy, physiology, and corrective factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,395,1,2,0)
 ;;=398^educate in S/S of respiratory infection, bronchospasm, etc^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,395,1,3,0)
 ;;=399^teach patient actions to take when S/S reoccur^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,395,1,4,0)
 ;;=400^consider/discuss preventive measures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,395,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,395,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,395,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,396,0)
 ;;=teach patient and SO procedures for quad cough^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,396,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,396,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,397,0)
 ;;=anatomy, physiology, and corrective factors^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,398,0)
 ;;=educate in S/S of respiratory infection, bronchospasm, etc^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,399,0)
 ;;=teach patient actions to take when S/S reoccur^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,1,0)
 ;;=401^postural drainage^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,2,0)
 ;;=402^humidification therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,3,0)
 ;;=403^use of expectorants^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,4,0)
 ;;=404^aerosol therapy q [frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,5,0)
 ;;=405^fluid intake^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,6,0)
 ;;=406^antibiotic therapy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,7,0)
 ;;=407^avoidance of respiratory irritants^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,1,8,0)
 ;;=408^contact health professional for assistance^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,399,5)
 ;;=including
