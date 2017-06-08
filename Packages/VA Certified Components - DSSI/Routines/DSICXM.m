DSICXM ;DSS/SGM - RPC TO SEND MAILMAN MESSAGE ;02/11/2003 15:17
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#   SUPPORTED
 ;  -----   ---------------------------
 ;  10104   UP^XLFSTR
 ;   2729   SENDMSG^XMXAPI
 ;
SEND(RET,ARR) ; RPC: DSIC XM SEND MAIL MSG
 ;  send a mail message
 ;  This format was used becasue multiple array can be sent and
 ;    the broker at this time does not support more than one
 ;    List type input parameter
 ;  ARR(sub) - required input array where 'sub' can be any value
 ;  Format: ARR(sub) - parameter name ^ value
 ;  Acceptable parameters:
 ;    FLAGS - optional - string of uppercase characters representing
 ;            special instructions [.XMINSTR]
 ;            P = priority
 ;            I = info only
 ;            X = closed
 ;            C = confidential
 ;            R = confirm receipt
 ;     FROM - optional - default to user DUZ
 ;SELF BSKT - optional - if FROM=user DUZ then name of user's basket to
 ;            deliver message
 ;    VAPOR - optional - Fileman date.time for which this message should
 ;            be deleted from recipient's baskets
 ;     SUBJ - required - subject of mail message 3-65 characters
 ;    NOTME - optional - if ARR(sub) = "NOTME^1" then DO NOT include
 ;            user DUZ as a recipient.  Otherwise user DUZ will always
 ;            be a recipient even if they are not included in the
 ;            recipient list.
 ;      REC - optional - recipient to receive mail message
 ;            each recipient will be a separate ARR(sub) entry
 ;            acceptable formats for recipient values:
 ;              DUZ number
 ;              G.mail group name
 ;              D.device name
 ;              S.server name
 ;              For DUZ and mail groups there are additional params:
 ;                 I: to indicate this one for INFO only
 ;                 C: to indicate this one for cc (copy) only
 ;                 L@fileman_datetime: - deliver to this user at the
 ;                    later specified date.time
 ;                 Example: I:1301 for user 1301
 ;                          CL@3021224.23:G.IRM STAFF
 ;     TEXT - required - text of mail message - each line of text in
 ;            the message will be a separate ARR(sub) entry.  No line
 ;            should exceed 80 characters
 ;
 ;  Return message number if successful, else return -1^error message
 ;
 N I,J,X,Y,Z,FROM,INSTR,NOTME,SUBJ,TEXT,TO,XMERR,XMZ
 K ^TMP("XMERR",$J)
 S I="" F  S I=$O(ARR(I)) Q:I=""  D
 .S X=$P(ARR(I),U),Y=$P(ARR(I),U,2)
 .I X?.E1L.E S X=$$UP^XLFSTR(X)
 .I X="FLAGS" D:$L(Y)  Q
 ..I Y?.E1L.E S Y=$$UP^XLFSTR(Y)
 ..S Z="" F J=1:1:$L(Y) S:"PIXCR"[$E(Y,J) Z=Z_$E(Y,J)
 ..S:Z]"" INSTR("FLAGS")=Z
 ..Q
 .I X="FROM" S:Y]"" FROM=Y Q
 .I X="SELF BSKT" S:Y]"" INSTR("SELF BSKT")=Y Q
 .I X="VAPOR" S:Y'<DT INSTR("VAPOR")=Y Q
 .I X="SUBJ" S:Y]"" SUBJ=Y Q
 .I X="NOTME" S:Y=1 NOTME=1 Q
 .I X="REC" S:Y]"" TO(Y)="" Q
 .I X="TEXT" S Z=1+$O(TEXT("A"),-1),TEXT(Z,0)=Y
 .Q
 I $G(NOTME) F Z="","I:","C:","IC:","CI:" K TO(Z_DUZ)
 E  S X=0 D
 .F Z="","I:","C:","IC:","CI:" I $D(TO(Z_DUZ)) S X=1 Q
 .I 'X S TO(DUZ)=""
 .Q
 I '$D(TEXT) S RET="-1^No message text received" Q
 I '$D(SUBJ) S RET="-1^No message subject received" Q
 I '$D(TO) S RET="-1^No recipients received" Q
 I '$D(FROM) S FROM=DUZ
 D SENDMSG^XMXAPI(FROM,SUBJ,"TEXT",.TO,.INSTR,.XMZ)
 S RET=$S($G(XMZ)>0:XMZ,1:$$ERR)
 Q
 ;
ERR() ;  process mailman error array and return a single string
 ;  Return Mailman error message string, or <null> if no error
 N X,Z,ROOT,STOP
 S ROOT=$NA(^TMP("XMERR",$J)),STOP=$E(ROOT,1,$L(ROOT)-1)
 S X=""
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  S Z=@ROOT Q:($L(X)+$L(Z))>252  S X=X_Z_" "
 K ^TMP("XMERR",$J) S:X]"" X="-1^"_X
 Q X
