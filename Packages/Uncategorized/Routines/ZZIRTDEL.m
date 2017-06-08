ZZIRTDEL ;LLR/ALB - Delete Old IRT Records ; 05/08/96@08:09
 ;;Version 1.0
 ;
 ;This routine is for deleting old IRT record entries in
 ;^VAS(393 that are not currently being used.
 ;
 ;This routine should NOT BE DISTRIBUTED to any site without
 ;IRMFO assistance and it must be removed from site after
 ;completion.
 ;
EN ;Entry point for processing
 S DA=0 
 F  S DA=$O(^VAS(393)) Q:'DA  S EVDT=0 F  S EVDT=$O(^VAS(393,"C",EVDT,DA))
DATE W !!,"****Event Date Range Selection****"
 W ! S %DT(0)=-DT,%DT="AEP",%DT("A")="  Beginning Event Date : " D ^%DT Q:Y<0  S EVDTB=Y-.1
 W ! S %DT="AEP",%DT("A")="  Ending Event Date    : " D ^%DT K %DT Q:Y<0 S EVDTE=Y+.9 
