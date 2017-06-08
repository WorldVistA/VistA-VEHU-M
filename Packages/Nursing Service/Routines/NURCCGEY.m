NURCCGEY ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13985,1,2,0)
 ;;=13989^[Extra Goal]^3^NURSC^387
 ;;^UTILITY("^GMRD(124.2,",$J,13985,1,3,0)
 ;;=13990^[Extra Goal]^3^NURSC^388
 ;;^UTILITY("^GMRD(124.2,",$J,13985,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13986,0)
 ;;=[Extra Order]^3^NURSC^11^391^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13986,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13986,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13987,0)
 ;;=[Extra Goal]^3^NURSC^9^386^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13987,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13987,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13988,0)
 ;;=[Extra Order]^3^NURSC^11^392^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13988,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13988,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13989,0)
 ;;=[Extra Goal]^3^NURSC^9^387^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13989,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13989,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13990,0)
 ;;=[Extra Goal]^3^NURSC^9^388^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13990,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13990,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13991,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^300^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13991,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,13991,1,1,0)
 ;;=13992^[Extra Order]^3^NURSC^393
 ;;^UTILITY("^GMRD(124.2,",$J,13991,1,2,0)
 ;;=13993^[Extra Order]^3^NURSC^394
 ;;^UTILITY("^GMRD(124.2,",$J,13991,1,3,0)
 ;;=13994^[Extra Order]^3^NURSC^395
 ;;^UTILITY("^GMRD(124.2,",$J,13991,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13991,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13992,0)
 ;;=[Extra Order]^3^NURSC^11^393^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13992,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13992,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13993,0)
 ;;=[Extra Order]^3^NURSC^11^394^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13993,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13993,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13994,0)
 ;;=[Extra Order]^3^NURSC^11^395^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13994,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13994,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13995,0)
 ;;=Depressive Behavior^2^NURSC^2^2^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13995,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,13995,1,1,0)
 ;;=13996^Etiology/Related and/or Risk Factors^2^NURSC^187
 ;;^UTILITY("^GMRD(124.2,",$J,13995,1,2,0)
 ;;=14005^Goals/Expected Outcomes^2^NURSC^184
 ;;^UTILITY("^GMRD(124.2,",$J,13995,1,3,0)
 ;;=14019^Nursing Intervention/Orders^2^NURSC^154
 ;;^UTILITY("^GMRD(124.2,",$J,13995,1,4,0)
 ;;=14034^Related Problems^2^NURSC^160
 ;;^UTILITY("^GMRD(124.2,",$J,13995,1,5,0)
 ;;=14043^Defining Characteristics^2^NURSC^163
 ;;^UTILITY("^GMRD(124.2,",$J,13995,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,13995,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13995,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13995,"TD",0)
 ;;=^^2^2^2890307^^
 ;;^UTILITY("^GMRD(124.2,",$J,13995,"TD",1,0)
 ;;=A universal mode of interacting manifested by sadness, poor self-concept,
 ;;^UTILITY("^GMRD(124.2,",$J,13995,"TD",2,0)
 ;;=and inability to act for self; ranges from mild grief to a psychosis.
 ;;^UTILITY("^GMRD(124.2,",$J,13996,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^187^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,0)
 ;;=^124.21PI^8^7
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,1,0)
 ;;=2344^belief that stress, event or illness is uncontrollable^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13996,1,2,0)
 ;;=2345^cognitive errors; negative ideas of self, world, & future^3^NURSC^1
