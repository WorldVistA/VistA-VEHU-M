NURCCG2J ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,776,0)
 ;;=remains free from injuries^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,776,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,776,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,777,0)
 ;;=verbalizes how to prevent injury^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,777,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,777,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,778,0)
 ;;=inspect for external factors which produce injury q [freq.]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,778,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,778,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,779,0)
 ;;=observe for adverse effects of chemical agents/treatments^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,779,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,779,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,780,0)
 ;;=identify and eliminate potential sources of injury^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,780,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,780,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,781,0)
 ;;=provide physically safe environment^2^NURSC^11^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,1,0)
 ;;=787^bedrails^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,2,0)
 ;;=788^call light^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,3,0)
 ;;=789^prosthetic devices^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,4,0)
 ;;=790^night light^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,5,0)
 ;;=791^safety restraints^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,6,0)
 ;;=792^isolation^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,7,0)
 ;;=793^remove constrictive clothing^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,1,8,0)
 ;;=794^eliminate source of infestation^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,781,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,781,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,781,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,781,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,782,0)
 ;;=protect with restraints [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,782,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,782,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,783,0)
 ;;=provide restraint care q[frequency]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,783,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,783,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,784,0)
 ;;=teach patient regarding health maintenance^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,784,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,784,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,785,0)
 ;;=teach S/O regarding potential for injury^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,785,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,785,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,786,0)
 ;;=assure understanding of informed consent^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,786,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,786,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,787,0)
 ;;=bedrails^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,788,0)
 ;;=call light^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,789,0)
 ;;=prosthetic devices^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,790,0)
 ;;=night light^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,791,0)
 ;;=safety restraints^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,792,0)
 ;;=isolation^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,793,0)
 ;;=remove constrictive clothing^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,794,0)
 ;;=eliminate source of infestation^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,795,0)
 ;;=pain and discomfort^3^NURSC^^1^^^T
