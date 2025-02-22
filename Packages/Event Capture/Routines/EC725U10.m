EC725U10 ;ALB/GTS/JAP/JAM - EC National Procedure Update;1/10/01
 ;;2.0; EVENT CAPTURE ;**27**;8 May 96
 ;
 ;this routine is used as a post-init in a KIDS build 
 ;to modify the EC National Procedure file #725
 ;
ADDPROC ;* add national procedures
 ;
 ;  ECXX is in format:
 ;   NAME^NATIONAL NUMBER^CPT CODE^FIRST NATIONAL NUMBER SEQUENCE
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECDINUM,NAME,CODE,CPT,COUNT,X,Y,DIC,DIE,DA,DR,DLAYGO,DINUM
 N ECADD,ECBEG,ECEND,CODX,NAMX,ECSEQ,LIEN,STR,CPTN,STR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Adding new procedures to EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 S ECDINUM=$O(^EC(725,9999),-1),COUNT=$P(^EC(725,0),U,4)
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S NAME=$P(ECXX,U,1),CODE=$P(ECXX,U,2),CPTN=$P(ECXX,U,3),CODX=CODE
 .S CPT=""
 .I CPTN'="" S CPT=$$FIND1^DIC(81,"","X",CPTN) I +CPT<1 D  Q
 ..S STR="   CPT code "_CPTN_" not a valid code in CPT File."
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   ["_CODE_"] "_STR)
 .S ECBEG=$P(ECXX,U,4),ECEND=$P(ECXX,U,5),NAMX=NAME
 .I ECBEG="" S X=NAME D FILPROC Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S NAME=NAMX_ECSEQ,X=NAME,CODE=CODX_ECADD
 ..D FILPROC
 S $P(^EC(725,0),U,4)=COUNT,X=$O(^EC(725,999999),-1),$P(^EC(725,0),U,3)=X
 Q
 ;
