EVETAUD ;;HINES/DS - Audit of communications between VistA and Health eVet ; 10/23/02 9:32am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ;
 Q
 ;
AUDIT(EVUSR,EVICN,EVDT,EVTYP,EVMESS,EVREQID) ;
 ;EVUSER - Username
 ;EVICN - ICN of user
 ;EVDT - Date time of message
 ;EVTYP - Type of message 
 ;        A - Activation
 ;        AR - Activation Responce
 ;        EP - Extract Poll
 ;        E - Extract
 ;        UR - Update Responce
 ;EVMESS - Message text
 ;EVREQID - Request id
 N EVIEN,EVNEXT,EVLAST
 S EVLAST=$O(^EVET(2276,"B",""),-1)
 I $G(EVLAST)'="" D
 . S EVNEXT=$O(^EVET(2276,"B",EVLAST,""),-1)
 . S EVNEXT=EVNEXT+1
 . Q
 I $G(EVNEXT)="" S EVNEXT=1
 K EVLOG
 S EVLOG(2276,"+1,",.01)=EVNEXT
 S EVLOG(2276,"+1,",.02)=EVUSR
 S EVLOG(2276,"+1,",.03)=EVICN
 S EVLOG(2276,"+1,",.04)=EVDT
 S EVLOG(2276,"+1,",.05)=EVTYP
 S EVLOG(2276,"+1,",.06)=EVMESS
 S EVLOG(2276,"+1,",.07)=EVREQID
 K EVERR
 D UPDATE^DIE("","EVLOG","EVIEN","EVERR")
 Q
