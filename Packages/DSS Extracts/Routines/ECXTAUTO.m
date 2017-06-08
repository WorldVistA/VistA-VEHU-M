ECXTAUTO ;BIR/DMA-Background Queuing for Package Extracts ; 17 Mar 95 / 1:04 PM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;Queuing and message sending for package extracts for local use
 ;Input ECPACK   printed name of package (e.g. Lab, Prescriptions)
 ;      ECPIECE  piece of node where last date is stored
 ;      ECRTN    in the form of START^ROUTINE
 ;      ECGRP    name of local mail group to receive summary message
 ;               (MUST BE 1 TO 5 UPPER CASE ALPHA - NO SPACES)
 ;      ECFILE   file number of the local editing file
 ; generates EC23=2nd and 3rd piece of zero node in local editing file
 ;               =YYMM of end date^pointer to 727
 ;
 Q  ;no entry from the top
 ;
GO ; called entry from QUE
 S ECINST=+$P(^ECX(728,1,0),U) K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 I '$D(ECNODE) S ECNODE=7
 S ECFDT=$$FMADD^XLFDT($P($G(^ECX(728,1,ECNODE)),U,ECPIECE),1) I ECFDT>ECED D ERROR G REQUE:'$D(ECEDNEW) Q
 I ECFDT>ECSD S ECSD=ECFDT I ECSD>ECED G REQUE:'$D(ECDNEW) Q
 S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)="R"
 S ECSDN=$$FMTE^XLFDT(ECSD),ECEDN=$$FMTE^XLFDT(ECED),ECSD1=ECSD-.1
 L +^ECX(727,0) S EC=$P(^ECX(727,0),U,3)+1,$P(^(0),U,3,4)=EC_U_EC L -^ECX(727,0)
 S ^ECX(727,EC,0)=EC_U_DT_U_ECPACK_U_ECSD_U_$E(ECED,1,7)
 S ^ECX(727,EC,"HEAD")=ECHEAD
 S ^ECX(727,EC,"FILE")=ECFILE
 S ^ECX(727,EC,"GRP")=ECGRP
 S ^ECX(727,"AC",DT,EC)="",^ECX(727,"AD",ECPACK,EC)=""
 S ECRN=0,EC23=$$ECXYM^ECXUTL(ECED)_U_EC
EXTRACT ;do specific extract
 S ECXSTART=$P($$HTE^XLFDT($H),":",1,2),ECXNOW=$H
 D @ECRTN
 S $P(^ECX(728,1,ECNODE),U,ECPIECE)=$P(ECED,".") S TIME=$P($$HTE^XLFDT($H),":",1,2)
 S $P(^ECX(727,$P(EC23,U,2),0),U,6)=ECRN
 S ECLAST=$O(^ECX(ECFILE,999999999),-1),ECTOTAL=$P(^ECX(ECFILE,0),U,4)+ECRN,$P(^(0),U,3,4)=ECLAST_U_ECTOTAL K ECLAST,ECTOTAL
 ;set piece 3 and 4 of the zero node
 ;
MSG ; send message to mail group 'DSS-ECGRP'
 S XMSUB=ECINST_" - "_ECPACK_" BACKGROUND EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The BACKGROUND DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN,ECMSG(2,0)="through "_ECEDN_" was begun on "_$P(ECXSTART,"@")_" at "_$P(ECXSTART,"@",2)
 S ECMSG(3,0)="and completed on "_$P(TIME,"@")_" at "_$P(TIME,"@",2)_"."
 S ECMSG(4,0)=" ",ECMSG(5,0)="A total of "_ECRN_" records were written."
 S ECMSG(6,0)=" ",ECMSG(7,0)="Extract time was [HH:MM:SS] "_$$HDIFF^XLFDT($H,ECXNOW,3),ECMSG(8,0)=" "
 S XMTEXT="ECMSG(" D ^XMD
 S $P(^ECX(728,1,ECNODE+.1),U,ECPIECE)=""
 Q:$D(ECEDNEW)  ;for weekly where we have to do 2, don't requeue after first
 ;
REQUE ;use fields in 727.1 to reque job for next time
 S EC=$O(^ECX(727.1,"AF",ECFILE,0)),EC=$P(^ECX(727.1,EC,0),U,3)
 I EC="D" S ZTDTH=ZTDTH+1_","_$P(ZTDTH,",",2) D REQ^%ZTLOAD Q
 I EC="W" S ZTDTH=ZTDTH+7_","_$P(ZTDTH,",",2) D REQ^%ZTLOAD Q
 I EC="M" S EC=$$HTFM^XLFDT(ZTDTH,1),EC=$E(EC,1,5)+1+($E(EC,4,5)=12*8800)_$E(EC,6,14),ZTDTH=$$FMTH^XLFDT(EC,1)_","_$P(ZTDTH,",",2) D REQ^%ZTLOAD Q
 Q
 ;
QUE ;Entry point from package extracts - determine start and stop date from 727.1
 ;
 K ECEDNEW
 S EC=$O(^ECX(727.1,"AF",ECFILE,0)),EC=^ECX(727.1,EC,0),ECD=$P(EC,U,4),EC=$P(EC,U,3)
 S ECDT=$P($$HTFM^XLFDT(ZTDTH,1),".")
 I EC="M" S ECSD=$E(ECDT,1,5)-1-($E(ECDT,4,5)="01"*8800)_"01",ECED=$$FMADD^XLFDT($E(ECDT,1,5)_"01",-1) G GO
 I EC="D" S ECED=$$HTFM^XLFDT(ZTDTH-ECD,1),ECSD=ECED G GO
 I EC="W" S ECED=$$HTFM^XLFDT(ZTDTH-ECD,1),ECSD=$$HTFM^XLFDT(ZTDTH-ECD-6,1) I $E(ECED,4,5)=$E(ECSD,4,5) G GO
 ;here for a weekly extract that spans 2 months.
 S ECEDNEW=ECED,ECED=$$FMADD^XLFDT($E(ECED,1,5)_"01",-1) D GO
 S ECED=ECEDNEW,ECSD=$E(ECED,1,5)_"01" K ECEDNEW G GO
 ;
ERROR ; send message when job was queued to extract data already extracted
 ;
 S XMSUB=ECINST_" - "_ECPACK_" BACKGROUND EXTRACT FAILURE",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ECMSG(1,0)="The "_ECPACK_" extract was queued to extract data for",ECMSG(2,0)="a range of dates which had already been extracted.",ECMSG(3,0)="  The extract was NOT rerun"
 S XMTEXT="ECMSG(" D ^XMD
 S ECNOGO=1
 Q
