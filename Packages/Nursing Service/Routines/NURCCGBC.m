NURCCGBC ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7804,0)
 ;;=Fluid Volume (Deficit/Excess)^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7804,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7804,1,1,0)
 ;;=7805^Etiology/Related and/or Risk Factors^2^NURSC^264
 ;;^UTILITY("^GMRD(124.2,",$J,7804,1,2,0)
 ;;=7810^Goals/Expected Outcomes^2^NURSC^276
 ;;^UTILITY("^GMRD(124.2,",$J,7804,1,3,0)
 ;;=7839^Nursing Intervention/Orders^2^NURSC^279
 ;;^UTILITY("^GMRD(124.2,",$J,7804,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7804,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7804,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7805,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^264^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7805,1,0)
 ;;=^124.21PI^5^3
 ;;^UTILITY("^GMRD(124.2,",$J,7805,1,1,0)
 ;;=4613^blood/fluid loss in the operating room^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7805,1,2,0)
 ;;=4614^hypovolemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7805,1,5,0)
 ;;=15665^diuretic therapy^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7805,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7810,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^276^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,0)
 ;;=^124.21PI^7^6
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,2,0)
 ;;=4462^maintain fluid/electrolyte balance WNL for pt ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,3,0)
 ;;=7821^maintain fluid/electrolytes WNL for patient^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,4,0)
 ;;=4627^urine output less than [specify] cc/hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,5,0)
 ;;=4628^gradual decrease in post-op weight [specify amt] over 3-4d^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,6,0)
 ;;=7837^[Extra Goal]^3^NURSC^121
 ;;^UTILITY("^GMRD(124.2,",$J,7810,1,7,0)
 ;;=8965^hemodynamically stable^2^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,7810,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7820,0)
 ;;=Coping, Ineffective Family^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7820,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7820,1,1,0)
 ;;=7822^Etiology/Related and/or Risk Factors^2^NURSC^109
 ;;^UTILITY("^GMRD(124.2,",$J,7820,1,2,0)
 ;;=7840^Goals/Expected Outcomes^2^NURSC^107
 ;;^UTILITY("^GMRD(124.2,",$J,7820,1,3,0)
 ;;=7852^Nursing Intervention/Orders^2^NURSC^92
 ;;^UTILITY("^GMRD(124.2,",$J,7820,1,4,0)
 ;;=7870^Related Problems^2^NURSC^92
 ;;^UTILITY("^GMRD(124.2,",$J,7820,1,5,0)
 ;;=7884^Defining Characteristics^2^NURSC^96
 ;;^UTILITY("^GMRD(124.2,",$J,7820,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7820,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7820,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7820,"TD",0)
 ;;=^^5^5^2901126^^^^
 ;;^UTILITY("^GMRD(124.2,",$J,7820,"TD",1,0)
 ;;=A usually supportive primary person (family member or close friend)
 ;;^UTILITY("^GMRD(124.2,",$J,7820,"TD",2,0)
 ;;=is providing insufficient, ineffective, or compromised support,
 ;;^UTILITY("^GMRD(124.2,",$J,7820,"TD",3,0)
 ;;=comfort, assistance, or encouragement that may be needed by the 
 ;;^UTILITY("^GMRD(124.2,",$J,7820,"TD",4,0)
 ;;=client to manage or master adaptive tasks related to the client's
 ;;^UTILITY("^GMRD(124.2,",$J,7820,"TD",5,0)
 ;;=health challenge.
 ;;^UTILITY("^GMRD(124.2,",$J,7821,0)
 ;;=maintain fluid/electrolytes WNL for patient^2^NURSC^9^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7821,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,7821,1,1,0)
 ;;=4393^electrolytes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7821,1,2,0)
 ;;=4394^BUN [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7821,1,3,0)
 ;;=4395^creatinine [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7821,1,4,0)
 ;;=4396^enzymes [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7821,7)
 ;;=D EN4^NURCCPU1
