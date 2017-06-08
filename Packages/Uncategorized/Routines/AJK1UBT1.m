AJK1UBT1 ;580/MRL - Collections, XMIT Stat's Message; 02-Dec-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called after all processing (transmission) is
 ;completed.  It simply generates a short message indicating how
 ;many records, of each type (new, status updates & retransmits)
 ;were sent for that day.  It is of particular use to the collection
 ;agency in that (1) if they don't get this message it's an
 ;indication that a problem may exist, and (2), if the message is
 ;received and the numbers don't match the messages received there
 ;is a problem.
 ;
 D XMQ^AJK1UBTM
 S XMSUB="<"_AJKCP("C")_">> Transmission Activity Rpt"
 S XMTEXT="TXT("
 S X=$$GRP^AJK1UBTM($$TGP^AJK1UBCP)
 S TXT(1,0)="The following is a summary of transmission activity sent to you on the date"
 S TXT(2,0)="shown above from the "_$G(^DD("SITE"))_"."
 S TXT(3,0)=""
 S TXT(4,0)=$$T(1)
 S TXT(5,0)=$$T(2)
 S TXT(6,0)=$$T(3)
 S TXT(7,0)=""
 S TXT(8,0)="*Please note that any retransmissions shown above are included in the NEW,"
 S TXT(9,0)=" or UPDATES, totals displayed above, depending on the type of record which"
 S TXT(10,0)=" was retransmitted."
 S TXT(11,0)=""
 S TXT(12,0)="Transmissions are included in the following, local, messages:"
 S I=13,J=0,T=""
 F  S J=$O(AJK1MSG(J)) Q:J'>0  S T=T_$E(J_"         ",1,15) D
 .I $L(T)>70 S TXT(I,0)=T,T="",I=I+1
 I $L(T) S TXT(I,0)=T
 D ^XMD
 K I,J,T
 D XMQ^AJK1UBTM
 Q
 ;
T(T) ; --- return message line
 ;     T = 1) New records
 ;         2) Updates
 ;         3) Retransmissions
 ;
 N X,X1
 S X="Number of "_$P("NEW records^UPDATES^RETRANSMISSIONS","^",+T)
 S:X<3 X=X_" transmitted"
 E  S X=X_" included"
 S X=$E(X_" ...................................................",1,65)
 S X1=$P("NC^SC^RC","^",T),X1=+$G(@X1)
 S X=X_"  "_$J(X1,7)
 Q X
