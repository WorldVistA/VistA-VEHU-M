MAGGTMC2 ;WASH ISC/RMP-UPDATE/CREATE MED PROCEDURE WITH IMAGE POINTER [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
UDATE(TIME,PSIEN,DFN,MAGPTR,MCIEN,MCFILE,OK) ;
 ;IF MCIEN IS DEFINED UPDATE PROCEDURE WITH THE IMAGE PTR
 S X="ERR^MAGGTMC2",@^%ZOSF("TRAP")
 N PATFLD,X,Y
 ; MOD \GEK NEXT 2 LINES OUT , NEXT 3 IN. Stops looking at patient
 ;  field pointer in the procedure/subspecialty file, and checks the
 ;  DD of the pointer to file, it DEFAULTS TO 1 if not found;
 ;;S PATFLD=$P(^MCAR(697.2,PSIEN,0),U,12)
 ;;S MCFILE=+$P($P(^(0),U,2),"(",2)
 S MCFILE=+$P($P(^MCAR(697.2,PSIEN,0),U,2),"(",2)
 S PATFLD=$O(^DD(MCFILE,"B","MEDICAL PATIENT",""))
 S:PATFLD="" PATFLD=1
 I +MCIEN>0 S OK=$$VALID(MCFILE,PATFLD,MCIEN,DFN) Q:'OK
 S X=TIME
 S DIC=^DIC(MCFILE,0,"GL")
 S DIC(0)="XZ"
 D ^DIC K DIC
 I Y'=-1 S OK=$$VALID(MCFILE,PATFLD,+Y,DFN) Q:'OK  S MCIEN=+Y
 I Y=-1 D NEW(TIME,DFN,MCFILE,PSIEN,PATFLD,.MCIEN,.OK) Q:'OK
 D FILE(MCIEN,MCFILE,.MAGPTR,.OK)
 Q
ERR S OK="0^"_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
NEW(TIME,DFN,MCFILE,PSIEN,PATFLD,MCIEN,OK) ;
 ;ADD PATIENT TO 690 IF NOT ALREADY THERE
 N PSPTR
 S PSPTR=$$PSP(MCFILE)
 I '$D(^MCAR(690,DFN)) S ^MCAR(690,DFN,0)=DFN,^MCAR(690,"B",DFN,DFN)="",$P(^MCAR(690,0),U,4)=$P(^MCAR(690,0),U,4)+1 S:$P(^MCAR(690,0),U,3)<DFN $P(^MCAR(690,0),U,3)=DFN
 ;CREATE A PROCEDURE STUB
 S DIC=^DIC(MCFILE,0,"GL")
 ;S DIC(0)="AELMQZ"
 S DIC(0)="LZ" ; GEK/ 5/7/96   CAN'T HAVE AE IN DIC(0)
 S X=TIME,DIC("DR")=PATFLD_"////^S X=DFN"
 S:PSPTR'="" DIC("DR")=DIC("DR")_";"_PSPTR_"////^S X=PSIEN"
 K DD,DO ; GEK/10-08-96  
 D FILE^DICN
 I Y=-1 S OK="0^CANNOT FILE NEW PROCEDURE RECORD" Q
 S OK=1
 S MCIEN=+Y
 Q
FILE(MCIEN,MCFILE,MAG,OK) ;
 ;FILE THE IMAGE POINTER
 N K,I,J
 I $D(MAG)<10 S OK="0^NO Image Number to file in Procedure File" Q
 I '$D(^DD(MCFILE,2005,0)) S OK="0^Procedure File doesn't have Image Field" Q
 S:'$D(^MCAR(MCFILE,MCIEN,2005,0)) ^MCAR(MCFILE,MCIEN,2005,0)=U_+$P(^DD(MCFILE,2005,0),U,2)
 S (J,K)=0 F I=0:0 S I=$O(^MCAR(MCFILE,MCIEN,2005,I)) Q:I'?1N.N  S K=I
 F MCI=0:0 S MCI=$O(MAG(MCI)) Q:MCI=""  S K=K+1,J=J+1,^MCAR(MCFILE,MCIEN,2005,K,0)=MCI,^MCAR(MCFILE,MCIEN,2005,"B",MCI,K)="",MAG(MCI)=MCFILE_"^"_MCIEN_"^"_K
 S $P(^MCAR(MCFILE,MCIEN,2005,0),U,3)=K,$P(^(0),U,4)=$P(^(0),U,4)+J
 S OK="1^The Medicine Procedure file has been updated"
 Q
VALID(MCFILE,PATFLD,MCIEN,DFN) ;
 S TMP=$P($P(^DD(MCFILE,PATFLD,0),U,4),";",2)
 Q $S(DFN'=$P(^MCAR(MCFILE,MCIEN,0),U,TMP):"O^Patient MISMATCH",1:"1")
PSP(MCFILE) ;RETURN FIELD # OF PROCEDURE SUBSPECIALTY FILE REFERENCE
 N TMP
 S TMP=$O(^DD(MCFILE,"B","PROCEDURE",0))
 S:TMP="" TMP=$O(^DD(MCFILE,"B","PROCEDURE/SUBSPECIALTY",0))
 S:TMP="" TMP=$O(^DD(MCFILE,"B","SUBSPECIALTY",0))
 Q $S(TMP="":"",$P(^DD(MCFILE,TMP,0),"^",2)["P697.2":TMP,1:"")
