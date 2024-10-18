IB20P799 ;MNTVBB/AJR - IB YEAR 2025 STOP CODES UPDATE ; January 29, 2024 @13:20
 ;;2.0;INTEGRATED BILLING;**799**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the IB Stop Code Billable Types file (#352.5).
 ;
 Q
EN ; Update IB Stop Code Billable Types for Year 2025 in #352.5
 ; Call the Global Backup Tag (Backs up entire file to XTMP and sets the GLBRSTR node
 ; used to prevent a rerun of the backup and update, that would result in
 ; overwriting the backup file unintentionally)
 ; Initiate Update
 ;D ADD    ;add new code
 N IB799FILES
 S IB799FILE=""
 S IB799FILES="352.5"
 S IBCNT=0
 F IBCNT=1:1:$L(IB799FILES,"^") D
 . S IB799FILE=$P(IB799FILES,"^",IBCNT)
 . D GLBBKUP
 . Q
 N IBEFFDT
 D START,ADD,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL("DSS Clinic Stop Codes for Year 2025, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("DSS Clinic Stop Codes for Year 2025, Post-Install Complete")
 Q
 ;
 ;
ADD ;add a new code
 N Y,IBC,IBT,IBX,IBY,IBCODE,IBTYPE,IBDES,IBOVER
 D BMES^XPDUTL(" Adding new codes to file 352.5")
 S IBC=0
 F IBX=1:1 S IBT=$P($T(NCODE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=+$P(IBT,U)
 . S IBTYPE=$P(IBT,U,2)
 . S IBDES=$E($P(IBT,U,3),1,30)
 . S IBOVER=$P(IBT,U,4)
 . S IBY=$P(IBT,U,5)
 . I $D(^IBE(352.5,"AEFFDT",IBCODE,-IBY)) D  Q
 . . D BMES^XPDUTL(" Duplication of stop code "_IBCODE)
 . S Y=+$$ADD3525(IBCODE,IBY,IBTYPE,IBDES,IBOVER) S:Y>0 IBC=IBC+1
 D BMES^XPDUTL("     "_IBC_$S(IBC<2:" entry",1:" entries")_" added to 352.5")
 Q
 ;
UPDATE ;update an old code
 N Y,IB1,IBC,IBT,IBX,IBCODE,IBMSG,IBTYPE,IBDES,IBOVER,IBLSTDT
 S (IBC,IBMSG(1),IBMSG(2),IBMSG(3))=0
 D BMES^XPDUTL(" Updating Stop Code entries in file 352.5")
 F IBX=1:1 S IBT=$P($T(OCODE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=+$P(IBT,U)
 . S IBY=$P(IBT,U,5)
 . I $D(^IBE(352.5,"AEFFDT",IBCODE,-IBY)) D  Q 
 . . D BMES^XPDUTL(" Duplication of stop code "_IBCODE)
 . S IBLSTDT=$O(^IBE(352.5,"AEFFDT",IBCODE,-9999999))
 . I +IBLSTDT=0 D  Q
 . . D BMES^XPDUTL(" Code "_IBCODE_" not found in file 352.5")
 . S IB1=$O(^IBE(352.5,"AEFFDT",IBCODE,IBLSTDT,0))
 . S IB1=$G(^IBE(352.5,IB1,0))
 . S IBTYPE=$S($P(IBT,U,2)'="":$P(IBT,U,2),1:$P(IB1,U,3))
 . S IBDES=$S($P(IBT,U,3)'="":$E($P(IBT,U,3),1,30),1:$P(IB1,U,4))
 . S IBOVER=$P(IBT,U,4)
 . S Y=+$$ADD3525(IBCODE,IBY,IBTYPE,IBDES,IBOVER) S:Y>0 IBC=IBC+1
 D BMES^XPDUTL("     "_IBC_$S(IBC<2:" update",1:" updates")_" added to file 352.5")
 Q
 ;
ADD3525(IBCODE,IBEFFDT,IBTYPE,IBDES,IBOVER) ;
 ;add a new entry
 D BMES^XPDUTL("   "_IBCODE_"  "_IBDES)
 N IBIENS,IBFDA,IBER,IBRET
 S IBRET=""
 S IBIENS="+1,"
 S IBFDA(352.5,IBIENS,.01)=IBCODE
 S IBFDA(352.5,IBIENS,.02)=IBEFFDT
 S IBFDA(352.5,IBIENS,.03)=IBTYPE
 S IBFDA(352.5,IBIENS,.04)=IBDES
 S:IBOVER IBFDA(352.5,IBIENS,.05)=1
 D UPDATE^DIE("","IBFDA","IBRET","IBER")
 I $D(IBER) D BMES^XPDUTL(IBER("DIERR",1,"TEXT",1))
 Q $G(IBRET(1))
 ;
GLBBKUP  ; XTMP Backup of file(s)
 S IBBKUPNDE="IB*2*799-Update FY25 STOP CODE (#352.5)"
 S ^XTMP("IB20P799",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_IBBKUPNDE
 M ^XTMP("IB20P799",IB799FILE,$H)=^IBE(IB799FILE)
 Q
 ;new stop codes - ADD
NCODE ;;code^billable type^description^override flag^effective date
 ;;732^0^SYNCHRONOUS CHAT-BY-TEXT^1^3241001
 ;
 ;codes updated
OCODE ;;code^billable type^description^override flag^effective date
 ;;318^1^GERIATRIC EVALUATIONS^^3241001
 ;;436^1^CHIROPRACTIC CARE^1^3241001
 ;;523^1^OPIOID TREATMENT PROGRAM^1^3241001
 ;
