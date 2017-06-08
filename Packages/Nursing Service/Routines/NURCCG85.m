NURCCG85 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4350,0)
 ;;=Optional Care Plans^2^NURSC^^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,0)
 ;;=^124.21PI^54^53
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,1,0)
 ;;=4351^Pulmonary Embolus^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,2,0)
 ;;=4354^Acute Myocardial Infarction^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,3,0)
 ;;=4355^Congestive Heart Failure^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,4,0)
 ;;=4360^Cirrhosis^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,5,0)
 ;;=4534^Hypertension^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,6,0)
 ;;=4558^Cardiac Surgery^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,7,0)
 ;;=4570^Pancreatitis^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,9,0)
 ;;=4694^Cancer of the Larynx^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,10,0)
 ;;=4770^Aortobifemoral Bypass^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,11,0)
 ;;=4795^Pneumonia/Pleurisy^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,12,0)
 ;;=4852^Psychoses/Schizophrenia^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,13,0)
 ;;=4927^Gastroenteritis/Gastritis^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,14,0)
 ;;=4984^Angina/Chest Pain^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,15,0)
 ;;=4995^Manic Behavior^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,16,0)
 ;;=5006^Cancer of the Lung^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,17,0)
 ;;=5095^Transurethral Resection/Benign Prostatic Hypertrophy^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,18,0)
 ;;=5096^Renal Failure^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,19,0)
 ;;=5098^Asthma/Chronic Obstructive Pulmonary Disease^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,20,0)
 ;;=5099^Pleural Effusion/Pneumothorax/Hemothorax/Empyema^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,21,0)
 ;;=5100^Cancer of the Lung (Surgical)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,22,0)
 ;;=5101^Chemotherapy/Radiation Therapy^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,23,0)
 ;;=5102^Acute Respiratory Failure/Adult Resp Distress Syndrome^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,24,0)
 ;;=5103^Hemodialysis^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,25,0)
 ;;=5104^Renal/Urinary Calculi^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,26,0)
 ;;=5106^Ocular Disorder/Surgery (Cataracts)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,27,0)
 ;;=5107^Acquired Immune Deficiency Syndrome (AIDS)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,28,0)
 ;;=5108^Diabetes Mellitus^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,29,0)
 ;;=5109^Gastrointestinal Hemorrhage (G.I. Bleed)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,30,0)
 ;;=5110^Hernia Repair^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,31,0)
 ;;=5112^Cholecystectomy ^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,32,0)
 ;;=5113^Hepatitis^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,33,0)
 ;;=5114^Cerebrovascular Accident (Left Hemiplegia/Paresis)^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,34,0)
 ;;=5115^Abdominal Aortic Aneurysm Repair^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,35,0)
 ;;=5117^Tuberculosis^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,36,0)
 ;;=5118^Depressive Neurosis^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,37,0)
 ;;=5119^Substance Abuse Withdrawal/Detoxification^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,38,0)
 ;;=5120^Post Traumatic Stress Disorder^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,39,0)
 ;;=5121^Alcohol/Drug Dependency Rehabilitation^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,40,0)
 ;;=5122^Organic Disturbances^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,41,0)
 ;;=5149^Sleep Apnea^2^NURSC^2
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,42,0)
 ;;=5152^Parkinsons Disease^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4350,1,43,0)
 ;;=5153^Seizure Disorder^2^NURSC^1
