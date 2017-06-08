VEJDDDR0 ; BLJ/DSS-Clones of Fileman calls; 04/15/1999  1:11 PM
 ;;2.11;VEJDCERT RPCS;;Mar 06, 2002
 ; This routine copyright 2000 by Document Storage Systems, Inc.  All rights reserved.
 Q 
 ; Call via linetags only
 ;
FIND(RESULT,FILE,IENS,FIELD,NUMBER,VALUE,INDEX,SCREEN,FLAGS) ; Lookup VEJDDDR
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
 N LOOP,FIELD1,LOOP1
 S (LOOP,FIELD1,LOOP1)=0
 S FIELD=$TR($G(FIELD),"^",";")
 S:FIELD="," FIELD=""
 K ^TMP("DIERR",$J)
 ;**MOD,AB/SD, 10/15/99, NEXT LINE COMMENTED OUT
 ;D FIND^DIC($G(FILE),$G(IENS),$G(FIELD),$G(FLAGS,"AM"),$G(VALUE),$G(NUMBER,"*"),$G(INDEX),$G(SCREEN),$G(IDENTIFY))
 ;**MOD,AB/SD, 10/15/99, NEXT 2 LINES AS PER NOISs SDC-0999-61114 & SDC-1099-61594
 I +$G(FILE)'=2 D FIND^DIC($G(FILE),$G(IENS),$G(FIELD),$G(FLAGS,"AM"),$G(VALUE),$G(NUMBER,"*"),$G(INDEX),$G(SCREEN),$G(IDENTIFY))
 E  I +$G(FILE)=2 D FIND^DIC($G(FILE),$G(IENS),$G(FIELD),$G(FLAGS,"AM"),$G(VALUE),$G(NUMBER,"*"),"B^BS^BS5^SSN",$G(SCREEN),$G(IDENTIFY))
 I $D(^TMP("DIERR",$J)) D
 .S ^TMP("VEJDDDR",$J,0)="-1^"_$G(^TMP("DIERR",$J,"1","PARAM",0))_"^"_$G(^(1))_"^"_$G(^("FILE"))
 .S ^TMP("VEJDDDR",$J,0)=$G(^TMP("VEJDDDR",$J,0))_"^"_$G(^TMP("DIERR",$J,"1","PARAM","IENS"))_"^"_$G(^TMP("DIERR",$J,"1","TEXT","1"))
 .K ^TMP("DILIST",$J)
 I '$D(^TMP("DIERR",$J))  D
 .S ^TMP("VEJDDDR",$J,0)=$G(^TMP("DILIST",$J,0))
 .I +$P(^TMP("DILIST",$J,0),U)>0 D
 ..F LOOP=1:1:+$P(^TMP("DILIST",$J,0),U) D
 ...S ^TMP("VEJDDDR",$J,LOOP)=$G(^TMP("DILIST",$J,2,LOOP))_U
 ...S LOOP1=1 F  S FIELD1=+$P($G(FIELD),";",LOOP1) Q:FIELD1=0  D
 ....S ^TMP("VEJDDDR",$J,LOOP)=$G(^TMP("VEJDDDR",$J,LOOP))_$G(^TMP("DILIST",$J,"ID",LOOP,FIELD1))_U,LOOP1=+LOOP1+1
 D CLEANUP
 K ^TMP("DILIST",$J)
 S RESULT=$NA(^TMP("VEJDDDR",$J))
 Q
