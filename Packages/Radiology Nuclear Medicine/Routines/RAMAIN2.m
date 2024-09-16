RAMAIN2 ;HISC/GJC - Radiology Utility File Maintenance (Part Two) ; May 31, 2024@14:28:03
 ;;5.0;Radiology/Nuclear Medicine;**45,62,71,65,127,138,158,208,214**;Mar 16, 1998;Build 1
 ; 08/12/2005 bay/kam Remedy Call 104630 Patch 62
 ; 03/02/2006 BAY/KAM Remedy Call 131482 Patch RA*5*71
 ; 
 ;Supported IA #10141 reference to MES^XPDUTL
 ;Supported IA #10142 reference to EN^DDIOL
 ;Supported IA #10103 reference to DT^XLFDT
 ;
 ;*** start of RA5p208 updates ***
 ;*** start of RA5p214 updates *** 05/06/2024
2 ;;Procedure Enter/Edit
 ; *** This subroutine once resided in RAMAIN i.e, '2^RAMAIN'. ***
 ; RA PROCEDURE option.
 F  S RAY214=0 DO PRCEE Q:+$G(RAY214)=-1
 ; kill and quit... Note: leave all the package
 ;wide variables setup at sign-on
 ;-------------------------------
 ; RACCESS array, RAIMGTY
 ; RAMDIV, RAMDV & RAMLC
 ;kill option variables on way out...
 D KILLPRCEE K %DT,DILN,DIWT,DN,DUOUT,DTOUT,DIRUT,DIROUT
 D VALIDITY ;run once for ALL procedures entered/edited
 Q  ;'Procedure Enter/Edit' option exit
 ;*** end of RA5p214 updates *** 05/06/2024
 ;
PRCEE ;PROCEDURE ENTER/EDIT subroutine
 ;kill key option variables inside loop
 D KILLPRCEE
 ;K RADA,RACTIVE,RAENALL,RAEXC,RAF71,RAY,RAFILE,RASTAT,RAXIT,RAIEN,RANEW,RANEW71
 ;K DA,J,RACMDIFF,RAOPTYP,RARMPF,RATRKCMA,RATRKCMB,RAY214,X,Y
 S (RAENALL,RANEW71,RAXIT,RANEW)=0 K ^XTMP("RAMAIN4",$J)
 N RADIO,RAPNM,RAPTY,RAASK,RAROUTE ;used by the edit template
 ;F  D  Q:$G(RAXIT)=0!($G(RAXIT)="")!($G(^XTMP("RAMAIN4",$J,"RAEND"))=1)  G:$G(^XTMP("RAMAIN4",$J,"RAEND"))=1 END
 ;K DA,DD,DIC,DINUM,DLAYGO,DO,RACMDIFF,RATRKCMA,RATRKCMB
 S DIC="^RAMIS(71,",DIC(0)="QEAMLZ",DLAYGO=71,DIC("DR")=6
 W ! D ^DIC K D,DD,DIC,DINUM,DLAYGO,DO S RAY214=$G(Y) ;RA5p214 namespace!
 Q:+Y=-1  ;-1 no selection - exit
 ;I $G(Y)<0!($G(Y)="") S ^XTMP("RAMAIN4",$J,"RAEND")=1 Q
 S (DA,RADA)=+Y,RAY=Y,RAFILE=71
 S RAPNM=$G(Y(0,0)) ;proc. name for display purposes in template
 ;RA*5*71 changed next line for Remedy Call 131482
 S RANEW71=$S($P(Y,U,3)=1:1,1:0) ;used in template, edit CPT Code if new rec.
 L +^RAMIS(RAFILE,RADA):5
 I '$T D  Q
 .W !?5,"This record is currently being edited by another user."
 .W !?5,"Try again later!",$C(7) S RAXIT=1
 .Q
