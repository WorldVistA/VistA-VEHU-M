DENTVA2 ;DSS/KC - DRM REPORTS;11/20/2003 13:26
 ;;1.2;DENTAL;**38,39,42,43,45,47,50,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ;  2056      x      $$GET1^DIQ
 ;  10103     x      FMTE^XLFDT
 ;  3512  Cont Sub   Direct global read of .01 field on file 9000010
 ;  3744      x      $$TESTPAT^VADPT 
 ;
ADMIN(RET) ; Non Clinical Time by Provider Rpt called by DENTVAU
 N X,X1,IEN,IP,PROV,I,K,CNT,UNK,PROV0,P,PS,PROVALL
 S STN=$G(DATA("STN")),CNT=0 ; reset station to external value
 S PROVALL=0 I $G(DATA("PROV"))="ALL" S PROVALL=1
 E  S IP=+$O(^DENT(220.5,"B",+$G(DATA("PROV")),0)) D  I PROV="" Q
 .I IP="" S @RET@(1)="-1^Invalid provider" Q
 .S PROV=+$P($G(^DENT(220.5,IP,0)),U,2) I PROV>0 D
 ..I $L(PROV)<4 S PROV=$E("000"_PROV,$L(PROV),$L(PROV)+3),PROVST=$E("000"_PROVST,$L(PROVST),$L(PROVST)+3)
 ..Q
 .S $P(PROV,U,2)=$P($G(^DENT(220.5,IP,0)),U,4)
 .Q
 ;we have PROV and IP if we don't have PROVALL
 S SDT=SDT-.0001,EDT=EDT_.9
 F  S SDT=$O(^DENT(226,"B",SDT)) Q:'SDT!(SDT>EDT)  D
 .S IEN="" F  S IEN=$O(^DENT(226,"B",SDT,IEN)) Q:'IEN  D
 ..S X=$G(^DENT(226,IEN,0)) Q:X=""
 ..I STN,STN'=$P(X,U,2) Q  ;not correct station
 ..I 'PROVALL Q:$P(X,U,3)'=$P(PROV,U)&($P(X,U,6)'=IP)  ;not correct provider
 ..S P=$S($P(X,U,6):$P(X,U,6),$P(X,U,3):+$O(^DENT(220.5,"C",$P(X,U,3),0)),1:"")
 ..Q:'P  S PROV0=$G(^DENT(220.5,P,0)) Q:'PROV0
 ..S PS=$S($P(PROV0,U,4):$P(PROV0,U,4),1:+$P(PROV0,U,2))
 ..I '$D(@RET@(PS)) S @RET@(PS)=$$NAME(PROV0)_"^0^0^0^0^"
 ..S X1=$P(X,U,4),X1=$S(X1="R":3,X1="E":4,X1="F":5,1:6)
 ..S $P(@RET@(PS),U,X1)=$P($G(@RET@(PS)),U,X1)+$P(X,U,5)
 ..S $P(@RET@(PS),U,7)=$P($G(@RET@(PS)),U,7)+$P(X,U,5) ;PROV TOTAL
 ..Q
 .Q
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria" Q
 ;conver the hourly figures to days
 S I=0 F  S I=$O(^TMP("DENT",$J,I)) Q:'I  S X=$G(^(I)) D
 .F K=3:1:7 S $P(X,U,K)=$P(X,U,K)+4\8
 .S ^TMP("DENT",$J,I)=X
 .Q
 Q
 ;
NAME(X0) ;get the provider name
 N X,Y
 S X=$$GET1^DIQ(200,+X0_",",.01) I X="" S X="name unavailable"
 S Y=$S($P(X0,U,4):$P(X0,U,4),1:$P(X0,U,2))
 Q Y_U_X
 ;
PLAN(RET) ; Provider Planning Report called by DENTVAU
 N CNT,DENTDFN,PRI,SEC,PIEN,DENTP,PROV,PRIIEN,SECIEN,NAM,VIS,VISOUT
 S TOT=0,CNT=0,PTOT=0,DENTDFN=0,PROV=$G(DATA("PROV"))
 I PROV=0 S @RET@(1)="-1^Invalid Provider" Q  ;P47 quit vs error on screen
 I PROV="ALL" S PROV=""
 E  D SET
 F  S DENTDFN=$O(^DENT(228.2,"AP",DENTDFN)) Q:'DENTDFN  D
 .S PRIIEN=+$P($G(^DENT(220,DENTDFN,0)),U,9),SECIEN=+$P($G(^(0)),U,10),SEC=""
 .S PRI=$S(PRIIEN:$$PROV(PRIIEN),1:"~999") I PROV]"",PRI="~999" Q  ;no undefined unless all providers
 .I DOSEC=1 S:SECIEN SEC=$$PROV(SECIEN) ;only do secondary if defined (no "unknown" default)
 .S PIEN="",PIEN=$O(^DENT(228.1,"C",DENTDFN,PIEN),-1) Q:'PIEN  ;get last encounter
 .S NODE=$G(^DENT(228.1,PIEN,0)) Q:NODE=""  ;bad data
 .I $$TESTPAT^VADPT(+$P(NODE,U,2)) Q  ;test pt, don't count
 .I PTYP<3,'$D(^TMP("DENTPAT",$J,+$P(NODE,U,2))) D PATSTA^DENTVA1
 .I PTYP<3,PTYP'=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) Q  ;not selected pt status
 .I PTYP=4 S X=$G(^TMP("DENTPAT",$J,+$P(NODE,U,2))) I "02"'[X Q  ;act/maint only
 .S VIS=$P(NODE,U,5),VIS=$S(VIS:+$G(^AUPNVSIT(VIS,0)),1:$P(NODE,U,3))
 .S:VIS VISOUT=$$FMTE^XLFDT(VIS) ;P50 12/28/06
 .S SSN=$E($$GET1^DIQ(2,DENTDFN_",",.09),6,10)
 .S NAM=$$GET1^DIQ(2,DENTDFN_",",.01),NAM=$E(NAM,1,18)_" "_SSN
 .S DENTP=NAM_U_VISOUT_U_$P(NODE,U,13)_U_$P(NODE,U,14)_U_$$GET1^DIQ(2,DENTDFN_",",.132)_U_$$FAP
 .D TXN
 .Q
 I '$D(@RET) S @RET@(1)="-1^No data for the selected criteria"
 K ^TMP("DSIC",$J) ;used to get next appt
 Q
 ;
