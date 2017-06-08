NURCCGCX ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,10744,0)
 ;;=[etiology]^3^NURSC^^133^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10745,0)
 ;;=[etiology]^3^NURSC^^134^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10746,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^282^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10746,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10746,1,1,0)
 ;;=10747^[Extra Goal]^3^NURSC^353
 ;;^UTILITY("^GMRD(124.2,",$J,10746,1,2,0)
 ;;=10748^[Extra Goal]^3^NURSC^354
 ;;^UTILITY("^GMRD(124.2,",$J,10746,1,3,0)
 ;;=10749^[Extra Goal]^3^NURSC^355
 ;;^UTILITY("^GMRD(124.2,",$J,10746,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10747,0)
 ;;=[Extra Goal]^3^NURSC^9^353^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10747,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10747,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10748,0)
 ;;=[Extra Goal]^3^NURSC^9^354^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10748,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10748,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10749,0)
 ;;=[Extra Goal]^3^NURSC^9^355^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10749,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10749,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10750,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^286^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10750,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,10750,1,1,0)
 ;;=10751^[Extra Order]^3^NURSC^360
 ;;^UTILITY("^GMRD(124.2,",$J,10750,1,2,0)
 ;;=10752^[Extra Order]^3^NURSC^361
 ;;^UTILITY("^GMRD(124.2,",$J,10750,1,3,0)
 ;;=10753^[Extra Order]^3^NURSC^362
 ;;^UTILITY("^GMRD(124.2,",$J,10750,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10750,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10751,0)
 ;;=[Extra Order]^3^NURSC^11^360^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10751,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10751,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10752,0)
 ;;=[Extra Order]^3^NURSC^11^361^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10752,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10752,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10753,0)
 ;;=[Extra Order]^3^NURSC^11^362^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10753,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,10753,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10754,0)
 ;;=Grieving, Dysfunctional^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,10754,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,10754,1,1,0)
 ;;=10755^Etiology/Related and/or Risk Factors^2^NURSC^146
 ;;^UTILITY("^GMRD(124.2,",$J,10754,1,2,0)
 ;;=10769^Goals/Expected Outcomes^2^NURSC^144
 ;;^UTILITY("^GMRD(124.2,",$J,10754,1,3,0)
 ;;=10775^Nursing Intervention/Orders^2^NURSC^122
 ;;^UTILITY("^GMRD(124.2,",$J,10754,1,4,0)
 ;;=10787^Related Problems^2^NURSC^126
 ;;^UTILITY("^GMRD(124.2,",$J,10754,1,5,0)
 ;;=10799^Defining Characteristics^2^NURSC^125
 ;;^UTILITY("^GMRD(124.2,",$J,10754,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,10754,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,10754,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,10754,"TD",0)
 ;;=^^2^2^2890301^
 ;;^UTILITY("^GMRD(124.2,",$J,10754,"TD",1,0)
 ;;=Delayed or exaggerated response to a preceived actual or potential
 ;;^UTILITY("^GMRD(124.2,",$J,10754,"TD",2,0)
 ;;=loss.
 ;;^UTILITY("^GMRD(124.2,",$J,10755,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^146^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,1,0)
 ;;=2298^absence of anticipatory grieving^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,2,0)
 ;;=10757^actual or perceived object loss (broadest sense) such as:^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,10755,1,3,0)
 ;;=2307^chronic fatal illness^3^NURSC^1
