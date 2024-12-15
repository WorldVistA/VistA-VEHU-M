NHINP025 ;EDE/SAB - post install ; June 03, 2024@12:57:56
 ;;1.0;NHIN - DAS;**25**;June 2024;Build 6
 ;
 Q
 ;
MAIN ; Control subroutine
 N XU8ERRX,XU8DATA
 S XU8ERRX=""
 ;
 ; Install NUMI entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="NHIN DAS CC" ; Name
 S XU8DATA(2)="NHIN DAS CC" ; ContextOption Name
 S XU8DATA(3)="NHIN DAS CC Remote Application" ; ContextOption Menu Text
 S:$$PROD^XUPROD(1) XU8DATA(4)="Di9mPIzHKexEm+B1ISj3+/B8oHMntf4tlzTk3FhJ7jk=" ; Security phrase - Production
 S:'$$PROD^XUPROD(1) XU8DATA(4)="NagGWBAVhrLTvljADSyqsbd1QyFl3Zv2zoH/WCJgTgo=" ; Security phrase - Non Production
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 ;
 ; CallBack Type:   S - Station #
 ;   H - HTTP
 ;   R - RPC Broker
 ;
 ;S XU8DATA(5)="H"_"^"_"-1"_"^"_"N/A"_"^"_"https://sqa.ehrm.das.domain.ext/vista/v1/api/selectPatient"
 S XU8DATA(5)="S"_"^"_"-1"_"^"_"N/A"_"^"_"N/A"
 ;S XU8DATA(5)="S^-1^N/A^N/A"
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 Q
 ;
CREATE(XU8DATA) ; Create new REMOTE APPLICATION entry
 N XU8ERR,XU8FDA,XU8IEN,XU8MSG,XU8I,XU8IENS,DA,DIK
 ; Delete existing entry if it exists, before creating updated entry
 S XU8IEN=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^XWB(8994.5,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 S XU8ERR="   REMOTE APPLICATION entry created: "_XU8DATA(1)
 S XU8FDA(8994.5,"?+1,",.01)=XU8DATA(1) ; NAME
 I $D(XU8DATA(2)) S XU8FDA(8994.5,"?+1,",.02)=$$FIND1^DIC(19,"","X",XU8DATA(2),"B") ; CONTEXTOPTION
 S XU8FDA(8994.5,"?+1,",.03)=$$SHAHASH^XUSHSH(256,XU8DATA(4),"B") ; APPLICATIONCODE
 D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create REMOTE APPLICATION "_XU8DATA(1)
 ; Find the REMOTE APPLICATION
 S XU8IENS=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I +XU8IENS<1 S XU8ERR=XU8IENS Q XU8ERR
 ; Fill in CALLBACKTYPE multiple
 S XU8I=4 F  S XU8I=$O(XU8DATA(XU8I)) Q:XU8I=""  D
 . N XU8FDA,XU8IEN,XU8MSG,XU8TEST,XU8J,XU8FLAG
 . ; Check for duplicates (loop through CALLBACKTYPE for this entry)
 . S XU8J=0 F  S XU8J=$O(^XWB(8994.5,XU8IENS,1,"B",$E(XU8DATA(XU8I),1,1),XU8J)) Q:(XU8J="")!($D(XU8FLAG))  D
 . . I $G(XU8DATA(XU8I))=$G(^XWB(8994.5,XU8IENS,1,XU8J,0)) S XU8FLAG=1
 . I '$D(XU8FLAG) D
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.01)=$P(XU8DATA(XU8I),"^",1) ; CALLBACKTYPE
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.02)=$P(XU8DATA(XU8I),"^",2) ; CALLBACKPORT
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.03)=$P(XU8DATA(XU8I),"^",3) ; CALLBACKSERVER
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.04)=$P(XU8DATA(XU8I),"^",4) ; URLSTRING
 . . D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 . . I $D(XU8MSG) D
 . . . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to update REMOTE APPLICATION "_XU8DATA(1)
 ;
 D CLEAN^DILF
 Q XU8ERR