GET(RESULT,FILE,IENS,FIELD,FLAGS) ; Get values for
 ; a particular file entry
 ;
 ; Input: FILE: File number
 ;        IENS: Internal entry number string
 ;        FIELD: Fields to get, in either ^ delimited format or ";"
 ;                  delimited format
 ;        FLAGS: Flags to control processing:
 ;                  "E": External format
 ;                  "I": Internal format
 ;                  "N": Do NOT return null VEJDDDRs
 ;                       (Do NOT use this, Jay, it will screw your
 ;                        stuff up completely.)
 ;                  "R": Resolves field numbers to field names
 ; Returns: Array with the following format:
 ;          FileNumber^IENS^FieldNumber^Data
 ;
 ; Restriction: At this point, this routine will NOT return multiple
 ;              levels of a file simultaneously.
 ;
 N LOOP,LOOP1,DATA,TYPE
 S RESULT=$NA(^TMP("VEJDDDR",$J))
 I FIELD["**" S ^TMP("VEJDDDR",$J,1)="-1^Getting submultiples not supported." Q
 S FIELD=$TR($G(FIELD),"^",";"),FLAGS=$G(FLAGS,"AM")
 D GETS^DIQ($G(FILE),$G(IENS),$G(FIELD),FLAGS,"^TMP(""VEJDDDR"",$J)")
 S LOOP="^TMP(""VEJDDDR"",$J)"
 F  S LOOP=$Q(@LOOP) Q:LOOP=""  Q:$QS(LOOP,1)'="VEJDDDR"  Q:$QS(LOOP,2)'=$J  D
 .S LOOP1=$P(LOOP,"(",2),LOOP1=$P(LOOP1,")")
 .S DATA=$G(@LOOP)
 .S TYPE=$P(LOOP1,",",7),TYPE=$S(TYPE["E":"E",1:"I")
 .S @LOOP=$P(LOOP1,",",3)_U_IENS_U_$P(LOOP1,",",6)_U_DATA_U_TYPE
 D CLEANUP
 Q
LIST(RESULT,FILE,IENS,FIELD,FLAGS,NUMBER,FROM,PARTIAL,INDEX,SCREEN,IDENTIFY) ; Gets list of values
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
 ;           File Number^Field Number^IEN^Text
 ;
 N FILE1,LOOP,LOOP1,DATA,ENTRY
 S FILE1=FILE
 D LIST^DIC($G(FILE),$G(IENS),$G(FIELD),$G(FLAGS),$G(NUMBER,"*"),$G(FROM),$G(PARTIAL),$G(INDEX),$G(SCREEN),$G(IDENTIFY),"^TMP(""VEJDDDR1"",$J)")
 S LOOP="^TMP(""VEJDDDR1"",$J,""DILIST"",""ID"")"
 F  S LOOP=$Q(@LOOP) Q:LOOP=""  Q:$QS(LOOP,1)'="VEJDDDR1"  Q:$QS(LOOP,2)'=$J  D
 .S LOOP1=$P(LOOP,"(",2),LOOP1=$P(LOOP1,")")
 .S DATA=$G(@LOOP)
 .S ENTRY=$P($G(LOOP1),",",5)
 .S @LOOP=FILE1_U_$G(^TMP("VEJDDDR1",$J,"DILIST",2,ENTRY))_U_$P(LOOP1,",",6)_U_DATA
 M ^TMP("VEJDDDR",$J)=^TMP("VEJDDDR1",$J,"DILIST","ID")
 S RESULT=$NA(^TMP("VEJDDDR",$J))
 K ^TMP("VEJDDDR1",$J)
 D CLEANUP
 Q
WP(RESULT,FILE,IENS,FIELD,FLAGS,DATA) ; Save a WP field
 ; Input : FILE: file number
 ;         IENS: IENS
 ;         FIELD: field number
 ;         FLAGS: Flags
 ;         DATA: Word processing text to be saved
 ; 
 ; Return: Successful save: "1^"
 ;       unsuccessful save: "-1^Error text"
 ;
 K DIERR,^TMP("DIERR",$J)
 D WP^DIE(FILE,IENS,FIELD,FLAGS,"DATA")
 I $D(DIERR) D MSG^DIALOG("AE",.RESULT) S RESULT(1)="-1^"_RESULT(1) D CLEANUP Q
 S RESULT(1)="1^"
 D CLEANUP
 Q
KILL(RESULT,FILE,IENS) ; Kill an entry in a file.  Copied from DIKC^DDR1
 ; Input: FILE: File number
 ;        IENS: IENS
 ;
 ; Return: Successful kill: "1^"
 ;         Unsuccessful kill: "-1^"
 ;
 N DIK,DA,FDA
 S FILE=$G(FILE)
 S IENS=$G(IENS)
 I $$FNO^DILIBF(FILE)=FILE,$L(IENS,",")=2 D  Q
 .S DIK=$G(^DIC(FILE,0,"GL")),DA=+IENS D ^DIK S RESULT(1)="1"_U
 .D CLEANUP
 S FDA(FILE,IENS,.01)="@"
 D FILE^DIE("","FDA")
 S RESULT(1)='$G(DIERR)_U
 D CLEANUP
 Q
UPDATE(RESULT,FILE,DATA) ; Add a new entry to a file
 ;
 D UPDATE1(.RESULT,FILE,"+1,",.DATA)
 Q
 ;
UPDATE1(RESULT,FILE,IENS,DATA) ; Add a new entry to a file or multiple
 ; Input: FILE : File number
 ;        DATA : Array of
 ;           ("Field number")=Data
 ;
 ; Return: RESULT: Successful Create="1^New Entry Number"
 ;                 unsuccessful Create="-1^Error Message"
 ;
 K ^TMP("VEJDDDR",$J),IENS1
 M ^TMP("VEJDDDR",$J,FILE,$G(IENS,"+1,"))=DATA
 D UPDATE^DIE("","^TMP(""VEJDDDR"",$J)","IENS1")
 I '$D(DIERR) S RESULT(1)="1^"_$G(IENS1(1)) D CLEANUP Q
 D MSG^DIALOG("AE",.RESULT) S RESULT(1)="-1^"_$G(RESULT(1))
 D CLEANUP
 Q
FILE(RESULT,FILE,IENS,FLAGS,DATA) ; Update current entry in file
 ;
 ; Input: FILE: File number
 ;        IENS: IENS of entry
 ;        DATA: Array in
 ;            "(FieldNumber)"="Data"
 ;
 ; Return: Successful file: 1^
 ;       Unsuccessful file: -1^error message
 ;
 K ^TMP("VEJDDDR",$J),DIERR
 M ^TMP("VEJDDDR",$J,FILE,IENS)=DATA
 D FILE^DIE($G(FLAGS,"KE"),"^TMP(""VEJDDDR"",$J)")
 I $D(DIERR) D 
 .D MSG^DIALOG("AE",.RESULT)
 .S RESULT(1)="-1^"_$G(RESULT(1)) D CLEANUP Q
 S RESULT(1)="1^"
 D CLEANUP
 Q
CLEANUP ;
 D CLEAN^DILF
