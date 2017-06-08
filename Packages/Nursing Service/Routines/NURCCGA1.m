NURCCGA1 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,2,0)
 ;;=5577^verbalizes S/S of urinary tract infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,3,0)
 ;;=5582^verbalizes understanding of treatment regimen^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,4,0)
 ;;=5584^demonstrates absence of foul smelling urine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,5,0)
 ;;=5587^verbalizes factors that increase risk of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,6,0)
 ;;=5592^demonstrates adequate personal hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5573,1,7,0)
 ;;=8275^[Extra Goal]^3^NURSC^71
 ;;^UTILITY("^GMRD(124.2,",$J,5573,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,0)
 ;;=Defining Characteristics^2^NURSC^12^70^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,5574,1,1,0)
 ;;=5579^denial of obvious problems/weaknesses^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,1,2,0)
 ;;=5580^projection of blame/responsibility^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,1,3,0)
 ;;=5581^rationalizes failure^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,1,4,0)
 ;;=5583^hypersensitive to slight criticism^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,1,5,0)
 ;;=5585^grandiosity^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,5574,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5575,0)
 ;;=infection free^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5575,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5575,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5576,0)
 ;;=[Extra Problem]^2^NURSC^2^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5576,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5576,1,1,0)
 ;;=5578^Etiology/Related and/or Risk Factors^2^NURSC^254
 ;;^UTILITY("^GMRD(124.2,",$J,5576,1,2,0)
 ;;=5588^Goals/Expected Outcomes^2^NURSC^79
 ;;^UTILITY("^GMRD(124.2,",$J,5576,1,3,0)
 ;;=5595^Nursing Intervention/Orders^2^NURSC^264
 ;;^UTILITY("^GMRD(124.2,",$J,5576,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5576,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,5576,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5577,0)
 ;;=verbalizes S/S of urinary tract infection^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5577,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5577,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5578,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^254^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5578,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,5578,1,1,0)
 ;;=5677^[etiology]^3^NURSC^83
 ;;^UTILITY("^GMRD(124.2,",$J,5578,1,2,0)
 ;;=5693^[etiology]^3^NURSC^84
 ;;^UTILITY("^GMRD(124.2,",$J,5578,1,3,0)
 ;;=5955^[etiology]^3^NURSC^17
 ;;^UTILITY("^GMRD(124.2,",$J,5578,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5579,0)
 ;;=denial of obvious problems/weaknesses^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5580,0)
 ;;=projection of blame/responsibility^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5581,0)
 ;;=rationalizes failure^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5582,0)
 ;;=verbalizes understanding of treatment regimen^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5582,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5582,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5583,0)
 ;;=hypersensitive to slight criticism^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5584,0)
 ;;=demonstrates absence of foul smelling urine^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5584,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,5584,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,5585,0)
 ;;=grandiosity^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,5586,0)
 ;;=Defining Characteristics^2^NURSC^12^71^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,5586,1,0)
 ;;=^124.21PI^5^4
 ;;^UTILITY("^GMRD(124.2,",$J,5586,1,2,0)
 ;;=5590^verbalization of undesired consequences of actions^3^NURSC^1
