A1BFMAI1 ;ALBANY ISC ; ECF ; 12APRIL92  13:46 [ 05/20/93  1:40 PM ]
 ;;V1.0
EN ;Routine 2 of daily E-mail report generation
 ;MSM version
START ;
 D VAR,GTOT,HDR,LOOP,FTR
 D SENDLOC^A1BFMAI2
 D SENDFAR^A1BFMAI2,EXIT
 Q
VAR ;Check critical variables
 S A1BFZERO="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 Q:'$D(A1BFARR)  F A1BFI=8:1:17 S:'$D(A1BFARR(A1BFI)) A1BFARR=A1BFZERO
 S U="^"
 ;Count number of good prime time hours
 S A1BFGH=0 F A1BFI=8:1:17 S:$P(A1BFARR(A1BFI),U,1)>0 A1BFGH=A1BFGH+1
 S:A1BFGH=0 A1BFGH=1
 ;Check kernel version
 S A1BFKV=6 I $D(^ ("XUS")) S A1BFKV=$P($T(+2^XUS),";",3)
 S A1BFKV=$E(A1BFKV,1) I A1BFKV'>6 S A1BFKV=6
 Q
GTOT ;Create day totals for message header
 S A1BFMU=0 F A1BFI=8:1:17 S:$P(A1BFARR(A1BFI),U,6)>A1BFMU A1BFMU=$P(A1BFARR(A1BFI),U,6)  ;Largest number of users (partitions)
 S A1BFMTJ=0 F A1BFI=8:1:17 S:$P(A1BFARR(A1BFI),U,8)>A1BFMTJ A1BFMTJ=$P(A1BFARR(A1BFI),U,8)  ;Largest number of TaskMan jobs running
 S A1BFMDV=0 F A1BFI=8:1:17 S:$P(A1BFARR(A1BFI),U,7)>A1BFMDV A1BFMDV=$P(A1BFARR(A1BFI),U,7)  ;Largest number of devices in use
 S A1BFUSGT=0 F A1BFI=8:1:17 S A1BFUSGT=A1BFUSGT+$P(A1BFARR(A1BFI),U,12)
 S A1BFUSGT=$J(A1BFUSGT/A1BFGH,0,0)
 S A1BFRTGT=0 F A1BFI=8:1:17 S A1BFRTGT=A1BFRTGT+$P(A1BFARR(A1BFI),U,10)
 S A1BFRTGT=$J(A1BFRTGT/A1BFGH,0,2)
 S A1BFTMGT=0 F A1BFI=8:1:17 S A1BFTMGT=A1BFTMGT+$P(A1BFARR(A1BFI),U,11)
 S A1BFTMGT=$J(A1BFTMGT/A1BFGH,0,0)
 S A1BFDVGT=0 F A1BFI=8:1:17 S A1BFDVGT=A1BFDVGT+$P(A1BFARR(A1BFI),U,13)
 S A1BFDVGT=$J(A1BFDVGT/A1BFGH,0,0)
 Q
HDR ;Create mail message header
 S ^UTILITY($J,"A1BFMSG",1)="Good Morning...",^UTILITY($J,"A1BFMSG",2)="  "
 S ^UTILITY($J,"A1BFMSG",3)="During Prime Time 8am-5:00pm, the Average Response Time was --> "_A1BFRTGT_$S(A1BFRTGT?.N:"sec.",1:"")
 S ^UTILITY($J,"A1BFMSG",4)="The AVG # of users was --> "_A1BFUSGT_".  The MAX # of users was --> "_A1BFMU_"."
 S ^UTILITY($J,"A1BFMSG",5)="The AVG # of devices was --> "_A1BFDVGT_". The MAX number of devices was "_A1BFMDV_"."
 S A1BFMSGL=6
 I A1BFKV>6 S A1BFMSGL=A1BFMSGL+1 S ^UTILITY($J,"A1BFMSG",A1BFMSGL)="The AVG # of tasked jobs was --> "_A1BFTMGT_".  The MAX # of tasked jobs was "_A1BFMTJ S A1BFMSGL=A1BFMSGL+1
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+1)="The average hourly response times (in seconds) and avg. # of users follows: " S A1BFMSGL=A1BFMSGL+1
 Q
