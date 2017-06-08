NURCCGH6 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15933,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^327^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,1,0)
 ;;=15935^teach about disease^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,3,0)
 ;;=15936^teach how to assess need for dose adjustment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,4,0)
 ;;=15937^teach principles of pain control^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,5,0)
 ;;=15938^provide phone numbers to contact health care provider^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,6,0)
 ;;=15939^assess behavior/level of understanding:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,1,7,0)
 ;;=1006324^[Extra Order]^3^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,15934,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15934,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15935,0)
 ;;=teach about disease^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15935,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15935,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15936,0)
 ;;=teach how to assess need for dose adjustment^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15936,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15936,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15937,0)
 ;;=teach principles of pain control^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15937,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15937,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15938,0)
 ;;=provide phone numbers to contact health care provider^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15938,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15938,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15939,0)
 ;;=assess behavior/level of understanding:^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15939,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15939,1,1,0)
 ;;=15940^neutropenic precautions^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15939,1,2,0)
 ;;=2658^diet^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15939,1,3,0)
 ;;=15941^pain control^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15939,1,4,0)
 ;;=12978^disease management^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15939,5)
 ;;=; monitor and document
 ;;^UTILITY("^GMRD(124.2,",$J,15939,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15939,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15939,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15940,0)
 ;;=neutropenic precautions^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15941,0)
 ;;=pain control^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15942,0)
 ;;=Spinal Headache^2^NURSC^8^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15942,1,0)
 ;;=^124.21PI^12^5
 ;;^UTILITY("^GMRD(124.2,",$J,15942,1,7,0)
 ;;=15949^Pain, Acute^2^NURSC^19
 ;;^UTILITY("^GMRD(124.2,",$J,15942,1,8,0)
 ;;=15953^Anxiety^2^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,15942,1,9,0)
 ;;=15967^General Self-Care Deficit^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15942,1,11,0)
 ;;=15976^Skin Integrity, Impaired^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15942,1,12,0)
 ;;=15987^[Extra Problem]^2^NURSC^31
 ;;^UTILITY("^GMRD(124.2,",$J,15944,0)
 ;;=expresses pain is within tolerable limits ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15944,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15944,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15945,0)
 ;;=verbalizes that pain is absent upon discharge^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15945,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15945,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15946,0)
 ;;=[Extra Goal]^3^NURSC^9^28^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15946,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15946,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15949,0)
 ;;=Pain, Acute^2^NURSC^2^19^^^T
