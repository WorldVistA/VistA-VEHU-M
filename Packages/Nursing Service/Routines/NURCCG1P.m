NURCCG1P ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,1,0)
 ;;=613^verbalizes awareness of the cause/contributing factors^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,2,0)
 ;;=614^verbalizes effects of medical tx. on sexual functioning^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,3,0)
 ;;=615^relates confidence to resume satisfying sexual activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,4,0)
 ;;=616^relates ability to resume satisfying sexual activity^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,5,0)
 ;;=617^identifies stressors in life related to sexual dysfunction^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,602,1,6,0)
 ;;=2880^[Extra Goal]^3^NURSC^57^0
 ;;^UTILITY("^GMRD(124.2,",$J,602,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,603,0)
 ;;=Nursing Intervention/Orders^2^NURSC^6^12^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,0)
 ;;=^124.21PI^13^13
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,1,0)
 ;;=618^elicit personal information about sexual history^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,2,0)
 ;;=619^provide privacy and assure confidentiality^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,3,0)
 ;;=620^establish a trusting relationship^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,4,0)
 ;;=621^discuss sexual activity limitations^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,5,0)
 ;;=622^discuss the varied etiologies of impotence^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,6,0)
 ;;=623^discuss ways to enhance sexual expression^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,7,0)
 ;;=624^teach sexual physiology as indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,8,0)
 ;;=625^teach the likelihood of adverse effects^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,9,0)
 ;;=626^provide information regarding altered body structure^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,10,0)
 ;;=627^teach possible reconstructive surgical intervention^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,11,0)
 ;;=628^teach relaxation techniques^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,12,0)
 ;;=629^refer for consultation or support resource^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,1,13,0)
 ;;=2967^[Extra Order]^3^NURSC^50^0
 ;;^UTILITY("^GMRD(124.2,",$J,603,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,603,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,604,0)
 ;;=Related Problems^2^NURSC^7^12^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,604,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,604,1,1,0)
 ;;=1937^Sexual Pattern, Altered^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,604,1,2,0)
 ;;=1411^Self Concept, Disturbance In^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,604,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,605,0)
 ;;=altered body structure or function^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,606,0)
 ;;=ineffectual or absent role models^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,607,0)
 ;;=lack of privacy^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,608,0)
 ;;=lack of significant other^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,609,0)
 ;;=misinformation or lack of knowledge^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,610,0)
 ;;=values conflict^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,611,0)
 ;;=vulnerability^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,612,0)
 ;;=physical or psychosocial abuse, e.g. harmful relationships^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,613,0)
 ;;=verbalizes awareness of the cause/contributing factors^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,613,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,613,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,614,0)
 ;;=verbalizes effects of medical tx. on sexual functioning^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,614,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,614,10)
 ;;=D EN2^NURCCPU1
