NURCCGBF ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,3,0)
 ;;=4295^S/O's lack of understanding illness affects assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,4,0)
 ;;=4305^S/O doting behavior affects client's autonomy/abilities^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,5,0)
 ;;=4309^S/O is withdrawn from patient at time of need^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,6,0)
 ;;=4310^S/O attempts assistance with less than satisfactory results^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,7,0)
 ;;=4315^abandonment, desertion, intolerance or rejection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,8,0)
 ;;=4317^distortion of reality to client's illness ie., denial^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,1,9,0)
 ;;=4318^S/O assumes clients signs of illness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7884,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7885,0)
 ;;=Tissue Integrity, Impaired^2^NURSC^2^3^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7885,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,7885,1,1,0)
 ;;=7886^Etiology/Related and/or Risk Factors^2^NURSC^110
 ;;^UTILITY("^GMRD(124.2,",$J,7885,1,2,0)
 ;;=7900^Related Problems^2^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,7885,1,3,0)
 ;;=7906^Goals/Expected Outcomes^2^NURSC^108
 ;;^UTILITY("^GMRD(124.2,",$J,7885,1,4,0)
 ;;=7921^Nursing Intervention/Orders^2^NURSC^93
 ;;^UTILITY("^GMRD(124.2,",$J,7885,1,5,0)
 ;;=7954^Defining Characteristics^2^NURSC^97
 ;;^UTILITY("^GMRD(124.2,",$J,7885,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7885,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,7885,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7885,"TD",0)
 ;;=^^1^1^2890306^^
 ;;^UTILITY("^GMRD(124.2,",$J,7885,"TD",1,0)
 ;;=State of tissue damage.
 ;;^UTILITY("^GMRD(124.2,",$J,7886,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^110^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7886,1,0)
 ;;=^124.21PI^7^2
 ;;^UTILITY("^GMRD(124.2,",$J,7886,1,1,0)
 ;;=1761^altered circulation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7886,1,7,0)
 ;;=2785^surgical incision^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7886,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7900,0)
 ;;=Related Problems^2^NURSC^7^93^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,7900,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,7900,1,1,0)
 ;;=1516^Tissue Integrity, Impaired^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7900,1,2,0)
 ;;=1775^Knowledge Deficit (Specify)^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7900,1,3,0)
 ;;=1515^Tissue Perfusion, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7900,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7906,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^108^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7906,1,0)
 ;;=^124.21PI^13^3
 ;;^UTILITY("^GMRD(124.2,",$J,7906,1,11,0)
 ;;=7982^[Extra Goal]^3^NURSC^143
 ;;^UTILITY("^GMRD(124.2,",$J,7906,1,12,0)
 ;;=4667^incision free of redness, edema, drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7906,1,13,0)
 ;;=4670^wound edges approximated with no drainage^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7906,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7920,0)
 ;;=[Extra Goal]^3^NURSC^9^142^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7920,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,7920,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,7921,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^93^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,7921,1,0)
 ;;=^124.21PI^17^3
 ;;^UTILITY("^GMRD(124.2,",$J,7921,1,15,0)
 ;;=4673^assess,monitor,document incision q[frequency] for:^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7921,1,16,0)
 ;;=1877^aseptic dressing change q [frequency]hrs^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,7921,1,17,0)
 ;;=8091^[Extra Order]^3^NURSC^147
 ;;^UTILITY("^GMRD(124.2,",$J,7921,7)
 ;;=D EN4^NURCCPU1
