ORY174 ; Export Package Level Parameters ; Jun 03, 2003@09:27
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**174**;Dec 17, 1997
MAIN ; main (initial) parameter transport routine
 K ^TMP($J,"XPARRSTR")
 N ENT,IDX,ROOT,REF,VAL,I
 ; Install Parameter Categories
 D INSTCATS
 S ROOT=$NAME(^TMP($J,"XPARRSTR")),ROOT=$E(ROOT,1,$L(ROOT)-1)_","
 D ^ORY17401
XX2 S IDX=0,ENT="PKG."_"ORDER ENTRY/RESULTS REPORTING"
 F  S IDX=$O(^TMP($J,"XPARRSTR",IDX)) Q:'IDX  D
 . N PAR,INST,VAL,ERR
 . S PAR=$P(^TMP($J,"XPARRSTR",IDX,"KEY"),U),INST=$P(^("KEY"),U,2)
 . M VAL=^TMP($J,"XPARRSTR",IDX,"VAL")
 . D EN^XPAR(ENT,PAR,INST,.VAL,.ERR)
 K ^TMP($J,"XPARRSTR")
 Q
INSTCATS        ; Install Parameter Categories
 N PXRMDA,LUVALUE,TEXT
 ; Find REMINDER EXCHANGE file Entry
 S LUVALUE(1)="OR*3*174 TEST v8"
 S LUVALUE(2)="06/09/2003@17:46:21"
 S PXRMDA=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 I PXRMDA=0 D  Q
 . S TEXT=" Couldn't find Exchange File for OR*3*174 TEST v8..."
 . D BMES^XPDUTL(TEXT)
 S TEXT=" Installing PARAMETER CATEGORIES..."
 D BMES^XPDUTL(TEXT)
 D POSTKIDS^PXRMEXU5(PXRMDA)
 D INSTALL^PXRMEXSI(PXRMDA)
 Q
