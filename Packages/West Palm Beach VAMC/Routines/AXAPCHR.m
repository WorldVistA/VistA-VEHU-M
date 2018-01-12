AXAPCHR ;WPB/JLTP ; RPC BROKER CALLS ; 30-SEP-98
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
GT(G,M) ;------ Get Message Text ------
 ; G = Global to return data in
 ; M = Message Number
 N I,L,X
 S G=$NA(^TMP($J,"MESG")) K @G
 S L=0,I=.9 F  S I=$O(^XMB(3.9,M,2,I)) Q:'I  S X=^(I,0) Q:X="$END TXT"  D
 .S L=L+1,^TMP($J,"MESG",L,0)=X
 Q
GN(G,M) ;------ Get Patch Notes ------
 ; G = Global to return data in
 ; M = Message Number
 N I,L,X
 S G=$NA(^TMP($J,"MESG")) K @G
 S RN=0 F  S RN=$O(^XMB(3.9,M,3,RN)) Q:'RN  S R=+^(RN,0) D
 .S L=0,I=.9
 .S X=$G(^XMB(3.9,R,0)),Y=$P(X,U,2) I Y=+Y S Y=$P($G(^VA(200,Y,0)),U)
 .S X=$P(X,U)_"  ("_Y_")  "_$$FMTE^XLFDT($P(X,U,3))
 .S L=L+1,^TMP($J,"MESG",L,0)=X
 .F  S I=$O(^XMB(3.9,R,2,I)) Q:'I  S X=^(I,0) Q:X="$END TXT"  D
 ..S L=L+1,^TMP($J,"MESG",L,0)=X
 .S L=L+1,^TMP($J,"MESG",L,0)=" "
 Q