TXN ; get the transactions, don't process if no ADA code, not a txn, or deleted
 N X0,X1,TXN,CAT,PIN,STA,COST,ADA,PNAM S TXN=0 K DENT
 F  S TXN=$O(^DENT(228.2,"AP",DENTDFN,TXN)) Q:'TXN  D
 .S X0=$G(^DENT(228.2,TXN,0)),X1=$G(^(1)) S TR=0,TOOTH="",SURF=""
 .Q:X0=""!($P(X0,U,4)="")!($P(X0,U,29)'=1)!($P(X1,U,3))
 .I $P(X0,U,9)=23,$P(X0,U,22)>1 Q  ;only count the first tooth for partials
 .S IEN=$P(X1,U,15) I IEN S STA=$P($G(^DENT(228.1,IEN,0)),U,18) I STN,STA'=STN Q  ;not selected division
 .;S PIN=$$GET1^DIQ(200,$P(X0,U,3)_",",1) S:PIN="" PIN=$$GET1^DIQ(200,$P(X0,U,3)_",",.01)
 .;S:$L(PIN)>3 PIN=$E(PIN,1,3)
 .S ADA=$P(X0,U,4) Q:'ADA  ;no ada code
 .S FLD=$$FLD^DENTVA21(3) I FLD="" Q  ;can't figure out the category
 .I $E(FLD)="Z" S FLD=$E(FLD,2,99)
 .S VAL=$P(X1,U,12),CAT=$$CPT^DSICCPT(,ADA,,,,1),CAT=$P(CAT,U,2) I CAT=+CAT S CAT="Z"_CAT
 .I VIS>3061001 S RVU=$P($G(^DENT(228,ADA,0)),U,18) S:RVU]"" VAL=RVU ;P50 12.28.06
 .S COST=$$GET1^DIQ(228,ADA_",",1.15)
 .;save like data, "roll up" to conserve lines going back DENT(DCODE)=DESCR_U_COUNT_U_RVUs
 .S X=$G(DENT(CAT)),$P(X,U,2)=$P(X,U,2)+1,$P(X,U,3)=$P(X,U,3)+VAL,$P(X,U,4)=$P(X,U,4)+COST
 .S DENT(CAT)=FLD_U_$P(X,U,2,4)_U_$P(X0,U,3)
 .Q
 S Y="" F  S Y=$O(DENT(Y)) Q:Y=""  D  ;set the "rolled up" data into the return array
 .I 'DOSEC I PROV=""!(PROV[(U_PRIIEN_U)) D
 ..I $G(PROVIDEN) S PNAM=$$PNAM^DENTVAU($E(PRI,2,9)) I $E(PNAM,1,7)="Unknown" S PNAM="Unassigned"
 ..I '$D(@RET@(PRI)) S @RET@(PRI)="$START^"_$S($G(PROVIDEN):PNAM,1:$E(PRI,2,9)),@RET@(PRI,"~")="$END"
 ..I '$D(@RET@(PRI,"X1"_DENTDFN)) S @RET@(PRI,"X1"_DENTDFN)="DFN^"_DENTP_U_"P"
 ..S CNT=CNT+1,@RET@(PRI,"X1"_DENTDFN,CAT,CNT)=DENT(Y)
 ..Q
 .I DOSEC=2 S SECIEN=$P(DENT(Y),U,5),SEC=$$PROV1(SECIEN),SECIEN=$O(^DENT(220.5,"B",SECIEN,0)) ;P53, 
 .I DOSEC,SECIEN'=0 I PROV=""!(PROV[(U_SECIEN_U)) D
 ..I $G(PROVIDEN) S PNAM=$$PNAM^DENTVAU($E(SEC,2,9)) I $E(PNAM,1,7)="Unknown" S PNAM="Unassigned"
 ..I '$D(@RET@(SEC)) S @RET@(SEC)="$START^"_$S($G(PROVIDEN):PNAM,1:$E(SEC,2,9)),@RET@(SEC,"~")="$END"
 ..I '$D(@RET@(SEC,"X2"_DENTDFN)) S @RET@(SEC,"X2"_DENTDFN)="DFN^"_DENTP_U_$S(DOSEC=2:"E",1:"S")
 ..S CNT=CNT+1,@RET@(SEC,"X2"_DENTDFN,CAT,CNT)=DENT(Y)
 ..Q
 .Q
 Q
