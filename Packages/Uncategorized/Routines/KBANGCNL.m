KBANGCNL ; VEN/SMH - Load GCNs into VISTA ;2015-04-17  11:00 AM
 ;;0.1;SAM'S INDUSTRIAL CONGLOMERATES;;;Build 34
 ; (C) Sam Habiel 2013
 ;
 ; Use allowed under Medical Cybernetics CS-Tools only.
 ;
 ; Note that there are two PEPs: EN (to load directly) and KIDS (from KIDS)
EN(PATH) ; Main entry point to load the data into XTMP and then into VISTA.
 ;
 ; PATH by value like "/home/sakura/Documents/workspace/Vista/cstools/VUID2GCN20130627.csv"
 ;
READ ; Read Data into ^TMP
 ;
 S D="|"
 N PIECES S PIECES=$L(PATH,"/")
 N FILENAME S FILENAME=$P(PATH,"/",PIECES)
 S PATH=$P(PATH,"/",1,PIECES-1)
 K ^TMP($J)
 D OPEN^%ZISH("FILE",PATH,FILENAME,"R") Q:POP
 U IO
 N LINE,COL ; Line, Column
 R LINE:0 ; First line
 ;
 ; Create COL array containing the first line columns
 N CP F CP=1:1:$L(LINE,D) S COL(CP)=$P(LINE,D,CP) ; Columns array; CP = Comma Piece
 ;
 ; Subscript data using COL array when read in.
 F I=1:1 R LINE:0 Q:$$STATUS^%ZISH  F CP=1:1:$L(LINE,D) S ^TMP($J,I,COL(CP))=$P(LINE,D,CP)
 D CLOSE^%ZISH("FILE")
 ;
CLEAN ; Clean Data - Make GCN number canonical; replace NULL with "".
 ; Love letter below
 N I S I=0 F  S I=$O(^TMP($J,I)) Q:'I  S ^("GCN_SEQNO")=$S(+^TMP($J,I,"GCN_SEQNO"):+^("GCN_SEQNO"),1:"")
 ;
STORE ; Store data in XTMP
 N S S S=$T(+0)
 K ^XTMP(S)
 N X,X1,X2 S X1=DT,X2=5 D C^%DTC
 S ^XTMP(S,0)=X_U_DT_U_"VUID2GCN translation table for KIDS"
 M ^XTMP(S)=^TMP($J)
 ;
LOAD ; Load data
 K ^TMP($J,"FDA")
 N I S I=0 F  S I=$O(^TMP($J,I)) Q:'I  D
 . N VUID S VUID=^TMP($J,I,"VUID")
 . I 'VUID QUIT  ; Can't match nulls
 . N GCN S GCN=^TMP($J,I,"GCN_SEQNO")
 . S GCN=$TR($J(GCN,6)," ",0)
 . I 'GCN QUIT  ; No point in doing this if no GCN
 . N NDCLINK S NDCLINK=^TMP($J,I,"NDC LINK TO GCNSEQNO")
 . N IEN S IEN=$O(^PSNDF(50.68,"AMASTERVUID",VUID,1,"")) ; Try #1
 . I 'IEN S IEN=$O(^PSNDF(50.68,"AVUID",VUID,""))        ; Try #2
 . I 'IEN D MES^XPDUTL(VUID_" not found") QUIT
 . S ^TMP($J,"FDA",50.68,IEN_",",11)=GCN
 . S ^TMP($J,"FDA",50.68,IEN_",",13)=NDCLINK
 ;
 D CLEAN^DILF
 D FILE^DIE("",$NA(^TMP($J,"FDA")))
 I $D(DIERR) N ERROR M ERROR=^TMP("DIERR",$J) S $EC=",UFILEMANERROR,"
 ;
 QUIT
 ;
 ; Below are the Public KIDS entry points
TRAN ; Move Data into Transport Global
 M @XPDGREF@($T(+0))=^XTMP($T(+0))
 QUIT
 ;
POST ; Post install hook
 K ^TMP($J)
 M ^TMP($J)=@XPDGREF@($T(+0))
 D LOAD
 K ^TMP($J)
 QUIT
 ;
 ; Private entry points again...
