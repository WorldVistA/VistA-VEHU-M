NURCCGG7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15291,0)
 ;;=help to correlate past trauma w/present situations [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15291,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15291,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15292,0)
 ;;=teach alternative methods for dealing with stress [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15292,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15292,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15293,0)
 ;;=assist to identify triggers for impulsive behavior [specify]^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15293,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15293,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15294,0)
 ;;=assist to learn and use pro-active behaviors^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15294,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15294,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15295,0)
 ;;=assist to identify community resources for discharge^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15295,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15295,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15299,0)
 ;;=no information requested by patient^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15300,0)
 ;;=[etiology]^3^NURSC^^157^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15302,0)
 ;;=assess,monitor,document laboratory values^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15302,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15302,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15303,0)
 ;;=verbalizes adequate healthcare knowledge for H-C decisions ^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15303,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15303,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15305,0)
 ;;=verbalizes appropriate knowledge base: reduce kidney damage^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15305,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15305,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15306,0)
 ;;=verbalizes knowledge of self-care needs & to leave hospital^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15306,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15306,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15309,0)
 ;;=verbalizes routine to meet basic needs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15309,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15309,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15310,0)
 ;;=describes measures to reduce risk factors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15310,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15310,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15311,0)
 ;;=instruct on:^2^NURSC^11^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15311,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,15311,1,1,0)
 ;;=15312^fluid intake 2000 to 3000cc per 24 hours^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15311,1,2,0)
 ;;=15313^cranberry or apple juice to acidify urine (if Ca+ based)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15311,1,3,0)
 ;;=15317^strain urine, send sediment to Dr. for analysis^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15311,1,4,0)
 ;;=15319^[Extra Order]^3^NURSC^429
 ;;^UTILITY("^GMRD(124.2,",$J,15311,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15311,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15311,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15312,0)
 ;;=fluid intake 2000 to 3000cc per 24 hours^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15313,0)
 ;;=cranberry or apple juice to acidify urine (if Ca+ based)^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15314,0)
 ;;=regular voiding schedule^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15315,0)
 ;;=verbalizes S/S reportable to health care professional^3^NURSC^9^1^^^T
