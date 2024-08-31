PSO746PI ;BHAM/MFR - PSO*7*746 POST INSTALL; 10/01/2022 11:24Am
 ;;7.0;OUTPATIENT PHARMACY;**746**;DEC 1997;Build 106
 ;
 ;Reference to $$CRDD^TIUCRDD in ICR #7179
 ;
EN ; Entry Point
 N HOPIEN,RRPIEN,DONE,IEN,CHHOPIEN,XCODE,DIC,X
 D BMES^XPDUTL("Starting post-install for PSO*7*746 at "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 ; New Hold codes
 I '$D(^PS(52.45,"B","HFF")) D
 . S X="HFF",DIC="^PS(52.45,",DIC(0)="",DIC("DR")=".02///HOLD FOR FUTURE FILL;.03///ERX"
 . D FILE^DICN
 ;
 ; Adding template Change Reason Texts to file #52.45
 S CODE="" F  S CODE=$O(^PS(52.45,"TYPE","REA",CODE)) Q:'CODE  D
 . K TEXT,REATXT S XCODE=$$GET1^DIQ(52.45,CODE,.01)
 . I ",DA,DD,HD,LD,MS,TD,AR,DI,DR,ID,UD,PS,SX,TP,"'[(","_XCODE_",") Q
 . K ^PS(52.45,CODE,20)
 . I XCODE="DA" D
 . . S TEXT(1,0)="Pt has a listed allergy to medication/component of medication prescribed"
 . . S TEXT(2,0)="[DRUG_NAME]. Please advise: To fill as is, send denial to this request with"
 . . S TEXT(3,0)="note stating reason fill is acceptable. If med should not be filled, Cancel Rx"
 . . S TEXT(4,0)="and send replacement."
 . I XCODE="DD" D
 . . S TEXT(1,0)="eRx drug interacts with [DRUG_NAME]. Please advise: To fill this medication,"
 . . S TEXT(2,0)="send denial with note stating pt requires both medications or note that"
 . . S TEXT(3,0)="[DRUG_NAME] should be canceled. If med should not be filled, Cancel RX and send"
 . . S TEXT(4,0)="replacement."
 . I XCODE="HD" D
 . . S TEXT(1,0)="The prescribed dosage exceeds typical maximum. Please advise: To fill as is,"
 . . S TEXT(2,0)="send denial to this request with note stating reason fill is acceptable. To"
 . . S TEXT(3,0)="fill within manufacturer guidelines, approve recommendation below."
 . I XCODE="LD" D
 . . S TEXT(1,0)="The prescribed dosage is below typical minimum. Please advise: To fill as is,"
 . . S TEXT(2,0)="send denial to this request with note stating reason fill is acceptable. To fill"
 . . S TEXT(3,0)="within manufacturer guidelines, approve recommendation below."
 . I XCODE="MS" D
 . . S TEXT(1,0)="The eRx is missing or unclear on [ADD_TEXT_HERE], Please edit and respond or"
 . . S TEXT(2,0)="cancel Rx and send a new prescription with the requested information."
 . I XCODE="TD" D
 . . S TEXT(1,0)="Pt has medication of the same class/indication/drug on file. To fill this Rx,"
 . . S TEXT(2,0)="send denial with note stating pt requires both medications or note that"
 . . S TEXT(3,0)="[DRUG_NAME] should be canceled. If this med should not be filled, Cancel RX and"
 . . S TEXT(4,0)="send a replacement."
 . I XCODE="AR" D
 . . S TEXT(1,0)="Patient has an adverse drug reaction to medication/component of medication"
 . . S TEXT(2,0)="prescribed. To fill as is, send denial to this request with note stating reason"
 . . S TEXT(3,0)="fill is acceptable. If med should not be filled- Cancel RX and send a"
 . . S TEXT(4,0)="replacement."
 . I XCODE="DI" D
 . . S TEXT(1,0)="eRx drug is incompatible with [DRUG_NAME]. To fill this Rx, send denial with"
 . . S TEXT(2,0)="note stating pt requires both medications or note that [DRUG_NAME] should be"
 . . S TEXT(3,0)="canceled. If med should not be filled, Cancel RX and send a replacement."
 . I XCODE="DR" D
 . . S TEXT(1,0)="The prescribed dosage does not align with manufacturer recommendations. Please"
 . . S TEXT(2,0)="advise: To fill as is, send denial to this request with note stating reason fill"
 . . S TEXT(3,0)="is acceptable. To fill within manufacturer guidelines, approve recommendation"
 . . S TEXT(4,0)="below."
 . I XCODE="ID" D
 . . S TEXT(1,0)="Pt has medication containing the same ingredient on file. To fill this Rx, send"
 . . S TEXT(2,0)="denial with note stating pt requires both medications or note that [DRUG_NAME]"
 . . S TEXT(3,0)="should be canceled. If med should not be filled-Cancel RX and send a"
 . . S TEXT(4,0)="replacement."
 . I XCODE="UD" D
 . . S TEXT(1,0)="Pt has multiple prescriptions for the same drug and strength on file. To fulfill"
 . . S TEXT(2,0)="both Rx, send one Rx containing total qty/directions etc. To fill only this Rx,"
 . . S TEXT(3,0)="send denial with note stating other should be canceled. If med should not be"
 . . S TEXT(4,0)="filled, Cancel Rx."
 . I XCODE="PS" D
 . . S TEXT(1,0)="Pharmacy is unable to supply medication as prescribed; however, alternative"
 . . S TEXT(2,0)="options may exist. Please approve an option below or Cancel Rx and send a"
 . . S TEXT(3,0)="replacement."
 . I XCODE="SX" D
 . . S TEXT(1,0)="The prescribed medication does not align with manufacturer recommendations based"
 . . S TEXT(2,0)="on patient sex assigned at birth. The pharmacy is unable to fill the medication"
 . . S TEXT(3,0)="as prescribed. Pt may obtain locally at usual cash price."
 . I XCODE="TP" D
 . . S TEXT(1,0)="Prior to processing this medication/class the pharmacy is required to obtain a"
 . . S TEXT(2,0)="diagnosis code. Please edit and respond or Cancel Rx and send a new prescription"
 . . S TEXT(3,0)="with the requested information."
 . S REATXT(52.45,CODE_",",20)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Script Clarification",0))
 I CODE D
 . K ^PS(52.45,CODE,20)
 . K TEXT,REATXT
 . S TEXT(1,0)="The eRx is missing or unclear on [ADD_TEXT_HERE], Please edit and respond or"
 . S TEXT(2,0)="cancel Rx and send a new prescription with the requested information."
 . S REATXT(52.45,CODE_",",20)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ; 
 S CODE=$O(^PS(52.45,"D","Therapeutic Interchange/Substi",0))
 I CODE D
 . K ^PS(52.45,CODE,20)
 . K TEXT,REATXT
 . S TEXT(1,0)="Pharmacy is unable to supply medication as prescribed; however, alternative"
 . S TEXT(2,0)="options may exist. Please approve an option below or Cancel Rx and send a"
 . S TEXT(3,0)="replacement."
 . S REATXT(52.45,CODE_",",20)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Generic Substitution",0))
 I CODE D
 . K ^PS(52.45,CODE,20)
 . K TEXT,REATXT
 . S TEXT(1,0)="Rx received was marked Dispense as Written however Brand Name product is not"
 . S TEXT(2,0)="available to be dispensed. Please approve generic substitution option below or"
 . S TEXT(3,0)="send replacement Rx."
 . S REATXT(52.45,CODE_",",20)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 S CODE=$O(^PS(52.45,"D","Prescribed with acknowledgemen",0))
 I CODE D
 . N DIE S DIE="^PS(52.45,",DA=CODE,DR=".02///Prescribed w/ acknowledgements" D ^DIE
 ;
 S CODE=$O(^PS(52.45,"D","Out of Stock",0))
 I CODE D
 . K ^PS(52.45,CODE,20)
 . K TEXT,REATXT
 . S TEXT(1,0)="The medication prescribed is currently out of stock, if a substitutable product"
 . S TEXT(2,0)="exists and is presented as an option below, it may be approved. Otherwise, pt"
 . S TEXT(3,0)="may need to obtain locally or have replacement product prescribed."
 . S REATXT(52.45,CODE_",",20)="TEXT"
 . K DIERR D UPDATE^DIE("","REATXT")
 ;
 D CREATEPN("PHARMACY SERVICE","PHARMACY PROGRESS NOTE","ERX RX CHANGE REQUEST NOTE") ;create new eRx Progress Notes Title in File #8925.1
 ;
 ; Killing and Re-Building "ADRGVRX" x-reference
 I $$GET1^DIQ(59.7,1,102,"I")'="MBM" D
 . D BMES^XPDUTL("Re-building Drug Suggestion x-reference... "_$$FMTE^XLFDT($$NOW^XLFDT()))
 . K ^PS(52.49,"ADRGVRX") S DIK="^PS(52.49,",DIK(1)=".13^ADRGVRX" D ENALL^DIK
 ;
 ; Updating Protocol Headers to display eRx Meds on File in Backdoor Pharmacy
 N ORDIEN
 S ORDIEN=$O(^ORD(101,"B","PSO LM PAT INFO MENU",0))
 I ORDIEN S ^ORD(101,ORDIEN,26)="D SHOW^VALM,NVAERX^PSOORUT2"
 S ORDIEN=$O(^ORD(101,"B","PSO LM MEDICATION PROFILE",0))
 I ORDIEN S ^ORD(101,ORDIEN,26)="D A^PSOORUT3,SHOW^VALM S XQORM(""#"")=$O(^ORD(101,""B"",""PSO LM NEW SELECT ORDER"",0))_""^1:""_$S($G(PSORCNT):PSORCNT,1:PSOCNT) D NVAERX^PSOORUT2"
 ;
 D BMES^XPDUTL("Post-install for PSO*7*746 completed successfully at "_$$FMTE^XLFDT($$NOW^XLFDT()))
 Q
 ;
CREATEPN(PARNTDOC,STDTITLE,TITLE) ;
 ;Input: PARNTDOC - Name of the desired parent in File #8925.1
 ;       STDTITLE - Name of the VHA Enterprise Standard Title in File #8926.1
 ;       TITLE    - Name of the desired title in File #8925.1
 ;Output: Create a new entry TIU NOTE Title in File #8925.1
 ;
 N FOUNDDOC,FOUNDSTD,MES,RESULT
 ;check parent document class PHARMACY SERVICE
 S FOUNDDOC=$$FIND1^DIC(8925.1,"","X",PARNTDOC,"B")
 ;
 ; check VHA Enterprise Standard Title PHARMACY PROGRESS NOTE
 S FOUNDSTD=$$FIND1^DIC(8926.1,"","X",STDTITLE,"B")
 ;
 S MES(1)=""
 ;if PHARMACY SERVICE and PHARMACY PROGRESS NOTE exist, attach and map the new ERX RX CHANGE REQUEST NOTE TIU Note Title
 I +FOUNDDOC,+FOUNDSTD D  Q
 . S RESULT=$$CRDD^TIUCRDD(TITLE,"DOC","ACTIVE",PARNTDOC,STDTITLE)
 . I '+RESULT D  Q
 . . S MES(2)=$S(RESULT["already exists":$P(RESULT,U,2)_" No action taken.",1:"Installation Error: "_$P(RESULT,U,2))
 . . S MES(3)=""
 . . D MES^XPDUTL(.MES)
 . S MES(2)="Successfully created "_TITLE_" in File #8925.1."
 . S MES(3)=""
 . D MES^XPDUTL(.MES)
 ;
 ;Otherwise, do not attach and map the new ERX RX REQUEST NOTE TIU Note Title
 S MES(2)="Installation Error:"
 S MES(3)="    The creation of the ERX RX CHANGE REQUEST NOTE TIU Title failed."
 ;
 I '+FOUNDDOC,'+FOUNDSTD D  ;both parent doc class and std title does not exist at the site
 . S MES(4)="       * "_PARNTDOC_" Document Class not found."
 . S MES(5)="       * VHA Enterprise Standard Title "_STDTITLE_" not found."
 . S MES(6)=""
 ;
 I '+FOUNDDOC,+FOUNDSTD D  ;std title exist but parent doc class does not exist at the site
 . S MES(4)="       * "_PARNTDOC_" Document Class not found."
 . S MES(5)=""
 ;
 I +FOUNDDOC,'+FOUNDSTD D  ;parent doc exist but std title does not exist at the site
 . S MES(4)="       * VHA Enterprise Standard Title "_STDTITLE_" not found."
 . S MES(5)=""
 ;
 D MES^XPDUTL(.MES)
 Q
