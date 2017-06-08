NURCCG1O ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,586,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,586,1,1,0)
 ;;=598^make time for discussions of philosophic issues^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,586,1,2,0)
 ;;=599^make time for questions about treatment regimen^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,586,1,3,0)
 ;;=600^listen attentively and non-judgementally to patient^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,586,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,586,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,586,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,587,0)
 ;;=help patient find reason for living^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,587,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,587,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,588,0)
 ;;=help patient find meaning in illness/suffering^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,588,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,588,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,589,0)
 ;;=assist to develope coping skills^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,589,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,589,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,590,0)
 ;;=assist patient to identify his strengths and support systems^3^NURSC^11^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,590,9)
 ;;=D EN2^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,590,10)
 ;;=D EN1^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,591,0)
 ;;=religious practices in use^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,592,0)
 ;;=if yes, to what religion do you belong?^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,593,0)
 ;;=how will your illness affect your practices/beliefs?^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,594,0)
 ;;=how can I help you maintain your spiritual strength?^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,594,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,594,1,1,0)
 ;;=595^contact minister/priest/rabbi^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,594,1,2,0)
 ;;=596^provide privacy at special times^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,594,1,3,0)
 ;;=597^request reading material^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,594,5)
 ;;=such as
 ;;^UTILITY("^GMRD(124.2,",$J,594,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,595,0)
 ;;=contact minister/priest/rabbi^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,596,0)
 ;;=provide privacy at special times^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,597,0)
 ;;=request reading material^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,598,0)
 ;;=make time for discussions of philosophic issues^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,599,0)
 ;;=make time for questions about treatment regimen^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,600,0)
 ;;=listen attentively and non-judgementally to patient^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,601,0)
 ;;=Etiology/Related and/or Risk Factors^2^NURSC^4^15^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,0)
 ;;=^124.21PI^8^8
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,1,0)
 ;;=605^altered body structure or function^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,2,0)
 ;;=606^ineffectual or absent role models^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,3,0)
 ;;=607^lack of privacy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,4,0)
 ;;=608^lack of significant other^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,5,0)
 ;;=609^misinformation or lack of knowledge^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,6,0)
 ;;=610^values conflict^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,7,0)
 ;;=611^vulnerability^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,1,8,0)
 ;;=612^physical or psychosocial abuse, e.g. harmful relationships^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,601,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,602,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^15^1^^T
