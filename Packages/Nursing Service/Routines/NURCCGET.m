NURCCGET ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,6,0)
 ;;=1283^patient fluid preference [ADDITIONAL TEXT]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,7,0)
 ;;=1284^respond within [ ]min to request for toileting assistance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,8,0)
 ;;=13809^assess urine character [specify]^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,9,0)
 ;;=1239^active isometric pelvic exercises [ ]times per [ ]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,10,0)
 ;;=13811^teach S/S of urinary tract infection^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,11,0)
 ;;=5393^teach catheterization technique/care q [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,12,0)
 ;;=13816^monitor for S/S of sepsis^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,13,0)
 ;;=1200^cath care q[frequency]hr^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,14,0)
 ;;=1295^teach intermittent catheterization per protocol^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,15,0)
 ;;=14328^[Extra Order]^3^NURSC^249
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,16,0)
 ;;=15338^teach urinary management program [specify]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,17,0)
 ;;=15339^assess contributing factors for infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,18,0)
 ;;=15340^teach perineal hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,1,19,0)
 ;;=15341^teach rationale for preventive practices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13785,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13806,0)
 ;;=assess for bladder emptying^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13806,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13806,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13809,0)
 ;;=assess urine character [specify]^3^NURSC^11^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13809,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13809,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13811,0)
 ;;=teach S/S of urinary tract infection^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,1,0)
 ;;=13812^temperature elevation/chills^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,2,0)
 ;;=13813^concentrated urine^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,3,0)
 ;;=13814^decreased urinary output^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,4,0)
 ;;=15326^foul smelling urine^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,5,0)
 ;;=1191^hematuria^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,6,0)
 ;;=1210^frequent urination^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,7,0)
 ;;=15329^flank pain^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,8,0)
 ;;=15330^spasticity increase^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,9,0)
 ;;=2861^perineal hygiene^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,1,10,0)
 ;;=15332^rationale for preventive practices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,13811,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,13811,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,13812,0)
 ;;=temperature elevation/chills^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13813,0)
 ;;=concentrated urine^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13814,0)
 ;;=decreased urinary output^3^NURSC^^2^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,13816,0)
 ;;=monitor for S/S of sepsis^2^NURSC^11^2^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,1,0)
 ;;=13817^tachycardia and tachypnea^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,2,0)
 ;;=4221^increased body temperature above normal range^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,13816,1,3,0)
 ;;=15334^pale, cool skin^3^NURSC^1
