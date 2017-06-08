DSICTSK ;DSS/SGM - TASK TRACKER ;11/15/2002 11:58
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  -----------------------------------
 ;  10103      X      ^XLFDT:  FMADD, NOW
 ;
 ;  This routine will allow a GUI client to task up a job
 ;  and then retrieve the extract later
 ;
 ;  Description of global format:
 ;  ^XTMP("DSICTSK",0) = purge date ^ date created
 ;  For the following node refers to ^XTMP("DSICTSK",node)
 ;  ^XTMP("DSICTSK",.1) - sorted based upon user and report
 ;      ^XTMP("DSICTSK",.1,DUZ,RPTNM,node)=""
 ;
 ;  ^XTMP("DSICTSK",.2) - sorted based upon report
 ;      ^XTMP("DSICTSK",.2,RPTNM,node) = DUZ
 ;
 ;  ^XTMP("DSICTSK",.3) - header for node - this way the extract
 ;      program can format the ^XTMP("DSICTSK",node) any way it wishes
 ;      This will be useful for just referencing this node for return
 ;      via a global array RPC
 ;      ^XTMP("DSICTSK",.3,node) = string  where string equals
 ;         p1^p2^...^p8
 ;         p1 = status       p4 = start time    p7 = ztsk
 ;         p2 = duz          p5 = end time      p8 = indicator
 ;         p3 = report name  p6 = purge date
 ;
 ;         where status equals F:finished  R:running  S:stalled/stopped
 ;                             N:no status
 ;         N status indicates that the M job invoked a process for
 ;         which it has no control and thus cannot update the indicator
 ;         in a routine manner (e.g., calling another pkg print rtn)
 ;
 ;         Indicator - the extract program needs to call STUP
 ;                     occasionally.  The status monitor will look to
 ;                     see if this is changing in an one minute period.
 ;                     If it does not change, then the status flag is
 ;                     set to 'S'
 ;
CLEANUP(NODE,FLG) ;  delete the master nodes
 ;  NODE - optional - subscript for ^XTMP("DSICTSK",NODE)
 ;    if NODE="", loop through all nodes & clean out old stuff
 ;   FLG - optional - K:FLG ^XTMP("DSICTSK",NODE)
 ;         valid only if NODE]""
 ;
 N I,X,Y,Z,DOIT,ED,PD,RPTNM,SD,ST,USER
 S Z="DSICTSK",FLG=$G(FLG)
 ;  cleanup individual extract
 I $G(NODE)'="" D VAR G CLX
 S Z="DSICTSK"
 F NODE=0:0 S NODE=$O(^XTMP(Z,.3,NODE)) Q:'NODE  D
 .S (DOIT,FLG)=0 D VAR
 .I "FNS"[ST,PD<DT S DOIT=1,FLG=1
 .I 'DOIT,"FS"[ST,'$D(^XTMP(Z,NODE)) S DOIT=1,FLG=1
 .I ST="R" S Y=$P(X,U,8) D
 ..F I=1:1:61 Q:Y'=$P(^XTMP(Z,.3,NODE),U,8)
 ..I I>60 S $P(^XTMP(Z,.3,NODE),U)="S"
 ..Q
 .I DOIT D CLX
 .Q
 Q
 ;
CLX ;  expects Z, FLG, NODE to be defined
 N I,X
 F I=1:1:5 S X=$$LOCK Q:X  H 1
 Q:'X
 K:FLG ^XTMP(Z,NODE)
 K ^XTMP(Z,.3,NODE)
 I RPTNM]"" K ^XTMP(Z,.1,USER,RPTNM,NODE),^XTMP(Z,.2,RPTNM,NODE)
 D UNLOCK
 Q
 ;
LOCK() L +^XTMP("DSICTSK",0):2 Q $T
 ;
UNLOCK L -^XTMP("DSICTSK",0) Q
 ;
