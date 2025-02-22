ZDDUTIL ;PROGRAM TO MANIPULATE THE DD [ 05/01/94  8:11 PM ] ;8/7/96  15:29
FILES ;GET A LIST OF FILES FOR THE UCI
 S FNAME=""
 K ^TMP($J)
 S FILECNT=0
 F  S FNAME=$O(^DIC("B",FNAME)) Q:FNAME=""  D GETFILES
 I $D(^DIC("B","PRIM. CARE TEAM TRACKING")) S ^TMP($J,646076)="PRIM CARE TEAM TRACKING" ;TO TEST 646 LOCAL FILE
 S ^TMP($J,2)="PATIENT"
 S ^TMP($J,5)="STATE" ;TO TEST STATE FILE
 S ^TMP($J,40.15)="OPC ERRORS"
 Q
GETFILES ;GET FILE NAMES
 ;AND NUMBERS
 ;don't include files with * as first char-file marked for removal
 S FRSTCH=$E(FNAME,1,1) I FRSTCH="*" Q
 S FNUM=""
 S FNUM=$O(^DIC("B",FNAME,FNUM)) Q:FNUM=""!(FILECNT>400)  D WRFILEN
 Q
WRFILEN ;WRITE THE FILENAME
 I FNUM<2.5!(FNUM=63)!(FNUM=44) Q  ;ELIMINATE SOME FILES.
 I FNUM>1000 Q  ;ONLY GET NATIONAL FILES
 ;
 S ^TMP($J,FNUM)=FNAME
 S FILECNT=FILECNT+1
 ;W !,"FILE NUM=",FNUM,?18,"  FILE NAME=",FNAME
 Q
 ;***********************FIELD LISTER***********************
