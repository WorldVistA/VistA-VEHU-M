DENTVTP3 ;DSS/KC - TREATMENT PLAN DATA RETRIEVAL ;11/03/2003 16:54
 ;;1.2;DENTAL;**39,45,57,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine contains subroutines to retrieve DSS Dental Treatment 
 ;  plan data for PSR, Perio and Head&Neck 
 ;  see DENTVTP4 to add/update these records
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ;  2056      x      GETS^DIQ
 ;  10103     x      FMTE^XLFDT
 ;
PSR(RET,DATA,NUM)        ; RPC: DENTV TP GET PSR
 ;  get all of the PSR data for a specified patient
 ;  RET = name of global array which stores the results to be returned
 ;      = ^TMP("DENT",$J)
 ;        ^TMP("DENT",$J,#) = txn id^exam date^prov id^psr score string
 ;  DATA = DFN (patient ien)
 ;  Errors returned as -1^error message
 N X,TIEN,IEN,NODE,DFN,FLDS,TMP,DENT,DENTERR,I,FROM
 S RET=$NA(^TMP("DENT",$J)),NODE=+$G(NUM),DFN=$G(DATA) K ^TMP("DENT",$J)
 S X=$$DFN^DENTVRF0(DFN) I X<0 S ^TMP("DENT",$J,1)=X Q
 S FLDS=".01;.13;.03;3.01"
 F TIEN=0:0 S TIEN=$O(^DENT(228.2,"AD",DFN,3,TIEN)) Q:'TIEN  D
 .S IEN=TIEN_"," D GETS^DIQ(228.2,IEN,FLDS,"IE","DENT","DENTERR")
 .K TMP M TMP=DENT(228.2,IEN) K DENT
 .F I=1:1:4 S FROM=$P(FLDS,";",I),$P(X,U,I)=$S(I=2!(I=3):$G(TMP(FROM,"I")),1:$G(TMP(FROM,"E")))
 .;format date to MM/DD/YYYY@HH:MM
 .S:+$P(X,U,2) $P(X,U,2)=$$FMTE^XLFDT($P(X,U,2),5)
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)=X
 .Q
 I '$O(^TMP("DENT",$J,0)) S ^(1)="-1^No PSR data found for the patient"
 Q
 ;
PERIO(RET,DATA,NUM) ; RPC: DENTV TP GET PERIO
 ; get all of the PERIO data for a specified patient
 ; RET = name of global array which stores the results to be returned
 ;     = ^TMP("DENT",$J)
 ;       ^TMP("DENT",$J,#)=$START_ien
 ;       ^TMP("DENT",$J,#)=txn id^exam#^exam date^provider
 ;       ^TMP("DENT",$J,#)=perio info nodes
 ;       ^TMP("DENT",$J,#)=$END_ien
 ; DATA = DFN (patient ien)
 ; Errors returned as -1^error message
 N X,TIEN,IEN,NODE,PIEN,P0,DFN,FLDS,TMP,DENT,DENTERR,I,FROM,PNUL
 S RET=$NA(^TMP("DENT",$J)),NODE=+$G(NUM),DFN=$G(DATA) K ^TMP("DENT",$J)
 S X=$$DFN^DENTVRF0(DFN) I X<0 S ^TMP("DENT",$J,1)=X Q
 S FLDS=".01;2.01;.13;.03"
 F TIEN=0:0 S TIEN=$O(^DENT(228.2,"AD",DFN,2,TIEN)) Q:'TIEN  D
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)="$START "_TIEN
 .S IEN=TIEN_"," D GETS^DIQ(228.2,IEN,FLDS,"IE","DENT","DENTERR")
 .K TMP M TMP=DENT(228.2,IEN) K DENT
 .F I=1:1:4 S FROM=$P(FLDS,";",I),$P(X,U,I)=$S(I>2:$G(TMP(FROM,"I")),1:$G(TMP(FROM,"E")))
 .;format date to MM/DD/YYYY@HH:MM
 .S:+$P(X,U,3) $P(X,U,3)=$$FMTE^XLFDT($P(X,U,3),5)
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)=X
 .S PNUL=$G(^DENT(228.2,TIEN,2.3,1,0)) S:PNUL="" PNUL=$$NULLS(200) ;KC P45 adding perionullshex
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)=PNUL
 .F PIEN=0:0 S PIEN=$O(^DENT(228.2,TIEN,2.1,PIEN)) Q:'PIEN  S P0=^(PIEN,0) D
 ..S NODE=NODE+1,^TMP("DENT",$J,NODE)=$P(P0,U)
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)="$END "_TIEN
 I '$O(^TMP("DENT",$J,0)) S ^(1)="-1^No PERIO data found for the patient"
 Q
