NURCCGDX ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12235,1,3,0)
 ;;=228^verbalizes comfort and satisfaction with body cleanliness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12235,1,4,0)
 ;;=12239^[Extra Goal]^3^NURSC^196
 ;;^UTILITY("^GMRD(124.2,",$J,12235,1,5,0)
 ;;=6697^performs bathing with [min/mod/max] assistance [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12235,1,6,0)
 ;;=6777^performs bathing independently^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12235,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12239,0)
 ;;=[Extra Goal]^3^NURSC^9^196^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12239,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12239,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,0)
 ;;=dressing/grooming deficit outcomes^2^NURSC^^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,0)
 ;;=^124.21PI^8^7
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,1,0)
 ;;=229^increased ability to dress self^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,2,0)
 ;;=230^ability to request/accept assistance in dressing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,3,0)
 ;;=231^increased interest in appearance and dress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,4,0)
 ;;=2498^adaptive techniques/devices for independent dressing^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,5,0)
 ;;=2499^independence in dressing/grooming^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,6,0)
 ;;=12246^[Extra Goal]^3^NURSC^197
 ;;^UTILITY("^GMRD(124.2,",$J,12240,1,8,0)
 ;;=6947^performs dressing/grooming with [min/mod/max] assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12240,5)
 ;;=demonstrates
 ;;^UTILITY("^GMRD(124.2,",$J,12240,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12246,0)
 ;;=[Extra Goal]^3^NURSC^9^197^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12246,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12246,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,0)
 ;;=toileting deficit outcomes^2^NURSC^^4^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,0)
 ;;=^124.21PI^16^9
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,5,0)
 ;;=7409^demonstrates use of adaptive devices [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,7,0)
 ;;=12254^[Extra Goal]^3^NURSC^198
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,8,0)
 ;;=905^evacuates soft, formed stool q[ ]days without pain/strain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,9,0)
 ;;=7408^performs toileting hygiene independently^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,11,0)
 ;;=5358^re-establishes control over urination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,13,0)
 ;;=15351^maintain fluid intake of [ ]cc q[frequency]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,14,0)
 ;;=15352^performs independent toilet transfers^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,15,0)
 ;;=7404^performs toilet transfer with [min/mod/max] assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,1,16,0)
 ;;=7406^performs toileting hygiene with [min/mod/max] assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12247,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12254,0)
 ;;=[Extra Goal]^3^NURSC^9^198^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12254,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12254,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12255,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^137^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12255,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,12255,1,1,0)
 ;;=232^general self-care deficit interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12255,1,2,0)
 ;;=233^feeding deficit interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12255,1,4,0)
 ;;=235^dressing/grooming deficit interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12255,1,5,0)
 ;;=373^toileting deficit interventions^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12255,7)
 ;;=D EN4^NURCCPU1
