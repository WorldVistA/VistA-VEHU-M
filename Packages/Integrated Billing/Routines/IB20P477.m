IB20P477 ;ALB/RDK - IB*2.0*477; DSS CLINIC STOP CODES ; 4/10/12 9:26am
 ;;2.0;INTEGRATED BILLING;**477**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
EN ;
 N IBEFFDT,IBY
 D START,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL("DSS Clinic Stop Codes, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("DSS Clinic Stop Codes, Post-Install Complete")
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
 ;existing stop codes - UPDATE
OCODE ;;code^billable type^description^override flag^effective date
 ;;179^0^RT CLIN VID CARE HOME^1^3120507
 ;
