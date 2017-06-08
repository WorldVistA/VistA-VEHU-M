DSIVIC2 ;DSS/CC - Insurance card RPC's ;12/14/2004 [3/9/05 1:00pm]
 ;;2.2;INSURANCE CAPTURE BUFFER;;May 19, 2009;Build 12
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  10009  FILE^DICN
 ;  2053   UPDATE^DIE
 ;  5318   FILE^DSICDDR0,UPDATE1^DSICDDR0
 ; 
 Q
GETIEN(RET,PAT,BUF,CDT) ;;Retrieve ICB Audit IEN
 ; Implements DSIV GET ICB AUDIT remote procedure call
 S RET="-1^Missing input parameter"
 I '$G(PAT)!($G(BUF)="")!('$G(CDT)) Q
 N O S O=$O(^DSI(19625,"G",PAT,BUF,CDT,""))
 S RET="-1^No data found"
 S:+O=O RET=O
 Q
 ;
ADD(DFN,LOC,APDT,INSF) ; add viewing audit from get appt listing rpcs if no buffer 8.17.07 KC
 Q:'$G(DFN)  Q:'$G(APDT)
 I $D(^DSI(19625,"AD",DFN,APDT\1)) Q  ;already has audit entry for the day
 N Z,RET S Z("DFN")=DFN,Z("LOC")=LOC,Z("APDT")=APDT,Z("PPOL")=+$G(INSF)
 D AAUDIT(.RET,.Z)
 Q
AAUDIT(RET,DATA)    ;RPC: DSIV ADD VIEWING AUDIT
 ;  add "viewing" audit entry to 19625, minimum data
 ;  DATA("DFN") - reqd, pointer to the patient file
 ;  DATA("LOC") - reqd, free text clinic location
 ;  DATA("APDT")- reqd, appt date
 ;  DATA("PPOL")- not reqd, patient policy needs update (0=no,1=yes)
 ;  return -1^error message  or ien of entry
 N X,DIERR,ERR,DSIVDA,IENS,DFN,LOC,APDT,DSIVIEN,PPOL
 F X="DFN","LOC","APDT","PPOL" S @X=$G(DATA(X))
 I 'DFN S RET="-1^no patient" Q
 I LOC="" S RET="-1^no location" Q
 I 'APDT S RET="-1^no appt date" Q
 D GETIEN(.X,DFN,0,APDT) I X,X>0 S RET=X Q
 S IENS="+1,",DSIVIEN=""
 S DSIVDA(19625,IENS,.01)=DFN
 S DSIVDA(19625,IENS,.02)=0
 S DSIVDA(19625,IENS,.04)=+PPOL
 S DSIVDA(19625,IENS,1)=DUZ
 S DSIVDA(19625,IENS,1.01)=APDT
 S DSIVDA(19625,IENS,1.11)=LOC
 L +^DSI(19625,0):2
 E  Q "-1^Unable to lock the ICB AUDIT file #19625, try again"
 D UPDATE^DIE(,"DSIVDA","DSIVIEN","ERR") L -^DSI(19625,0)
 I $D(DIERR) S RET="-1^Error encountered when adding entry" Q
 S RET=$G(DSIVIEN(1))
 Q
