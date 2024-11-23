PSOEPUT2 ;BIR/TJL - ePCS Broker Utilities ;11/1/23  12:05
 ;;7.0;OUTPATIENT PHARMACY;**545,743,732**;DEC 1997;Build 10
 ;
EPCSHELP(RESULTS,EPCSARY) ;
 ;
 ;Broker call returns the entries from HELP FILE #9.2
 ;        RPC: PSO EPCS GET HELP
 ;INPUTS   EPCSARY - Contains the following elements
 ;         HELPDA  - Help Frame Name
 ;
 ;OUTPUTS  RESULTS - Array of help text in the HELP FRAME File (#9.2)
 ;
 N HELPDA,DIC,X,Y
 S HELPDA=$G(EPCSARY) I HELPDA="" Q
 D SETENV K ^TMP("EPCSHELP",$J)
 S DIC="^DIC(9.2,",DIC(0)="MN",X=HELPDA
 D ^DIC M ^TMP("EPCSHELP",$J)=^DIC(9.2,+Y,1)
 I $D(^TMP("EPCSHELP",$J)) D
 . S $P(^TMP("EPCSHELP",$J,0),U)=$P(^DIC(9.2,+Y,0),U,2)
 S RESULTS=$NA(^TMP("EPCSHELP",$J))
 Q
 ;
EPCSDATE(RESULTS,EPCSARY) ;
 ;
 ;Broker call returns an FileMan internal date
 ;        RPC: PSO EPCS SYSTEM DATE TIME
 ;INPUTS   EPCSARY - Contains the following elements
 ;         DTSTR  - Date String (e.g., 'N' for 'Now')
 ;
 ;OUTPUTS  RESULTS - A valid FileMan date format^External format
 ;
 N EPCSDATE,DIC,X,Y,DATESTR
 D SETENV
 S DATESTR=$P(EPCSARY,U) I DATESTR="" Q
 S X=DATESTR,%DT="XT",%DT(0)="-NOW" D ^%DT
 I +Y<1 S RESULTS="0^Invalid Date/Time" Q
 S RESULTS=Y D D^DIQ
 S RESULTS=RESULTS_U_Y
 Q
 ;
SRCLST(RESULTS,EPCSARY) ;
 ;
 ; This broker entry returns an array of codes from a file
 ; based on a search string.
 ;        RPC: PSO EPCS GET LIST
 ;
 ;INPUTS    EPCSARY  - Contains the following subscripted elements
 ;          EPCSFILE - File to search
 ;          EPCSSTR  - Search string
 ;          EPCSDIR  - Search order
 ;          EPCSNUM  - (Optional) # records to return [default=44]
 ;OUTPUTS   RESULTS - Array of values based on the search criteria.
 ;
 N EPCSFILE,EPCSSTR,EPCSDIR,EPCSORD,EPCSNUM
 D SETENV
 S EPCSFILE=$P(EPCSARY,U),EPCSSTR=$P(EPCSARY,U,2),EPCSDIR=$P(EPCSARY,U,3)
 S EPCSORD=$S(EPCSDIR=-1:"B",1:"I")
 K ^TMP($J,"EPCSFIND"),^TMP("EPCSSRCH",$J)
 I EPCSFILE="" Q
 S EPCSNUM=$S(+$P(EPCSARY,U,4)>0:$P(EPCSARY,U,4),1:44)
 I EPCSFILE=200 D PROV(EPCSNUM)      ;Providers
 D SORT
EXIT K ^TMP("EPCSSRCH",$J)
 S RESULTS=$NA(^TMP($J,"EPCSFIND"))
 Q
 ;
SORT ;Order the data to be returned by the broker
 N COUNT
 S COUNT=0
 F  S COUNT=$O(^TMP("EPCSSRCH",$J,"DILIST","ID",COUNT)) Q:'COUNT  D
 .S ^TMP($J,"EPCSFIND",COUNT)=$G(^TMP("EPCSSRCH",$J,"DILIST","ID",COUNT,.01))_U_^TMP("EPCSSRCH",$J,"DILIST",2,COUNT)
 Q
 ;
PROV(EPCSNUM) ;Return a set of providers from the NEW PERSON file
 ;Input Variables:-
 ;  EPCSNUM - # of records to return
 ;  FROM    - text to begin $O from
 ;  DATE    - checks for an active person class on this date (optional)
 ;  EPCSDIR - $O direction
 ;  REPORT  - Set to "R" to get all entries from file 200 OR set to blank 
 ;            if only users with a person class should be returned.
 ;
 ;Output Variables:-
 ;  ^TMP($J,"EPCSFIND",1..n - returned array
 ;     IEN of file 200^Provider Name^occupation^specialty^subspecialty
 ;
 N I,IEN,COUNT,FROM,DATE,EPCSUTN,REPORT S I=0,COUNT=$S(+$G(EPCSNUM)>0:EPCSNUM,1:44)
 S FROM=$P(EPCSSTR,"|"),DATE=$P(EPCSSTR,"|",2),REPORT=$P(EPCSSTR,"|",3)
 F  Q:I'<COUNT  S FROM=$O(^VA(200,"B",FROM),EPCSDIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^VA(200,"B",FROM,IEN),EPCSDIR) Q:'IEN  D 
 . . I IEN<1 Q     ; Don't include special users postmaster and sharedmail
 . . I REPORT="R" S I=I+1,^TMP($J,"EPCSFIND",I)=IEN_"^"_FROM_"^" Q
 . . S EPCSUTN=$$GET^XUA4A72(IEN,DATE)
 . . S I=I+1,^TMP($J,"EPCSFIND",I)=IEN_"^"_FROM_"^"_$P(EPCSUTN,"^",2,4)
 Q
SETENV ;
 I '$G(DUZ) D
 . S DUZ=.5,DUZ(0)="@",U="^",DTIME=300
 . D NOW^%DTC S DT=X
 Q
DELMULT(RETURN,NPIEN,DEATXT) ; Remove DEA multiple (#53.21) from the NEW PERSON file (#200)
 ; INPUT: NPIEN - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ; DEATXT - PROPERLY FORMATTED DEA NUMBER
 ; OUTPUT: RETURN - 1 for SUCCESS, 0 for UNSUCCESSFUL
 N FDA,IENS,MSGROOT,NPDEAIEN,DNDEAIEN,DEATYPE,DA,DIE,DR
 S RETURN=0 Q:'$G(NPIEN)  Q:$G(DEATXT)=""
 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4","B",DEATXT,0)) I 'NPDEAIEN Q
 S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 S DEATYPE=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")
 S FDA(1,200.5321,NPDEAIEN_","_NPIEN_",",.01)="@"
 D UPDATE^DIE(,"FDA(1)",,"MSGROOT") Q:$D(MSGROOT)
 S RETURN=1
 Q
 ;
ASK(TYPE,NAME,DELEG) ;Ask user if Allocate/De-allocate or Delegate/Un-delegate - returns y/n
 ;TYPE - flag weather Allocate/De-allocate or Delegate/Un-delegate
 ;Name - user's name
 N DIR,Y
 S DELEG=$G(DELEG,"")
 I DELEG S DIR("A")=$S(TYPE=1:"Un-delegate",1:"Delegate")_" PSDRPH for "_NAME
 I 'DELEG S DIR("A")=$S(TYPE=1:"De-allocate",1:"Allocate")_" PSDRPH for "_NAME
 S DIR("B")="Y"
 S DIR(0)="Y" D ^DIR K DIR
 Q Y
 ;
PSDKEY(RESULTS,PSOSUBJ,PSOACTOR,PSOACTION) ;Allocate/De-allocate the PSDRPH key
 ; RESULTS   - Success or Failure of the allocation/deallocation of the PSDRPH key.
 ; PSOSUBJ   - The user to whom the PSDRPH key is being allocated/deallocated
 ; PSOACTOR  - The user performing the allocation/deallocation of the PSDRPH key.
 ; PSOACTION - Action to perform - 1=Allocate, 0=Deallocate
 ;
 N PSOKEY,PSOMSG,PSOKSTAT,PSOIGNORE,PSOINPUT
 S PSOIGNORE=0 K RESULTS
 S PSOKSTAT=$$FIND1^DIC(200.051,","_PSOSUBJ_",",,"PSDRPH",,,"ERROR")
 S PSOACTION=$G(PSOACTION),PSOSUBJ=$G(PSOSUBJ),PSOACTOR=$G(PSOACTOR)
 I (PSOACTION'=1)&(PSOACTION'=0) S RESULTS="0^Invalid Action Code: "_PSOACTION Q
 S PSOKEY=$$LKUP^XPDKEY("PSDRPH")
 I PSOKEY="" S RESULTS="0^PSDRPH key does not exist" Q
 I 'PSOSUBJ S RESULTS="0^Missing or invalid key recipient input parameter." Q
 I 'PSOACTOR S RESULTS="0^Missing or invalid key allocator input parameter." Q
 I '$$FIND1^DIC(200,,,"`"_PSOSUBJ) S RESULTS="0^Key recipient IEN "_PSOSUBJ_" does not exist in the NEW PERSON file." Q
 I '$$FIND1^DIC(200,,,"`"_PSOACTOR) S RESULTS="0^Allocator IEN "_PSOACTOR_" does not exist in the NEW PERSON file." Q
 ;
 ;De-allocate key
 I PSOACTION=0 D
 . I 'PSOKSTAT S PSOIGNORE=1 Q  ; Key not on file, take no action to avoid unnecessary audit file records
 . K DIK S DIK="^VA(200,PSOSUBJ,51,",DA(1)=PSOSUBJ,DA=PSOKEY D ^DIK
 ;
 ;Allocate key
 I PSOACTION=1 D
 . I PSOKSTAT S PSOIGNORE=1 Q  ; Key already on file, take no action to avoid unnecessary audit file records
 . S FDA(200.051,"+1,"_PSOSUBJ_",",.01)="PSDRPH" D UPDATE^DIE("E","FDA","IEN","PSOMSG") D  I $L($G(RESULTS)) Q
 . I '$$FIND1^DIC(200.051,","_PSOSUBJ_",",,"PSDRPH") S RESULTS="0^PSDRPH NOT FILED-"_$G(PSOMSG("DIERR",1,"TEXT",1))
 ;
 ;Set and record audit data
 I 'PSOIGNORE D
 . S NOW=$P($$HTE^XLFDT($H),":",1,2)
 . S PSOINPUT="`"_PSOSUBJ_"^"_"`"_PSOACTOR_"^"_PSOACTION D RECORD(PSOINPUT,NOW)
 ;
 ; Return true if intended state of PSDRPH exists, either by current action or pre-existing state
 S RESULTS=1
 Q
 ;
RECORD(LINE,NOW) ;Record the edited data into audit file #8991.7
 N FDA,VALUE,IEN,MSG,I
 F I=1:1:3 S VALUE=$P(LINE,U,I),FDA(8991.7,"+1,",(I/100))=VALUE
 S FDA(8991.7,"+1,",.04)=NOW
 D UPDATE^DIE("E","FDA","IEN","MSG")
 Q
