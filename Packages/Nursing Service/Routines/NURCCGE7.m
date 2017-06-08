NURCCGE7 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,12737,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12740,0)
 ;;=have a network of support developed prior to discharge^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12740,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12740,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12743,0)
 ;;=verbalizes feelings and healthy ways to deal with them^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12743,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12743,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12751,0)
 ;;=[Extra Goal]^3^NURSC^9^204^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12751,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,12751,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12753,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^143^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12753,1,0)
 ;;=^124.21PI^12^5
 ;;^UTILITY("^GMRD(124.2,",$J,12753,1,4,0)
 ;;=12764^allow patient to ventilate feelings of anxiety concerns^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12753,1,8,0)
 ;;=12772^recognize/support stage of grieving patient & S/O in^3^NURSC^13
 ;;^UTILITY("^GMRD(124.2,",$J,12753,1,10,0)
 ;;=12776^assess support available to patient and S/O^3^NURSC^3
 ;;^UTILITY("^GMRD(124.2,",$J,12753,1,11,0)
 ;;=13273^[Extra Order]^3^NURSC^236
 ;;^UTILITY("^GMRD(124.2,",$J,12753,1,12,0)
 ;;=289^refer for appropriate consults^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12753,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12753,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12764,0)
 ;;=allow patient to ventilate feelings of anxiety concerns^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12764,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12764,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12768,0)
 ;;=evaluate eye: during dressing change & eye drop instillation^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12768,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12768,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12772,0)
 ;;=recognize/support stage of grieving patient & S/O in^3^NURSC^11^13^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12772,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12772,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12776,0)
 ;;=assess support available to patient and S/O^3^NURSC^11^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12776,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12776,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12779,0)
 ;;=[Extra Order]^3^NURSC^11^206^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,12779,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,12779,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,12782,0)
 ;;=Related Problems^2^NURSC^7^147^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,1,0)
 ;;=1948^Violence, Potential For, Directed At Others^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,2,0)
 ;;=1946^Violence, Potential For, Self Directed^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,3,0)
 ;;=1945^Family Process, Alteration In^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,4,0)
 ;;=1415^Coping, Ineffective Individual^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,5,0)
 ;;=1416^Coping, Ineffective Family^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,6,0)
 ;;=1405^Depressive Behavior^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,7,0)
 ;;=1420^Fear^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,8,0)
 ;;=1918^Social Isolation^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,9,0)
 ;;=1916^Powerlessness^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,1,10,0)
 ;;=2018^Sleep Pattern Disturbance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,12782,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,12802,0)
 ;;=Defining Characteristics^2^NURSC^12^147^1^^T^1