LOOP ;Finish message with hourly figures
 F A1BFI=1:1:3 D
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+1)=""
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+2)=$J(" ",10)
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+3)="R/T"_$J(" ",9)
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+4)="Avg. Users  "
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+5)="Max. Users  "
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+6)="Avg. Devices"
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+7)="Max. Devices"
 .I A1BFKV>6 D
 ..S ^UTILITY($J,"A1BFMSG",A1BFMSGL+8)="Avg. TM jobs"
 ..S ^UTILITY($J,"A1BFMSG",A1BFMSGL+9)="Max. TM jobs"
 ..S ^UTILITY($J,"A1BFMSG",A1BFMSGL+10)=""
 ..;S ^UTILITY($J,"A1BFMSG",A1BFMSGL+11)=""
 .I A1BFKV<7 S ^UTILITY($J,"A1BFMSG",8)=" "
 .I A1BFI=1 F A1BFJ=7:1:14 D HOURS
 .I A1BFI=2 F A1BFJ=15:1:22 D HOURS
 .I A1BFI=3 F A1BFJ=23,0:1:6 D HOURS
 .S A1BFMSGL=A1BFMSGL+$S(A1BFKV>6:10,1:8)
 Q
HOURS ;Loop for 8 hours per mail msg line
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+2)=$P($T(LABELS+A1BFI^A1BFMAI3),";;",2)
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+3)=^UTILITY($J,"A1BFMSG",A1BFMSGL+3)_$J($P(A1BFARR(A1BFJ),U,10),8)
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+4)=^UTILITY($J,"A1BFMSG",A1BFMSGL+4)_$J($P(A1BFARR(A1BFJ),U,12),8)
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+5)=^UTILITY($J,"A1BFMSG",A1BFMSGL+5)_$J($P(A1BFARR(A1BFJ),U,6),8)
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+6)=^UTILITY($J,"A1BFMSG",A1BFMSGL+6)_$J($P(A1BFARR(A1BFJ),U,13),8)
 S ^UTILITY($J,"A1BFMSG",A1BFMSGL+7)=^UTILITY($J,"A1BFMSG",A1BFMSGL+7)_$J($P(A1BFARR(A1BFJ),U,7),8)
 I A1BFKV>6 D
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+8)=^UTILITY($J,"A1BFMSG",A1BFMSGL+8)_$J($P(A1BFARR(A1BFJ),U,11),8)
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL+9)=^UTILITY($J,"A1BFMSG",A1BFMSGL+9)_$J($P(A1BFARR(A1BFJ),U,8),8)
 Q
FTR ;
 Q:'$D(A1BF("GAP"))
 S A1BFJ=0 F A1BFI=0:0 S A1BFJ=$O(A1BF("GAP",A1BFJ)) Q:A1BFJ=""  D
 .S A1BFMSGL=A1BFMSGL+1 S A1BFK=$P(A1BF("GAP",A1BFJ),U,1),A1BFL=$P(A1BF("GAP",A1BFJ),U,2)
 .S Y=A1BFK D DD^%DT S A1BFK=$P($P(Y,"@",2),":",1,2),A1BFK=$S($P(A1BFK,":",1)>12:($P(A1BFK,":",1)-12)_":"_$P(A1BFK,":",2)_"PM",$E(A1BFK,1)="0":$E(A1BFK,2,5)_"AM",1:A1BFK_"AM")
 .S Y=A1BFL D DD^%DT S A1BFL=$P($P(Y,"@",2),":",1,2),A1BFL=$S($P(A1BFL,":",1)>12:($P(A1BFL,":",1)-12)_":"_$P(A1BFL,":",2)_"PM",$E(A1BFL,1)="0":$E(A1BFL,2,5)_"AM",1:A1BFL_"AM")
 .S ^UTILITY($J,"A1BFMSG",A1BFMSGL)="Data missing for "_A1BFK_" to "_A1BFL
 Q
EXIT ;
 K A1BFDVGT,A1BFGH,A1BFI,A1BFJ,A1BFK,A1BFMDV,A1BFMSGL,A1BFMSGT,A1BFMTJ,A1BFMU,A1BFRTGT,A1BFTMGT,A1BFUSGT
 Q
