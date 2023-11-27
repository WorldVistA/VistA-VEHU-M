MAGTLRD ;WOIFO/CD - RPC MAG TELER UPDATES ; 20 Jul, 2023@14:36:03
 ;;3.0;IMAGING;**356**;Mar 19, 2002;Build 9
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; RPC: MAG TELER UPDATES 
 ; 
 ; Return the latest updates to IFC consults. Used by the VAEC-based TeleReader Proxy 
 ; Service to scope and QA its description of TeleHealth IFCs.
 ; 
 ; Input Values
 ; ============
 ; [FROM]  Date to start from in FileMan format.
 ;         Maximum is 90 days back from NOW.
 ;         Default is 90 days back from NOW.
 ; [SRVCS] Filter of relevant services.
 ;         0 or more IENs of entries from file 123.5, delimited with ;
 ;         Default is no filtering.
 ; [MAX]   Maximum number of entries to return.
 ;         Default and maximum is 1000.
 ;
 ; Return Value
 ; ============
 ; REPLY(1) holds information about the reply: 
 ;   Count^Count SRVCS Filtered^Count Action Filtered^FROM^Last Date Seen^MORE
 ; where MORE is 1 if there are more entries available after Last Date Seen.
 ;
 ; REPLY(2...N) each hold an update for a particular consult. 
 ;  
CNSLTS(REPLY,FROM,SRVCS,MAX) ;RPC [MAG TELER UPDATES]
 N DT90,DTD,FLDS,SCRN,ACTDT,ACQSNO,ACQID,SIEN,ACTTYP,ACTSTS,CNT,RCNT,SKIP1,SKIP2,MORE,X,Y,IN,OUT,ERR,IEN
 S DT90=$$FMADD^XLFDT($$NOW^XLFDT,-90,0,0,0)
 S FROM=$G(FROM,DT90)
 S DTD=$$FMDIFF^XLFDT($$NOW^XLFDT,FROM,1)
 S:DTD>90 FROM=DT90
 S SRVCS=$G(SRVCS,"")
 S MAX=$G(MAX,1000)
 S:MAX>1000 MAX=1000
 S FLDS="IXI;.06;.07I;1I"
 S SCRN="I ($P($G(^(12)),U,5)=""F"")"
 D LIST^DIC("123",,FLDS,,$S(SRVCS:"",1:MAX),FROM,,"ASTATUS",.SCRN,,"OUT","ERR")
 S ACTDT=""
 S CNT=0
 S RCNT=1
 S SKIP1=0
 S SKIP2=0
 S MORE=0
 F X=1:1 S Y=$P(SRVCS,",",X) Q:Y=""  S SRVCS(Y)=""
 N IN S IN="" F  S IN=$O(OUT("DILIST",2,IN)) Q:IN=""!(CNT=MAX)  D
 . S ACTDT=OUT("DILIST","ID",IN,0,1)
 . S ACQSNO=$P($G(^DIC(4,OUT("DILIST","ID",IN,.07),99)),U)
 . S SIEN=OUT("DILIST","ID",IN,1)
 . S CNT=CNT+1
 . I SRVCS,'$D(SRVCS(SIEN)) S SKIP1=SKIP1+1 Q
 . S IEN=OUT("DILIST",2,IN)
 . S ACQID=OUT("DILIST","ID",IN,.06)
 . S ACTTYP=OUT("DILIST","ID",IN,0,2)
 . I ACTTYP="REMOTE REQUEST RECEIVED" S RCNT=RCNT+1 S REPLY(RCNT)=$$RECREQ(IEN,ACTDT,ACQSNO,ACQID)
 . E  D
 . . S ACTSTS=$S(ACTTYP="DISCONTINUED":"DISCONTINUED",ACTTYP="COMPLETE/UPDATE":"COMPLETE",ACTTYP="CANCELLED":"CANCELLED",ACTTYP="RECEIVED":"ACTIVE",1:"")
 . . I ACTSTS="" S SKIP2=SKIP2+1 Q
 . . S RCNT=RCNT+1 S REPLY(RCNT)=$$OTHACT(IEN,ACTDT,ACQSNO,ACQID,ACTSTS,SIEN)
 S REPLY(1)=CNT_U_SKIP1_U_SKIP2_U_FROM_U_ACTDT_U_$S(CNT=MAX:1,1:0)
 Q
 ;
 ; Receive Request - NEW includes patient information and core of consult
 ;
RECREQ(IEN,ACTDT,ACQSNO,ACQID) ;Receive Request
 ;
 ; Note: 507 has SECID of Remote Provider for Cerner Providers not yet taken as not
 ; available from vista to vista
 ;
 N FLDS,OUT,CNS,PIEN,PAT,PICN,TZ,NACTS,SRL,URG
 S FLDS=".02;.126;1;3;5"
 D GETS^DIQ(123,IEN_",",FLDS,"IE","OUT")
 M CNS=OUT(123,IEN_",")
 Q:$G(CNS(.02,"I"))="" "PENDING"
 K OUT
 S FLDS=".01;.09"
 D GETS^DIQ(2,CNS(.02,"I")_",",FLDS,"E","OUT")
 M PAT=OUT(2,CNS(.02,"I")_",")
 S PICN=$$GETICN^MPIF001(CNS(.02,"I"))
 K OUT
 D GETS^DIQ(123.02,"1,"_IEN_",",".23","E","OUT")
 S TZ=OUT(123.02,"1,"_IEN_",",.23,"E")
 S NACTS=$P($G(^GMR(123,IEN,40,0)),U,4)
 S URG=$P($G(CNS(5,"E")),"GMRCURGENCY - ",2)
 S SRL="PENDING^"_IEN_U_ACTDT_U_NACTS_"^REMOTE^"_$G(PAT(.01,"E"))_"|"_$G(PAT(.09,"E"))_"|"_PICN_"|"_CNS(.02,"I")
 S SRL=SRL_U_ACQID_U_ACQSNO_U_$G(CNS(.126,"I"))_U_$G(CNS(1,"E"))_"|"_$G(CNS(1,"I"))_U_$G(CNS(3,"I"))_"|"_TZ
 S SRL=SRL_U_URG
 Q SRL
 ;
OTHACT(IEN,ACTDT,ACQSNO,ACQID,STS,SIEN) ;All other than RECEIVE REQUEST
 N MIEN,AIEN,FLDS,OUT,ACT,NACTS,SNAME,SRL
 S MIEN=$O(^GMR(123,IEN,40,"B",ACTDT,0))
 S AIEN=MIEN_","_IEN ; should be 1,IEN
 S FLDS=".22;.23;2;3"
 D GETS^DIQ(123.02,AIEN_",",FLDS,"IE","OUT")
 M ACT=OUT(123.02,AIEN_",")
 S NACTS=$P($G(^GMR(123,IEN,40,0)),U,4)
 S SNAME=$P($G(^GMR(123.5,SIEN,0)),U)
 S SRL=STS_U_IEN_U_ACTDT_U_NACTS
 S SRL=SRL_U_$S($L(ACT(3,"I")):"LOCAL"_U_ACT(3,"E")_"|"_$P($G(^VA(200,ACT(3,"I"),205)),U)_"|"_ACT(3,"I"),1:"REMOTE"_U_ACT(.22,"I"))
 S SRL=SRL_U_SNAME_U_ACQID_U_ACQSNO
 Q SRL
 ;
