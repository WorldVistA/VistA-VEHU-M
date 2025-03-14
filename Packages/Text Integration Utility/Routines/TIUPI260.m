TIUPI260 ;SLC/WAT High Risk Mental Health;11/30/11  15:43 ;12/08/11  12:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**260**;Jun 20, 1997;Build 37
 ;
 ;EXTERNAL CALLS
 ;B/MES^XPDUTL 10141
 ;UPDATE^DIE 2053
 ;^DIC 10006
 ;^DIK 10013
 ;
 Q
EN ;
 N TIUFPRIV S TIUFPRIV=1
 ;
 D DELOBJ
 ;
 N NAME,METHOD,PNAME,HSIEN
 ;
 S NAME="MH MISSED APPOINTMENTS 10D"
 S PNAME="MISSED MH APPOINTMENTS (10 DAYS)"
 S METHOD="S X=$$MSTAPPT^TIULO1(DFN,""^TMP(""""TIU APPT"""",$J)"")"
 I $$MKOBJ(NAME,METHOD)<0 D
 .D BMES^XPDUTL("Installation Error:  Creation of TIU Object "_NAME_" failed.")
 Q
 ;
CHKTITLE(FILE,NAME)     ;
 N DIC,X,Y
 S DIC=FILE,DIC(0)="X"
 S X=NAME
 D ^DIC
 S:+Y'>0 Y=""
 Q $P(Y,"^")
 ;
MKOBJ(NAME,METHOD)      ;
 N FDA,FDAIEN,MSG
 S FDA(8925.1,"+1,",.01)=NAME
 S FDA(8925.1,"+1,",.03)=PNAME
 S FDA(8925.1,"+1,",.04)="O"
 S FDA(8925.1,"+1,",.06)=$$CHKTITLE(8930,"CLINICAL COORDINATOR")
 S FDA(8925.1,"+1,",.07)=11
 S FDA(8925.1,"+1,",9)=METHOD
 S FDA(8925.1,"+1,",99)=$H
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D  Q -1
 . D AWRITE("MSG")
 D BMES^XPDUTL("Creation of TIU Object "_NAME_" successful...") H 1
 Q 1
DELOBJ ;
 N DA,DIK,X,Y
 S DIK="^TIU(8925.1,"
 S DA=$O(^TIU(8925.1,"B","MH MISSED APPOINTMENTS 10D",""))
 I DA>0 D ^DIK
 Q
AWRITE(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("PXRM",$J).
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TIUTEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,TIUTEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.TIUTEXT)
 Q
 ;
