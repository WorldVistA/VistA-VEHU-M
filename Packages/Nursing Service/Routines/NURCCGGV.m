NURCCGGV ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,4,0)
 ;;=15821^assess impact of pain on self care ability^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,5,0)
 ;;=35^assist to maintain and manage health care^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,6,0)
 ;;=15823^assist to match identified needs to community resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,7,0)
 ;;=151^discuss role of exercise^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,8,0)
 ;;=150^discuss role of nutrition^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,9,0)
 ;;=152^discuss role of safety measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,10,0)
 ;;=154^discuss role of social support systems^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,11,0)
 ;;=153^discuss role of stress management^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,12,0)
 ;;=15824^discuss role of infection control measures^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,13,0)
 ;;=15825^discuss role of prescribed medication^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,14,0)
 ;;=12936^encourage patient/SO to express feelings/concerns^3^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,15,0)
 ;;=15827^evaluate the environment to which patient is discharged^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,16,0)
 ;;=15828^explain purpose of applicable community resources^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,17,0)
 ;;=15829^promote reality orientation^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,19,0)
 ;;=36^promote wellness through patient/family knowledge [specify]^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,20,0)
 ;;=15838^provide education regarding requirements of care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,21,0)
 ;;=15839^provide health counseling about bowel/bladder alterations^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,22,0)
 ;;=15840^provide health counseling about home safety^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,23,0)
 ;;=15841^provide health counseling about sensory changes^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,24,0)
 ;;=289^refer for appropriate consults^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,25,0)
 ;;=15843^reinforce importance of adhering to treatment regime^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,26,0)
 ;;=15844^reinforce use of adaptive/assistive devices for self-care^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,27,0)
 ;;=15846^teach alternate methods for task accomplishment^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,28,0)
 ;;=15847^teach assertive versus aggressive behaviors^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,29,0)
 ;;=15849^teach effective methods for relieving tension/stress^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,30,0)
 ;;=15850^teach family/SO use of assistive/adaptive devices^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,31,0)
 ;;=15852^teach patient signs/symptoms of infection^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,32,0)
 ;;=15853^teach positive coping methods for pain relief^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,33,0)
 ;;=15854^teach positive methods for problem resolution^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,1,34,0)
 ;;=15856^[Extra Order]^3^NURSC^269
 ;;^UTILITY("^GMRD(124.2,",$J,15774,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,15774,9)
 ;;=D EN1^NURCCPU2
 ;;^UTILITY("^GMRD(124.2,",$J,15775,0)
 ;;=anxiety regarding health management^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15776,0)
 ;;=alteration in family process^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15777,0)
 ;;=homelessness/abandonement^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15778,0)
 ;;=inadequate financial resources^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15781,0)
 ;;=mobility impaired^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,15782,0)
 ;;=noncompliance with treatment^3^NURSC^^1^^^T