21 ;ENTRY POINT FROM RANPRO, RA*5.0*127 (de-activation of LOINC) RA5p208
 ;S (RAENALL,RANEW71,RAXIT,RANEW)=0 S:$G(RACTIVE)="" RACTIVE="" K ^XTMP("RAMAIN4",$J)
 S RACTIVE=$P($G(^RAMIS(71,RADA,"I")),"^")
 S:$G(RASTAT)="" RASTAT=$S(RACTIVE="":1,RACTIVE>DT:1,1:0) ;<-- RAY & RAFILE set above. RA5P208
 S RASTAT=$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 D TRKCMB^RAMAINU(DA,.RATRKCMB) ;tracks existing
 ; CM definition before editing. RATRKCMB ids the before CM values
 ;I $G(RANEW)=1 Q  ;RA*50*127 NEW PROCEDURE <- commented out w/RA5p208
 S DIE="^RAMIS(71,",DR="[RA PROCEDURE EDIT]" D ^DIE
 S RACPT=$P(^RAMIS(71,RADA,0),U,9)
 K RAPNM S RAPROC(0)=$G(^RAMIS(71,RADA,0))
 ;
 ;check for data consistency between the 'CONTRAST MEDIA USED' &
 ;'CONTRAST MEDIA' fields.
 D CMINTEG^RAMAINU1(RADA,RAPROC(0))
 ;
 D TRKCMA^RAMAINU(RADA,RATRKCMB,.RATRKCMA,.RACMDIFF)
 I $O(^RAMIS(71,RADA,"NUC",0)),($P(RAPROC(0),"^",2)=1) D DELRADE(RADA)
 S RACTIVE=$P($G(^RAMIS(71,RADA,"I")),"^")
 S RASTAT=RASTAT_"^"_$S(RACTIVE="":1,RACTIVE>DT:1,1:0)
 ; 08/12/2005 104630 KAM - added '$G(RANEW71) to next line
 I RAPROC(0)]"",("^B^P^"'[(U_$P(RAPROC(0),"^",6)_U)),('+$P(RAPROC(0),"^",9)),'+$G(RANEW71) D
 .K %,C,D0,DE,DI,DIE,DQ,DR
 .W !?5,$C(7),"...no CPT code entered..."
 .W !?5,"...will change type to a 'broad' procedure.",!
 .S DA=RADA,DIE="^RAMIS(71,",DR="6///B" D ^DIE
 .Q
 ;08/12/2005 104630 - KAM added next 5 lines
 I RAPROC(0)]"",("^B^P^"'[(U_$P(RAPROC(0),"^",6)_U)),('+$P(RAPROC(0),"^",9)),+$G(RANEW71) D
 .K %,C,D0,DE,DI,DIK,DQ,DR
 .W !?5,$C(7),"...no CPT code entered..."
 .W !?5,"...will delete the record at this time.",!
 .S DIK="^RAMIS(71,",DA=RADA D ^DIK K DIK
 ;if an active parent w/o descendants, inactivate the parent
 I $P(RASTAT,U,2),($P(RAPROC(0),U,6)="P"),('$O(^RAMIS(71,RADA,4,0))) D
 .K D,D0,D1,DA,DI,DIC,DIE,DQ,DR
 .W !!?5,"Inactivating this parent procedure - no descendents.",!,$C(7)
 .S DA=RADA,DIE="^RAMIS(71,",DR="100///"_$S($D(DT):DT,1:$$DT^XLFDT())
 .D ^DIE K D,D0,D1,DA,DI,DIC,DIE,DQ,DR S $P(RASTAT,U,2)=0 ;inactive
 .Q
 I $P($G(^RA(79.2,+$P(RAPROC(0),U,12),0)),U,5)="Y",(+$O(^RAMIS(71,RADA,"NUC",0))) D VRDIO(RADA)
 I "^B^P^"[(U_$P(RAPROC(0),U,6)_U),($P(RAPROC(0),U,9)]"") D
 .K %,D,D0,DA,DE,DIC,DIE,DQ,DR
 .S DA=RADA,DIE="^RAMIS(71,",DR="9///@" D ^DIE
 .W !!?5,"...CPT code deleted because "_$S($P(RAPROC(0),U,6)="B":"Broad",1:"Parent")_" procedures",!?5,"should not have CPT codes.",!,$C(7)
 .Q
 K %,%X,%Y,C,D,D0,D1,DA,DE,DI,DIE,DQ,DR,RAIMAG,RAMIS,RAPROC,X,Y
 ;send Orderable Item HL7 msg to CPRS if the ORDER DIALOG (#101.41)
 ;file exists unconditionally
 D:$$ORQUIK^RAORDU()=1 PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 ;
 L -^RAMIS(RAFILE,RADA)
 ;unconditionally update the parent procedure if the descendent
 I $O(^RAMIS(71,"ADESC",+RAY,0)) D UPDATP^RAO7UTL(RAY)
 ;has been edited
 ;commented out w/RA5p208 BEGIN
 ;I $G(RANEW)=1 D EN^RANPRO(RAYY,RATYPE,RANEW)  ;RA*5.0*127 NEW PROCEDURE
 ;K DIR,RACMDIFF,RATRKCMA,RATRKCMB
 ;I $G(^XTMP("RAMAIN4",$J,"RAEND"))=1 G END
 ;D EXIT G END
 ;Q
 QUIT  ;create VALIDITY subroutine RA5P214.
 ;
VALIDITY ;Running validity check on CPT and stop codes.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YAO",DIR("B")="NO"
 S DIR("A")="Want to run a validity check on CPT and stop codes? "
 S DIR("?",1)="Answer 'YES' to print a list of Radiology/Nuclear Medicine Procedures"
 S DIR("?",2)="with missing or invalid CPT's and/or Credit Clinic Stop Code(s)."
 S DIR("?",3)="Broad procedures with invalid codes are included for information"
 S DIR("?",4)="only.  Inactive procedures are not required to have valid codes."
 S DIR("?",5)="To be valid, Stop Codes must be in the Imaging Stop Codes file 71.5;"
 S DIR("?",6)="CPT's must be nationally active."
 S DIR("?")="Please answer 'YES' or 'NO'."
 W ! D ^DIR K DIR Q:$D(DIRUT)#2
 D:Y ^RAPERR
 Q
 ; *** end of RA5p208 updates *** 
 ;
13 ;;Rad/Nuc Med Common Procedure File Enter/Edit
 ; RA COMMON PROCEDURE option RA5P158
 N RADA,RAENALL,RAY,RAFILE,RALOW,RAMIS713,RASTAT,RAIMGTYI S RAENALL=0
 W ! D EN1^RAUTL17 G:Y'>0 Q13 S RAIMGTYI=Y
131 S DIC="^RAMIS(71.3,",DIC(0)="AELMQZ",DLAYGO=71.3
 S DIC("S")="I $$SCRN713^RAMAIN2(+$P(^(0),U),RAIMGTYI)"
 S DIC("W")="W $$DICW713^RAMAIN2($P($G(^(0)),U,4))"
 W ! D ^DIC K DIC,DLAYGO,D,X
 I Y<0 D Q13 G RESEQ
 ; If a sequence # exists, the Common Proc. is active
 MERGE RAY=Y S RADA=+Y,RAFILE=71.3 L +^RAMIS(RAFILE,RADA):5
 I '$T D  G Q13
 . W !?5,"This record is currently being edited by another user."
 . W !?5,"Try again later!",$C(7)
 . Q
 S RASTAT=$S($P(Y(0),"^",4)]"":1,1:0)_"^"
 I '+$P(RASTAT,"^") S RALOW=$$LOW(RAIMGTYI)
 S DA=RADA,DIE="^RAMIS(71.3,",DR="[RA COMMON PROCEDURE EDIT]" D ^DIE
 S RAMIS713(0)=$G(^RAMIS(71.3,RADA,0))
 ; If the procedure is different than the one originally selected and
 ; the CPRS Order Dialog file exists, send the Orderable Item Update
 ; message to CPRS.
 I $P(RAMIS713(0),"^")'=$P(RAY,"^",2),($$ORQUIK^RAORDU()=1) D
 . S RASTAT=RASTAT_0 D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 . S RAY=RADA_"^"_$P($G(^RAMIS(71.3,RADA,0)),"^")_"^"_1,RASTAT=0_"^"
 . Q
 K %,%X,%Y,C,D,D0,DA,DE,DI,DIE,DQ,DR,X,Y
 S RASTAT=RASTAT_$S($P($G(^RAMIS(71.3,+RAY,0)),"^",4)]"":1,1:0)
 ; If before & after statuses differ, and the CPRS Order Dialog file
 ; exists, send the Orderable Item Update message to CPRS.
 I $$ORQUIK^RAORDU()=1,(($P(RASTAT,"^")+$P(RASTAT,"^",2))=1) D
 . D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 . Q
 L -^RAMIS(RAFILE,RADA)
 G 131
