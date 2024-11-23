ORY535 ;ISL/TDP - Pre- and Post-install for patch OR*3*535 ;Sep 11, 2024@14:16:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**535**;Dec 17, 1997;Build 20
 ;
PRE ; Initiate pre-init processes
 D RENAME("^OCXS(860.3,","GLUCOPHAGE ORDER","METFORMIN ORDER")
 D CLRINDX
 Q
 ;
CLRINDX ;Delete the "B" index of file 100.04
 N DIK
 D BMES^XPDUTL("Clearing 'B' indexes for file 100.04")
 S DIK="^ORD(100.04,",DIK(1)=".01"
 D ENALL2^DIK
 D MES^XPDUTL("   Completed!")
 Q
 ;
POST ; Initiate post-init processes
 D ACTIV("GLUCOPHAGE - LAB RESULTS",1,0)
 D ACTIV("METFORMIN EGFR - LAB RESULTS",0,1) ;Activate if it exists already and is inactive status
 D S^ORY535ES
 D BMES^XPDUTL("   ---Completed---")
 D PARAMSET
 D REMOVE
 D REINDEX
 D NATIONAL
 Q
 ;
ACTIV(ORCHKRL,ORACTIV,PST) ; Inactivate Order Check Rule
 ; ORCHKRL = Name of Order Check Rule in file 860.2
 ; ORACTIV = Status of Order Check Rule. 0 = Active, 1 = Inactive, No value defaults to Active
 ; PST = Indicates METFORMIN EGFR - LAB RESULTS from Post-init code (1 = yes, 0 = no)
 N ORACT,ORACT1,ORCHKRLIEN
 Q:$G(ORCHKRL)=""
 S ORACTIV=+$G(ORACTIV) D
 . I ORACTIV=1 S ORACT="Inactivating ",ORACT1="inactivated."
 . E  S ORACT="Activating ",ORACT1="activated."
 S ORCHKRLIEN=$O(^OCXS(860.2,"B",ORCHKRL,0))
 I 'ORCHKRLIEN D  Q
 . I PST Q  ;METFORMIN EGFR - LAB RESULTS won't exist yet on initial install
 . D BMES^XPDUTL("   "_ORCHKRL_" does not exist in the ORDER CHECK")
 . D MES^XPDUTL("   RULE (#860.2) file.")
 . Q
 I +$G(^OCXS(860.2,ORCHKRLIEN,"INACT"))=ORACTIV D  Q
 . D BMES^XPDUTL("   "_ORCHKRL_" is already "_ORACT1_" ABORTING action!")
 . Q
 D BMES^XPDUTL(ORACT_ORCHKRL_" in the ORDER CHECK")
 D MES^XPDUTL("RULE (#860.2) file.")
 S ^OCXS(860.2,ORCHKRLIEN,"INACT")=ORACTIV
 D BMES^XPDUTL("   "_ORCHKRL_" has been "_ORACT1)
 Q
 ;
RENAME(FILE,OROLD,ORNEW) ; Rename file entry
 N CNT,DA,DIC,DIE,DO,DR,FILENM,TEXT,X,Y
 Q:$G(FILE)=""
 Q:$G(OROLD)=""
 Q:$G(ORNEW)=""
 S (DIC,DIE)=FILE
 S DIC(0)="X"
 S X=OROLD
 D ^DIC Q:Y<1
 S DA=+Y
 I 'DA Q
 S DIE="^OCXS(860.3,",DR=".01///"_ORNEW
 D ^DIE
 S FILENM=FILE
 S DO=""
 D DO^DIC1
 I DO(2)'=-1 D
 . S FILENM=$P(DO,U,1)_" (#"_$P(DO,U,2)_")"
 S CNT=1
 S TEXT(CNT)="Renamed "_FILENM_" file entry "_OROLD_" to "_ORNEW_"."
 I $L(TEXT(CNT))>66 D
 . N DONE
 . S DONE=0
 . S X=$L(TEXT(CNT))
 . F Y=66:-1:1 D  Q:DONE
 .. I $E(TEXT(CNT),Y)'=" " Q
 .. S TEXT(CNT+1)=$E(TEXT(CNT),Y+1,X)
 .. S TEXT(CNT)=$E(TEXT(CNT),1,Y)
 .. S CNT=CNT+1
 .. I $L(TEXT(CNT))<66 S DONE=1
 S CNT=1
 D BMES^XPDUTL($G(TEXT(CNT)))
 F  S CNT=$O(TEXT(CNT)) Q:+CNT=0  D MES^XPDUTL("   "_$G(TEXT(CNT)))
 Q
 ;
PARAMSET ;Set needed parameters at the Package levels
 N ORPARAM,ORVAL
 ;ORVAL("PARAMETER NAME")="INSTANCE^VALUE"
 S ORVAL("ORK METFORMIN EGFR")="1^365"
 S ORVAL("ORK PROCESSING FLAG")="METFORMIN EGFR-LAB RESULTS^Enabled"
 S ORVAL("ORK CLINICAL DANGER LEVEL")="METFORMIN EGFR-LAB RESULTS^High"
 S ORPARAM=""
 F  S ORPARAM=$O(ORVAL(ORPARAM)) Q:ORPARAM=""  D
 . N ERR,ERRTXT,VAL
 . S VAL=$P($G(ORVAL(ORPARAM)),U,2)
 . D BMES^XPDUTL("Setting the Package level value to "_VAL_" for the "_ORPARAM)
 . D MES^XPDUTL("parameter...")
 . D EN^XPAR("PKG",ORPARAM,$P($G(ORVAL(ORPARAM)),U,1),VAL,.ERR)
 . I $G(ERR)=0 D  Q
 .. D BMES^XPDUTL("   Completed Successfully.")
 . S ERRTXT=$P($G(ERR),U,2)
 . D BMES^XPDUTL("Error while setting the Package level value for the "_ORPARAM)
 . D MES^XPDUTL("parameter!!!!")
 . D MES^XPDUTL("   Error:  "_ERRTXT)
 Q
 ;