LNDCGCN(PATH) ; Load NDC 2 GCN table from FDB
 ; Path by value like /home/sakura/Documents/workspace/Vista/cstools
 ;
 D gcnB4 ; Record before
 N S S S=$T(+0)_"-NDCMATCH1"
 K ^XTMP(S)
 N X,X1,X2 S X1=DT,X2=5 D C^%DTC
 S ^XTMP(S,0)=X_U_DT_U_"NDC 2 GCN"
 N POP
 D OPEN^%ZISH("FILE",PATH,"RNDC14_NDC_MSTR","R") 
 I POP W "FAILED TO LOAD FILE",! QUIT
 U IO
 N I,X F I=0:0 R X:0 Q:$$STATUS^%ZISH  D
 . N NDC S NDC=$P(X,"|")
 . N GCN S GCN=$P(X,"|",3)
 . S ^XTMP(S,NDC)=GCN
 D specialAdditions(S)
 D CLOSE^%ZISH("FILE")
 ;
 ;
LDBYNDC ; Fall through
 ;
 K ^TMP($J,"FDA")
 N I F I=0:0 S I=$O(^PSNDF(50.68,I)) Q:'I  D  ; Loop through all entries.
 . ;
 . Q:$P(^PSNDF(50.68,I,7),U,3)  ; don't continue if inactive
 . ;
 . N GCN S GCN=0
 . N DGNM S DGNM=$P(^PSNDF(50.68,I,0),U) ; drug name
 . ;
 . ; Find a GCN from at least one NDC (loop forwards now through the index to get most recent)
 . N J S J="" F  S J=$O(^PSNDF(50.68,"ANDC",I,J),+1) Q:'J  D  Q:GCN  ; Loop though each NDC pointer; Stop if GCN is found.
 . . N NDC S NDC=$P(^PSNDF(50.67,J,0),U,2) ; VISTA NDC
 . . I '$L(NDC) WRITE "BAD ENTRY"," ",DGNM,! QUIT
 . . N HNDC S HNDC=$E(NDC,2,20) ; Remove first zero for HIPPA format NDC
 . . I $D(^XTMP(S,HNDC)) S GCN=^(HNDC)
 . . Q:'GCN  ; not found
 . . S ^TMP($J,"FDA",50.68,I_",",11)=GCN  ; File in VA PRODUCT file
 . . S ^TMP($J,"FDA",50.68,I_",",13)=NDC  ; ditto
 D CLEAN^DILF
 D FILE^DIE("",$NA(^TMP($J,"FDA")))
 I $D(DIERR) N ERROR M ERROR=^TMP("DIERR",$J) S $EC=",UFILEMANERROR,"
 ;
 D gcnAfter
 ;
STXTMP ; Store in XTMP
 N S S S=$T(+0)
 K ^XTMP(S)
 N X,X1,X2 S X1=DT,X2=5 D C^%DTC
 S ^XTMP(S,0)=X_U_DT_U_"VUID2GCN translation table for KIDS"
 N I F I=0:0 S I=$O(^PSNDF(50.68,I)) Q:'I  D  ; Loop through all entries.
 . Q:$P(^PSNDF(50.68,I,7),U,3) ; Quit if inactive
 . Q:'$P(^PSNDF(50.68,I,1),U,5)  ; Quit if no GCN
 . N KBANI S KBANI=I D
 . . N I
 . . S ^XTMP(S,KBANI,"VUID")=$$GET1^DIQ(50.68,KBANI,"VUID")
 . . S ^XTMP(S,KBANI,"GCN_SEQNO")=$$GET1^DIQ(50.68,KBANI,"GCNSEQNO")
 . . S ^XTMP(S,KBANI,"NDC LINK TO GCNSEQNO")=$$GET1^DIQ(50.68,KBANI,"NDC LINK TO GCNSEQNO")
 QUIT
 ;
 ;
