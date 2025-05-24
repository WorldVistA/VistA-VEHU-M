XUPKILOG ; OAK/JEL - Kernel PKI Logging ; Nov 19, 2024@18:29:06
 ;;8.0;KERNEL;**817**;Oct 28, 2024;Build 21
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
DEFDIR() ; Extrinsic subroutine
 ; Gets the default hfs directory and checks to see if the path ends with a 
 ; trailing slash. If no trailing slash is present then append one at the end 
 ; of the path
 ; 
 ; Input:    void
 ;
 ; Output:   string default hfs directory
 ;
 N DIR S DIR=$$DEFDIR^%ZISH
 I $E(DIR,$L(DIR))'="/" S DIR=DIR_"/"
 ; if the hfs directory does not exist then we may be on a VDIF system; use tmp directory
 I ##class(%File).DirectoryExists(DIR)=0 S DIR="/tmp/"
 ; if the hfs directory is not writable then we may be on a VDIF system; use tmp directory
 I ##class(%File).Writeable(DIR)=0 S DIR="/tmp/" D  Q:DIR="" ""
 . ; check to see if tmp directory is writable
 . I ##class(%File).Writeable(DIR)=0 D
 . . ; if it is still not writeable then log an error and quit
 . . S MSG="XU PKI SECURITY ERROR: Unable to find an accessible read/write directory"
 . . D APPERROR^%ZTER(MSG) S DIR=""
 Q DIR
CAFILE() ; Extrinsic subroutine
 ; Checks to see if the certificate authorities file is available. If the file does
 ; NOT exist then create the file so that SAML tokens can pass digital signature 
 ; validation. Why do this? Most likely we won't have a trust store configured in 
 ; all production VistA systems by the time this patch is released.
 ;
 ; Input:    void
 ;
 ; Output:   string denoting the full path to the certificate authority file
 ;           otherwise an empty string if it fails to write the file
 ;
 ; ZEXCEPT: %File
 N MSG,HANDLE,PATH,FILENAME,POP,IO
 S HANDLE="XU817",PATH=$$DEFDIR,FILENAME=$NAMESPACE_"_xu_817_ca_chain.pem" Q:$G(PATH)="" ""
 ; check to see if the ca file exists
 I ##class(%File).Exists(PATH_FILENAME) Q PATH_FILENAME
 ; if the file does not exist then lets prepare to write the file out
 ; acquire a lock to prevent concurrent writes to the same file
 L +^TMP(FILENAME):15
 ; if we fail to acquire a lock then log the error and quit
 I '$TEST D  Q ""
 . S MSG="XU PKI SECURITY ERROR: Unable to acquire a concurrency lock; check LOCKTAB for ^TMP("_FILENAME_")"
 . D APPERROR^%ZTER(MSG)
 ; concurrency check - did another job write the file already?
 I ##class(%File).Exists(PATH_FILENAME) L -^TMP(FILENAME) Q PATH_FILENAME
 ; open the file for writing
 D OPEN^%ZISH(HANDLE,PATH,FILENAME,"W")
 I POP>0 D  Q ""
 . L -^TMP(FILENAME)
 . S MSG="XU PKI SECURITY ERROR: Unable to create certificate authority file"
 . D APPERROR^%ZTER(MSG)
 . D CLOSE^%ZISH(HANDLE)
 ; by default use PROD certificate authority. if not PROD then use NOTPROD CAs
 N CA S CA="PROD+XXX^XUPKICA" I $$PROD^XUPROD=0 S CA="NOTPROD+XXX^XUPKICA1"
 ; write the file
 U IO
 F I=1:1:2000 D  Q:MSG="STOP"
 . N CAA S CAA=$REPLACE(CA,"XXX",I)
 . S MSG=$TEXT(@CAA),MSG=$P(MSG,";;",2) Q:MSG="STOP"
 . W MSG,!
 D CLOSE^%ZISH(HANDLE)
 L -^TMP(FILENAME)
 Q PATH_FILENAME
 ;
NOW() ; Extrinsic subroutine
 ; Get the current date/time in ISO8601 format
 ;
 ; Input:    void
 ;
 ; Output:   string that represents the current date/time in ISO8601 format
 ;
 ; ZEXCEPT: $ZDATETIME ; no kernel api for ISO8601
 Q $ZDATETIME($H,3,5)
