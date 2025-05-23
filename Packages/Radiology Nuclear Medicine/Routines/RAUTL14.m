RAUTL14 ;HISC/GJC - Utilities for message display. ; Mar 07, 2024@13:17:03
 ;;5.0;Radiology/Nuclear Medicine;**34,208**;Mar 16, 1998;Build 4
 ;
 ;Supported IA #2055 reference to $$EXTERNAL^DILFD
 ;Supported IA #10142 reference to EN^DDIOL
 ;Supported IA #2053 reference to FILE^DIE
 ;
EN1 ; Message display.  Called from the input transform of the
 ;'TYPE OF IMAGING' field of the Imaging Locations file
 ; i.e, ^DD(79.1,6,0) --> D:'$D(^RA(79.1,"BIMG",+Y)) EN1^RAUTL14
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RATXT,RAX,RAY,RAYN
 S RAX=X,RAY=Y,RATXT(1)=" " K X,Y
 S RATXT(2)="** Caution: You are activating a new Imaging Type.  **"
 S RATXT(3)="   This means you will have to assign procedures to"
 S RATXT(4)="   this imaging type.  Workload reports will be printed"
 S RATXT(5)="   separately for this Imaging Type."
 S RATXT(6)=" " D EN^DDIOL(.RATXT) S DIR(0)="YA"
 S DIR("A")="Are you sure? "
 S DIR("?")="Enter 'Y' for yes, 'N' to re-edit this field."
 D ^DIR S RAYN=+Y K X,Y D EN^DDIOL(" ")
 S X=RAX,Y=RAY K:'RAYN X Q:'$D(X)
 I $D(^RA(79.2,"B","CARDIOLOGY STUDIES (NUC MED)",+Y)) K RATXT D
 . S RATXT(1)="   The 'CARDIOLOGY STUDIES' imaging type should not be"
 . S RATXT(2)="   activated unless nuclear cardiology is done separately"
 . S RATXT(3)="   from Nuclear Medicine at your facility."
 . D EN^DDIOL(.RATXT)
 . Q
 Q
EN2 ; Message display.  Called from input transform of the
 ;'TYPE OF IMAGING' field of the Rad/Nuc Med Procedure file
 ; i.e, ^DD(71,12,0) --> D EN2^RAUTL14
 I '$D(^RA(79.1,"BIMG",+Y)) D
 . N RATXT,X,Y S RATXT(1)=" "
 . S RATXT(2)="This Imaging Type has not been assigned to any Imaging Location."
 . S RATXT(3)="In order to register this procedure for patients, you must"
 . S RATXT(4)="assign this Imaging Type to an Imaging Location."
 . S RATXT(5)=" " D EN^DDIOL(.RATXT)
 . Q
 N RAD0,RASEQ
 S RAD0=+$O(^RAMIS(71.3,"B",D0,0)),RASEQ=$P($G(^RAMIS(71.3,RAD0,0)),U,4)
 I RASEQ D  K X
 . N RATXT,X,Y S RATXT(1)=" "
 . S RATXT(2)="This procedure was found in the Rad/Nuc Med Common"
 . S RATXT(3)="Procedure file.  To change its imaging type you must"
 . S RATXT(4)="first inactivate it in that file.  After it is made"
 . S RATXT(5)="inactive you may change its imaging type.  You can"
 . S RATXT(6)="then reactivate it if you wish."
 . S RATXT(7)=" " D EN^DDIOL(.RATXT)
 . Q
 Q