FIELDS ;
 ;R !,"Enter file number:",FILENUM
 I FILENUM="^"!(FILENUM="") S ERROR="FILE NOT SPECIFIED." Q
 S ORIGFIL=FILENUM ;SAVE ORIGINAL FILE NUMBER
 K ^TMP($J)
 S GLOB=$G(^DIC(FILENUM,0,"GL"))
 I GLOB="" S ERROR="File doesn't exist!" Q 
 S FILENAME=$P($G(^DIC(FILENUM,0)),"^",1)
 I FILENAME["/" S NUMPER=$L(FILENAME,"/")-1 F II=1:1:NUMPER S FILENAME=$TR(FILENAME,"/","")
 I FILENAME["." S NUMPER=$L(FILENAME,".")-1 F II=1:1:NUMPER S FILENAME=$TR(FILENAME,".","")
 I FILENAME["?" S NUMPER=$L(FILENAME,"?")-1 F II=1:1:NUMPER S FILENAME=$TR(FILENAME,"?","")
 ;I FILENAME["#" S NUMPER=$L(FILENAME,"#")-1 F II=1:1:NUMPER S FILENAME=$TR(FILENAME,"#","")
 ;W !,"File selected is:",FILENAME,"  Global location is:",GLOB
 S ^TMP($J,"GLOBAL DATA")=FILENAME_GLOB
 ;R X:1 ;WASTE A SECOND
 S FIELDNAM=""
LOOP ;
 F  S SUBLEV=1 S FIELDNAM=$O(^DD(FILENUM,"B",FIELDNAM)) Q:FIELDNAM=""  D FINDFLD
 ;W !,"End of file..."
 D BLDFLDP ;BUILD A PATH TO EACH FIELD
 K SUBLEV,FIELDREF,NFIELDNUM,PIECE5,XSTR,XPOS,NODE,NODPIECE
 K FLDATTR,FLDLEN,FIELDNAME,FIELDNUM,L,PIECE,ORIGFIL
 K F1,F2,F3,FILEN1,FILEN2,FILEN3,MUL
 K FLDPATH,FTYPE,SUBVAL,WP
 K FILEN,FLD1,FLD2,FLD3,FLDN,KEYNUM
 Q
FINDFLD ;GET THE FIELD DATA
 I $E(FIELDNAM,1,1)="*" Q  ;FIELD OBSOLETE THROW AWAY
 ;W !,"FIELD=",FIELDNAM
 S FIELDNUM=$O(^DD(FILENUM,"B",FIELDNAM,""))
MULT ;HERE YOU MIGHT HAVE A MULTIPLE FIELD
 S FIELDREF=$P(^DD(FILENUM,FIELDNUM,0),"^",1),FIELDX=$P(^(0),"^",2)
 S WP=0 ;WORD PROCESSING FIELD
 I +FIELDX D  I WP Q  ;MULTIPLE FIELD
 .S FTYPE=$P($G(^DD(FIELDX,.01,0)),"^",2)
 .I FTYPE="W"!(FTYPE="WL") S WP=1
 .S ^TMP($J,FILENUM,FIELDNUM)=FIELDNAM_"^"_"W^30^"_FIELDX_"^"_FILENUM_"^"_FIELDNUM_"^"_FILENUM
 I +FIELDX D  ;MULTIPLE FIELD
 .S ^TMP($J,FILENUM,FIELDNUM)=FIELDNAM_"^"_"*Top Multiple*"_"^"_FIELDX_"^"_FIELDNUM_"^"_FILENUM
 .S SUBLEV=SUBLEV+1 
 .S SUB(SUBLEV)=$P($P(^DD(FILENUM,FIELDNUM,0),"^",4),";",1)
 .S SUBLEV=SUBLEV+1
 .S NFILENUM=FILENUM,NFIELDNUM=FIELDNUM,NFIELDNAME=FIELDNAM 
 .N FILENUM,FIELDNAM,FIELDNUM 
 .S FILENUM=+$P(^DD(NFILENUM,NFIELDNUM,0),"^",2),FIELDNAM="",N1=FILENUM 
 .S PIECE5=$P(^DD(FILENUM,.01,0),"^",5,999),SUBVAL="DA"
 .I PIECE5["DINUM" D  ;LOOK FOR A DINUM ENTRY IN DD
   ..S XPOS=$F(PIECE5,"DINUM")-5,XSTR=$E(PIECE5,XPOS,999)
   ..S SUBVAL=$P(XSTR," ",1)
 .S SUB(SUBLEV)=SUBVAL
 .D MORMULT
 .S FIELDNAM=$O(^DD(FILENUM,"B",FIELDNAM)) Q:FIELDNAM="" 
 I +$P(^DD(FILENUM,FIELDNUM,0),"^",2) Q  ;HAVE A MULTIPLE
 ;W " [",FIELDNUM,"]"
 S NODPIECE=$P($G(^DD(FILENUM,FIELDNUM,0)),"^",4)
 S NODE=$P(NODPIECE,";",1),PIECE=$P(NODPIECE,";",2)
 ;W ?35," NODE=",NODE,"  PIECE=",PIECE
 ;FIELD ATTRIBUTES
 S FLDATTR=$P($G(^DD(FILENUM,FIELDNUM,0)),"^",2)
 I FLDATTR["NJ" S L=$P(FLDATTR,"NJ",2),FLDLEN=+L,FLDATTR="$" G CURR
 S FLDLEN=$P($G(^DD(FILENUM,FIELDNUM,0)),"^",5)
 S L=$P(FLDLEN,">",2),L=$P(L,"!") ;PULL LENGTH FROM M-STRING
 S L=+L ;SHOULD STRIP UNWANTED CHARACTERS
 S FLDLEN=L
CURR ;CURRENCY
 I +FLDLEN=0 S FLDLEN=30 ;ARBITRARY
SORT ;SORT THE DATA
 ;D SET
 S KEYNUM=$S(SUBLEV=1:1,SUBLEV=3:2,SUBLEV=5:3,SUBLEV=7:4,SUBLEV=9:5,SUBLEV=11:6,1:"SUBSCRIPT LEVEL ERROR")
 I +KEYNUM S KEYNUM=KEYNUM_"LEV KEY"
 S ^TMP($J,FILENUM,FIELDNUM)=FIELDNAM_"^"_FLDATTR_"^"_FLDLEN_"^"_ORIGFIL_"^"_FILENUM_"^"_FIELDNUM_"^"_KEYNUM
 ;W ?65,"FIELD ATR:"_FLDATTR
 Q
SET ;BUILD SUBSCRIPTS FOR GETTING DATA
 S D=0,X="\\DA"
 F  S D=$O(SUB(D)) Q:D'>0  S X=X_"^"_SUB(D)
 S SUBS=X
 Q
MORMULT ;
 ;W !,"******* MULTIPLE FILE****>",FILENUM
 F  S FIELDNAM=$O(^DD(FILENUM,"B",FIELDNAM)) Q:FIELDNAM=""  D FINDFLD
 K SUB(SUBLEV),SUB(SUBLEV-1) S SUBLEV=SUBLEV-2
 Q
BLDFLDP ;BUILD FIELD PATH
 S FILEN=FILENUM
FLDS ;FIELDS
 S FLDN=""
 F  S FLDN=$O(^TMP($J,FILEN,FLDN)) Q:FLDN=""  D CHECKIT
 Q
CHECKIT ;LOOK FOR MULT
 S X=$G(^TMP($J,FILEN,FLDN)) S MUL=$p(X,"^",2)
 S ^TMP($J,FILEN,FLDN)=X_"^"_FLDN_"^"_FILENAME
 S FLDPATH=FLDN_"^"_FILENAME
 I MUL["*Top Multiple*" S SUBFILN1=$P(X,"^",1) D  ;
 .S F0=FLDN ;FIRST FLD NUM
 .S FILEN1=+$P(X,"^",3),FLD1=""
 .F  S FLD1=$O(^TMP($J,FILEN1,FLD1)) Q:FLD1=""  D  ;
 ..S X=$G(^TMP($J,FILEN1,FLD1))
 ..S FLDPATH=F0_","_FLD1
 ..S FLDPATH=FLDPATH_"^"_SUBFILN1
 ..S ^TMP($J,FILEN1,FLD1)=X_"^"_FLDPATH
 ..S MUL=$P(X,"^",2)
 ..I MUL["*Top Multiple*" S SUBFILEN2=$P(X,"^",1) D  ;
 ...S FILEN2=+$P(X,"^",3)
 ...S F1=FLD1
 ...S FILEN2=+$P(X,"^",3),FLD2=""
 ...F  S FLD2=$O(^TMP($J,FILEN2,FLD2)) Q:FLD2=""  D  ;
 ....S FLDPATH=F0_","_F1_","_FLD2_"^"_SUBFILEN2
 ....S X=$G(^TMP($J,FILEN2,FLD2)) 
 ....S ^TMP($J,FILEN2,FLD2)=X_"^"_FLDPATH
 ....S MUL=$P(X,"^",2)
 ....I MUL["*Top Multiple*" S SUBFILEN3=$P(X,"^",1) D  ;
 .....S F2=FLD2
 .....S FILEN3=+$P(X,"^",3),FLD3=""
 .....F  S FLD3=$O(^TMP($J,FILEN3,FLD3)) Q:FLD3=""  D  ;
 ......S X=$G(^TMP($J,FILEN3,FLD3))
 ......S FLDPATH=F0_","_F1_","_F2_","_FLD3_"^"_SUBFILEN3
 ......S ^TMP($J,FILEN3,FLD3)=X_"^"_FLDPATH
 Q
