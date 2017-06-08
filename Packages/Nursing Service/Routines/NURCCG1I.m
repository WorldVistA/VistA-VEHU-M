NURCCG1I ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,526,1,1,0)
 ;;=706^Pressure Sores^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,526,1,2,0)
 ;;=707^Skin Grafts^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,526,1,3,0)
 ;;=2802^Burns^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,0)
 ;;=Musculo-Skeletal/Orthopedic^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,1,0)
 ;;=700^Amputation^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,2,0)
 ;;=701^Carpal Tunnel Syndrome^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,3,0)
 ;;=702^Casts^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,4,0)
 ;;=703^Fractures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,5,0)
 ;;=704^Total Joint Replacement (knee, hip, elbow, fingers, wrist)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,6,0)
 ;;=705^Traction^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,527,1,7,0)
 ;;=707^Skin Grafts^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,0)
 ;;=Neurologic^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,0)
 ;;=^124.21PI^10^10
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,1,0)
 ;;=714^OBS (Alzheimer's/Wernicke-Korsakoff Syndrome)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,2,0)
 ;;=715^Spinal Procedures (Laminectomy/Spinal Fusion)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,3,0)
 ;;=716^CVA/TIA^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,4,0)
 ;;=717^Hypophysectomy (Craniotomy)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,5,0)
 ;;=718^Spinal Cord Injury^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,6,0)
 ;;=719^Syncope^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,7,0)
 ;;=2759^Craniotomy^2^NURSC^3^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,8,0)
 ;;=2760^Seizure/Headache^2^NURSC^4^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,9,0)
 ;;=2806^Degenerative Nervous System Disease^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,528,1,10,0)
 ;;=2807^Traumatic Brain Injury^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,529,0)
 ;;=Nutrition/Metabolic^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,0)
 ;;=^124.21PI^6^6
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,1,0)
 ;;=731^Anorexia Nervosa/Anorexia Bulemia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,2,0)
 ;;=732^Hypovolemia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,3,0)
 ;;=733^Hypokalemia^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,4,0)
 ;;=734^Malnutrition^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,5,0)
 ;;=735^Obesity^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,529,1,6,0)
 ;;=2769^Malabsorption Syndrome^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,530,0)
 ;;=Other^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,530,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,530,1,1,0)
 ;;=737^Sepsis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,0)
 ;;=Pulmonary^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,1,0)
 ;;=668^Cancer of the Larynx^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,2,0)
 ;;=669^COPD, Bronchitis, Asthma^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,3,0)
 ;;=670^Lung Cancer^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,4,0)
 ;;=738^Lung Cancer:  Surgical Intervention^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,5,0)
 ;;=739^Pneumonia and Pleurisy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,6,0)
 ;;=740^Pneumothorax/Hemothorax/Pleural Effusion^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,7,0)
 ;;=2770^Pulmonary Edema^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,8,0)
 ;;=2771^Respiratory Failure/Acute Resp Distress Syndrome^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,9,0)
 ;;=2772^Interstitial Lung Disease^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,10,0)
 ;;=2773^Sleep Apnea^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,531,1,11,0)
 ;;=2774^Tuberculosis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,532,0)
 ;;=Plastic Surgery^2^NURSC^10^1^1^^T