Q13 K DDC,DDH,DISYS,I,POP,RA713
 Q
RESEQ ;Resequence the common procedure list
 N D,D0,DI,DQ,H,I,J,CNT,DIC,DIE,DR,DA,TXT,X
 I $D(XPDNM) D  ; if called during package install
 . S TXT(1)=" "
 . S TXT(2)="Resequencing the Rad/Nuc Med Common Procedure List."
 . Q
 E  W !!?5,"Resequencing the Rad/Nuc Med Common Procedure List"
 S DIE="^RAMIS(71.3,",(I,CNT)=0
 F  S I=$O(^RAMIS(71.3,"AA",RAIMGTYI,I)) Q:I'>0  D
 . S J=0
 . F  S J=$O(^RAMIS(71.3,"AA",RAIMGTYI,I,J)) Q:J'>0  I $D(^RAMIS(71.3,J,0)) D
 .. S DA=J,CNT=CNT+1 N I,J
 .. S DR="3////^S X=CNT" D ^DIE W:'$D(XPDNM) "."
 .. Q
 . Q
 I $D(XPDNM) D  ; if called during package install
 . S TXT(2)=$G(TXT(2))_"  Done!"
 . D MES^XPDUTL(.TXT)
 . Q
 E  W "  Done!"
 Q