REMOVE ;Kill off invalid entries made due to bad "B" index setting in
 ;the NAME (.01) field and remove the "B" cross-reference no longer
 ;being used in the ORDER CHECK OVERRIDE REASONS (#100.04) file.
 N OUTPUT,MSG
 I $D(^OR(100.04,"B")) D
 . D BMES^XPDUTL("Deleting entries stored in ^OR(100.04,""B"") index ...")
 . K ^OR(100.04,"B") ;Proper location is at ^ORD(100.04,"B")
 . D BMES^XPDUTL("   Completed!")
 I $D(^DD(100.04,.01,1,1)) D
 . D BMES^XPDUTL("Deleting Traditional ""B"" cross-reference from the Data Dictionary for the")
 . D MES^XPDUTL("NAME (#.01) field in the ORDER CHECK OVERRIDE REASONS (#100.04) file ...")
 . D DELIX^DDMOD(100.04,.01,1,"KW","OUTPUT","MSG")
 . I $D(MSG("DIERR")) D  Q
 .. N ERRCODE,ERRTXT,X,Y
 .. D BMES^XPDUTL("An error occurred while deleting the Traditional ""B"" cross-reference!!!")
 .. S X=0
 .. F  S X=$O(MSG("DIERR",X)) Q:+X=0  D
 ... S ERRCODE=+$G(MSG("DIERR",X))
 ... I ERRCODE>0 D MES^XPDUTL("ERROR CODE: "_ERRCODE)
 ... S Y=0
 ... F  S Y=$O(MSG("DIERR",X,"TEXT",Y)) Q:+Y=0  D
 .... D MES^XPDUTL($G(MSG("DIERR",X,"TEXT",1)))
 . D BMES^XPDUTL("   Completed!")
 Q
 ;
NATIONAL ;Set the NATIONAL (#.05) field for the nationally released
 ;ORDER CHECK OVERRIDE REASONS (#100.04) entries to YES.
 ;Reset entries if they have been modified or removed.
 N ORLINE,ORACT,ORDATA,ORNAME,ORNAT,ORSYN,ORTYPE,ORVAL
 D BMES^XPDUTL("Updating file #100.04 National entries.")
 F ORLINE=1:1:10 D
 . N DA,DIC,DIE,DINUM,DO,DR,DTOUT,DUOUT,Y,X
 . S ORVAL=$P($T(REASONS+ORLINE^ORY535),";",3)
 . S ORNAME=$P(ORVAL,U,1)
 . S ORSYN=$P(ORVAL,U,2)
 . S ORTYPE=$P(ORVAL,U,3)
 . S ORACT=$P(ORVAL,U,4)
 . S ORNAT=$P(ORVAL,U,5)
 . S DA=$O(^ORD(100.04,"B",ORNAME,""))
 . I 'DA D  Q
 .. D MES^XPDUTL("   '"_ORNAME_"' does not exist!!!")
 .. D MES^XPDUTL("      Adding ...")
 .. S X=ORNAME
 .. S DIC="^ORD(100.04,",DIC(0)=""
 .. S DIC("DR")=".02///^S X=ORSYN;.03///^S X=ORTYPE;.04///^S X=ORACT;.05///^S X=ORNAT"
 .. D FILE^DICN
 .. I Y<0 D MES^XPDUTL("      ERROR occurred. Entry not added!!!")
 . D MES^XPDUTL("   Updating '"_ORNAME_"'")
 . S ORDATA=$G(^ORD(100.04,+DA,0))
 . S DIE="^ORD(100.04,"
 . S DR=""
 . I $P(ORDATA,U,2)'=ORSYN S DR=".02///^S X=ORSYN"_";"
 . I $P(ORDATA,U,3)'=ORTYPE S DR=DR_".03///^S X=ORTYPE"_";"
 . I $P(ORDATA,U,4)'=ORACT S DR=DR_".04///^S X=ORACT"_";"
 . S DR=DR_".05///^S X=ORNAT"
 . D ^DIE
 D BMES^XPDUTL("Completed update of 100.04 National file entries!")
 Q
 ;
REINDEX ;Reindex "B" cross reference in file 100.04
 N DIK
 D BMES^XPDUTL("Reindexing the 'B' cross reference for file 100.04")
 S DIK="^ORD(100.04,",DIK(1)=".01"
 D ENALL^DIK
 D MES^XPDUTL("   Completed!")
 Q
 ;
REASONS ;File 100.04 file entries
 ;1;Benefit of Therapy Outweighs Risk^BEN^B^1^1
 ;2;Patient tolerating current therapy with this medication^PAT^B^1^1
 ;3;Previous Adverse Reaction signs/symptoms managed by patient^PRE^B^1^1
 ;4;Renewal of Current Therapy^REN^B^1^1
 ;5;Will Monitor Closely for Adverse Effects^WILL^B^1^1
 ;6;Documentation of Allergy/Adverse Reaction is in Error^DOCAA^B^1^1
 ;7;Documentation of Allergy/Adverse Reaction is to different agent in same drug class^DOAD^B^1^1
 ;8;Patient report per interview is inconsistent with remote allergy data.^REM^B^1^1
 ;9;Indicated for procedure. Risks mitigated and will monitor.^IND^B^1^1
 ;10;Patient counselled risks/benefits, verbalizes understanding, and elects to proceed^COUNSELLED^B^1^1
 Q
