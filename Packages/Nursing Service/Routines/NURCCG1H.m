NURCCG1H ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,6,0)
 ;;=712^Parathyroidectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,7,0)
 ;;=713^Thyroidectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,8,0)
 ;;=2757^Diabetes Mellitus^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,521,1,9,0)
 ;;=2800^Diabetes Insipidus^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,0)
 ;;=Gastrointestinal^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,0)
 ;;=^124.21PI^18^18
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,1,0)
 ;;=671^Cholecystectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,2,0)
 ;;=672^Diverticulitis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,3,0)
 ;;=673^Esophageal Varices^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,4,0)
 ;;=674^Fecal Diversion (Ileostomy, Colostomy)^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,5,0)
 ;;=675^Gastric Resection/Gastrectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,6,0)
 ;;=676^Gastrointestinal Hemorrhage^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,7,0)
 ;;=677^Hemorrhoidectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,8,0)
 ;;=678^Hemmorrhoids/Anal Fissure/Pilonidal Cyst^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,9,0)
 ;;=679^Herniorrhaphy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,10,0)
 ;;=680^Intestinal Surgery^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,11,0)
 ;;=681^Liver Failure/Cirrhosis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,12,0)
 ;;=682^Mallory-Weiss Syndrome^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,13,0)
 ;;=683^Pancreatitis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,14,0)
 ;;=684^Peritonitis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,15,0)
 ;;=685^Surgical Procedures of the GI Tract^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,16,0)
 ;;=686^Ulcers/Peptic^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,17,0)
 ;;=2775^Esophagitis/Esophageal Reflux/Esophageal Stricture^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,522,1,18,0)
 ;;=2776^Gastroenteritis/Gastritis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,0)
 ;;=GU/Renal^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,0)
 ;;=^124.21PI^11^11
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,1,0)
 ;;=688^Acute/Chronic Renal Failure^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,2,0)
 ;;=689^Adrenalectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,3,0)
 ;;=690^Benign Prostatic Hypertrophy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,4,0)
 ;;=691^Hemodialysis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,5,0)
 ;;=692^Urinary Diversion/Ileal Conduit^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,6,0)
 ;;=693^Nephritis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,7,0)
 ;;=694^Peritoneal Dialysis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,8,0)
 ;;=695^Prostatectomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,9,0)
 ;;=696^Transurethral Procedures^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,10,0)
 ;;=697^Urinary Tract Infection/Kidney Infection^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,523,1,11,0)
 ;;=698^Urolithiasis^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,524,0)
 ;;=HEENT^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,524,1,0)
 ;;=^124.21PI^4^4
 ;;^UTILITY("^GMRD(124.2,",$J,524,1,1,0)
 ;;=727^Cancer of the Larynx:  Radical Neck/Permanent Laryngostomy^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,524,1,2,0)
 ;;=729^Rhinoplasty^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,524,1,3,0)
 ;;=730^Septorhinoplasty^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,524,1,4,0)
 ;;=754^Ocular Disorders/Surgery^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,525,0)
 ;;=Immune (Cancer,AIDS,Transplant,Arthritis)^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,525,1,0)
 ;;=^124.21PI^1^1
 ;;^UTILITY("^GMRD(124.2,",$J,525,1,1,0)
 ;;=736^Immune Deficient Conditions^2^NURSC^1^0
 ;;^UTILITY("^GMRD(124.2,",$J,526,0)
 ;;=Integument^2^NURSC^10^1^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,526,1,0)
 ;;=^124.21PI^3^3
