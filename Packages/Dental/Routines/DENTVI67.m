DENTVI67 ;DSS/AJ - 2015 ADA Code Adding Routine; 1/5/2015
 ;;1.2;DENTAL;**67**;Aug 10, 2001;Build 11
 ;Copyright 1995-2015, Document Storage Systems, Inc., All Rights Reserved
 ;
 Q
EN ;Entry point for ADA Code changes
 D ADD,INACTIVE,REVISE
 Q
INACTIVE ;Inactivate ADA Codes
 F ADA="D6053","D6054","D6078","D6079","D6975" D
 .S DENTIEN=$$FIND1^DIC(228,"","MX",ADA)_","
 .S DENT(228,DENTIEN,.02)=3150101
 .D FILE^DIE("K","DENT","DENTERR")
 .S STNDRD(1)="DELETED 2015."
 .D WP^DIE(228,DENTIEN,4,"K","STNDRD","DENTERR")
 Q
REVISE ;Revise ADA Codes
 ;;D5913^360
 ;;D5914^360
 ;;D5915^420
 ;;D5916^250
 ;;D5926^120
 ;;D5927^90
 ;;D5928^180
 ;;D5931^250
 ;;D5932^360
 ;;D5934^250
 ;;D5936^250
 ;;D5953^250
 ;;D5954^480
 ;;D5955^250
 ;;D5959^120
 ;;D5988^90
 ;;D1310^5
 ;;D1320^10
 ;;D1330^5
 F I=1:1:19 D
 .S TMP=$P($T(REVISE+I),";",3)
 .S DENTIEN=$$FIND1^DIC(228,"","MX",$P(TMP,U))_","
 .S DENT(228,DENTIEN,.18)=$P(TMP,U,2)
 .D FILE^DIE("K","DENT","DENTERR")
 S CSD1310(1)="REVISED 2015 - The Additional Comments section of the DRM Social History screen relating to eating habits must be completed. The code is used when counseling on food selection and dietary habits as a part of treatment and "
 S CSD1310(1)=CSD1310(1)_"control of periodontal disease and caries. Clear documentation of the nutritional topics reviewed and the counseling approach used (i.e. cognitive, behavioral, psychoanalytic, etc.) must accompany use of this code."
 D WP^DIE(228,$$FIND1^DIC(228,"","MX","D1310")_",",4,"K","CSD1310","DENTERR")
 S CSD1320(1)="REVISED 2015 - The Tobacco use section of the DRM Social History screen must be completed. Clear documentation including all elements of the ""ask, advise and refer"" protocol must accompany "
 S CSD1320(1)=CSD1320(1)_"use of this code. Tobacco prevention and cessation services reduce patient risks of developing tobacco-related oral diseases and conditions and improves prognosis for certain dental therapies."
 D WP^DIE(228,$$FIND1^DIC(228,"","MX","D1320")_",",4,"K","CSD1320","DENTERR")
 S CSD1330(1)="REVISED 2015 - The Plaque Index and Oral Hygiene sections of the DRM Oral Health Assessment screen must be completed. Clear documentation of all modalities demonstrated, including patient acceptance, must accompany use of this "
 S CSD1330(1)=CSD1330(1)_"code.  Examples include tooth brushing technique, flossing and use of special oral hygiene aids. May be used to document education or to track performance. This may include instructions for specialized home care."
 D WP^DIE(228,$$FIND1^DIC(228,"","MX","D1330")_",",4,"K","CSD1330","DENTERR")
 K CSD1310,CSD1320,CSD1330
 Q
