VEJDWPCS ;DSS/SGM - RPC CALLS FOR DSS CORE MRM ;12/04/2002 14:04
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;See individual line tags for description of RPC calls
 Q
 ;
PAID(RET) ;  rpc call to get paid data
 N I,X,Y,ARR,DIERR,ERR,FLDS,PAID,TMP
 S PAID=+$G(^VA(200,DUZ,450)) I 'PAID D
 .S X=$P($G(^VA(200,DUZ,1)),U,9)
 .I $L(X) S X=$O(^PRSPC("SSN",X,0)) S:X PAID=X
 .Q
 S ARR(1)=$P($G(^VA(200,DUZ,0)),U)_U_DUZ
 I PAID S FLDS="2;6;8;9;15.5;16;17;42;49;95;458;590",PAID=PAID_"," D
 .D GETS^DIQ(450,PAID,FLDS,"IE","TMP","ERR") S I=1
 .F X=2:1:8,11,12 S I=I+1,ARR(I)=TMP(450,PAID,$P(FLDS,";",X),"E")
 .F X=2,49,95 S I=I+1,ARR(I)=$$PDT(TMP(450,PAID,X,"I"))
 .Q
 F I=1:1:13 S RET(I)=$G(ARR(I))
 Q
 ;
PDT(D) Q $S(D="":"",1:$E(D,4,5)_"/"_$E(D,6,7)_"/"_(1700+$E(D,1,3)))
