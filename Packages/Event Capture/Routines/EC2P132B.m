EC2P132B ;ALB/DE - EC National Procedure Update ; 4/8/16 11:00am
 ;;2.0;EVENT CAPTURE;**132**;8 May 96;Build 3
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file (#725)
 ;
 Q
 ;
ADDPROC ;* add national procedures
 ;
 ;  ECXX is in format:
 ;   NAME^NATIONAL NUMBER^CPT CODE^FIRST NATIONAL NUMBER SEQUENCE
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECDINUM,ECNAME,ECCODE,ECCPT,ECCOUNT,X,Y,DIC,DIE,DA,DR,DLAYGO,DINUM
 N ECADD,ECBEG,ECEND,ECCODX,ECNAMX,ECSEQ,ECLIEN,ECSTR,ECCPTN
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Adding new procedures to EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 S ECDINUM=$O(^EC(725,9999),-1),ECCOUNT=$P(^EC(725,0),U,4)
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECNAME=$P(ECXX,U,1),ECCODE=$P(ECXX,U,2),ECCPTN=$P(ECXX,U,3),ECCODX=ECCODE
 .S ECCPT=""
 .I ECCPTN'="" S ECCPT=$$FIND1^DIC(81,"","X",ECCPTN) I +ECCPT<1 D  Q
 ..S ECSTR="   CPT code "_ECCPTN_" not a valid code in CPT File."
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   ["_ECCODE_"] "_ECSTR)
 .S ECBEG=$P(ECXX,U,4),ECEND=$P(ECXX,U,5),ECNAMX=ECNAME
 .I ECBEG="" S X=ECNAME D FILPROC Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..;S ECNAME=ECNAMX_ECADD,X=ECNAME,ECCODE=ECCODX_ECADD
 ..I $E(ECCODX,1,3)'="RCM" S ECNAME=ECNAMX_ECSEQ,X=ECNAME,ECCODE=ECCODX_ECADD
 ..E  S ECNAME=ECNAMX_$E(ECADD,2,99),X=ECNAME,ECCODE=ECCODX_$E(ECADD,2,99)
 ..D FILPROC
 S $P(^EC(725,0),U,4)=ECCOUNT,X=$O(^EC(725,999999),-1),$P(^EC(725,0),U,3)=X
 Q
 ;
FILPROC ;File national procedures
 I '$D(^EC(725,"D",ECCODE)) D
 .S ECDINUM=ECDINUM+1,DINUM=ECDINUM,DIC(0)="L",DLAYGO=725,DIC="^EC(725,"
 .S DIC("DR")="1////^S X=ECCODE;4///^S X=ECCPT"
 .D FILE^DICN
 .I +Y>0 D
 ..S ECCOUNT=ECCOUNT+1
 ..D MES^XPDUTL(" ")
 ..S ECSTR="   Entry #"_+Y_" for "_$P(Y,U,2)
 ..S ECSTR=ECSTR_$S(ECCPT'="":" [CPT: "_ECCPT_"]",1:"")_" ("_ECCODE_")"
 ..D BMES^XPDUTL(ECSTR)
 ..D BMES^XPDUTL("      ...successfully added.")
 .I Y=-1 D
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("ERROR when attempting to add "_ECNAME_" ("_ECCODE_")")
 I $D(^EC(725,"DL",ECCODE)) D
 .S ECLIEN=$O(^EC(725,"DL",ECCODE,""))
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   Your site has a local procedure (entry #"_ECLIEN_") in File #725")
 .D BMES^XPDUTL("   which uses "_ECCODE_" as its National Number.")
 .D BMES^XPDUTL("   Please inactivate this local procedure.")
 .K Y
 Q
NEW ;national procedures to add;;descript^nation #^CPT code^beg seq^end seq
 ;;CAT F/U PROSTH DEV^BR059^97762
 ;;LS AT ASSESS^BR060^97755
 ;;LS F/U PROSTH DEV^BR061^97762
 ;;MS AT ASSESS^BR062^97755
 ;;MS F/U PROSTH DEV^BR063^97762
 ;;OM AT ASSESS^BR064^97755
 ;;OMF/U PROSTH DEV^BR065^97762
 ;;LV AT ASSESS^BR066^97755
 ;;LV F/U PROSTH DEV^BR067^97762
 ;;YOGA / GRP 30M^CI001^
 ;;YOGA / IND 30M^CI002^
 ;;YOGA / GRP REMOT 30M^CI003^
 ;;YOGA / IND REMOT 30M^CI004^
 ;;TAI CHI / GRP 30M^CI005^
 ;;TAI CHI / IND 30M^CI006^
 ;;QI GONG / GRP 30M^CI007^
 ;;QI GONG / IND 30M^CI008^
 ;;REIKI / GRP 30M^CI009^
 ;;REIKI / IND 15M^CI010^
 ;;HEAL TCH / GRP 30M^CI011^
 ;;HEAL TCH / IND 15M^CI013^
 ;;WHL HLTH CO IP / GRP 30M^CI014^
 ;;WHL HLTH CO IP / IND 30M^CI015^
 ;;WHL HLTH CO TEL / IND 15M^CI016^
 ;;WHL HLTH PR FAC / GRP 30M^CI017^
 ;;WHL HLTH PR FAC / IND 30M^CI018^
 ;;OTR RXN TQ / GRP 30M^CI019^
 ;;OTR RXN TQ / IND 30M^CI020^
 ;;BIOFDBK / GRP 30M^CI021^
 ;;BIOFDBK / IND 30M^CI022^
 ;;MDFLNS / GRP 30M^CI023^
 ;;MDFLNS / IND 30M^CI024^
 ;;MDTN / GRP 30M^CI025^
 ;;MDTN / IND 30M^CI026^
 ;;WELL BNG MSG / IND 30M^CI027^
 ;;WHL HLTH ED / GRP 30M^CI028^
 ;;WHL HLTH ED / IND 30M^CI029^
 ;;OTHR MVMT TRPY/GRP 30M^CI030^
 ;;OTHR MVMT TRPY/IND 30M^CI031^
 ;;BIOFLD OTHR / GRP 30M^CI032^
 ;;BIOFLD OTHR / IND 30M^CI033^
 ;;CRT WHC IP / GRP 30M^CI034^
 ;;CRT WHC IP / IND 30M^CI035^
 ;;CRT WHC TEL / IND 15M^CI036^
 ;;ACUPT / GRP 30M^CI037^
 ;;ACUPT / IND 30M^CI038^
 ;;BFA / GRP 30^CI039^
 ;;BFA / IND 30^CI040^
 ;;EDMR / IND 30M^CI041^
 ;;EDMR / GRP 30M^CI042^
 ;;EXP ART THRPY / GRP 30M^CI043^
 ;;EXP ART THRPY / IND 30M^CI044^
 ;;NAT AM HLG / GRP 30M^CI045^
 ;;NAT AM HLG / IND 30M^CI046^
 ;;IH CONSULT / GRP 30M^CI047^
 ;;IH CONSULT / IND 30M^CI048^
 ;;TRMT MSG / IND <30M^CI049^
 ;;AML AST THRPY / GRP 30M^CI050^
 ;;AML AST THRPY / IND 30M^CI051^
 ;;EQN THRPY / GRP 30M^CI052^
 ;;EQN THRPY / IND 30M^CI053^
 ;;CLIN HYP / GRP 30M^CI054^
 ;;CLIN HYP / IND 30M^CI055^
 ;;MDFLNS / GRP 120M^CI056^
 ;;WAX REMOV UNI INSTR^SP571^69209
 ;;QUIT
NAMECHG ;* change national procedure names
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^NEW NAME
 ;
 N ECX,ECXX,ECDA,DA,DR,DIC,DIE,X,Y,ECSTR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing names in EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CHNG+ECX),";;",2) Q:ECXX="QUIT"  D
 .I $D(^EC(725,"D",$P(ECXX,U,1))) D
 ..S ECDA=+$O(^EC(725,"D",$P(ECXX,U,1),0))
 ..I $D(^EC(725,ECDA,0)) D
 ...S DA=ECDA,DR=".01////^S X=$P(ECXX,U,2)",DIE="^EC(725," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("   Entry #"_ECDA_" for "_$P(ECXX,U,1))
 ...D BMES^XPDUTL("      ... field (#.01) updated to  "_$P(ECXX,U,2)_".")
 .I '$D(^EC(725,"D",$P(ECXX,U,1))) D
 ..D MES^XPDUTL(" ")
 ..S ECSTR="Can't find entry for "_$P(ECXX,U,1)
 ..D BMES^XPDUTL(ECSTR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes -national code #^new procedure name
 ;;NU194^MOVE QUESTION W/PT 1ST15M
 ;;RC092^CASE MGMT IND
 ;;RC093^CASE MGMT GRP 2-4
 ;;RC094^CASE MGMT GRP 5-8
 ;;SD010^BASIC RATE, STATE DOM
 ;;SD011^SVC-CONNECT(SC) STATE DOM
 ;;SH010^BASIC RATE, STATE ADHC
 ;;SH011^SVC-CONNECT(SC) ST ADHC
 ;;SN010^BASIC RATE, STATE HOME
 ;;SN011^SVC-CONNECT(SC) STATE HME
 ;;SP147^E&M, OUTPATIENT EST
 ;;SP196^TELEPHONE SERVICE, 5-10 MIN
 ;;SP197^TELEPHONE SERVICE,11-20 MIN
 ;;SP198^TELEPHONE SERVICE, 21-30 MIN
 ;;SP206^DISABILITY EXAMINATION
 ;;SP364^FITTING/ORIENTATION/CHECKING OF HEARING AID
 ;;SP365^REPAIR/MODIFICATION OF HEARING AID
 ;;SP366^CONFORMITY EVAL, REAL-EAR MEASUREMENT
 ;;SP367^HEARING AID, MON, BODY WORN, AIR CONDUCTION
 ;;SP368^HEARING AID, MON, BODY WORN, BONE CONDUCTION
 ;;SP369^HEARING AID, MONAURAL, ITE
 ;;SP370^HEARING AID, MONAURAL, BTE
 ;;SP371^HEARING AID, EYEGLASS, AIR CONDUCTION
 ;;SP372^HEARING AID, EYEGLASS, BONE CONDUCTION
 ;;SP373^DISPENSING FEE, UNSPECIFIED HEARING AID
 ;;SP374^HEARING AID, BILATERAL, BODY WORN
 ;;SP375^DISPENSING FEE, BILATERAL HEARING AID
 ;;SP376^HEARING AID, BINAURAL, BODY HEARING AID
 ;;SP377^HEARING AID, BINAURAL, ITE
 ;;SP378^HEARING AID, BINAURAL, BTE
 ;;SP379^HEARING AID, BINAURAL, EYEGLASS
 ;;SP380^DISPENSING FEE, BINAURAL HEARING AID
 ;;SP381^HEARING AID, CROS, ITE
 ;;SP382^HEARING AID, CROS, BTE
 ;;SP383^HEARING AID, CROS, GLASSES
 ;;SP384^DISPENSING FEE, CROS
 ;;SP385^HEARING AID, BICROS, ITE
 ;;SP386^HEARING AID, BICROS, BTE
 ;;SP387^HEARING AID, BICROS, GLASSES
 ;;SP388^DISPENSING FEE, BICROS
 ;;SP389^HEARING AID, MISCELLANEOUS SERVICE
 ;;SP391^OUTCOME VERIFICATION, QUESTIONNAIRE
 ;;SP392^ADJUST, DIGITAL PROGRAM, OR RE-PROGRAM
 ;;SP422^COCHLEAR IMPLANT DEVICE/SYSTEM
 ;;SP423^COCHLEAR IMPLANT EXT SPEECH PROCESSOR, REPL
 ;;SP428^ARTIFICIAL LARYNX, ANY TYPE
 ;;SP429^TRACHEOSTOMY SPEAKING VALVE
 ;;SP430^CI TRANSMIT CABLE RPL
 ;;SP431^TRACHEOSTOMA FILTER
 ;;SP434^TRACH INNER CANNULA
 ;;SP435^TRACHEOSTOMY CARE KIT FOR NEW TRACHEOSTOMY
 ;;SP436^TRACHEOSTOMY CARE KIT FOR EST TRACHEOSTOMY
 ;;SP452^REPAIR/MODIFICATION OF PROSTHETIC DEVICE
 ;;SP473^COMMUNICATION BOARD
 ;;SP503^ALCOHOL WIPES
 ;;SP504^SKIN PROTECTIVE BARRIER
 ;;SP505^ADHESIVE REMOVER WIPES
 ;;SP506^SKIN BARRIER WIPE/SWAB
 ;;SP507^TRACH VALVE W DIAPHRAGM
 ;;SP508^DIAPHRAGM VALVE REPL
 ;;SP509^HMES FILTER HOLDER OR CAP
 ;;SP510^HMES FILTER
 ;;SP511^HMES VALVE HOUSING
 ;;SP512^HMES ADHESIVE DISC
 ;;SP513^HMES HOLDER WITH FILTER
 ;;SP514^HMES HOUSING WITH ADHESIVE
 ;;SP515^HMES SYSTEM
 ;;SP516^LARYNGECTOMY TUBE NON-CUFF
 ;;SP517^LARYNGECTOMY TUBE CUFFED
 ;;SP518^TRACH SHOWER PROTECT
 ;;SP519^TRACH STENT/STUD/BUTTON
 ;;SP520^TRACH TUBE PLUG/STOP
 ;;SP521^ALERTING DEVICE, NOC
 ;;SP522^UNLISTED MISC PROSTH SERVICE
 ;;SP523^TRACH INSERT, INDWELL REPL
 ;;SP524^GEL CAP TRACH VOICE PROSTH
 ;;SP525^TRACH PROSTH CLEANING DEV
 ;;SP526^REPL TEPDIALATOR
 ;;SP527^GEL CAP APPLICATION
 ;;SP528^COCHLEAR IMPLANT HEADSET
 ;;SP529^COCHLEAR MICROPHONE REPL
 ;;SP530^COCHLEAR IMPLANT COIL REPL
 ;;SP531^LITHIUM ION BAT,CIDEVBDY
 ;;SP532^CI BATTERY ZINC AIR
 ;;SP533^CI BATTERY ALKALINE
 ;;SP534^COMP GERIATRIC ASSESSMENT
 ;;SP535^COUNSELING ADV DIRECTIVES
 ;;SP536^DISEASE MGMT PROG INITIAL
 ;;SP537^DISEASE MGMT FOLLOWUP
 ;;SP538^DISEASE MGMT PER DIEM
 ;;SP539^AUDIOMETRY FOR HEARING AID
 ;;SP544^PROSTHETIC IMPLANT, NOS
 ;;SP549^LITHIUM BAT,CIDEV,EARLVL
 ;;SP550^SEMI-IMPLNT MIDEAR HRDV
 ;;SP553^ONLINE SERVICE
 ;;SP001^WAX REMOV UNI INSTR
 ;;SP064^CAL W/REC,BIL;BITHER
 ;;SP231^CAL W/REC,BIL;MONOTH
 ;;QUIT
