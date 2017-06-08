SRONI001 ; ; 09-FEB-1993
 ;;3.0; Surgery ;;24 Jun 93
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1376,0)
 ;;=SR SURGERY REQUEST^Surgery Request^^O^^^^^^^^SURGERY
 ;;^UTILITY(U,$J,"PRO",1376,1,0)
 ;;=^^2^2^2920713^^^^
 ;;^UTILITY(U,$J,"PRO",1376,1,1,0)
 ;;=This protocol allows the entry and editing of operation requests through
 ;;^UTILITY(U,$J,"PRO",1376,1,2,0)
 ;;=OE/RR.
 ;;^UTILITY(U,$J,"PRO",1376,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1376,2,1,0)
 ;;=SR
 ;;^UTILITY(U,$J,"PRO",1376,2,"B","SR",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1376,3,0)
 ;;=^101.03PA^0^0
 ;;^UTILITY(U,$J,"PRO",1376,4)
 ;;=^^^
 ;;^UTILITY(U,$J,"PRO",1376,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",1376,15)
 ;;=K SRSITE,^TMP($J,"SRCUSS")
 ;;^UTILITY(U,$J,"PRO",1376,20)
 ;;=D EN^SROERR
 ;;^UTILITY(U,$J,"PRO",1376,99)
 ;;=55552,36253
 ;;^UTILITY(U,$J,"PRO",1376,101.01)
 ;;=1
 ;;^UTILITY(U,$J,"PRO",1376,"MEN","ORADD")
 ;;=1376^SR