NULLS(CNT) ;create a string of cnt characters for PerioNulls
 N I,NU S CNT=$G(CNT,100),NU="" F I=1:1:CNT S NU=NU_0
 Q NU
 ;
HNC(RET,DATA,NUM)        ; RPC: DENTV TP GET HNC
 ;  get all of the Head&Neck data for a specified patient
 ;  RET = name of global array which stores the results to be returned
 ;  RET=^TMP("DENT",$J)
 ;  ^TMP("DENT",$J,#) = txn id^provider^X coord^Y coord^LesionDt^
 ;      Color^Shape^size^descr^deleted^master^link^result^readonly^history
 ;  DATA = DFN (patient ien)
 ;  Errors returned as -1^error message
 N X,TIEN,IEN,NODE,DFN,Y,FLDS,TMP,DENT,DENTERR,I,FROM,PIEN,P0
 S RET=$NA(^TMP("DENT",$J)),NODE=+$G(NUM),DFN=$G(DATA) K ^TMP("DENT",$J)
 S X=$$DFN^DENTVRF0(DFN) I X<0 S ^TMP("DENT",$J,1)=X Q
 S FLDS=".01;.03;4.01;4.02;.13;4.03;4.04;4.05;4.06;.23;4.07;4.08;4.09;.28;4.2" ;Added 4.2 HistoryOnly P59
 F TIEN=0:0 S TIEN=$O(^DENT(228.2,"AD",DFN,4,TIEN)) Q:'TIEN  D
 .S IEN=TIEN_"," D GETS^DIQ(228.2,IEN,FLDS,"IE","DENT","DENTERR")
 .K TMP M TMP=DENT(228.2,IEN) K DENT
 .F I=1:1:15 S FROM=$P(FLDS,";",I),$P(X,U,I)=$S(",2,5,8,12,"[(","_I_","):$G(TMP(FROM,"I")),1:$G(TMP(FROM,"E")))
 .;convert to Constants VALUE
 .S $P(X,U,8)=$P($G(^DENT(228.3,+$P(X,U,8),0)),U,3)
 .;convert TRUE/FALSE to -1/0
 .F I=10,11,13,14 S $P(X,U,I)=$S(+$P(X,U,I):-1,$P(X,U,I)="TRUE":-1,1:0)
 .;format date to MM/DD/YYYY@HH:MM
 .S:+$P(X,U,5) $P(X,U,5)=$$FMTE^XLFDT($P(X,U,5),5)
 .;get the transaction id of the link id pointer
 .I +$P(X,U,12) S $P(X,U,12)=+$G(^DENT(228.2,$P(X,U,12),0))
 .E  S $P(X,U,12)=0
 .I $P(X,U,11)=0,$P(X,U,12)=0 Q  ;P57 not master or detail Quit
 .I $P(X,U,15)="TRUE" S $P(X,U,15)=-1
 .E  S $P(X,U,15)=0
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)=X
 .F PIEN=0:0 S PIEN=$O(^DENT(228.2,TIEN,4.1,PIEN)) Q:'PIEN  S P0=^(PIEN,0) D
 ..S NODE=NODE+1,^TMP("DENT",$J,NODE)="WP"_U_$P(P0,U)
 ..Q
 .Q
 I '$O(^TMP("DENT",$J,0)) S ^(1)="-1^No HNC data found for the patient"
 Q
 ;
