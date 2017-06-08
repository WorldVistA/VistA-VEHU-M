DENTVTPF ;DSS/KC - UPDATE PCE DX FOR TP ;06/20/2007 10:59
 ;;1.2;DENTAL;**53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------
 ;  1889  cont sub   $$DATA2PCE^PXAPI
 ;  2056      x      $$GET1^DIQ
 ;
UDX(DENTRET,DATA) ;rpc DENTV UPDATE PCE DX
 ;returns RET(n)=0^OK, or -1^error
 ;DATA(1)=Visit ien^Visit date
 ;DATA(n)=1^"POV"^dx ien^dx external^^desc
 ;DATA(n)=1^"PRV"^provider ien(file 200)^provider name
 ;
 N PKG,SOURCE,I,X,DENVIEN,DENVIEDT,CNT,VAR
 S DENTRET="0^OK"
 S PKG=0 D PKG^DENTVTPE
 I PKG<0 S DENTRET="-1^No Dental package file entry found" Q
 ;Setup the data for the DATA2PCE API
 S X=$G(DATA(1)) I 'X S DENTRET="-1^Visit not sent" Q
 S DENVIEN=+X,DENVIEDT=$$GET1^DIQ(9000010,DENVIEN,.01,"I") ;get the visit date
 S CNT=0,I=1 K ^TMP("DENTVTPE",$J)
 F  S I=$O(DATA(I)) Q:'I  S CNT=CNT+1 D
 .S X=DATA(I) I $P(X,U,2)="POV" D
 ..S ^TMP("DENTVTPE",$J,"DX/PL",CNT,"DIAGNOSIS")=$P(X,U,3)
 ..S ^TMP("DENTVTPE",$J,"DX/PL",CNT,"PRIMARY")=1
 .I $P(X,U,2)="PRV" D
 ..S ^TMP("DENTVTPE",$J,"PROVIDER",CNT,"NAME")=$P(X,U,3)
 ..S ^TMP("DENTVTPE",$J,"PROVIDER",CNT,"PRIMARY")=1
 .Q
 ;update PCE primary dx or Provider
 S VAR=$$DATA2PCE^PXAPI("^TMP(""DENTVTPE"",$J)",PKG,SOURCE,DENVIEN,"")
 K ^TMP("DENTVTPE",$J)
 Q
ENC ;delete by encounter, setup DATA array with txns
 N TXN,T0,T1  Q:'$G(ENC)
 S TXN=0 F  S TXN=$O(^DENT(228.2,"AG",ENC,TXN)) Q:'TXN  D
 .S T0=$G(^DENT(228.2,TXN,0)),T1=$G(^(1))
 .I $P(T0,U,12)'=104 Q  ;not complete
 .I $P(T0,U,29)>1 Q  ;not txn
 .I '$P(T1,U,19) Q  ;not filed to PCE
 .S DATA(TXN)=TXN
 .Q 