PHASE(PH,SEQ) ;set phase/sequence
 S PH=$G(PH,0),SEQ=$G(SEQ,0)
 S PH=$S($L(PH)=1:"0"_PH,1:PH),SEQ=$S($L(SEQ)=1:0_SEQ,1:SEQ)
 Q "X"_PH_SEQ
PROV(PIEN) ;get the provider id from the dental provider entry
 N Z S Z=$$GET1^DIQ(220.5,PIEN_",",.04) I Z]"" Q "X"_Z
 S Z=$$GET1^DIQ(220.5,PIEN_",",1) I Z]"" Q "X"_Z
 Q "XUNKNOWN"
PROV1(PIEN) ;get the provider id from the new person entry
 Q $$PROV($$DPRV^DENTVUTL(PIEN))
FAP() ;get the next dental appt
 N AP,SC,X,I,QUIT,APDT
 S SC(1)="S^180",SC(2)="S^181",QUIT=0,APDT=U
 D VSIT^DSICVST2(.AP,DENTDFN_U_DT_U_$$FMADD^XLFDT(DT,365)_"^^1",.SC)
 I +$G(@AP@(1))'=-1 D
 .F I=0:0 S I=$O(@AP@(I)) Q:'I!QUIT  S X=$G(@AP@(I)) I $P(X,U)="S" S APDT=$P(X,U,3,4),QUIT=1
 .Q
 Q APDT
SET ;set provider iens to 220.5 vs 200
 N I,X S I=1 F  S X=$P(PROV,U,I) Q:'X  S $P(PROV,U,I)=$O(^DENT(220.5,"B",+X,0)),I=I+1
 S PROV=U_PROV_"0^"
 Q
