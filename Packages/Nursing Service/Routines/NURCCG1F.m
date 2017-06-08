NURCCG1F ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,508,0)
 ;;=returns to and maintains NSR or pacing rhythm^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,508,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,508,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,509,0)
 ;;=maintains cardiac output^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,509,1,0)
 ;;=^124.21PI^5^5
 ;;^UTILITY("^GMRD(124.2,",$J,509,1,1,0)
 ;;=514^vital signs WNL or returns to baseline^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,509,1,2,0)
 ;;=516^capillary filling WNL^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,509,1,3,0)
 ;;=517^lab data (e.g. BUN, creatinine) is normal or baseline^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,509,1,4,0)
 ;;=2860^skin warm to touch^3^NURSC^2^0
 ;;^UTILITY("^GMRD(124.2,",$J,509,1,5,0)
 ;;=1424^normal skin color^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,509,5)
 ;;=as evidenced by
 ;;^UTILITY("^GMRD(124.2,",$J,509,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,509,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,509,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,510,0)
 ;;=maintains therapeutic levels of antiarrhythmic agents^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,510,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,510,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,511,0)
 ;;=avoids toxicity/allergic reactions to drugs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,511,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,511,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,512,0)
 ;;=limits myocardial infarction area^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,512,1,0)
 ;;=^124.21PI^2^2
 ;;^UTILITY("^GMRD(124.2,",$J,512,1,1,0)
 ;;=973^12 lead EKG findings^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,512,1,2,0)
 ;;=1201^level of energy^3^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,512,5)
 ;;=as determined by
 ;;^UTILITY("^GMRD(124.2,",$J,512,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,512,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,512,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,513,0)
 ;;=avoids metabolic death^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,513,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,513,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,514,0)
 ;;=vital signs WNL or returns to baseline^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,515,0)
 ;;=skin is warm to touch and is normal color^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,515,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,515,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,516,0)
 ;;=capillary filling WNL^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,517,0)
 ;;=lab data (e.g. BUN, creatinine) is normal or baseline^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,518,0)
 ;;=Medical Diagnoses^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,1,0)
 ;;=520^Cardiovascular^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,2,0)
 ;;=521^Endocrine^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,3,0)
 ;;=522^Gastrointestinal^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,4,0)
 ;;=523^GU/Renal^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,5,0)
 ;;=524^HEENT^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,6,0)
 ;;=525^Immune (Cancer,AIDS,Transplant,Arthritis)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,7,0)
 ;;=526^Integument^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,8,0)
 ;;=527^Musculo-Skeletal/Orthopedic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,9,0)
 ;;=528^Neurologic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,10,0)
 ;;=529^Nutrition/Metabolic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,11,0)
 ;;=530^Other^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,12,0)
 ;;=532^Plastic Surgery^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,13,0)
 ;;=533^Psychosocial^2^NURSC^1^0
