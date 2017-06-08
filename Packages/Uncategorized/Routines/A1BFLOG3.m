A1BFLOG3 ;ALBANY ISC ; ECF ; 16APR1993 0830AM [ 06/24/93  9:08 AM ]
 ;;V1.0
EN ;
CHK ;If data is missing, get rid of message
 I '$D(A1BFTT)!'$D(A1BFTMJ)!('$D(A1BFDEVU))!('$D(A1BFAJOB))!('$D(A1BFRT)) G EXIT 
 ;No text? go to exit
 I '$D(^XMB(1,1,"INTRO",0)) G EXIT
 ;Just started? go to exit
 I A1BFINT1=0 G EXIT
 ;Set up text lines
 S:'$D(A1BFSP) $P(A1BFSP," ",78)=" "
 S A1BFNL1="As of "_A1BFTT_" today the response time was "_$S('$D(A1BFRT):"UNKNOWN",A1BFRT="99999":"UNKNOWN",1:A1BFRT_" second"_$S(A1BFRT>1:"s.",1:"."))
 S A1BFNL2="There "_$S(A1BFDEVU>1:"are",1:"is")_" presently "_A1BFDEVU_" interactive user"_$S(A1BFDEVU>1:"s",1:"")_" on the system."
 S A1BFNL3="There "_$S(A1BFAJOB-A1BFDEVU>0:"are ",1:"is ")_$S(A1BFAJOB-A1BFDEVU>0:A1BFAJOB-A1BFDEVU,1:0)_" background job"_$S(A1BFAJOB-A1BFDEVU'=1:"s",1:"")_" running."
 S A1BFNL4="There "_$S(A1BFTMJ>1:"are",1:"is")_" also "_A1BFTMJ_" tasked job"_$S(A1BFTMJ>1:"s",1:"")_" running."
 S A1BFNL5="The response time during the previous 5 minutes has been "_$S('$D(A1BFRT):"UNKNOWN",A1BFRT<.6:"EXCELLENT",A1BFRT<.75:"ABOVE AVERAGE",A1BFRT<1:"AVERAGE",A1BFRT<1.5:"FAIR",A1BFRT<2.5:"POOR",1:"UNKNOWN")
 F I3=1:1:5 S @("A1BFNL"_I3)=$E(A1BFSP,1,(80-$L(@("A1BFNL"_I3))\2)-1)_@("A1BFNL"_I3)
 ;Count lines, find last line number
 F I=0:0 S I1=I S I=$O(^XMB(1,1,"INTRO",I)) Q:I=""  I $D(^XMB(1,1,"INTRO",I,0)) Q:(^(0))["the response time was"
 F I=1:1:5 S ^XMB(1,1,"INTRO",I1+I,0)=@("A1BFNL"_I)
 ;Update zero node of intro text
 S (I,I1,I2)=0 F  S I=$O(^XMB(1,1,"INTRO",I)) Q:I=""  S I1=I,I2=I2+1
 S $P(^XMB(1,1,"INTRO",0),U,3)=I2
 S $P(^XMB(1,1,"INTRO",0),U,4)=I1
 Q
DELET ;To get rid of text
 F I=0:0 S I1=I S I=$O(^XMB(1,1,"INTRO",I)) Q:I=""  I $D(^XMB(1,1,I,0)) Q:^(0)["the response time was" 
 Q:I1=0  F I2=1:1:5 I $D(^XMB(1,1,"INTRO",I+I2,0)) I ^(0)[$P($T(TEXT+I2),";",3) S ^XMB(1,1,"INTRO",I+I2)=$P($T(TEXT+I2),";",4)         
 ;Update zero node of intro text - just in case
 S (I,I1,I2)=0 F  S I=$O(^XMB(1,1,"INTRO",I)) Q:I=""  S I1=I,I2=I2+1
 S $P(^XMB(1,1,"INTRO",0),U,3)=I2
 S $P(^XMB(1,1,"INTRO",0),U,4)=I1
 Q
TEXT ;
 ;;the response time was;      --------------------------------------------------
 ;; interactive user;                         Response Data
 ;; background job;                         Not Available
 ;; tasked job;                           
 ;;The response time during;--------------------------------------------------
EXIT ;
 K A1BFNL1,A1BFNL2,A1BFNL3,A1BFNL4,A1BFNL5,A1BFTT,I1,I2,I3
 Q