ADDUPD(RET,FILE,IEN,DATA,FLAG) ;RPC: DSIV UPDATE SUBFILE MULT
 ;FILE = file to edit (Required)
 ;IEN = ien to edit (Required)
 ;FLAG = 0 to add, 1 to update multiple type fields
 ;DATA = array holding entries
 ;for adding:
 ;  DATA(n)=$START
 ;  DATA(n)=field^value
 ;  DATA(n)=field^value
 ;  DATA(n)=$END   etc...
 ;for updating:
 ;  DATA(n)=$START
 ;  DATA(n)=SubfieldIEN^field^value
 ;  DATA(n)=SubfieldIEN^field^value
 ;  DATA(n)=$END   etc...
 ;
 N I,CNT,END,DSIVR,DSIVI,DSIVDX,DSIVD,SUCC
 I '$G(FILE)!('$G(IEN))!('$D(DATA))!($G(FLAG)="") S RET(1)="-1^Missing input" Q
 S FLAG=+$G(FLAG)
 S CNT=1,END=0,SUCC=0
 F  Q:'$$PARSE1(.DSIVDX,.DATA)  D  Q:END
 .S I=0 F  S I=$O(DSIVDX(I)) Q:'I  D
 ..I FLAG=1 S DSIVI=+DSIVDX(I),DSIVDX(I)=$P(DSIVDX(I),U,2,3)
 ..S DSIVD(+DSIVDX(I))=$P(DSIVDX(I),U,2)
 ..Q
 .I FLAG=0 D  ; Add data
 ..D UPDATE1^DSICDDR0(.DSIVR,FILE,"+1,"_IEN_",",.DSIVD)
 ..Q
 .I FLAG=1 D  ; Update data
 ..D FILE^DSICDDR0(.DSIVR,FILE,DSIVI_","_IEN_",","",.DSIVD)
 ..Q
 .S RET(CNT)=$G(DSIVR(1))_U_CNT ; Append entry # at end
 .I $P(RET(CNT),U)="-1" S END=1,SUCC=0,RET(0)=RET(CNT) Q
 .S CNT=CNT+1,SUCC=1
 .K DSIVR,DSIVD
 .Q
 S:'$D(RET) RET(0)="0^Nothing processed"
 S:SUCC RET(0)="1^Success"
 Q
PARSE1(RET,DAT) ;
 N D,CNT,END
 K RET
 S (D,END)=0,CNT=1
 ; Ensure data
 Q:$D(DAT)<10 0 ;has decendents
 Q:$G(DAT(+$O(DAT(""))))'="$BEGIN" 0
 ; Parse out one entry and remove from array
 F  S D=$O(DAT(D)) Q:'D!END  D
 .I DAT(D)="$BEGIN" K DAT(D) Q
 .I DAT(D)="$END" K DAT(D) S END=1 Q
 .S RET(CNT)=DAT(D),CNT=CNT+1
 .K DAT(D)
 .Q
 Q $S($D(RET):1,1:0)
 ;
NOI(DSIVRET,DFN,DATA) ; - RPC: DSIV NO INSURANCE
 ; add no insurance flag for ICB to file 354 and file 2
 ; --Input DFN  = entry in patient file
 ;         DATA = list of fields to edit in 354
 ; --Return RET(1)=DFN^Data filed successfully
 ;       or RET(n)=-1^error message
 ;          RET(n)=additional error text -OPTIONAL (from DSICDDR0)
 I $G(DFN)=""!('$D(^DPT(DFN))) S DSIVRET(1)="-1^Invalid patient" Q
 I '$D(DATA) S DSIVRET(1)="-1^No filing information" Q
 I '$D(^IBA(354,DFN)) D ADDP Q:$D(DSIVRET(1))
 D FILE^DSICDDR0(.DSIVRET,354,DFN,"E",.DATA)
 I +$G(DSIVRET(1))<0 Q
 K DATA,DSIVRET S DATA(.3192)="N"
 D FILE^DSICDDR0(.DSIVRET,2,DFN,"E",.DATA)
 I +$G(DSIVRET(1))=1 S DSIVRET(1)=DFN_U_"Data filed successfully"
 Q
 ;
ADDP ; Add patient to file 354, from ADDP^IBAUTL6
 N DINUM,DLAYGO,X
 K DO,DD,DIC,DR,DA,DIE S DIC="^IBA(354,",DIC(0)="L",DLAYGO=354
 L +^IBA(354,DFN):15 E  S RET="-1^Unable to locl file 354 to add patient" Q
 S (DINUM,X)=DFN D FILE^DICN     I Y<0 S DSIVRET(1)=Y
 L -^IBA(354,DFN)
 K DO,DD,DIC,DR,DIE,DA
 Q
