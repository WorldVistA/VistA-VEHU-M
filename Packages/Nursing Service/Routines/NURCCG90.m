NURCCG90 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4775,1,3,0)
 ;;=4798^Nursing Intervention/Orders^2^NURSC^232
 ;;^UTILITY("^GMRD(124.2,",$J,4775,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4775,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4775,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4776,0)
 ;;=[etiology]^3^NURSC^^80^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4777,0)
 ;;=Pain, Acute^2^NURSC^2^15^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4777,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4777,1,1,0)
 ;;=4788^Etiology/Related and/or Risk Factors^2^NURSC^225
 ;;^UTILITY("^GMRD(124.2,",$J,4777,1,2,0)
 ;;=4789^Goals/Expected Outcomes^2^NURSC^230
 ;;^UTILITY("^GMRD(124.2,",$J,4777,1,3,0)
 ;;=4791^Nursing Intervention/Orders^2^NURSC^231
 ;;^UTILITY("^GMRD(124.2,",$J,4777,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4777,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4777,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4778,0)
 ;;=[etiology]^3^NURSC^^81^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4779,0)
 ;;=[Extra Problem]^2^NURSC^2^5^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4779,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4779,1,1,0)
 ;;=4803^Etiology/Related and/or Risk Factors^2^NURSC^229
 ;;^UTILITY("^GMRD(124.2,",$J,4779,1,2,0)
 ;;=4804^Goals/Expected Outcomes^2^NURSC^233
 ;;^UTILITY("^GMRD(124.2,",$J,4779,1,3,0)
 ;;=4806^Nursing Intervention/Orders^2^NURSC^234
 ;;^UTILITY("^GMRD(124.2,",$J,4779,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4779,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4779,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4780,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^228^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4780,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,4780,1,1,0)
 ;;=4782^[Extra Goal]^3^NURSC^281
 ;;^UTILITY("^GMRD(124.2,",$J,4780,1,2,0)
 ;;=4784^[Extra Goal]^3^NURSC^282
 ;;^UTILITY("^GMRD(124.2,",$J,4780,1,3,0)
 ;;=4786^[Extra Goal]^3^NURSC^283
 ;;^UTILITY("^GMRD(124.2,",$J,4780,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4781,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^224^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4781,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,4781,1,1,0)
 ;;=1375^alteration in preload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4781,1,2,0)
 ;;=4370^fluid volume deficit/excess^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4781,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4782,0)
 ;;=[Extra Goal]^3^NURSC^9^281^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4782,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4782,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4783,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^229^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4783,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,4783,1,1,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4783,1,2,0)
 ;;=4462^maintain fluid/electrolyte balance WNL for pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4783,1,3,0)
 ;;=4392^maintain fluid/electrolytes WNL for patient^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4783,1,4,0)
 ;;=4808^[Extra Goal]^3^NURSC^216
 ;;^UTILITY("^GMRD(124.2,",$J,4783,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4784,0)
 ;;=[Extra Goal]^3^NURSC^9^282^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4784,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4784,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^229^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,0)
 ;;=^124.21PI^10^9
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,1,0)
 ;;=4409^assess,monitor,document hemodynamics ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,2,0)
 ;;=1471^assess for EKG changes q[frequency]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4785,1,4,0)
 ;;=320^assess respiratory rate and pattern/breath sounds^3^NURSC^9