LOW(X) ; Find the lowest available sequence number for a procedure within
 ; a specific Imaging Type.  Seq. #'s range from 1 to 40.  If the
 ; range changes in the DD i.e, ^DD(71.3,3, this code as well as the 
 ; code if EN3^RAUTL18 must also be altered.
 ; If RAHIT is passed back as "", there is no available sequence number.
 N RA,RAHIT S RAHIT=""
 F RA=1:1:40 D  Q:RAHIT
 . Q:$D(^RAMIS(71.3,"AA",X,RA))
 . S:RAHIT="" RAHIT=RA
 . Q
 Q RAHIT
VRDIO(RADA) ; Validate the 'Usual Dose' field within the 'Default Radiopha-
 ; rmaceuticals' multiple.  'Usual Dose' must fall within the 'Low Adult
 ; Dose' & 'High Adult Dose' range.  This subroutine will display the
 ; Radiopharmaceutical in question along with the values in question if
 ; inconsistencies are found.
 ;
 ; Input Variable: 'RADA' the ien of the Procedure
 N RANUC S RADA(1)=RADA,RADA=0 D EN^DDIOL("","","!")
 F  S RADA=$O(^RAMIS(71,RADA(1),"NUC",RADA)) Q:RADA'>0  D
 . S RANUC(0)=$G(^RAMIS(71,RADA(1),"NUC",RADA,0))
 . Q:$P(RANUC(0),"^",2)=""  ; no need to validate, nothing input
 . I '$$USUAL^RADD2(.RADA,$P(RANUC(0),"^",2)) D
 .. N RARRY S RARRY(1)="For Radiopharmaceutical: "
 .. S RARRY(1)=RARRY(1)_$$EN1^RAPSAPI(+$P(RANUC(0),"^"),.01)_$C(7)
 .. S RARRY(2)="" D EN^DDIOL(.RARRY,"")
 .. Q
 . Q
 Q
DELRADE(RADA) ; Delete the Default Radiopharmaceuticals multiple 
 N RADA1 S RADA1=0
 W !!?3,"Deleting default radiopharmaceuticals for this procedure...",!
 F  S RADA1=$O(^RAMIS(71,RADA,"NUC",RADA1)) Q:RADA1'>0  D
 . K %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 . S DA(1)=RADA,DA=RADA1,DIE="^RAMIS(71,"_RADA_",""NUC"","
 . S DR=".01///@" D ^DIE
 . Q
 K %,%X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,Y
 Q
 ;
END ;KILL LOGIC AND END ROUTINE
 K RACODE,RACPT,RAGOLD,RAMATCH,RANEW71,RANM,RAPROIEN,RATYPE,RAYY
 K DDC,DDH,DISYS,I,POP,RA713,DIK,DA
 Q
 ;
SCRN713(Y,RAIMGTYI) ;screen common procedures by i-type
 ;RAIMGTYI set above in 13^RAMAIN2
 ;'Y' = the IEN of the common procedure as it exists in file 71
 ;'RAIMGTYI' = IEN of the imaging type for the common procedure
 QUIT:(RAIMGTYI=$P($G(^RAMIS(71,Y,0)),U,12)) 1
 Q 0
 ;
DICW713(RAX) ;display the sequence number or a message is the sequence
 ;number is missing. ^DD(71.3,3,0)="SEQUENCE NUMBER" 0;4
 ;'RAX' the sequence number or null statement
 N RASEQTXT S RASEQTXT="   "_$S(RAX>0:"("_RAX_")",1:"(no sequence number)")
 Q RASEQTXT
 ;
KILLPRCEE ;kill procedure enter/edit variables... RA5P214
 ;note: vars RAF71,RARMPF,RAOPTYP,RAEXC & RABINARY are also killed at the end of the
 ;RA PROCEDURE EDIT input template. Killing them here b/c exiting RA PROCEDURE EDIT
 ;before stepping through to the end leaves some/all of those vars defined.
 K DA,RADA,RACTIVE,RAENALL,RAEXC,RARMPF,RAF71,RAY,RAFILE,RASTAT,RAXIT,RAIEN,RANEW,RANEW71
 K %DT,DILN,DIWT,DN,DUOUT,J,RABINARY,RACMDIFF,RAOPTYP,RATRKCMA,RATRKCMB,RAY214,X,Y
 Q
 ;
