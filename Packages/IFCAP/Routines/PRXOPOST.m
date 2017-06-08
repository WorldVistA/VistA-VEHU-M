PRXOPOST ;Post init routine for Unposted Dietetic Cost Report ;
 ;;4.0;IFCAP;**34**;9/23/1993
 S DA=$O(^DIC(19,"B","PRCH UNPOSTED DIETETIC REPORT",0))
 S DIE="^DIC(19,",DR="60///@;62///@;63///@;64///@;68///@;69///@"
 D ^DIE K DIE,DA,DR
