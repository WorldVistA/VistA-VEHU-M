AJK1UBCP ;580/MRL - Collections, Parameters; 07-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called to process collection parameters activities
 ;such as editing the data and returning the collection variables.
 ;
EDIT ; --* call to edit collection parameters
 ;     uses ScreenMan to permit editing of the Collection
 ;     Parameters.  User must hold the AJK1UB SUPERVISOR key.
 ;
 I '$$KEY Q
 S DDSFILE="^DIZ(580950.1,",DR="[AJK1UB PARAMETERS]",DA=1 D ^DDS
 K DDSFILE,DR,DA
 Q
 ;
CPAR ; --- Call to obtain parameters for collections activity.
 ;     Returns the AJKPAR array.
 ;
 ;     AJKCP("B") = # days to look BACK
 ;          ("C") = CLIENT id
 ;          ("E") = EARLIEST day to ever search
 ;          ("M") = Minimum principle amount
 ;          ("R") = # RECORDS per message
 ;          ("S") = last SEARCH date
 ;          ("V") = VENDOR id
 ;          ("X") = maximum number of XMIT'S
 ;
 ;     AJKCP is returned as zero if all necessary parameters are
 ;     not defined.
 ;
 K AJKCP
 N I,X,Y
 S AJKCP=1
 S X=$G(^DIZ(580950.1,1,0))
 F I=1,2,3 I $$PIECE(I)="" S AJKCP=0,$P(AJKCP,"^",2)=$P(AJKCP,"^",2)_I
 I 'AJKCP Q
 F I=2:1:8 S Y=$E("CVRXBSE",(I-1)) D
 .S AJKCP(Y)=$$PIECE(I)
 S AJKCP("M")=+$$PIECE(18)
 ; ---> following sets defaults for null parameters
 S:'AJKCP("R") AJKCP("R")=250
 S:'AJKCP("B") AJKCP("B")=90
 S:'AJKCP("X") AJKCP("X")=99999999
 S:AJKCP("E")'?7N AJKCP("E")="2951001"
 Q
 ;
MAX() ; --- principle amt exceeds this amount
 ;
 Q $$PIECE(18)
 ;
DOW() ; --- days of the week to generate activity report
 ;     Should we generate the report today
 ;     Call H^%DTC to get current DOW and then checks
 ;     the parameter in file 580950.1 to see if this
 ;     is a report date.  Returns 1, if YES; 0, if no.
 ;
 N D,I,Y
 S X=DT D H^%DTC S D=(%Y+1)
 S X=$$PIECE(16) I '$L(X) Q 0
 I X[$P("SU^MO^TU^WE^TH^FR^SA","^",D) Q 1
 Q 0
 ;
KEY() ; --- security key held
 ;     1 = key held or not needed; 0 = not held
 ;
 I $G(DUZ(0))="@" S X=1 G KEYQ
 S X=$$PIECE(11)
 S X=$S($D(^VA(200,+$G(DUZ),51,+X)):1,1:0)
 ;
KEYQ ; --- come here to quit key processing
 ;
 W:'X !?4,"You don't have the necessary privileges to use this option."
 Q X
 ;
REC() ; --- number of records to include
 ;
 S X=$$PIECE(4) S:'X X=250 Q X
 ;
TGP() ; --- transmit mail group
 ;
 S X=$$PIECE(9)
 ;
GPQ ; --- come here to quit group processing
 ;
 I $G(^XMB(3.8,+X,0))'="" S X=X_"^"_$P(^(0),"^",1)
 E  S X=0
 I +X,$O(^XMB(3.8,+X,1,0))'>0 S X=0 ;no members
 Q X
 ;
UGP() ; --- update notification group
 ;
 S X=$$PIECE(10) G GPQ
 ;
RGP() ; --- report notification group
 ;
 S X=$$PIECE(20) G GPQ
 ;
PIECE(X) ; --- get parameter piece
 ;
 S X=$P($G(^DIZ(580950.1,1,0)),"^",+X) Q X
 ;
FILE() ; --- check, and update, zeroth node of file 580950.2
 ;
 N C,I,L,X
 S X=$G(^AJK1UB(0)) G CTR:X]""
 I '$D(^DIC(580950.2,0))!('$D(^DD(580950.2,0))) Q 0
 S ^AJK1UB(0)="AJK1UB TRANSMITAL^580950.2P^"
 ;
CTR ; --- update counter in transmital file
 ;
 S X=$G(^AJK1UB(0))
 S (C,I,L)=0
 F  S I=$O(^AJK1UB(I)) Q:I'>0  S C=C+1,L=I
 S $P(X,"^",3)=L,$P(X,"^",4)=C
 S ^AJK1UB(0)=X
 Q 1