UNI30(RADA,RAX) ; Determines if the 1st 30 chars of a procedure name are unique.
 ; If not, do not allow the user to add or alter the current procedure.
 ; Don't allow characters ; ^
 ; Called from the input transform in ^DD(71,.01,0)
 ; Pass back 1 if unique, 0 if a conflict.
 ; 'RA'   ---> temporary variable to hold data
 ; 'RAX'  ---> Input user wishes to enter/edit in ^RAMIS(71
 ; 'RADA' ---> IEN of the current entry in ^RAMIS(71,
 ; The first 30 do not match any other entries first 30
 N RA1,RA2,RABEG,RAEND,RAFLG1,RAFLG2,RALEN,RALST,RAPCE
 S (RAFLG1,RAFLG2)=0
 ;S RABEG=$E(RAX,1,30),RALEN=$L(RABEG),RALST=$E(RABEG,$L(RABEG))
 ;S RAEND=$E(RABEG,1,(RALEN-1))_$C(($A(RALST)-1))_"z"
 ;
 ; Check for bad characters in the procedure name: a semicolon
 I RAX[";" D EN^DDIOL("Entry must not contain a semicolon (;).    ",,"!?12,$C(7)") Q 0
 ;
 ;
 S RA1=$O(^RAMIS(71,"B",RAX),-1) ; Obtain collating entry immediately
 ;                          before user input.  Check 1st 30 of prior
 ;                          entry aginst 1st 30 of user entry.
 ;                          If different, ok!
 ;
 S:$E(RA1,1,30)'=$E(RAX,1,30) RAFLG1=1
 ;
 S RA2=$O(^RAMIS(71,"B",RAX)) ; Obtain the collating entry of
 S:$E(RA2,1,30)'=$E(RAX,1,30) RAFLG2=1 ; the entry immediately after the
 ;                                       user input.  If the 1st 30 of
 ;                                       user input does not equal the
 ;                                       1st 30 of the next collating
 ;                                       entry, the input is ok!
 ;
 ; Brand new entry
 I RADA=0 Q $S((RAFLG1+RAFLG2)>1:1,1:0)
 ;
 S RAPCE=$P($G(^RAMIS(71,RADA,0)),"^")
 I RADA,($E(RAPCE,1,30)=$E(RAX,1,30)) Q 1 ; 1st 30 chars of user input
 ;                                          may equal the 1st 30 chars
 ;                                          of the record we are editing.
 ;
 E  Q $S((RAFLG1+RAFLG2)>1:1,1:0) ; The 1st thirty chars may have changed
 ;                                  Check RAFLG1 & RAFLG2 for conflicts
 ;                                  with any other data in the database.
 ;
CHKPTYPE(OPTYP,APTYP) ;check the procedure type to ensure BROAD/PARENT procedures
 ; remain BROAD/PARENT procedures after editing the TYPE OF PROCEDURE
 ; (#6) field.
 ; Input: OPTYP = original procedure type value 
 ;        APTYP = after edit procedure type value
 ; Return: 0 if the procedure type value did not change
 ;         1 if there was a change in procedure type value
 Q:(OPTYP=APTYP) 0
 Q 1
 ;
RSETPTYP(RAPIEN,OPTYP) ;PARENT and BROAD procedures cannot have their procedure
 ; types changed. Change the procedure back to the appropriate procedure
 ; type: PARENT (P) or BROAD (B). Called from the RA PROCEDURE EDIT input
 ; template.
 ;
 ; Input: RAPIEN = IEN of the procedure (file: #71) record being edited
 ;         OPTYP = the original procedure type value
 ; Output: the original procedure type value (RAPTY will assume this value)
 ;
 N RAMSG,RAPTYNOW,RASTR
 ;Q1: what is the procedure type after the edit? RAPTYNOW
 S RAPTYNOW=$P($G(^RAMIS(71,RAPIEN,0)),U,6) ;B, D, P or S?
 ;if the original was 'D' or 'S' and if the ptype changes
 ;to 'D' or 'S' accept it & return the updated ptype value (RAPTYNOW)
 I "^D^S^"[("^"_OPTYP_"^"),("^D^S^"[("^"_RAPTYNOW_"^")) QUIT RAPTYNOW
 ;there is a difference that matters. notify the user and set the
 ;procedure type back to its original value.
 NEW RATMP
 S RASTR=$$EXTERNAL^DILFD(71,6,"",OPTYP) ;the external value of original ptype
 S RATMP=$$EXTERNAL^DILFD(71,6,"",RAPTYNOW) ;the external value new ptype
 S RAMSG(1)="An update from a "_RASTR_" to a "_RATMP_" procedure type is not allowed."
 S RAMSG(1,"F")="!!?3",RAMSG(2)="",RAMSG(2,"F")="!"
 D EN^DDIOL(.RAMSG,"")
 N RAERR,RAFDA S RAFDA(71,RAPIEN_",",6)=OPTYP ;original ptype value restored.
 D FILE^DIE("","RAFDA","RAERR")
 S:$D(RAERR)#2 $P(^RAMIS(71,RAPIEN,0),U,6)=OPTYP ;hardset: no xrefs on nat'l DD
 Q OPTYP
 ;