NXT(RPTNM,ADD) ;  get next node and initialize zeroth node
 ;  RPTNM - required - name of report/extract
 ;  ADD - optional - number of days to keep this subscript
 ;                   default = 4 days
 ;  Function returns: subscript for this job, else return <null>
 ;
 N I,X,Y,Z,NODE,STR
 S Z="DSICTSK"
 S ^XTMP(Z,0)=$$FMADD^XLFDT(DT,7)_U_$$NOW^XLFDT
 S RPTNM=$G(RPTNM) S:RPTNM="" RPTNM="unknown"
 S ADD=$G(ADD,4) S:'ADD ADD=4
 S STR="R^"_DUZ_U_RPTNM_U_$$NOW^XLFDT_U_U_U_$G(ZTSK)_U
 S $P(STR,U,6)=$$FMADD^XLFDT(DT,ADD)_".24"
 I '$$LOCK Q ""
 S NODE=1+$O(^XTMP(Z,.3,"A"),-1)
 I NODE>999 F NODE=1:1 Q:'$D(^XTMP(Z,.3,NODE))
 S ^XTMP(Z,.3,NODE)=STR
 D UNLOCK
 S ^XTMP(Z,.1,DUZ,RPTNM,NODE)="",^XTMP(Z,.2,RPTNM,NODE)=DUZ
 Q NODE
 ;
STGET(RET,NODE) ;  RPC: 
 ;  get the status of job
 ;  NODE - required - ^XTMP node name for extract
 ;  RET - return value code^message
 ;       -1 = error message
 ;        R,S,F,N - see definitions above
 ;
 N I,X,Y,Z,ED,PD,RPTNM,SD,ST,USER
 I $G(NODE)="" S RET="-1^No report name (subscript) received" Q
 D VAR
 I X="" S RET="-1^Export global does not exist" Q
 I ST="F" S RET="F^Extract finished and is available for retrieving" Q
 I ST="S" D  Q
 .S RET="S^Extract appears to have stopped and did not finish"
 .I PD<DT D CLEANUP(NODE,1)
 .Q
 I ST="N" D  Q
 .I PD>DT S RET="N^Extract appears to be running" Q
 .S RET="-1^Extract did not appear to finish and has exceeded its purge date"
 .D CLEANUP(NODE,1)
 .Q
 ;  status = R, check to see if indicator has changed
 S Y=$P(X,U,8) F I=1:1:61 Q:Y'=$P($G(^XTMP(Z,.3,NODE)),U,8)  H 1
 I I<61 S RET="R^The extract appears to still be running" Q
 E  D
 .S $P(^XTMP(Z,.3,NODE),U)="S"
 .S RET="S^The extract has appeared to have stopped"
 .Q
 Q
 ;
STUP(NODE,STAT,IND) ;  update the status node
 ;  NODE - required - subscript ^XTMP("DSICTSK",NODE)
 ;  STAT - optional - F to indicate job finished
 ;   IND - optional - value to pass to status so that monitor can
 ;     determined if the job is still running.  A value should be
 ;     passed at least once a minute or else the monitor will think
 ;     the job does not exist
 ;
 Q:$G(NODE)=""  N X,Z,ED,PD,RPTNM,SD,ST,USER
 S STAT=$G(STAT),IND=$G(IND) D VAR
 I STAT="F" D:X]""  Q
 .S $P(X,U)="F",$P(X,U,5)=$$NOW^XLFDT,^XTMP(Z,.3,NODE)=X
 .Q
 I IND]"" S $P(^XTMP(Z,.3,NODE),U,8)=IND
 Q
 ;
VAR ;  expects NODE
 S Z="DSICTSK"
 S X=$G(^XTMP(Z,.3,NODE))
 S ST=$P(X,U),USER=+$P(X,U,2),RPTNM=$P(X,U,3)
 S SD=$P(X,U,4),ED=$P(X,U,5),PD=$P(X,U,6)
 Q
