BACKSTR ;YZH;29-SEP-83;BACKUP START OPTION SELECTOR
START S QUES="NMQ",DEF="" S (ANS,%A,NM)="NORM AAA"
 I '$D(^SYS(0,"BACKUP",NM)) D NMQH G START
 I '$D(^SYS(0,"UNATTENDED BACKUP TIME")) S (^("UNATTENDED BACKUP TIME"),^("UNATTENDED BACKUP FILE"))=""
 S J=0,M=1 D DSK^DPBEGIN,TYPES^SYSROU
TEST S J=J+1,TSIZE=0,K=0 G:'$D(^SYS(0,"BACKUP",NM,"DISK "_J)) DAT
 I ^("DISK "_J,"TO")="M" G DAT
 S TYU=^("FROM","UNIT"),DKNUM=$F(TYPES,$E(TYU,1,2))\3-1*8+$E(TYU,3)
 I '$D(DSK(DKNUM)) G ERR
 S FSIZE=$P(DSK(DKNUM)," ",5)
RP S K=K+1,TYU=$P(^SYS(0,"BACKUP",NM,"DISK "_J,"TO","UNIT"),";",K)
