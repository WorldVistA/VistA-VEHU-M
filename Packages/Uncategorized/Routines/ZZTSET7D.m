ZZTSET7D        ;ciofo-scramble patient data (cont) ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 ; original concept/code taken from ZDWGTDM2 (author unknown)
 ;
 N ZZDATA
 S ZZDATA=$G(^DPT(DA,.321))
 I $P(ZZDATA,U,10)'="" D
 .S Y=$P(ZZDATA,U,10)
 .D SCRAM
 .S $P(ZZDATA,U,10)=X
 .S ^DPT(DA,.321)=ZZDATA
 .K ZZDATA
 ;
 S ZZDATA=$G(^DPT(DA,.33))
 I ZZDATA'="" D
 .I $P(ZZDATA,U,1)]"" D NAME S $P(ZZDATA,U,1)=X
 .I $P(ZZDATA,U,6)]"" S $P(ZZDATA,U,6)=NCITY
 .I $P(ZZDATA,U,7)]"" S $P(ZZDATA,U,7)=NSTATE
 .I $P(ZZDATA,U,8)]"" S $P(ZZDATA,U,8)=NZIP+$R(100)
 .I $P(ZZDATA,U,9)]"" D PHONE S $P(ZZDATA,U,9)=X
 .S ^DPT(DA,.33)=ZZDATA
 .K ZZDATA
 ;
 S ZZDATA=$G(^DPT(DA,.331))
 I ZZDATA'="" D
 .I $P(ZZDATA,U,1)]"" S X="" D NAME S $P(ZZDATA,U,1)=X
 .I $P(ZZDATA,U,6)]"" S $P(ZZDATA,U,6)=NCITY
 .I $P(ZZDATA,U,7)]"" S $P(ZZDATA,U,7)=NSTATE
 .I $P(ZZDATA,U,8)]"" S $P(ZZDATA,U,8)=NZIP+$E(100)
 .I $P(ZZDATA,U,9)]"" D PHONE S $P(ZZDATA,U,9)=X
 .S ^DPT(DA,.331)=ZZDATA
 .K ZZDATA 
 ;
 S ZZDATA=$G(^DPT(DA,.34))
 I ZZDATA'="" D
 .I $P(ZZDATA,U,1)]"" S X="" D NAME S $P(ZZDATA,U,1)=X
 .S:$P(ZZDATA,U,6)]"" $P(ZZDATA,U,6)=NCITY
 .S:$P(ZZDATA,U,7)]"" $P(ZZDATA,U,7)=NSTATE
 .S:$P(ZZDATA,U,8)]"" $P(ZZDATA,U,8)=NZIP+$R(100)
 .I $P(ZZDATA,U,9)]"" D PHONE S $P(ZZDATA,U,9)=X
 .S ^DPT(DA,.34)=ZZDATA
 .K ZZDATA
 Q
 ;
SCRAM S X="" F L=1:1:$L(Y) S ST=$E(Y,L),X=X_$S(ST?1A:$C($A(ST)-64+$R(26)#26+65),ST?1N:$R(9),1:ST)
 Q
 ;
PHONE S X="(800) "_(100+$R(900))_" "_(1000+$R(9000))
 Q
 ;
NAME I $D(^DPT(DA,.21)),$P($G(^DPT(DA,.33)),U,2)=$P(^DPT(DA,.21),U,2) S X=$P(^(.21),U,1) Q
 I $D(^DPT(DA,.33)) D  Q
 .S Y=$P(^(.33),U,2)
 .I Y]"",$S(Y["WIFE":1,Y["SISTER":1,Y["MOTHER":1,Y["DAU":1,Y["MOM":1,Y["NIECE":1,Y["GIRL":1,1:0) D
 ..S RND=$R(15)+1
 ..S LIN=$R(NFN)+1
 ..S FNAME=$P(^TMP($J,"FENAME",LIN),U,RND)
 ..S X=$P($P(^DPT(DA,0),U,1),",",1)_","_FNAME
 ;
 ; else, get a name we can use...
 S RND=$R(15)+1
 S LIN=$R(NMN)+1
 S FNAME=$P(^TMP($J,"FNAME",LIN),U,RND)
 S RND=$R(15)+1
 S LIN=$R(NLN)+1
 S LNAME=$P(^TMP($J,"LNAME",LIN),U,RND)
 S MI=$E("ABCDEFGHIJKLMNOPQRSTUVWXYZ ",$R(27)+1)
 S X=FNAME_$S(MI?1A:" "_MI_". ",1:"")_LNAME
 Q
