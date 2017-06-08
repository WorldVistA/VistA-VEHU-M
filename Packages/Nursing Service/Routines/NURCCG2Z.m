NURCCG2Z ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,9,0)
 ;;=1015^provide non-irritating diet (clear liquid/soft/low residue)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,10,0)
 ;;=1016^maintain good hygiene of perineal area:^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,11,0)
 ;;=1021^administer antidiarrhea medication as ordered/indicated^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,12,0)
 ;;=1022^teach appropriate diet, medication usage^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,13,0)
 ;;=1023^obtain stool culture^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,14,0)
 ;;=1024^initiate consult^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,15,0)
 ;;=384^weight q[frequency]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,16,0)
 ;;=1462^I&O q[frequency]^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,17,0)
 ;;=1035^restrict foods/fluids that percipitate diarrhea [list items]^3^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,966,1,18,0)
 ;;=2974^[Extra Order]^3^NURSC^57^0
 ;;^UTILITY("^GMRD(124.2,",$J,966,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,966,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,967,0)
 ;;=Related Problems^2^NURSC^7^19^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,1,0)
 ;;=1400^Incontinence, Bowel^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,2,0)
 ;;=1401^Skin Integrity, Impairment Of (Actual)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,3,0)
 ;;=1402^Skin Integrity, Impairment Of (Potential)^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,4,0)
 ;;=1398^Nutrition, Alteration In: Less Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,5,0)
 ;;=1399^Nutrition, Alteration In: More Than Body Requirements^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,967,1,6,0)
 ;;=1403^Anxiety^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,967,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,968,0)
 ;;=contaminants^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,969,0)
 ;;=dietary intake^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,970,0)
 ;;=quality of pain on a scale of 1-10^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,971,0)
 ;;=inflammation, irritation or malabsorption of bowel^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,972,0)
 ;;=stress and anxiety^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,973,0)
 ;;=12 lead EKG findings^2^NURSC^^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,973,1,0)
 ;;=^124.21PI^3^3
 ;;^UTILITY("^GMRD(124.2,",$J,973,1,1,0)
 ;;=974^ST segment elevation [specify location]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,973,1,2,0)
 ;;=975^T wave depression [specify location]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,973,1,3,0)
 ;;=976^Q waves [specify location]^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,973,5)
 ;;=including
 ;;^UTILITY("^GMRD(124.2,",$J,973,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,974,0)
 ;;=ST segment elevation [specify location]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,975,0)
 ;;=T wave depression [specify location]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,976,0)
 ;;=Q waves [specify location]^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,977,0)
 ;;=evacuates soft, formed stool q[ ]days without pain/strain^3^NURSC^9^3^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,977,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,977,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,978,0)
 ;;=describes S/S requiring medical attention^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,978,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,978,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,979,0)
 ;;=describes methods to manage chronic diarrhea^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,979,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,979,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,980,0)
 ;;=verbalizes medication regimen^3^NURSC^9^1^^^T