FILPROC ;File national procedures
 I '$D(^EC(725,"D",CODE)) D
 .S ECDINUM=ECDINUM+1,DINUM=ECDINUM,DIC(0)="L",DLAYGO=725,DIC="^EC(725,"
 .S DIC("DR")="1////^S X=CODE;4////^S X=CPT"
 .D FILE^DICN
 .I +Y>0 D
 ..S COUNT=COUNT+1
 ..D MES^XPDUTL(" ")
 ..S STR="   Entry #"_+Y_" for "_$P(Y,U,2)
 ..S STR=STR_$S(CPT'="":" [CPT: "_CPT_"]",1:"")_" ("_CODE_")"_" "_NAME
 ..D BMES^XPDUTL(STR_"  ...successfully added.")
 .I Y=-1 D
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("ERROR when attempting to add "_NAME_" ("_CODE_")")
 I $D(^EC(725,"DL",CODE)) D
 .S LIEN=$O(^EC(725,"DL",CODE,""))
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   Your site has a local procedure (entry #"_LIEN_") in File #725")
 .D BMES^XPDUTL("   which uses "_CODE_" as its National Number.")
 .D BMES^XPDUTL("   Please inactivate this local procedure.")
 .K Y
 Q
NEW ;national procedures to add;;descript^nation #^CPT code^beg seq^end seq
 ;;REPAIR/MODIFY SPEECH GENERATING DEVICE^SP443^V5336
 ;;SPEECH GENERATING DEVICE EVAL, LEVEL 1^SP444^G0197
 ;;SPEECH GENERATING DEVICE EVAL, LEVEL 2^SP445^G0197
 ;;SPEECH GENERATING DEVICE EVAL, LEVEL 3^SP446^G0197
 ;;SPEECH GENERATING DEVICE TRAINING, LEVEL 1^SP447^G0198
 ;;SPEECH GENERATING DEVICE TRAINING, LEVEL 2^SP463^G0198
 ;;SPEECH GENERATING DEVICE TRAINING, LEVEL 3^SP464^G0198
 ;;SPEECH GENERATING DEVICE RE-EVAL, LEVEL 1^SP448^G0199
 ;;SPEECH GENERATING DEVICE RE-EVAL, LEVEL 2^SP465^G0199
 ;;SPEECH GENERATING DEVICE RE-EVAL, LEVEL 3^SP466^G0199
 ;;FOLLOW-UP ACOUSTIC DEVICE FITTING/ORIENTATION^SP449^97703
 ;;FOLLOW-UP HEARING AID FITTING/ORIENTATION, MON^SP450^97703
 ;;FOLLOW-UP HEARING AID FITTING/ORIENTATION, BIN^SP451^97703
 ;;L7510 REPAIR/MODIFICATION OF PROSTHETIC DEVICE^SP452^L7510
 ;;ENDOSCOPIC SWALLOWING EVALUATION--FEES^SP453^G0193
 ;;ENDOSCOPIC SWALLOWING EVALUATION--FEEST (ADD-ON)^SP454^G0194
 ;;SWALLOWING EVALUATION WITH RADIOOPAQUE MATERIAL^SP455^G0196
 ;;SPEECH GEN DEVICE, DIGITIZED, <8 MIN^SP456^K0541
 ;;SPEECH GEN DEVICE, DIGITIZED, >8 MIN^SP457^K0542
 ;;SPEECH GEN DEVICE, SYNTH, PHYSICAL ACCESS^SP458^K0543
 ;;SPEECH GEN DEVICE, SYNTH, MULTIPLE ACCESS^SP459^K0544
 ;;SPEECH GENERATING SOFTWARE^SP460^K0545
 ;;ACCESSORY FOR SPEECH GEN DEVICE, MOUNT^SP461^K0546
 ;;ACCESSORY FOR SPEECH GEN DEVICE NOS^SP462^K0547
 ;;CHECKOUT FOR PROSTHETIC USE^SP467^97703
 ;;HOME CARE BY SLP, EACH 15 MIN^SP468^G0153
 ;;QUIT
NAMECHG ;* change national procedure names
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^NEW NAME
 ;
 N ECX,ECXX,ECDA,DA,DR,DIC,DIE,X,Y,STR
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
 ..S STR="Can't find entry for "_$P(ECXX,U,1)
 ..D BMES^XPDUTL(STR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes
 ;;PM103^15MIN HIST/ASSESSMT
 ;;PM503^ADD'L PT SUPPRT/GRPEVTS/SPCPGMS
 ;;SP004^ACOUSTIC DEVICE EVAL/SELECTION, LEVEL 1
 ;;SP027^VESTIBULAR REHAB TREATMENT
 ;;SP038^INITIAL ACOUSTIC DEVICE FITTING/ORIENTATION
 ;;SP105^HEARING AID CHECK, MON, LEVEL 1
 ;;SP106^HEARING AID CHECK, BIN, LEVEL 1
 ;;SP112^VOICE PROSTHESIS EVAL, LEVEL 1
 ;;SP114^MODIFY/TRAIN VOICE PROSTHESIS, LEVEL 1
 ;;SP117^DIAGNOSTIC VIDEO-OTOSCOPY
 ;;SP196^99371 TELEPHONE CALL, BRIEF
 ;;SP197^99372 TELEPHONE CALL, INTERMEDIATE
 ;;SP198^99373 TELEPHONE CALL, COMPLEX
 ;;SP206^99456 DISABILITY EXAMINATION
 ;;SP230^CLINICAL SWALLOWING EVALUATION, LEVEL 1
 ;;SP268^ACOUSTIC DEVICE EVAL/SELECTION, LEVEL 2
 ;;SP269^ACOUSTIC DEVICE EVAL/SELECTION, LEVEL 3
 ;;SP323^HEARING AID CHECK, MON, LEVEL 2
 ;;SP324^HEARING AID CHECK, MON, LEVEL 3
 ;;SP325^HEARING AID CHECK, BIN, LEVEL 2
 ;;SP326^HEARING AID CHECK, BIN, LEVEL 3
 ;;SP327^VOICE PROSTHESIS EVALUATION, LEVEL 2
 ;;SP328^VOICE PROSTHESIS EVALUATION, LEVEL 3
 ;;SP329^MODIFY/TRAIN VOICE PROSTHESIS, LEVEL 2
 ;;SP330^MODIFY/TRAIN VOICE PROSTHESIS, LEVEL 3
 ;;FE001^FEE BEDDAY COST < 100
 ;;FE002^FEE BEDDAY COST 101 TO 200
 ;;FE003^FEE BEDDAY COST 201 TO 300
 ;;FE004^FEE BEDDAY COST 301 TO 400
 ;;FE005^FEE BEDDAY COST 401 TO 500
 ;;FE006^FEE BEDDAY COST 501 TO 600
 ;;FE007^FEE BEDDAY COST 601 TO 700
 ;;FE008^FEE BEDDAY COST 701 TO 800
 ;;FE009^FEE BEDDAY COST 801 TO 900
 ;;FE010^FEE BEDDAY COST 901 TO 1000
 ;;FE011^FEE BEDDAY COST 1001 TO 1100
 ;;FE012^FEE BEDDAY COST 1101 TO 1200
 ;;FE013^FEE BEDDAY COST 1201 TO 1300
 ;;FE014^FEE BEDDAY COST 1301 TO 1400
 ;;FE015^FEE BEDDAY COST 1401 TO 1500
 ;;FE016^FEE BEDDAY COST > 1500
 ;;FE101^FEE PHARM COST < .01
 ;;FE102^FEE PHARM COST .01 TO .02
 ;;FE103^FEE PHARM COST .021 TO .10
 ;;FE104^FEE PHARM COST .11 TO 1.00
 ;;FE105^FEE PHARM COST 1.00 TO 2.00
 ;;FE106^FEE PHARM COST 2.01 TO 5.00
 ;;FE107^FEE PHARM COST 5.01 TO 10.00
 ;;FE108^FEE PHARM COST 10.01 TO 25.00
 ;;FE109^FEE PHARM COST 25.01 TO 50.00
 ;;FE110^FEE PHARM COST > 50.00
 ;;FE201^FEE OUTPAT COST < 50.00
 ;;FE202^FEE OUTPAT COST 50 TO 99
 ;;FE203^FEE OUTPAT COST 100 TO 149
 ;;FE204^FEE OUTPAT COST 150 TO 199
 ;;FE205^FEE OUTPAT COST 200 TO 249
 ;;FE206^FEE OUTPAT COST 250 TO 299
 ;;FE207^FEE OUTPAT COST 300 TO 349
 ;;FE208^FEE OUTPAT COST 350 TO 399
 ;;FE209^FEE OUTPAT COST 400 TO 449
 ;;FE210^FEE OUTPAT COST 450 TO 499
 ;;FE211^FEE OUTPAT COST 500 TO 549
 ;;FE212^FEE OUTPAT COST 550 TO 599
 ;;FE213^FEE OUTPAT COST 600 TO 699
 ;;FE214^FEE OUTPAT COST 700 TO 799
 ;;FE215^FEE OUTPAT COST 800 TO 899
 ;;FE216^FEE OUTPAT COST 900 TO 999
 ;;FE217^FEE OUTPAT COST 1000 TO 1499
 ;;FE218^FEE OUTPAT COST 1500 TO 2999
 ;;FE219^FEE OUTPAT COST 3000 TO 5000
 ;;FE220^FEE OUTPAT COST > 5000
 ;;QUIT
