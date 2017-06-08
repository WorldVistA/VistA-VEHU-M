VEJDDDR3 ; BLJ/DSS ;07/18/2000 22:17
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 Q
 ; ONLY CALL VIA LINETAGS
FILE(RETURN,FILE,IENS,DATA) ;
 ; INPUT : FILE=File number
 ;         IENS=IENS of entry.  If lowest level of IENS contains a +,
 ;              an attempt to add a new entry is assumed
 ;         DATA=Array of
 ;              "(field number)=data"
 ;
 ; RETURN : 1^IEN if succesful
 ;          -1^Error message if not successful
 D CLEANUP
 I $D(DATA) M ^TMP("VEJDDDR",$J,FILE,IENS)=DATA
 I $P(IENS,",")["+" D
 . D UPDATE^DIE("E","^TMP(""VEJDDDR"",$J)","IENS1")
 . I '$D(DIERR) S RETURN(1)="1^"_$G(IENS1(1)) Q
 . D MSG^DIALOG("AE",.RETURN) S RETURN(1)="-1^"_$G(RETURN(1))
 I $P(IENS,",")'["+" D
 . D FILE^DIE("KE","^TMP(""VEJDDDR"",$J)","DIERR")
 . I '$D(DIERR) S RETURN(1)="1^"_$P($G(IENS),",") Q
 . D MSG^DIALOG("AE",.RETURN) S RETURN(1)="-1^"_$G(RETURN(1))
 D CLEANUP
 Q
 ;
LIST(RETURN,FILE,IENS,STARTIEN,NUMBER,FIELDS) ;
 ;
 D CLEANUP
 N FROM,LOOP,LOOP1,DATA,ENTRY
 S FROM("IEN")=STARTIEN
 D LIST^DIC(FILE,$G(IENS),$G(FIELDS),"",$G(NUMBER,"*"),$G(FROM),"","","","","^TMP(""VEJDDDR1"",$J)")
 S LOOP="^TMP(""VEJDDDR1"",$J,""DILIST"",""ID"")"
 F  S LOOP=$Q(@LOOP) Q:LOOP=""  Q:$QS(LOOP,2)'=$J  Q:$QS(LOOP,1)'="VEJDDDR1"  D
 .S LOOP1=$P(LOOP,"(",2),LOOP1=$P(LOOP1,")")
 .S DATA=$G(@LOOP)
 .S ENTRY=$P($G(LOOP1),",",5)
 .S @LOOP=$G(^TMP("VEJDDDR1",$J,"DILIST",2,ENTRY))_U_$P(LOOP1,",",6)_U_DATA
 M ^TMP("VEJDDDR",$J)=^TMP("VEJDDDR1",$J,"DILIST","ID")
 S ^TMP("VEJDDDR",$J,0.5)=$G(^TMP("VEJDDDR1",$J,"DILIST",0))
 K ^TMP("VEJDDDR1",$J)
 S RETURN=$NA(^TMP("VEJDDDR",$J))
 Q
DELETE(RETURN,FILE1,IENS1) ; Kill an entry in a file.  Copied from DIKC^DDR1
 ; Input: FILE: File number
 ;        IENS: IENS
 ;
 ; Return: Successful kill: "1^"
 ;         Unsuccessful kill: "-1^"
 ;
 N DIK,DA,FILE,IENS,FDA
 S FILE=$G(FILE1)
 S IENS=$G(IENS1)
 I $$FNO^DILIBF(FILE)=FILE,$L(IENS,",")=2 D  Q
 .S DIK=$G(^DIC(FILE,0,"GL")),DA=+IENS D ^DIK S RETURN(1)="1"_U
 S FDA(FILE,IENS,.01)="@"
 D FILE^DIE("","FDA")
 S RETURN(1)='$G(DIERR)_U
 Q
WP(RETURN,FILE,IENS,FIELD,FLAG,DATA) ; Save a WP field
 ; Input : FILE: file number
 ;         IENS: IENS
 ;         FIELD: field number
 ;         FLAG: Flags
 ;         DATA: Word processing text to be saved
 ; 
 ; Return: Successful save: "1^"
 ;       Unsuccessful save: "-1^Error text"
 ;
 D CLEANUP
 D WP^DIE(FILE,IENS,FIELD,FLAG,"DATA")
 I '$D(DIERR)  S RETURN(1)="1^" D CLEANUP Q
 D MSG^DIALOG("AE",.RETURN) S RETURN(1)="-1^"_RETURN(1) D CLEANUP
 Q 
VALIDATE(RETURN,FILE,IENS,FIELD,DATA) ; Validate data
 N ERROR
 K ^TMP("VEJDERR",$J)
 D VAL^DIE(FILE,IENS,FIELD,"FH",DATA,.RETURN,"^TMP(""VEJDVAL"",$J)")
 I RETURN="^" D  Q
 . D MSG^DIALOG("AE",.RETURN)
 . S RETURN(1)="-1^"_RETURN(1)
 . D CLEANUP
 S RETURN(1)="1^"_$G(RETURN) D CLEANUP
 Q
FILEFDA(RETURN) ; File FDA
 N IENS,FILE
 M ^TMP("VEJDDDR",$J)=^TMP("VEJDVAL",$J)
 S FILE=$O(^TMP("VEJDVAL",$J,0)),IENS=$O(^TMP("VEJDVAL",$J,FILE,0))
 I $P(IENS,",")["+" D
 . D UPDATE^DIE("","^TMP(""VEJDDDR"",$J)","IENS1")
 . I '$D(DIERR) S RETURN(1)="1^"_$G(IENS1(1)) Q
 . D MSG^DIALOG("AE",.RETURN) S RETURN(1)="-1^"_$G(RETURN(1))
 I $P(IENS,",")'["+" D
 . D FILE^DIE("K","^TMP(""VEJDDDR"",$J)","DIERR")
 . I '$D(DIERR) S RETURN(1)="1^"_$P($G(IENS),",") Q
 . D MSG^DIALOG("AE",.RETURN) S RETURN(1)="-1^"_$G(RETURN(1))
 D CLEANUP
 I $P($G(RETURN(1)),U)'="-1" K ^TMP("VEJDVAL",$J)
 Q
CLEANUP1(RETURN,TOTAL) ; Do cleanup stuff
CLEANUP ;
 D CLEAN^DILF
 K ^TMP("VEJDDDR",$J),IENS1
 K:$G(TOTAL) ^TMP("VEJDVAL",$J)
 S RETURN(1)="1^"
 Q
GETPARMS(RETURN,RPCCALL) ; Gets the parameter listing from an RPCBroker call.
 ;
 ; INPUT: RPCCALL: Name of an RPC Broker call from file 8994
 ;
 ; RETURN: Array of parameters for call in the form:
 ;   [PARAMETERS]
 ;   PARAMETER1=FOO
 ;   PARAMETER2=BAR
 ;
 N IEN,TAG,ROUTINE,RESULT,PARMLIST,PARMLST1,LOOPCNT
 D CLEAN^DILF
 K ^TMP("DILIST",$J)
 S RETURN(0)="[PARAMETERS]"
 D FIND^DIC(8994,,".01","MX",RPCCALL,"1")
 I $P($G(^TMP("DILIST",$J,0)),U)'="1" S RETURN(2)="PARAMETER1=ERROR IN LOOKUP" Q
 S IEN=$G(^TMP("DILIST",$J,2,1))
 K ^TMP("DILIST",$J)
 D GETS^DIQ(8994,IEN_",",".02;.03","E","RESULT")
 S TAG=$G(RESULT("8994",IEN_",",".02","E"))
 S ROUTINE=$G(RESULT("8994",IEN_",",".03","E"))
 S PARMLIST=$TEXT(@(TAG_"^"_ROUTINE))
 ; Now that we have the parameters, we need to parse them out properly.
 ; First, we get rid of everything outside the parentheses
 S PARMLIST=$P($G(PARMLIST),"(",2),PARMLIST=$P($G(PARMLIST),")")
 ; Now lets stuff the parameters in the array.
 D PARMS1(PARMLIST,.RETURN,"1")
 K RETURN(1)
 Q
PARMS1(PARAMS,PARAMS1,LOOPCNT) ; Pieces out parameters
 Q
LIST1(RETURN,FILE,IENS,STARTIEN,NUMBER,FIELDS) ;
 ; Test routine to try translating external to internal dates.
 ;
 D CLEANUP
 N FROM,LOOP,LOOP1,DATA,ENTRY,DATEFLDS,LOOP2,DATA1,LOOP3
 S DATA1="",LOOP2=1,LOOP3=.99999999
 F  S DATA1=$P(FIELDS,";",LOOP2)  Q:DATA1=""  D
 . ; We need to figger out which fields contain dates so we can deal with 'em later.
 . S:$P($G(^DD(FILE,DATA1,0)),"^",2)["D" DATEFLDS(DATA1)=""
 . S LOOP2=+LOOP2+1
 S FROM("IEN")=STARTIEN
 D LIST^DIC(FILE,$G(IENS),$G(FIELDS),"",$G(NUMBER,"*"),$G(FROM),"","","","","^TMP(""VEJDDDR1"",$J)")
 S LOOP="^TMP(""VEJDDDR1"",$J,""DILIST"",""ID"")"
 F  S LOOP=$Q(@LOOP) Q:LOOP=""  Q:$QS(LOOP,2)'=$J  D
 .S LOOP1=$P(LOOP,"(",2),LOOP1=$P(LOOP1,")")
 .S DATA=$G(@LOOP)
 .S ENTRY=$P($G(LOOP1),",",5)
 .S @LOOP=$G(^TMP("VEJDDDR1",$J,"DILIST",2,ENTRY))_U_$P(LOOP1,",",6)_U_DATA
 M ^TMP("VEJDDDR",$J)=^TMP("VEJDDDR1",$J,"DILIST","ID")
 S ^TMP("VEJDDDR",$J,0.5)=$G(^TMP("VEJDDDR1",$J,"DILIST",0))
 S DATA1=""
 F  S DATA1=$O(DATEFLDS(DATA1)) Q:DATA1=""  D
 . F  S LOOP3=$O(^TMP("VEJDDDR",$J,LOOP3))  Q:LOOP3=""  D
 . . S $P(^TMP("VEJDDDR",$J,LOOP3,DATA1),"^",3)=$$CONVTIME($P(^TMP("VEJDDDR",$J,LOOP3,DATA1),"^",3))
 K ^TMP("VEJDDDR1",$J)
 S RETURN=$NA(^TMP("VEJDDDR",$J))
 Q
CONVTIME(EXTDT) ;
 S %DT="TS",X=EXTDT D ^%DT Q Y
DATECONV(RETURN,EXTDATE) ;
 ; INPUT: EXTDATE: Date (time is optional) in external format
 ;
 ; RETURN: RETURN: Date/time in Fileman internal DateTime format
 S RETURN=$$CONVTIME(EXTDATE)
 Q
