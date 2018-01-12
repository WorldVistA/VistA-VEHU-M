AJK1UBTM ;580/MRL - Collections, XMIT Messages; 06-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called for the purpose of generating message off
 ;the transmission processor.  Messages include the statistical,
 ;error and actual transmission messages to the vendor.
 ;
 Q
 ;
XMIT ; --- this tag is called by ^AJK1UBT to actually transmit the
 ;     messages to the vendor
 ;
 K ^TMP($J,"AJK1M")
 S ERR=0 F AJK="N","U" Q:ERR  S (CT,I,SENT,NEW)=0 D
 .S:AJK="N" NEW=1
 .F  S I=$O(^TMP($J,"AJK",AJK,I)) Q:I'>0!(ERR)  S X=^(I),CT=CT+1 D
 ..S RT=+X,X1=$G(^TMP($J,"AJK",AJK,I,"T",1))
 ..S X2=$G(^TMP($J,"AJK",AJK,I,"T",2))
 ..S DC=$P(X,"^",3),PR=+$P(X,"^",2)
 ..I CT=1 S ERR=$$XMZ
 ..Q:ERR  ;couldn't create mailman message
 ..I '$$UP(I,DC,NEW,PR) D  Q  ;update if not previously sent
 ...S ^TMP($J,"AJKERR",99,AJK,I)="" ;zeroth node not in file
 ..S ^XMB(3.9,+XMZ,2,CT,0)=X1 ;1st line of xmit
 ..I $L($G(X2)) S CT=CT+1,^XMB(3.9,+XMZ,2,CT,0)=X2 ;2nd line of xmit
 ..S SENT=0
 ..D:CT=$$REC^AJK1UBCP SEND
 .I 'ERR,'SENT,CT D SEND ;send what's left
 Q
 ;
UP(IEN,DC,NW,PR) ; --- updates files with date xmit'd/msg number
 ;
 N I,CT,X,X1
 S X="^AJK1UB"_$S(NW:"",1:"S")_"("
 S X1=(X_+IEN_",0)")
 I '$D(@(X1)) Q 0
 S Y=$P(@(X1),"^",3)
 I Y K @(X_"""AM"","_+Y_","_+IEN_")") ;remove old msg on retransmit
 S Y=$P(@(X1),"^",2)
 I Y K @(X_"""AT"","_+Y_","_+IEN_")") ;remove old xmit date xref
 S $P(@(X1),"^",2)=DT ;date xmit'd
 S $P(@(X1),"^",3)=+XMZ ;msg #
 S @(X_"""AM"","_+XMZ_","_+IEN_")")="" ;msg x-ref
 S:NW @(X_"""AT"","_DT_","_+IEN_")")="" ;date xmit'd x-ref
 Q:'$L($G(DC)) 1
 ;
 ; --> update primary xref in status code file
 ;     when record is closed remove "AO" xref from transmital
 ;     file, and:   1)  pc3=set active flag to null
 ;                  2)  pc5=ptr to final status change record
 ;                  3)  pc7=final status code
 ;
 I 'NW,PR D
 .S @(X_"""AR"","_+PR_","_+IEN_")")="" ;primary record x-ref
 .S DC=$O(^DIZ(580950.8,"C",DC,0)) Q:'+DC
 .I $G(^AJK1UB(+PR,0)),$P($G(^DIZ(580950.8,DC,0)),"^",4) D
 ..S X=^AJK1UB(+PR,0),$P(X,"^",7)=DC ;disp status
 ..S $P(X,"^",4)="",$P(X,"^",5)=+IEN ;remove active/ptr to final
 ..S ^AJK1UB(+PR,0)=X ;save modified node
 ..K ^AJK1UB("AO",1,+PR) ;kill active x-ref
 ;
 ; ==> set up comments in file 430
 ;
 S X=$S(NW:"N",1:"U")_$S(RT:"$",1:"") D
 .S Y=+IEN I 'NW S Y=+PR
 .D UPDATE^AJK1UBTC(+Y,DT,X,DC)
 Q 1
 ;
SEND ; --- set up remainder of message and transmit
 ;
 K XMY
 N I,ERR,SENT
 S ^XMB(3.9,+XMZ,2,0)="^3.92A^"_+CT_"^"_+CT_"^"_DT
 I '$$GRP($$TGP^AJK1UBCP) S XMY(.5)=""
 ;I NEW S ^XMB(3.9,+XMZ,580000)=331
 D ENT1^XMD
 I '$D(^DIZ(580950.7,+XMZ,0)) D  ;update message file
 .S ^DIZ(580950.7,+XMZ,0)=+XMZ_"^"_DT_"^"_+CT_"^"_+NEW_"^1" ;zeroth node
 .S ^DIZ(580950.7,"B",+XMZ,+XMZ)="" ;'B' xref
 .S ^DIZ(580950.7,"AO",1,+XMZ)="" ;open
 .S X=^DIZ(580950.7,0),$P(X,"^",3)=+XMZ,$P(X,"^",4)=$P(X,"^",4)+1
 .S ^DIZ(580950.7,0)=X ;update zeroth node of file
 S SENT=1,CT=0
 Q
 ;
XMZ() ; --- grab a message number
 ;
 N I,CT,X
 S XMSUB="<"_AJKCP("C")_"> "_$S(AJK="N":"NEW",1:"UPDATE")_" Transmission"
 D XMZ^XMA2
 I XMZ'>0 Q 1
 S AJK1MSG(XMZ)=""
 Q 0
 ;
ERR ; --- format and send transmission error message
 ;
 S XMSUB="WARNING: Collection Transmission Aborted"
 K TXT
 S (C,I)=0 F  S I=$O(AJKERR(I)) Q:I'>0  S C=C+1 D
 .S TXT(C,0)="Error "_I_">>  "_AJKERR(I)
 S X=$$GRP($$UGP^AJK1UBCP)
 S X=$$GRP($$TGP^AJK1UBCP)
 S XMY(.5)=""
 S XMTEXT="TXT("
 D ^XMD
 ;
XMQ ; --- quit mailman and cleanup
 ;
 K XMSUB,XMY,XMTEXT,C,I,X Q
 ;
GRP(X) ; --- set up XMY(G.group)
 ;
 I $P(X,"^",2)="" Q 0
 S XMY("G."_$P(X,"^",2))=""
 Q 1
