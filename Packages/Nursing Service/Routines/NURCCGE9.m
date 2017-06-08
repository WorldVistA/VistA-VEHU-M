NURCCGE9 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12847,1,1,0)
 ;;=776^remains free from injuries^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12847,1,2,0)
 ;;=777^verbalizes how to prevent injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12847,1,3,0)
 ;;=13089^[Extra Goal]^3^NURSC^224
 ;;^UTILITY("^GMRD(124.2,",$J,12847,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12848,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^277^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12848,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12848,1,1,0)
 ;;=12852^[etiology]^3^NURSC^44
 ;;^UTILITY("^GMRD(124.2,",$J,12848,1,2,0)
 ;;=12855^[etiology]^3^NURSC^45
 ;;^UTILITY("^GMRD(124.2,",$J,12848,1,3,0)
 ;;=13062^[etiology]^3^NURSC^102
 ;;^UTILITY("^GMRD(124.2,",$J,12848,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12851,0)
 ;;=[etiology]^3^NURSC^^43^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12852,0)
 ;;=[etiology]^3^NURSC^^44^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12854,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^144^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,0)
 ;;=^124.21PI^11^6
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,4,0)
 ;;=12863^explore w/pt various stimuli that may precipitate seizures^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,6,0)
 ;;=12877^keep side rails up & padded with bed in lowest position^3^NURSC^12
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,7,0)
 ;;=12878^perform neuro/VS checks after seizure (LOC,orientation,etc)^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,8,0)
 ;;=12879^document type of seizure activity^3^NURSC^7
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,10,0)
 ;;=12881^stay with patient during/after seizure activity^3^NURSC^68
 ;;^UTILITY("^GMRD(124.2,",$J,12854,1,11,0)
 ;;=13376^[Extra Order]^3^NURSC^237
 ;;^UTILITY("^GMRD(124.2,",$J,12854,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12854,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12855,0)
 ;;=[etiology]^3^NURSC^^45^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12856,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^289^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12856,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12856,1,1,0)
 ;;=12857^[Extra Goal]^3^NURSC^371
 ;;^UTILITY("^GMRD(124.2,",$J,12856,1,2,0)
 ;;=12858^[Extra Goal]^3^NURSC^372
 ;;^UTILITY("^GMRD(124.2,",$J,12856,1,3,0)
 ;;=12861^[Extra Goal]^3^NURSC^373
 ;;^UTILITY("^GMRD(124.2,",$J,12856,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12857,0)
 ;;=[Extra Goal]^3^NURSC^9^371^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12857,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12857,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12858,0)
 ;;=[Extra Goal]^3^NURSC^9^372^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12858,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12858,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12861,0)
 ;;=[Extra Goal]^3^NURSC^9^373^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12861,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12861,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12863,0)
 ;;=explore w/pt various stimuli that may precipitate seizures^3^NURSC^11^5^^^T^
 ;;^UTILITY("^GMRD(124.2,",$J,12863,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12863,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12864,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^293^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12864,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,12864,1,1,0)
 ;;=12866^[Extra Order]^3^NURSC^378
 ;;^UTILITY("^GMRD(124.2,",$J,12864,1,2,0)
 ;;=12869^[Extra Order]^3^NURSC^379
 ;;^UTILITY("^GMRD(124.2,",$J,12864,1,3,0)
 ;;=12873^[Extra Order]^3^NURSC^380
 ;;^UTILITY("^GMRD(124.2,",$J,12864,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12864,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12866,0)
 ;;=[Extra Order]^3^NURSC^11^378^^^T
