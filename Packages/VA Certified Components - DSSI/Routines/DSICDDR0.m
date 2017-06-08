DSICDDR0 ; BLJ/DSS-Clones of Fileman calls ;11/29/2004 16:16
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  -----------------------
 ;  2051  ^DIC:  FIND, LIST
 ;  2056  GETS^DIQ
 ;  2053  ^DIE:  FILE, UPDATE, WP
 ;  2050  MSG^DIALOG
 ;
FILE(DSICP,FILE,IENS,FLAGS,DATA) ; rpc: DSIC DDR FILER
 ; DO NOT USE AFTER 11/21/2002 - use FILE^DSICFM04
 ;    DSICFM04 input format is different
 ;
 ; Input: FILE: File number
 ;        IENS: IENS of entry
 ;        DATA: Array in
 ;            "(FieldNumber)"="Data"
 ;
 ; Return: Successful file: 1^
 ;       Unsuccessful file: -1^error message
 ;
 N X,Y,Z,DSIN
 S Y=0,Z=$G(FLAGS),Z=$S(FLAGS["E":"E",1:"")
 F X=0:0 S X=$O(DATA(X)) Q:'X  S Y=Y+1,DSIN(Y)=X_U_Z_U_DATA(X)
 S FLAGS=$S(FLAGS["T":"T",1:"")
 D FILE^DSICFM04(.DSICP,$G(FILE),$G(IENS),FLAGS,.DSIN)
 G CLEANUP
 ;
FIND(DSICP,FILE,IENS,FIELD,NUMBER,VALUE,INDEX,SCREEN,FLAGS) ;
 ; RPC: DSIC DDR FINDER
 ;
 ; Input: FILE: File number
 ;        IENS: IENS in file
 ;        FIELD: ^ delimited (or ";" delimited) list of field
 ;                  numbers to retrieve
 ;        NUMBER:  Number of entries to retrieve (defaults to all)
 ;        VALUE:  Value to find
 ;        INDEX: Indexes to search on
 ;        SCREEN: Screening code
 ;        FLAGS: FileMan Flags
 ;
 ; Returns: Array in the following format:
 ;       Array[0]=Number found^Number requested^Any more?
 ;       Array[1]-[n]=IEN^Result fields in same order as listed in
 ;                    FIELD
 ;
 ; Restriction: If a null ^ delimited piece exists in FIELD, any
 ;              fields requested after that null field will not be
 ;              returned.
 ;
 N X,Y,Z,FLD,L,L1,SEQ
 D INIT("FIND")
 S:FIELD="," FIELD=""
 S:FLAGS="" FLAGS="AM"
 S:NUMBER="" NUMBER="*"
 S:FILE=2 INDEX="B^BS^BS5^SSN"
 K ^TMP("DSIC",$J)
 ;  NOIS: SDC-0999-61114 & SDC-1099-61594
 D FIND^DIC(FILE,IENS,FIELD,FLAGS,VALUE,NUMBER,INDEX,SCREEN)
 I $D(^TMP("DIERR",$J)) D
 .K X M X=^TMP("DIERR",$J,1,"PARAM")
 .S Y=$G(X(0))_U_$G(X(1))_U_$G(X("FILE"))_U_$G(X("IENS"))_U
 .S ^TMP("DSIC",$J,0)="-1^"_Y_$G(^TMP("DIERR",$J,"1","TEXT","1"))
 .K ^TMP("DILIST",$J)
 .Q
 I $D(^TMP("DILIST",$J)) D
 .S ^TMP("DSIC",$J,0)=$G(^TMP("DILIST",$J,0))
 .S SEQ=0
 .F  S SEQ=$O(^TMP("DILIST",$J,2,SEQ)) Q:'SEQ  S X=^(SEQ)_U D
 ..F L=1:1 S FLD=+$P(FIELD,";",L) Q:FLD=0  D
 ...S $P(X,U,L+1)=$G(^TMP("DILIST",$J,"ID",SEQ,FLD))
 ...Q
 ..S ^TMP("DSIC",$J,SEQ)=X
 ..Q
 .Q
 K ^TMP("DILIST",$J) S DSICP=$NA(^TMP("DSIC",$J))
 G CLEANUP
 ;
GET(DSICP,FILE,IENS,FIELD,FLAGS) ; RPC: DSIC DDR GETS ENTRY DATA
 ;  FILE = File number
 ;  IENS = Internal entry number string
 ; FIELD = Field numbers delimited by either ^ or ;
 ; FLAGS = Flags to control processing:
 ;         [ E = External format - default
 ;         [ I = Internal format
 ;         [ N = Do NOT return null field values
 ;               (not to be used by DSS)
 ;         [ R = Resolves field numbers to field names
 ;   If FLAGS="W" then expecting a single word processing field
 ;
 ; Return: Array with the following format:
 ;         @DSICP@(n) = FileNumber^IENS^FieldNumber^Data^I or E
 ;
 ; Restriction: At this point, this routine will NOT return multiple
 ;              levels of a file simultaneously.
 ;
 N L,X,Y,Z,DATA,ROOT,STOP,SUB,TYPE
 K ^TMP("DSIC",$J),^TMP("DSIC1",$J) S DSICP=$NA(^TMP("DSIC",$J))
 D INIT("GET")
 I FIELD["**" S @DSICP@(1)="-1^Getting submultiples not supported." Q
 S:FLAGS="" FLAGS="E"
 S X="-1^Only a single field number allowed with the W flag"
 I FLAGS="W",FIELD'=+FIELD S @DSICP@(1)=X Q
 S X="-1^The W flag must be used by itself"
 I FLAGS["W",FLAGS'="W" S @DSICP@(1)=X Q
 I FLAGS="W" S FLAGS=""
 D GETS^DIQ(FILE,IENS,FIELD,FLAGS,$NA(^TMP("DSIC1",$J)))
 S SUB=0,(ROOT,STOP)=$NA(^TMP("DSIC1",$J)),$E(STOP,$L(STOP))=","
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  D
 .S DATA=@ROOT,Y=$QL(ROOT)
 .S FILE=$QS(ROOT,3),FIELD=$QS(ROOT,5),X=$QS(ROOT,Y)
 .;  check for WP data
 .I FLAGS="" S:X=+X&(Y=6) SUB=SUB+1,@DSICP@(SUB)=DATA Q
 .Q:DATA[U  S:+X=X X="E"
 .S SUB=SUB+1,Z=FILE_U_IENS_U_FIELD_U
 .S L=$L(Z)+$L(DATA) I L<250 S Z=Z_DATA
 .I L>249 S Z=Z_$E(DATA,1,249-L)_"..."
 .S:DATA'="" Z=Z_U_X
 .S @DSICP@(SUB)=Z
 .Q
 I '$D(@DSICP) S @DSICP@(1)="-1^No data retrieved"
 K ^TMP("DSIC1",$J)
 G CLEANUP
 ;
KILL(DSICP,FILE,IENS) ; RPC: DSIC DDR DELETE ENTRY
 ; Input: FILE: File number
 ;        IENS: IENS
 ;
 ; Return: Successful kill: 1^
 ;         Unsuccessful kill: 0^message
 ;
 N X,FDA
 D INIT("KILL")
 S FDA(FILE,IENS,.01)="@"
 D FILE^DIE("","FDA")
 S X=$$MSG S:X<0 X="0^"_$P(X,U,2) S DSICP(1)=X
 G CLEANUP
 ;
LIST(DSICP,FILE,IENS,FIELD,FLAGS,NUMBER,FROM,PARTIAL,INDEX,SCREEN,IDENTIFY) ;
 ; RPC: DISC DDR LISTER
 ; INPUT : FILE : File Number
 ;         IENS : IENS of file if subfile list is requested.
 ;         FIELD : ';' delimited list of fields requested.
 ;         FLAGS : Flags ('B' or 'I')
 ;         NUMBER  : Maximum number of entries to return
 ;         FROM : Entry to start listing from
 ;         PARTIAL : Partial entry to match
 ;         INDEX : Cross-references to search
 ;         SCREEN : Screen
 ;         IDENTIFY : Identifier
 ;
 ; RETURN: Global Array
 ;         If successful, return array will be in the following order:
 ;           File Number^IEN^Field Number^Text
 ;
 N X,Y,DATA,FLD,ROOT,SEQ,STOP,TMP
 S DSICP=$NA(^TMP("DSIC",$J))
 S ROOT=$NA(^TMP("DSIC1",$J))
 K @DSICP,@ROOT
 D INIT("LIST")
 S:NUMBER="" NUMBER="*"
 D LIST^DIC(FILE,IENS,FIELD,FLAGS,NUMBER,FROM,PARTIAL,INDEX,SCREEN,IDENTIFY,ROOT)
 S TMP=$NA(^TMP("DSIC1",$J,"DILIST","ID")),STOP=$P(TMP,")")
 F  S TMP=$Q(@TMP) Q:TMP'[STOP  D
 .S DATA=@TMP,SEQ=$QS(TMP,5),FLD=$QS(TMP,6)
 .S X=$G(^TMP("DSIC1",$J,"DILIST",2,SEQ))
 .S ^TMP("DSIC",$J,SEQ,FLD)=FILE_U_X_U_FLD_U_DATA
 K ^TMP("DSIC1",$J)
 G CLEANUP
 ;
UPDATE(DSICP,FILE,DATA) ; RPC: DSIC DDR UPDATE FILE
 N IENS G U1
 ;
UPDATE1(DSICP,FILE,IENS,DATA) ; RPC: DSIC DDR UPDATE SUBFILE
 ; Input: FILE : File number
 ;        DATA : Array of
 ;           ("Field number")=Data
 ;
 ; Return: DSICP: Successful Create="1^New Entry Number"
 ;                 unsuccessful Create="-1^Error Message"
 ;
U1 N X,FDA,IENS1
 D INIT("UPDATE")
 S:IENS="" IENS="+1,"
 M FDA(FILE,IENS)=DATA K DATA
 D UPDATE^DIE("","FDA","IENS1")
 S X=$$MSG S:X>0 X=X_$G(IENS1(1)) S DSICP(1)=X
 G CLEANUP
 ;
WP(DSICP,FILE,IENS,FIELD,FLAGS,DSICD) ; RPC: DSIC DDR WP FILER
 ; Input : FILE: file number
 ;         IENS: IENS
 ;         FIELD: field number
 ;         FLAGS: Flags
 ;         DSICD: Word processing text to be saved
 ;                If DSICD="@", delete the wp field data
 ; 
 ; Return: Successful save: "1^"
 ;       unsuccessful save: "-1^Error text"
 ;
 N X,Y D INIT("WP") S X=$S($G(DSICD)="@":"@",1:"DSICD")
 D WP^DIE(FILE,IENS,FIELD,FLAGS,X)
 S DSICP(1)=$$MSG
 G CLEANUP
 ;
CLEANUP D CLEAN^DILF Q
 ;
INIT(F) ;  initialize fm input variables
 D CLEANUP Q:$G(F)=""
 S FILE=$G(FILE)
 S IENS=$G(IENS)
 I IENS'="",$E(IENS,$L(IENS))'="," S IENS=IENS_","
 I "FIND^GET^LIST^WP^"[F S FIELD=$TR($G(FIELD),U,";")
 I "FIND^LIST^"[F S NUMBER=$G(NUMBER)
 I "FIND^"[F S VALUE=$G(VALUE)
 I "FIND^LIST^"[F S INDEX=$G(INDEX)
 I "FIND^LIST^"[F S SCREEN=$G(SCREEN)
 I "FIND^GET^LIST^WP^FILE^"[F S FLAGS=$G(FLAGS)
 I "LIST^"[F S FROM=$G(FROM)
 I "LIST^"[F S PARTIAL=$G(PARTIAL)
 I "LIST^"[F S IDENTIFY=$G(IDENTIFY)
 Q
 ;
MSG() ;  return old Brian's error message
 I '$D(DIERR) Q "1^"
 N MSG D MSG^DIALOG("AE",.MSG)
 Q "-1^"_MSG(1)
