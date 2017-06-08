RTIPOST3 ;MJK,PKE/TROY ISC;Post Initization Routine DONT MAP; ; 1/11/87  9:27 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;**********DO NO MAP THIS ROUTINE***********
EN S Y=+$O(^RTV(195.9,"B","2;DIC(195.4,",0)) D MISS:'$D(^RTV(195.9,Y,0))
 D TELL,EAUDIT^RTIPRE
 D SDB
 D WARNS
 D WARN
 D BUFF
 Q
MISS S I=$P(^RTV(195.9,0),"^",3),X="2;DIC(195.4,"
LOCK S I=I+1 L +^RTV(195.9,I):1 I '$T!$D(^RTV(195.9,I)) L -^RTV(195.9,I) G LOCK
 S ^RTV(195.9,I,0)=X,^RTV(195.9,"B",X,I)="",^(0)=$P(^RTV(195.9,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1) L -^RTV(195.9,I)
 Q
TELL ;W !!,"Post-initialization routine running"
 Q
WARN W !!,"1. In File 195.4, Record Tracking System Parameters"
 W !,"   the MAS, RAD Interfaces status have been set 'DOWN'"
 W !,"   if this is the first installation of record tracking."
 W !,"   When RT is live remember to set them back 'UP'"
 W !!,"2. In File 195.4, Record Tracking System Parameters"
 W !,"   the BATCH RECORD,XRAY REQUESTS is set to NO.  You will want"
 W !,"   to process requests for records,xrays at night instead of"
 W !,"   immediately through the taskmanager."
 W !,"   Set this parameter to YES when RT is live."
 W !
 W !,"   MAKE SURE the RT SM-CLINIC-REQUESTS option is scheduled"
 W !,"   and runs daily after hours."
 W !
 W !,"   MAKE SURE the RT SM-PURGE-AUTOMATIC option is scheduled"
 W !,"   and runs monthly after hours."
 W !
 Q
SDB ;
 W !!,"Recompiling the Clinic Setup Template, don't worry"
 S Y=$O(^DIE("B","SDB",0)) Q:'Y  I $D(^DIE(Y,"ROUOLD")) S X=^("ROUOLD") I X="SDBT" S DMAX=4000 D EN^DIEZ
 Q
 ;
WARNS W !!,"   Remember to Recompile Templates on all systems using the "
 W !,"   'Re-compile templates' option."
 Q
BUFF ;start records #'s at 11
 I $D(^RT(0)),'$P(^RT(0),"^",3) S $P(^RT(0),"^",3)=10
 Q