gcnB4 ; Load for analysis GCN's before
 N R1 S R1=$NA(^TMP("gcnBefore",$J))
 K @R1
 N I F I=0:0 S I=$O(^PSNDF(50.68,I)) Q:'I  D  ; Loop through all entries.
 . ;
 . Q:$P(^PSNDF(50.68,I,7),U,3)  ; don't continue if inactive
 . ;
 . N GCN S GCN=$P(^PSNDF(50.68,I,1),U,5)
 . S @R1@(I)=GCN ; GCN can be empty
 . S:GCN]"" @R1@(GCN)=I
 QUIT
 ;
gcnAfter ; Analysis of GCNs after
 N R1 S R1=$NA(^TMP("gcnBefore",$J))
 N R2 S R2=$NA(^TMP("gcnAfter",$J))
 K @R2
 N I F I=0:0 S I=$O(^PSNDF(50.68,I)) Q:'I  D  ; Loop through all entries.
 . ;
 . Q:$P(^PSNDF(50.68,I,7),U,3)  ; don't continue if inactive
 . ;
 . N oldGCN S oldGCN=$S($D(@R1@(I)):@R1@(I),1:"")
 . N newGCN S newGCN=$P(^PSNDF(50.68,I,1),U,5)
 . D
 .. I newGCN="",oldGCN]"" S @R2@("hadGCNNowDoesnt",I)="",^(0)=$G(^(0))+1 QUIT
 .. I oldGCN="",newGCN]"" S @R2@("didntHaveGCNNowDoes",I)="",^(0)=$G(^(0))+1 QUIT
 .. I oldGCN'=newGCN S @R2@("hasDifferentGCN",I)=oldGCN_U_newGCN,^(0)=$G(^(0))+1
 .. I oldGCN="",newGCN="" quit
 .. I oldGCN=newGCN S @R2@("hasSameGCN",I)="",^(0)=$G(^(0))+1
 ;
 ; Report
 W "===================",!
 n sub f sub="hadGCNNowDoesnt","didntHaveGCNNowDoes","hasDifferentGCN","hasSameGCN" d
 . w sub,?30,$g(@R2@(sub,0),0),!
 . i sub="hasSameGCN" quit
 . i $g(@R2@(sub,0)) n i f i=0:0 s i=$o(@R2@(sub,i)) q:'i  do
 .. w ?5,i,?15,$piece(^PSNDF(50.68,i,0),U)
 .. i sub="hasDifferentGCN" w ?65,"old^new"," ",@R2@(sub,i)
 .. w !
 . w !!
 QUIT
 
specialAdditions(S) ; Add GCNS/NDCs for drugs not found in FDB.
 S ^XTMP(S,59148000635)="060225" ; NDC for ARIPIPRAZOLE 2MG TAB,UD IEN 17586
 S ^XTMP(S,"00074115270")="006542" ; NDC for HEPARIN NA 100UNT/ML LOCK FLUSH SOLN IEN 748
 quit
analyzeInactives ; [PUBLIC] - Standalone
 S U="^"
 w ?2,"IEN",?8,"VA PRODUCT",?80,"ACTIVE DATE",?90,"INACTIVATION",!
 w ?2,"===",?8,"==========",?80,"===========",?90,"============",!
 N I F I=0:0 S I=$O(^PSNDF(50.68,I)) Q:'I  D  ; Loop though all entries...
 . I '$D(^PSNDF(50.68,I,"TERMSTATUS")) QUIT
 . n lastDate,lastDateIEN s lastDate=$o(^PSNDF(50.68,I,"TERMSTATUS","B",""),-1) s lastDateIEN=$o(^(lastDate,""))
 . n isActive s isActive=$P(^PSNDF(50.68,I,"TERMSTATUS",lastDateIEN,0),"^",2)
 . n inactiveDate s inactiveDate=$P(^PSNDF(50.68,I,7),U,3)
 . i isActive&inactiveDate,lastDate>inactiveDate D
 . . W ?2,I,?8,$P(^PSNDF(50.68,I,0),U),?80,lastDate,?90,inactiveDate,!
 . . S ^TMP("KBANGCNL-UPDATE",$J,50.68,I_",",21)="@"
 . ; i 'isActive&'inactiveDate W ?5,I,?9,$P(^PSNDF(50.68,I,0),U),?80,lastDate,!
 QUIT
