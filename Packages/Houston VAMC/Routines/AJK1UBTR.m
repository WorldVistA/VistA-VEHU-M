AJK1UBTR ;580/MRL - Collections, XMIT Retransmits; 17-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This process is called to handle the retransmission of data.
 ;AUTO is called to check existing transmission data to see if
 ;it should be set up to transmit again.  Other supported entry
 ;points allow for the transmission of single records and groups
 ;of records, by original mail message number or original date
 ;of transmission.
 ;
AUTO ; --- Look for retransmit's
 ;     Called by ^AJK1UBT to find existing records which, in all
 ;     probability, weren't transmitted when they were supposed
 ;     to have been and set them up in the retransmit file.
 ;
 ;     1)  Anything open in transmit file w/o date transmitted
 ;     2)  Anything open in status change file
 ;     3)  Anything identified as having message not sent in
 ;         number of days specified by parameters
 ;
 ; --> get count of manually set up retransmissions
 ;
 S I=0 F  S I=$O(^DIZ(580950.4,I)) Q:I'>0  S RC=$G(RC)+1
 ;
 ; --> set up new xmit's w/o xmit date for retransmission
 ;
 S I=0 F  S I=$O(^AJK1UB("AO",1,I)) Q:I'>0  D
 .S X=^AJK1UB(+I,0) I '$P(X,"^",2) S X=$$RT(1,I)
 ;
 ; --> set up status changes not yet xmit'd for retransmission
 ;
 S I=0 F  S I=$O(^AJK1UBS("AO",1,I)) Q:I'>0  S X=$$RT(0,I)
 ;
 ; --> set up records in overdue message for retransmission
 ;
 I $$CHECK^AJK1UBTU(1,0) D
 .S I=0 F  S I=$O(^TMP($J,"AJKR",I)) Q:I'>0  D M(I)
 K ^TMP($J,"AJKR")
 ;
 ; --> place everything found in ^tmp($J,"AJK" for retransmit
 ;
 S I=0 F  S I=$O(^DIZ(580950.4,I)) Q:I'>0  D
 .S X=$P(^(I,0),"^",1) D TMP(X)
 Q
 ;
TMP(T) ; --- set retransmits into transmission global
 ;
 N I,N,N1,X,Y,Z
 S X=$S(T["UBS":0,1:1)
 S (Y,Z)="" I 'X S N=$G(^AJK1UBS(+T,0)) D:+N
 .S Y=$P(N,"^",10) ;primary record
 .S N=$G(^AJK1UBS(+T,"R",1,0)) Q:N=""
 .S N1=$G(^DIZ(580950.6,2,"D",18,0)) Q:N1=""
 .S Z=$E(N,+$P(N1,"^",2),+($P(N1,"^",2)+($P(N1,"^",3)-1)))
 S X=$$SET^AJK1UBT(X,+T,1,Y,"","",Z)
 Q
 ;
RT(X,Y) ; --- set up retransmit file
 ;     X = (1)  New transmit
 ;         (0)  Status Change
 ;     Y = IEN of record to be set up
 ;
 ;     returns 0 if record already exists in retransmit file
 ;             1 if new record was created.
 ;
 S X=+Y_";AJK1UB"_$S(X:"",1:"S")_"("
 I $O(^DIZ(580950.4,"B",X,0))>0 Q 0  ;already exists
 K DD,DO
 S DIC="^DIZ(580950.4,",DIC(0)="LZ",DLAYGO=580950.4 D FILE^DICN
 K DIC,DLGAYGO
 S RC=$G(RC)+1
 Q 1
 ;
OLD ; --- clean-up retransmission file
 ;
 ;S I=0 F  S I=$O(^DIZ(580950.4,I)) Q:I'>0  S X=$$DEL(I)
 S X=$P($G(^DIZ(580950.4,0)),"^",1,2)
 Q:'$L(X)
 K ^DIZ(580950.4)
 S ^DIZ(580950.4,0)=X
 Q
 ;
DEL(IEN) ; --- delete a retransmission record
 ;             ien = record to delete
 ;             returns $D of node deleted
 ;
 N I
 S DIK="^DIZ(580950.4,",DA=+IEN D ^DIK
 Q $D(^DIZ(580950.4,+IEN,0))
 ;
MSG ; --- interactive retransmit/message number
 ;
 D M(0) Q
 ;
M(W) ; --* retransmit by message number
 ;     entry point to pick a message number and set up for retransmission
 ;     If W is defined we're not interactive and W is the message #
 ;
 N I
 I +W S N=+W G M1
 R !!,"Select Message Number:  ",N:DTIME G END:'$T!(N="")
 I $L(N)>10 S N="?"
 I N["?" D  G MSG
 .W !?4,"Enter a message number from either the Transmittal or Status"
 .W !?4,"Change file for which you'd like the records retransmitted."
 .W !?4,"Once you confirm your selection these records will be set-up"
 .W !?4,"to go with the next regularly scheduled transmission."
 S N=+N G END:'+N
 ;
M1 ; --- come here if non-interactive
 ;
 S FLAG=-1 F I="AJK1UB(","AJK1UBS(" W:'W !!,"Searching " D
 .W:'W $S(I["S":"Status Change",1:"New")," Transmission Records..."
 .I $O(@("^"_I_"""AM"","_N_",0)")) S FLAG=$S(I["S":0,1:1)
 I FLAG<0 D:'W  G MSG:'W,END
 .W !!,"No records found with this message number assigned."
 K ^TMP($J,"AJKM")
 S (C,I)=0,GLOB="^AJK1UB"_$S(FLAG:"",1:"S")_"("_"""AM"","_N_","
 F  S I=$O(@(GLOB_I_")")) Q:I'>0  S C=C+1,^TMP($J,"AJKM",I)=""
 I W D FLAG G END
 W !!,+C," record",$S(C>1:"s",1:"")," found in the "
 W $S(FLAG:"TRANSMITAL",1:"STATUS CHANGE")," file..."
 ;
OK ; --- ok to set up
 ;
 W !!,"Sure you want to flag for retransmission" S %=2 D YN^DICN
 I % G MSG:%'=1
 I '% D  G OK
 .W !?4,"If you want to flag for retransmission please respond YES."
 .W !?4,"If not answer NO."
 D FLAG
 W !!,"<All Done>",*7
 G END
 ;
FLAG ; --- flag a group of records, in a single message, for re-xmit
 ;
 S IEN=0 F  S IEN=$O(^TMP($J,"AJKM",IEN)) Q:IEN'>0  D
 .S X=$$RT(FLAG,IEN)
 Q
 ;
END ; --- that's all folks
 ;
 Q
