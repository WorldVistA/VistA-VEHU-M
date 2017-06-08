NURCCG4E ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,14,0)
 ;;=321^TPR q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,1,15,0)
 ;;=2993^[Extra Order]^3^NURSC^78^0
 ;;^UTILITY("^GMRD(124.2,",$J,1659,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1659,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1660,0)
 ;;=cardiac rhythm q[frequency]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1660,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1660,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1661,0)
 ;;=move gently and protect from physical exhaustion^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1661,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1661,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1662,0)
 ;;=cover with warm blankets and/or layered clothing^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1662,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1662,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1663,0)
 ;;=maintain warm room temperature and avoid drafts^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1663,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1663,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1664,0)
 ;;=give warm liquids PO q [frequency] hrs^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1664,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1664,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1665,0)
 ;;=administer warmed IV fluids >115 degrees F at [rate]gtts/min^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1665,5)
 ;;=(45 degrees Centigrade)
 ;;^UTILITY("^GMRD(124.2,",$J,1665,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1665,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1666,0)
 ;;=administer heated, humidified oxygen via aerosol mask [time]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1666,5)
 ;;=as ordered (37-42 degrees Centigrade; 100% relative humidity)
 ;;^UTILITY("^GMRD(124.2,",$J,1666,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1666,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1667,0)
 ;;=Apply warming blanket as indicated^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1667,5)
 ;;=(circulating fluid at 100.4-107 degrees F/38-42 degrees C)
 ;;^UTILITY("^GMRD(124.2,",$J,1667,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,1667,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,1668,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^44^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,1,0)
 ;;=161^lack of exposure^3^NURSC^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,2,0)
 ;;=1669^lack of recall^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,3,0)
 ;;=1670^misinterpretation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,4,0)
 ;;=159^cognitive limitation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,5,0)
 ;;=1671^perceptual limitation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,6,0)
 ;;=1672^disinterest in learning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1668,1,7,0)
 ;;=165^unfamiliarity with information resources^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1668,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,1669,0)
 ;;=lack of recall^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1670,0)
 ;;=misinterpretation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1671,0)
 ;;=perceptual limitation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1672,0)
 ;;=disinterest in learning^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,1673,0)
 ;;=Related Problems^2^NURSC^7^32^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,1673,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,1673,1,1,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1673,1,2,0)
 ;;=1674^Noncompliance/Nonadherence [specify]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,1673,7)
 ;;=D EN4^NURCCPU1