ADD ;Add ADA Codes
 S TEXTLINE=0
 F  S TEXTLINE=TEXTLINE+1 Q:TEXTLINE>38  D
 .K CPTIEN
 .S Y=$G(Y)+1,DENT=$NA(DENTMP(228,"+1,"))
 .S TMP=$P($T(ADA+TEXTLINE),";",3)
 .S @DENT@(.01)=$P(TMP,U)       ;CPT CODE
 .S CPTIEN=$O(^ICPT("B",$P(TMP,U),0))
 .I $D(^DENT(228,CPTIEN)) S TEXTLINE=TEXTLINE+1 Q
 .S @DENT@(.06)=$P(TMP,U,2)     ;SUBCATEGORY-1
 .S @DENT@(.07)=$P(TMP,U,3)     ;SUBCATEGORY-2
 .S @DENT@(.08)=$P(TMP,U,4)     ;QUAD RELATED
 .S @DENT@(.09)=$P(TMP,U,5)     ;NUM SURFACES
 .S @DENT@(.1)=$P(TMP,U,6)      ;TOOTH RELATED
 .S @DENT@(.11)=$P(TMP,U,7)     ;DEFAULT CANALS
 .S @DENT@(.12)=$P(TMP,U,8)     ;DAS
 .S @DENT@(.13)=$P(TMP,U,9)     ;PRIMARY
 .S @DENT@(.14)=$P(TMP,U,10)    ;ARCH
 .S @DENT@(.15)=$P(TMP,U,11)    ;TYPE
 .S @DENT@(.16)=$P(TMP,U,12)    ;VA-DSS GROUP
 .S @DENT@(.17)=$P(TMP,U,13)    ;FLAGS
 .S @DENT@(.18)=$P(TMP,U,14)    ;RVU
 .S @DENT@(1.01)=$P(TMP,U,15)   ;TOTAL MAPPED DIAGNOSISES
 .S @DENT@(1.11)=$P(TMP,U,16)   ;TP CONDITION
 .S @DENT@(1.12)=$P(TMP,U,17)   ;TP AREA
 .S @DENT@(1.13)=$P(TMP,U,18)   ;TP MATERIAL
 .S @DENT@(1.14)=$P(TMP,U,19)   ;VA COST TO PERFORM
 .S @DENT@(1.15)=$P(TMP,U,20)   ;EQUIVALENT PRIVATE COST
 .S @DENT@(2.01)=$P(TMP,U,21)   ;TEETH
 .S @DENT@(3)=$P(TMP,U,22)      ;ADMIN GUIDELINE
 .S FIELD=""
 .F  S FIELD=$O(@DENT@(FIELD)) Q:FIELD=""  K:@DENT@(FIELD)="" @DENT@(FIELD)
 .S Y=1
 .F ICD9=23:1:42 D:$P(TMP,U,ICD9)'=""
 ..S Y=$G(Y)+1
 ..S DENTMP(228.05,"+"_Y_",+1,",.01)=$P(TMP,U,ICD9)  ;DEFAULT ICD9 DIAGNOSIS CODE
 .D UPDATE^DIE("EK","DENTMP","DENTIEN","DENTERR")
 .S TEXTLINE=TEXTLINE+1
 .S STNDRD(1)=$P($T(ADA+TEXTLINE),";",3,4)
 .D WP^DIE(228,DENTIEN(1)_",",4,"K","STNDRD","DENTERR")
 .K CPTIEN,DENTEMP,DENTIEN,STNDRD,TMP
 Q
