NURCCGH1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;4/29/92
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15866,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15867,0)
 ;;=control level of sensory stimuli^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15867,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15867,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15869,0)
 ;;=reorient as necessary^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15869,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15869,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15870,0)
 ;;=use simple instructions^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15870,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15870,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15872,0)
 ;;=[Extra Order]^3^NURSC^11^7^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15872,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15872,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15873,0)
 ;;=[Extra Goal]^3^NURSC^9^23^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15873,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15873,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15874,0)
 ;;=Impaired Physical Mobility^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,15874,1,0)
 ;;=^124.21PI^6^5
 ;;^UTILITY("^GMRD(124.2,",$J,15874,1,2,0)
 ;;=799^Etiology/Related and/or Risk Factors^2^NURSC^18
 ;;^UTILITY("^GMRD(124.2,",$J,15874,1,3,0)
 ;;=802^Related Problems^2^NURSC^14
 ;;^UTILITY("^GMRD(124.2,",$J,15874,1,4,0)
 ;;=5880^Defining Characteristics^2^NURSC^75
 ;;^UTILITY("^GMRD(124.2,",$J,15874,1,5,0)
 ;;=15876^Goals/Expected Outcomes^2^NURSC^321
 ;;^UTILITY("^GMRD(124.2,",$J,15874,1,6,0)
 ;;=15881^Nursing Intervention/Orders^2^NURSC^323
 ;;^UTILITY("^GMRD(124.2,",$J,15874,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15874,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,15874,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^321^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,1,0)
 ;;=806^free from injury^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,2,0)
 ;;=10704^verbalizes acceptance of limitations^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,3,0)
 ;;=3207^uses assistive devices [specify] correctly/consistently^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,4,0)
 ;;=807^maintains ROM in all joints^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,5,0)
 ;;=15877^achieves ADL independence^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,6,0)
 ;;=15878^experiences normal surgical wound healing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,7,0)
 ;;=15501^verbalizes plan of follow-up care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15876,1,8,0)
 ;;=1006317^[Extra Goal]^3^NURSC^174
 ;;^UTILITY("^GMRD(124.2,",$J,15876,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15877,0)
 ;;=achieves ADL independence^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15877,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15877,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15878,0)
 ;;=experiences normal surgical wound healing^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15878,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15878,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15880,0)
 ;;=verbalizes diminished pain^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15880,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,15880,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15881,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^323^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,15881,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,15881,1,1,0)
 ;;=15882^teach mobility skills^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15881,1,2,0)
 ;;=11608^instruct/assist with ROM [specify]^3^NURSC^56
 ;;^UTILITY("^GMRD(124.2,",$J,15881,1,3,0)
 ;;=7407^wound care/drsg change(s) of [specify area] q[frequency]^3^NURSC^1