LOG() ; Extrinsic subroutine
 ; Check the KERNEL SYSTEM PARAMETERS to see if the modified SAML tokens should
 ; be logged in the KERNEL PKI LOGS file. If this parameter is NOT configured
 ; then logging will be enabled.
 ;
 ; Input:    void
 ;
 ; Output:   bool = 1 for true, logging enabled. 0 for false, logging disabled.
 ;
 N LOG S LOG=$P($G(^XTV(8989.3,1,"PKI")),"^",1)
 I LOG="" Q 1
 Q LOG
GETSAML(DOC,XUMSAML) ; Subroutine
 ; The SAML token is broken up into chunks; this subroutine rejoins the chunks and then
 ; base64 encodes the SAML token to ensure data integrity
 ;
 ; Input:    DOC     = A string that is a closed reference to a global root containing 
 ;                       the XML document
 ;           XUMSAML = Pass by reference; the modified SAML token flag
 ;
 ; Output:   void; modifies XUMSAML through pass by reference
 ;
 N CDOC,QDOC S QDOC=DOC F  D  Q:$$STARTSWITH(QDOC,DOC)'=1
 . S QDOC=$Q(@QDOC) I $$STARTSWITH(QDOC,DOC)'=1 Q
 . S CDOC=$G(CDOC)_$G(@QDOC)
 S XUMSAML("SAML_TOKEN")=$$B64ENCD^XUSHSH($G(CDOC))
 Q
STARTSWITH(THIS,THAT) ; Extrinsic subroutine
 ; Performs a subscript comparison which askes, does THIS value start with THAT?
 ; Examples:
 ;   1) does (this) ^CHRISU(1,2,3) start with (that) ^CHRISU(1,2)? Yes
 ;   2) does (this) ^CHRISU(1,2,3) start with (that) ^XYZ(1,2)? No
 ;
 ; Input:    THIS    = A $NA formatted global string to compare
 ;           THAT    = A $NA formatted global string to compare
 ;
 ; Output:   -1 on error
 ;            0 when it does not start with THIS
 ;            1 when THIS does start with THAT
 ; 
 I ($G(THIS)="")!($G(THAT)="") Q -1
 N LENGTH S LENGTH=$QL(THAT) I $QL(THIS)<LENGTH S LENGTH=$QL(THIS)
 N RV S RV=-1 N I F I=0:1:LENGTH D  I RV=0 Q
 . I $QS(THAT,I)'=$QS(THIS,I) S RV=0 Q
 . S RV=1
 Q RV
GETUSER(XUMSAML) ; Subroutine
 ; Gets the user detail information from the given SAML token
 ; 
 ; Input:   XUMSAML = Pass by reference; the modified SAML token flag
 ;
 ; Output:  void; modifies XUMSAML through pass by reference
 ;
 S XUMSAML("SECID")=$G(^TMP("XUSAML",$J,"Name","urn:va:vrm:iam:secid"))
 S XUMSAML("FIRST_NAME")=$G(^TMP("XUSAML",$J,"Name","urn:va:vrm:iam:firstname"))
 S XUMSAML("LAST_NAME")=$G(^TMP("XUSAML",$J,"Name","urn:va:vrm:iam:lastname"))
 S XUMSAML("AUTHN")=$G(^TMP("XUSAML",$J,"Name","authnsystem"))
 ; if the user is coming through the rpc broker then get the ip address
 I $D(XWBOS) D GETIP(.XUMSAML) S XUMSAML("LOGIN_METHOD")="R"
 E  D
 . ; if the user is coming through the role and scroll then get the ip address
 . I $D(XQXFLG("GUI")) D GETSSHIP(.XUMSAML) S XUMSAML("LOGIN_METHOD")="S"
 Q
GETSSHIP(XUMSAML) ; Subroutine
 ; Gets the ip address of the client and server using the SSH_CONNECTION
 ; environment variable.
 ;
 ; Input:   XUMSAML = Pass by reference; the modified SAML token flag
 ;
 ; Output:  void; modifies XUMSAML through pass by reference
 ;
 N SSH S SSH=$SYSTEM.Util.GetEnviron("SSH_CONNECTION")
 S XUMSAML("SERVER_IP")=$P(SSH," ",3)_":"_$P(SSH," ",4)
 S XUMSAML("CLIENT_IP")=$P(SSH," ",1)_":"_$P(SSH," ",2)
 Q
