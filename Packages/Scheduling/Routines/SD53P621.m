SD53P621 ;ALB/JAM - Post install routine for SD*5.3*621 ;9/25/14
 ;;5.3;Scheduling;**621**;AUG 13, 1993;Build 4
 ;
EN ;This post install routine will remove two remaining DD nodes from File (#403.12)
 ;that were not properly removed when the file was originially deleted.
 ;Nodes remaining and needing to be removed are -
 ;                ^DD(403.12,.01,5,1,0)="44^.01^12"
 ;                ^DD(403.12,"TRB",44,.01,12,.01)=""
 ;
 D BMES^XPDUTL("Removing leftover DD nodes from File (#403.12) which no longer exist.")
 K ^DD(403.12)
 Q
