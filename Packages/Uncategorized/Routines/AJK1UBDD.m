AJK1UBDD ;580/MRL - Collections, Data Dictionary Calls; 20-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routines is called, when necessary, to accomplish certain
 ;data dictionary field manipulation or transformation.  The 7.5
 ;nodes of the 580431.01 and 580431.04 DD's, which have fields
 ;dependent on these calls, have been set to insure that the file
 ;can't be edited if this routine doesn't exist.
 ;
DOW ; --- called by field .16 in file 580431.01
 ;     takes the input and checks to make sure only valid days of
 ;     the week are entered.
 ;
 N E,I,Y,Z
 Q:X=""
 I X="*" S X="SU MO TU WE TH FR SA" Q
 I $E(X,1,2)'?2UA K X Q
 S Y="",E=0
 F I=1,4,7,10,13,16,19 D
 .S Z=$E(X,I,I+1)
 .I Z="" Q
 .I " SU MO TU WE TH FR SA "'[(" "_Z_" ") S E=1 Q
 .S Y=Y_Z_$S(I<19:" ",1:"")
 I E K X Q  ;bad entry
 S X=Y
 I $E(X,$L(X))=" " S X=$E(X,1,$L(X)-1)
 Q
 ;
SET(AJKY,AJKD,AJKS) ; --- reset STRING CHECK field on entry/change
 ;                     sets the STRING to 0's
 ;                     AJKY = Length of string
 ;                     AJKD = ien (DA) of entry being processed
 ;                     AJKS = 1:SET; 0:KILL
 ;
 N AJK,AJKX
 S AJKX="",$P(AJKX,0,(AJKY+1))=""
 S ^DIZ(580431.04,AJKD,"S")=AJKX
 Q:$O(^DIZ(580431.04,AJKD,"D",0))'>0
 S AJK=0 F  S AJK=$O(^DIZ(580431.04,AJKD,"D",AJK)) Q:AJK'>0  D
 .I 'AJKS,+DA=+AJK Q  ;this is the one being killed---ignore it
 .D BLD(AJKD,AJK)
 Q
 ;
CHK ; --- check validity of new field columns
 ;
 N P
 I '+$P($G(^DIZ(580431.04,DA(1),0)),"^",2) D  K X Q
 .W "   Maximum string length not defined!"
 S P=+X,P(1)=+$P(X,",",2)
 S P(3)=$G(^DIZ(580431.04,DA(1),"S"))
 S P(5)=0 F P(6)=P:1:P(1) I +$E(P(3),P(6)) S P(5)=1
 I P(5) D  K X Q
 .W "  All, or part, of this range already in use!!",*7
 Q
 ;
BLD(AJK1,AJK2) ; --- set string columns as IN USE
 ;             AJK1 - entry being updated
 ;             AJK2 - data element being checked
 ;
 N AJKD,X,Y,Z
 S AJKD=$P($G(^DIZ(580431.04,+AJK1,"D",+AJK2,0)),"^",2)
 S Z=$G(^DIZ(580431.04,AJK1,"S"))
 S X="" F Y=+AJKD:1:+$P(AJKD,",",2) S X=X_1
 S Z=$E(Z,1,(+AJKD-1))_X_$E(Z,+$P(AJKD,",",2)+1,999)
 S ^DIZ(580431.04,AJK1,"S")=Z
 Q