ADA ;ADA Codes
 ;;D0171^DIAG^EXAMS^^^^^^^^VACO^DES001^^0^12^cndDiag^areNone^matNone^^^^^521.02^521.03^525.10^523.33^523.42^522.5^522.4^528.3^525.3^525.40^525.50^V60.0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Can be used to code for post op visits, however note that RVUs for the procedure are included in the originating surgical/operative/procedure code.
 ;;D0351^DIAG^MISC^^^^^^^^VACO^DES001^^20^11^cndDiag^areNone^matNone^^^^^521.02^521.03^525.10^523.33^523.42^522.5^522.4^528.3^525.3^525.40^525.50^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Not for 2D photos or CBCT/CADCAM generated images. Should be clinically indicated and part of patient record.
 ;;D1353^PREV^MISC^^^Y^^^^^VACO^DES014^TM^5^3^cndSealant^areOneSurf^matResin^^^^^521.01^521.06^521.04^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Repair of existing sealant, coded per tooth.
 ;;D6110^IMPLANT^MISC^^^^^^^Y^VACO^DES050^AU^180^10^cndMisc^areArch^matUnknown^^^^^525.12^525.40^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported removable complete maxillary denture. Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6111^IMPLANT^MISC^^^^^^^Y^VACO^DES050^AL^180^10^cndMisc^areArch^matUnknown^^^^^525.12^525.40^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported removable complete mandibular denture. Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6112^IMPLANT^MISC^^^^^^^^VACO^DES050^R^180^10^cndImplantStem^areWholeTooth^matUnknown^^^^^525.12^525.13^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported removable partial maxillary denture. Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6113^IMPLANT^MISC^^^^^^^^VACO^DES050^R^180^10^cndImplantStem^areWholeTooth^matUnknown^^^^^525.12^525.13^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported removable partial mandibular denture. Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6114^IMPLANT^MISC^^^^^^^Y^VACO^DES066^RAU^120^10^cndBridgeAbut^areArch^matUnknown^^^^^525.12^525.13^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported fixed complete maxillary denture (hybrid prosthesis). Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6115^IMPLANT^MISC^^^^^^^Y^VACO^DES066^RAL^120^10^cndBridgeAbut^areArch^matUnknown^^^^^525.12^525.13^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported fixed complete mandibular denture (hybrid prosthesis). Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6116^IMPLANT^MISC^^^^^^^^VACO^DES066^R^120^10^cndBridgeAbut^areWholeTooth^matUnknown^^^^^525.12^525.13^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported fixed partial maxillary denture (hybrid prosthesis). Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6117^IMPLANT^MISC^^^^^^^^VACO^DES066^R^120^10^cndBridgeAbut^areWholeTooth^matUnknown^^^^^525.12^525.13^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Implant abutment supported fixed partial mandibular denture (hybrid prosthesis). Includes all related activities such as preparatory case analysis and surgical stent.
 ;;D6549^FIXED^ABUTMENTS^^^Y^^^^^VACO^DES069^TRM^30^11^cndBridgeAbut^areWholeTooth^matResin^^^^^521.02^521.03^521.08^525.60^525.67^521.81^521.04^521.10^521.20^521.30^525.61^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - D6545-D6792 are retainers for FPD. Resin based retainer for resin-bonded bridge.
 ;;D9219^ADJUNCT^MISC^^^^^^^^VACO^DES127^^15^11^cndMisc^areNone^matNone^^^^^521.02^521.03^525.10^523.33^523.42^522.5 ^522.4^528.3^525.3^525.40^525.50^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - For the immediate preop evaluation prior to sedation or general anesthesia; code for full H&P utilizing CPT codes.
 ;;D9931^ADJUNCT^MISC^^^^^^^^VACO^DES098^^10^10^cndClean^areNone^matNone^^^^^525.10^525.40^525.41^525.42^525.43^525.44^525.20^525.24^525.25^525.26^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Cleaning and inspection of removable appliance (i.e. denture prophy). Only code when cleaning is inclusive of ultrasonic and/or hand scaling debridement of appliance. Does not include adjustments.
 ;;D9986^ADJUNCT^MISC^^^^^^^^VACO^DES131^^0^1^cndMisc^areNone^matNone^^^^^V72.2^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Not recommended for use for coding purposes within VA.  Insure all missed appointments are documented as a new progress note or as an addendum to the most recent dental progress note.
 ;;D9987^ADJUNCT^MISC^^^^^^^^VACO^DES131^^0^1^cndMisc^areNone^matNone^^^^^V72.2^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;NEW 2015 - Not recommended for use for coding purposes within VA.  Insure all cancelled appointments are documented as a new progress note or as an addendum to the most recent dental progress note.
 ;;12053^LOCAL CODES^NATIONAL CODES^^^^^^^^local^DES114^^120^4^^^^^^^^873.53^873.54^873.51^873.59^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;Wound 5.1 to 7.5 cm, multiple layers, NOT for incisions.
 ;;15829^LOCAL CODES^NATIONAL CODES^^^^^^^^local^DES115^^60^1^^^^^^^^701.8^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;SMAS flap.
 ;;40820^LOCAL CODES^NATIONAL CODES^^^^^^^^local^DES123^^20^1^^^^^^^^210.4^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;;Destruction of lesion or scar in vestibule of mouth by  laser, thermal, cryo or chemical means.
