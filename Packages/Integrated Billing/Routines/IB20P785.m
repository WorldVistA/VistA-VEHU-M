IB20P785 ;MNTVBB/DMR - IB MID YEAR 2024 STOP CODES UPDATE ; January 29, 2024 @13:20
 ;;2.0;INTEGRATED BILLING;**785**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the IB Stop Code Billable Types file (#352.5).
 ;
 Q
EN ; Update IB Stop Code Billable Types for Mid Year 2024 in #352.5
 ; Call the Global Backup Tag (Backs up entire file to XTMP and sets the GLBRSTR node
 ; used to prevent a rerun of the backup and update, that would result in
 ; overwriting the backup file unintentionally)
 N GLBKUP
 D GLBBKUP
 I $D(GLBKUP) Q
 ; Initiate Update
 N IBEFFDT
 D START,ADD,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL("DSS Clinic Stop Codes for Mid Year 2024, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("DSS Clinic Stop Codes for Mid Year 2024, Post-Install Complete")
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
GLBBKUP ; XTMP Backup of file(s)
 I $D(^XTMP("IB20P785","GLBRSTR")) W !!,"CANNOT RERUN WITHOUT A RESTORE" S GLBKUP=1 Q
 K ^XTMP("IB20P785")
 S ^XTMP("IB20P785")=$$FMADD^XLFDT(DT,120)_"^"_DT
 M ^XTMP("IB20P785")=^IBE(352.5)
 S ^XTMP("IB20P785","GLBRSTR")=1
 Q
 ;
GLBRSTR ; Restore of Prior version of file using XTMP
 K ^XTMP("IB20P785","GLBRSTR")
 K ^IBE(352.5)
 M ^IBE(352.5)=^XTMP("IB20P785")
 Q
 ;new stop codes - ADD
NCODE ;;code^billable type^description^override flag^effective date
 ;;355^2^HEADACHE CENTER OF EXCELLENCE^^3240401
 ;
 ;codes updated
OCODE ;;code^billable type^description^override flag
 ;;534^1^PCMHI INDIV^^3240401
 ;;539^1^PCMHI GROUP^^3240401
 ;
