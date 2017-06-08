%RTNXFER ;DJM;BATCH COPY ROUTINES; [ 03/03/92  11:11 AM ]
 ;COPYRIGHT MICRONETICS DESIGN CORP. @1992
 ;
 K MSM S $ZT="PROMPT^%RTNXFER"
 I $ZV ;TRIGGER $ZTRAP IF ISM SYSTEM
 S MSM=1
PROMPT ;
 S $ZT=""
 W !!,"MSM - SEND/RECEIVE REMOTE ROUTINES"
 W !,?5,"1 - Send Routines"
 W !,?5,"2 - Load Routines From 'Send' Option"
 R !!,"Select Option: ",OPT Q:OPT=""!(OPT="^")
 I OPT=1 D TO G %RTNXFER
 I OPT=2 D RECV G %RTNXFER
 W *7," ..??" G %RTNXFER
 ;
TO ;
 K U D  Q:'$D(U)
 .F  R !,"Target UCI,SYS: ",X Q:X=""!(X="^")  D
 ..S UCI=$P(X,","),SYS=$P(X,",",2) I UCI'?3U!(SYS'?3U) W !,*7,".. Must be in format: UCI,SYS" Q
 ..S U(X)=""
SELECT ;
 D:'$D(MSM) ^%RSET D:$D(MSM) ^%RSEL G:'$D(^UTILITY($J)) TO
 ;
 S SEND="S U="""" F  S U=$O(U(U)) Q:U=""""  S UC=$P(U,"",""),VG=$P(U,"","",2) S ^[UC,VG]UTILITY(""%RTNXFER"",R,I)=X"
 S R=$S($D(MSM):"",1:0) F  S R=$O(^UTILITY($J,R)) Q:R=""  D SEND
 ;
 ;FUTURE CODE: NOW SEND A JOB TO ZSAVE
 G TO
SEND ;
 W !,R
 X "ZL @R F I=1:1 S X=$T(+I) Q:X=""""  X SEND"
 W "." Q
 ;
RECV ;
 S ID="%RTNXFER"
 S ZSAVE="X ZL ZS @R"
 S ZL="ZR  F I=1:1 S L=$G(^UTILITY(ID,R,I)) Q:L=""""  ZI L"
 S R=$S($D(MSM):"",1:0) F  S R=$O(^UTILITY(ID,R)) Q:R=""  D ZSAVE
 Q
ZSAVE ;
 W !,R X ZSAVE W "." K ^UTILITY(ID,R) Q
