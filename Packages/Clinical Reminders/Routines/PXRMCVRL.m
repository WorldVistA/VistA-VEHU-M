PXRMCVRL ; SLC/JM/AGP - Reminder CPRS Code ;04/08/2019
 ;;2.0;CLINICAL REMINDERS;**53,45**;Feb 04, 2005;Build 566
 Q
 ;
NEWACTIV(ORY) ;Return true if Interactive Reminders are active
 S ORY=0
 I $T(APPL^PXRMRPCA)'="",+$G(DUZ) D
 . N SRV
 . S SRV=$$GET1^DIQ(200,DUZ,29,"I")
 . S ORY=$$GET^XPAR(DUZ_";VA(200,^SRV.`"_+$G(SRV)_"^DIV^SYS","PXRM GUI REMINDERS ACTIVE",1,"Q")
 . I +ORY S ORY=1
 . E  S ORY=0
 Q
 ;
NEWCVOK(RESULT,USER) ; Returns status of 
 N SRV,ERR,TMP
 S RESULT=0,SRV=$$GET1^DIQ(200,USER,29,"I")
 D GETLST^XPAR(.TMP,"USR.`"_USER_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX NEW REMINDER PARAMS","Q",.ERR)
 I +TMP S RESULT=$P($G(TMP(1)),U,2)
 Q
 ;
ADDNAME(ORX) ; Add Reminder or Category Name as 3rd piece
 N CAT,IEN
 S CAT=$E($P(ORX,U,2),2)
 S IEN=$E($P(ORX,U,2),3,99)
 I +IEN D
 .I CAT="R" S $P(ORX,U,3)=$P($G(^PXD(811.9,IEN,0)),U,3)
 .I CAT="C" S $P(ORX,U,3)=$P($G(^PXRMD(811.7,IEN,0)),U)
 Q ORX
 ;
REMACCUM(RESULT,LVL,TYP,SORT,CLASS,USER) ; Accumulates ORTMP into ORY
 ; Format of entries in ORQQPX COVER SHEET REMINDERS:
 ;   L:Lock;R:Remove;N:Normal / C:Category;R:Reminder / Cat or Rem IEN
 N IDX,I,J,K,M,FOUND,ORERR,ORTMP,FLAG,IEN
 N FFLAG,FIEN,OUT,P2,ADD,DOADD,CODE
 I LVL="CLASS" D  I 1
 .N ORLST,ORCLS,ORCLSPRM,ORWP
 .S ORCLSPRM="ORQQPX COVER SHEET REM CLASSES"
 .D GETLST^XPAR(.ORLST,"SYS",ORCLSPRM,"Q",.ORERR)
 .S I=0,M=0,CLASS=$G(CLASS)
 .F  S I=$O(ORLST(I)) Q:'I  D
 ..S ORCLS=$P(ORLST(I),U,1)
 ..I +CLASS S ADD=(ORCLS=+CLASS) I 1
 ..E  S ADD=$$ISA^USRLM(USER,ORCLS,.ORERR)
 ..I +ADD D
 ...D GETWP^XPAR(.ORWP,"SYS",ORCLSPRM,ORCLS,.ORERR)
 ...S K=0
 ...F  S K=$O(ORWP(K)) Q:'K  D
 ....S M=M+1
 ....S J=$P(ORWP(K,0),";",1)
 ....S ORTMP(M)=J_U_$P(ORWP(K,0),";",2)
 E  D GETLST^XPAR(.ORTMP,LVL,"ORQQPX COVER SHEET REMINDERS",TYP,.ORERR)
 S I=0,IDX=$O(RESULT(999999),-1)+1,ADD=(SORT="")
 F  S I=$O(ORTMP(I)) Q:'I  D
 .S (FOUND,J)=0,P2=$P(ORTMP(I),U,2)
 .S FLAG=$E(P2),IEN=$E(P2,2,999)
 .I ADD S DOADD=1
 .E  D
 ..S DOADD=0
 ..F  S J=$O(RESULT(J)) Q:'J  D  Q:FOUND
 ...S P2=$P(RESULT(J),U,2)
 ...S FIEN=$E(P2,2,999)
 ...I FIEN=IEN S FOUND=J,FFLAG=$E(P2)
 ..I FOUND D  I 1
 ...I FLAG="R",FFLAG'="L" K RESULT(FOUND)
 ...I FLAG'=FFLAG,(FLAG_FFLAG)["L" S $E(P2)="L",$P(RESULT(FOUND),U,2)=P2
 ..E  I (FLAG'="R") S DOADD=1
 .I DOADD D
 ..S OUT(IDX)=ORTMP(I)
 ..S $P(OUT(IDX),U)=$P(OUT(IDX),U)_SORT
 ..I SORT="" S OUT(IDX)=$$ADDNAME(OUT(IDX))
 ..S IDX=IDX+1
 M RESULT=OUT
 Q
 ;
ADDREM(RESULT,IDX,IEN) ; Add Reminder to RESULT list
 I $D(RESULT("B",IEN)) Q               ; See if it's in the list
 I '$D(^PXD(811.9,IEN)) Q           ; Check if Exists
 I $P($G(^PXD(811.9,IEN,0)),U,6)'="" Q  ; Check if Active
 ;Check to see if the reminder is assigned to CPRS
 N USAGE
 S USAGE=$P($G(^PXD(811.9,IEN,100)),U,4)
 ;If the Usage is List or Order Check skip it.
 I (USAGE["L")!(USAGE["O") Q
 ;If the Usage is not C or * skip it.
 I USAGE'["C",USAGE'="*" Q
 S RESULT(IDX)=IDX_U_IEN
 S RESULT("B",IEN)=""
 Q
 ;
ADDCAT(RESULT,IDX,IEN) ; Add Category Reminders to ORY list
 N REM,I,IDX2,NREM
 D CATREM^PXRMAPI0(IEN,.REM)
 S I=0
 F  S I=$O(REM(I)) Q:'I  D
 . S IDX2="00000"_I
 . S IDX2=$E(IDX2,$L(IDX2)-5,99)
 . D ADDREM(.RESULT,+(IDX_"."_IDX2),$P(REM(I),U,1))
 Q
 ;
REMLIST(RESULT,PERSON,LOC) ;Returns a list of all cover sheet reminders
 N SRV,I,J,LST,CODE,IDX,IEN,NEWP,USER
 S USER=$S(+$G(PERSON)>0:+$G(PERSON),1:DUZ)
 S SRV=$$GET1^DIQ(200,USER,29,"I")
 D NEWCVOK(.NEWP,USER)
 I 'NEWP D  Q
 . N OLDLIST
 . D GETLST^XPAR(.OLDLIST,"USR.`"_USER_"^LOC.`"_$G(LOC)_"^SRV.`"_+$G(SRV)_"^DIV^SYS^PKG","ORQQPX SEARCH ITEMS","Q",.ORERR)
 . S I=0
 . F  S I=$O(OLDLIST(I)) Q:'I  D
 .. S IDX=$P(OLDLIST(I),U,1)
 .. F  Q:'$D(RESULT(IDX))  S IDX=IDX+1
 .. S IEN=$P(OLDLIST(I),U,2)
 .. D ADDREM(.RESULT,IDX,IEN)
 . K RESULT("B")
 ;
 D REMACCUM(.LST,"PKG","Q",1000)
 D REMACCUM(.LST,"SYS","Q",2000)
 D REMACCUM(.LST,"DIV","Q",3000)
 I +SRV D REMACCUM(.LST,"SRV.`"_+$G(SRV),"Q",4000)
 I +LOC D REMACCUM(.LST,"LOC.`"_+$G(LOC),"Q",5000)
 D REMACCUM(.LST,"CLASS","Q",6000,"",USER)
 D REMACCUM(.LST,"USR.`"_USER,"Q",7000)
 S I=0
 F  S I=$O(LST(I)) Q:'I  D
 .S IDX=$P(LST(I),U,1)
 .F  Q:'$D(RESULT(IDX))  S IDX=IDX+1
 .S CODE=$E($P(LST(I),U,2),2)
 .S IEN=$E($P(LST(I),U,2),3,999)
 .I CODE="R" D ADDREM(.RESULT,IDX,IEN)
 .I CODE="C" D ADDCAT(.RESULT,IDX,IEN)
 K RESULT("B")
 Q
 ;
LVREMLST(RESULT,LVL,CLASS) ;Returns cover sheet reminders at a specified level
 D REMACCUM(.RESULT,LVL,"Q","",$G(CLASS))
 Q
 ;
GETLVRD(RESULT,LVL,CLASS) ;
 N CAT,CINC,DIEN,IEN,INC,REMLIST,RIEN,REM,TEMP
 D LVREMLST(.REMLIST,LVL,$G(CLASS))
 S INC=0 F  S INC=$O(REMLIST(INC)) Q:INC'>0  D
 . S TEMP=$P($G(REMLIST(INC)),U,2) I TEMP="" Q
 . I $E(TEMP)="R" Q
 . I $E(TEMP,2)="C" D
 .. S CAT=$E(TEMP,3,$L(TEMP))
 .. D CATREM^PXRMAPI0(CAT,.REM)
 .. S CINC=0 F  S CINC=$O(REM(CINC)) Q:CINC'>0  D
 ... S IEN=$G(REM(CINC)) Q:IEN'>0
 ... S DIEN=+$G(^PXD(811.9,IEN,51)) Q:DIEN'>0
 ... S RESULT("REMINDER",DIEN)=""
 . S IEN=$E(TEMP,3,$L(TEMP))
 . S DIEN=+$G(^PXD(811.9,IEN,51)) Q:DIEN'>0
 . S RESULT("REMINDER",DIEN)=""
 Q
 ;
GETDLIST(RESULT,USER,LOC) ;
 ;get coversheet reminders list.
 N IEN,NODE,NUM,REMLIST
 D GETLIST(.REMLIST,USER,$G(LOC))
 S NUM=0 F  S NUM=$O(REMLIST(NUM)) Q:NUM'>0  D
 .S IEN=+$G(REMLIST(NUM)) I IEN'>0 Q
 .I +$G(^PXD(811.9,IEN,51))>0 S RESULT("REMINDER",+$G(^PXD(811.9,IEN,51)))=""
 Q
 ;
GETTDLST(RESULT) ;
 ;get TIU template reminder dialogs list.
 N IEN,NODE,NUM,REMLIST
 S IEN=0 F  S IEN=$O(^TIU(8927,IEN)) Q:IEN'>0  D
 .S NODE=$G(^TIU(8927,IEN,0))
 .I $P(NODE,U,15)>0  S RESULT("TEMPLATE",$P(NODE,U,15))=""
 Q
 ;
GETLIST(RESULT,USER,LOC) ;Returns a list of all cover sheet reminders
 N I
 D REMLIST(.RESULT,USER,$G(LOC))
 S I=0
 F  S I=$O(RESULT(I)) Q:'I  D
 .S RESULT(I)=$P(RESULT(I),U,2)
 Q
 ;
EVALCOVR(RESULT,PT,LOC) ; Evaluate Cover Sheet Reminders
 N ORTMP
 D GETLIST(.ORTMP,$G(LOC))
 D ALIST^ORQQPXRM(.RESULT,PT,.ORTMP)
 Q
 ;
