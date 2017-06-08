NURCCG1G ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,518,1,14,0)
 ;;=531^Pulmonary^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,0)
 ;;=Nursing Problems^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,0)
 ;;=^124.21PI^14^14
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,1,0)
 ;;=2^Health Management^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,2,0)
 ;;=3^Activities of Daily Living^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,3,0)
 ;;=4^Respiratory System^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,4,0)
 ;;=5^Circulatory System^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,5,0)
 ;;=6^Nutrition-Metabolic Area^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,6,0)
 ;;=7^Elimination^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,7,0)
 ;;=8^Integumentary (Skin)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,8,0)
 ;;=9^Musculoskeletal/Neurological^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,9,0)
 ;;=10^Cognitive-Sensory Area^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,10,0)
 ;;=11^Sleep/Rest^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,11,0)
 ;;=12^Sexual Functioning/Reproductive System^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,12,0)
 ;;=13^Psycho-Social Area^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,13,0)
 ;;=14^Spiritual Needs^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,519,1,14,0)
 ;;=340^Pain, Chest^2^NURSC^2^1
 ;;^UTILITY("^GMRD(124.2,",$J,520,0)
 ;;=Cardiovascular^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,0)
 ;;=^124.21PI^22^22
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,1,0)
 ;;=647^Abdominal Aortic Aneurysm Repair^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,2,0)
 ;;=860^Acute Myocardial Infarction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,3,0)
 ;;=648^Angina/Chest Pain^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,4,0)
 ;;=649^Aortobifemoral Bypass Graft^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,5,0)
 ;;=650^Arterial Insufficiency^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,6,0)
 ;;=652^Cardiac Surgery Post-Operative (CABG, Valve Replacement)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,7,0)
 ;;=653^Cardiac Tamponade^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,8,0)
 ;;=654^Cardiogenic Shock^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,9,0)
 ;;=655^Cardiomyopathy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,10,0)
 ;;=656^Carotid Artery Endarterectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,11,0)
 ;;=657^Digoxin Toxicity^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,12,0)
 ;;=658^Dysrhythmias^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,13,0)
 ;;=659^Endocarditis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,14,0)
 ;;=660^Heart Failure^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,15,0)
 ;;=661^Hypertension^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,16,0)
 ;;=662^Pericarditis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,17,0)
 ;;=663^Peripheral Vascular Surgery Procedures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,18,0)
 ;;=664^Pulmonary Embolus^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,19,0)
 ;;=665^Thrombophlebitis (DVT)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,20,0)
 ;;=666^Valvular Heart Disease^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,21,0)
 ;;=667^Vein Ligation and Stripping^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,520,1,22,0)
 ;;=651^Atherosclerosis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,0)
 ;;=Endocrine^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,0)
 ;;=^124.21PI^9^9
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,1,0)
 ;;=708^Addison's Disease (Adrenal Insufficiency)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,2,0)
 ;;=689^Adrenalectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,3,0)
 ;;=709^Cushing's Disease^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,4,0)
 ;;=710^Hyperthyroidism (Graves' Disease)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,5,0)
 ;;=711^Hypothyroidism^2^NURSC^1^0