GETIP(XUMSAML) ; Subroutine
 ; Gets the ip address of the client and server using the Linux tool lsof.
 ; Why implement this? ZIO^%ZIS4 - gets the ip address of the client only. 
 ; It does NOT provide detailed information of the server ip address or
 ; port which served the connection. This information is useful to triage
 ; any VistA systems with multiple nodes.
 ;
 ; Input:   XUMSAML = Pass by reference; the modified SAML token flag
 ;
 ; Output:  void; modifies XUMSAML through pass by reference
 ;
 ; ZEXCEPT: $ZF,$ZDATETIME
 N PWD S PWD=$$DEFDIR I PWD="" D  Q
 . S XUMSAML("SERVER_IP")="UNKNOWN"
 . N XINETDIP S XINETDIP=$SYSTEM.Util.GetEnviron("REMOTE_HOST")
 . S XUMSAML("CLIENT_IP")=$G(XINETDIP,"UNKNOWN")
 ; predefine the file name used
 N FILE S FILE=$NAMESPACE_"_"_$ZDATETIME($H,-2)_"_"_$J_".nio"
 ; use the linux tool lsof to identify the ip address of the client and server
 ; why $zf(-100)? no kernel api available to get the ip address of client and server
 D $ZF(-100,"/SHELL /NOQUOTE","lsof","-n", "-P", "-iTCP", "-sTCP:ESTABLISHED", "-a", "-p"_$J, "2>&1", "|", "awk", "'{print $9}'", "|", "uniq", "|", "sed '1,2d'", "&>", PWD_FILE)
 ; working linux lsof to get ip address information since xinetd doesnt support expose it
 ; sh-4.4$ lsof -nP -iTCP -a -sTCP:ESTABLISHED | awk '{print $9}' | uniq | sed '1d'
 ; ---
 ; open the file for reading
 N POP,IO,HANDLE S HANDLE="ip"_$J
 D OPEN^%ZISH(HANDLE,PWD,FILE,"R")
 ; read the file
 N IPSTRING,X
 I POP=0 D
 . I $G(DTIME)="" N DTIME S DTIME=5
 . U IO F I=1:1 R X:DTIME Q:$$STATUS^%ZISH  S IPSTRING=$G(X,"")
 . ; close the file
 . D CLOSE^%ZISH(HANDLE)
 ; delete the file
 N DELETEME,Y S DELETEME(FILE)=""
 S Y=$$DEL^%ZISH(PWD,$NA(DELETEME))
 ; if the ipstring does not contain an ip address in the expected format then 
 ; fail back and use what's defined in xinetd
 I ($G(IPSTRING)="")!($G(IPSTRING)'["->") D 
 . ; get the ip address as defined by xinetd linux environment variable
 . N XINETDIP S XINETDIP=$SYSTEM.Util.GetEnviron("REMOTE_HOST")
 . S IPSTRING="UNKNOWN->"_$G(XINETDIP,"UNKNOWN")
 ; set the server and client
 N SERVERIP,CLIENTIP
 S SERVERIP=$P(IPSTRING,"->",1),CLIENTIP=$P(IPSTRING,"->",2)
 S SERVERIP=$E(SERVERIP,1,50),CLIENTIP=$E(CLIENTIP,1,50)
 S XUMSAML("SERVER_IP")=SERVERIP,XUMSAML("CLIENT_IP")=CLIENTIP
 Q
INSERT(XUMSAML) ; Subroutine
 ; Insert the information related to the modified SAML token into the database.
 ;
 ; Input:   XUMSAML = Pass by reference; the modified SAML token flag
 ;
 ; Output:  void; modifies XUMSAML through pass by reference
 ;
 N FDA,ERRORS,IENS,$ETRAP,MSG
 ; on trapped error, silently log the error and move on...
 S $ETRAP="D LOGERR",MSG=""
 ; lookup existing log entry for today
 N DINDEX S DINDEX(1)=$G(XUMSAML("SECID")),DINDEX(2)=$P($$NOW,"T",1)
 S IENS=$$FIND1^DIC(6.666,"","X",.DINDEX,"D","","ERRORS")
 I IENS>0 S XUMSAML("LOGIEN")=IENS D UPDATE(IENS) Q
 S FDA(6.666,"+1,",.01)="NOW" ; date/time now
 S FDA(6.666,"+1,",10)=$G(XUMSAML("SECID"))
 S FDA(6.666,"+1,",11)=$G(XUMSAML("FIRST_NAME"))
 S FDA(6.666,"+1,",12)=$G(XUMSAML("LAST_NAME"))
 ; sha256 hash of the saml token
 S FDA(6.666,"+1,",20.5)=$$SHAHASH^XUSHSH(256,XUMSAML("SAML_TOKEN"),"H")
 S FDA(6.666,"+1,",21)=$G(XUMSAML("ERROR_API"))
 S FDA(6.666,"+1,",22)=$G(XUMSAML("ERROR_RSA"))
 S FDA(6.666,"+1,",23)=$G(XUMSAML("OTHER_MSG"))
 ; client and server ip and port
 S FDA(6.666,"+1,",31)=$G(XUMSAML("CLIENT_IP"))
 S FDA(6.666,"+1,",32)=$G(XUMSAML("SERVER_IP"))
 S FDA(6.666,"+1,",33)=$G(XUMSAML("LOGIN_METHOD"))
 S FDA(6.666,"+1,",34)=1
 K IENS,ERRORS D UPDATE^DIE("E","FDA","IENS","ERRORS")
 I $D(ERRORS) D  Q  ; quit after record errors in error trap.
 . S MSG="XU PKI SECURITY ERROR: Unable to log a modified SAML token event. See ERRORS variable."
 . D APPERROR^%ZTER(MSG)
 ; chunk up the base64 string so that it can be filed in the wp field
 N MYCHUNK,CHUNKS,CHUNKSIZE,I,SAMLTOKEN
 S CHUNKSIZE=10240,I=1,SAMLTOKEN=XUMSAML("SAML_TOKEN")
 F  Q:$L(SAMLTOKEN)'>0  D
 . S MYCHUNK=$E(SAMLTOKEN,1,CHUNKSIZE)
 . S SAMLTOKEN=$E(SAMLTOKEN,CHUNKSIZE+1,$L(SAMLTOKEN))
 . S CHUNKS(I)=MYCHUNK
 . S I=I+1
 S $ECODE="" K ERRORS S XUMSAML("LOGIEN")=$G(IENS(1))
 D WP^DIE(6.666,IENS(1)_",",20,,"CHUNKS","ERRORS")
 I $D(ERRORS) D
 . S MSG="XU PKI SECURITY ERROR: Unable to log the modified SAML token. See ERRORS variable."
 . D APPERROR^%ZTER(MSG)
 Q
 ;
UPDATE(LOGIEN) ; Subroutine
 ; Instead of logging an additional entry in the log file, increment 
 ; the SAML TOKEN REUSE COUNT by 1.
 ;
 ; Input:    LOGIEN = the ien of the entry in the KERNEL PKI LOGS file
 ;
 ; Output:   void
 ;
 N ERRORS,I S I=$$GET1^DIQ(6.666,LOGIEN,34,"","","ERRORS")
 S I=I+1 N FDA S FDA(6.666,LOGIEN_",",34)=I
 D FILE^DIE("","FDA","ERRORS")
 Q
LOGCONTEXT(CONTEXTIEN,LOGIEN) ; Subroutine
 ; This helper subroutine logs which context option was used with the modified SAML token.
 ;
 ; Input:    CONTEXTIEN = the ien of the entry in the OPTION file
 ;           LOGIEN = the ien of the entry in the KERNEL PKI LOGS file
 ;
 ; Output:   void
 ;
 N FDA,ERRORS S FDA(6.666,LOGIEN_",",30)=CONTEXTIEN
 D FILE^DIE("","FDA","ERRORS")
 I $D(ERRORS) D
 . N MSG S MSG="XU PKI SECURITY ERROR: Unable to log the context option used. See ERRORS variable."
 . D APPERROR^%ZTER(MSG)
 Q
LOGERR ; Subroutine
 ; This helper subroutine is used to silently log an error in the error trap.
 ;
 ; Input:   void
 ;
 ; Output:  void
 ;
 D APPERROR^%ZTER("XU PKI SECURITY ERROR: Unmanaged error - review the stack trace.")
 Q
RESETCA ; Subroutine
 ; This subroutine resets the CA file so that updates can be received
 N PWD S PWD=$$DEFDIR I PWD="" W !,"Failed. No accessible default directory.",! Q
 N FILE S FILE=$NAMESPACE_"_xu_817_ca_chain.pem"
 I ##class(%File).Exists(PWD_FILE)=0 D  Q:PWD=""
 . W "Failed to find file in "_PWD_FILE,! S PWD="/tmp/" D
 . . I ##class(%File).Exists(PWD_FILE)=0 D
 . . . W "Failed to find file in "_PWD_FILE,! S PWD=""
 N DELETEME,Y S DELETEME(FILE)=""
 S Y=$$DEL^%ZISH(PWD,$NA(DELETEME))
 Q
