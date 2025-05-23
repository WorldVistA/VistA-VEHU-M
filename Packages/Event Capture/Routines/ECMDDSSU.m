ECMDDSSU ;ALB/CMD - Event Capture Management Delete Unused DSS Unit ;12/22/21  10:43
 ;;2.0;EVENT CAPTURE ;**156**;8 May 96;Build 28
 ;
 ; Reference to $$CPT^ICPTCOD supported by ICR #1995
 ; Reference to $$GET1^DIQ supported by ICR #2056
 ; Reference to $$REPEAT^XLFSTR supported by ICR #10104
 ; Reference to ^XMD supported by ICR #10070
 ; Reference to ^DIK supported by ICR #10013
 ; Reference to ^VA(200 supported by ICR #10060
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ;
DELDSS ;Used by the RPC broker to delete unused DSS Unit in file #724
 ;  Variable passed in:
 ;    ECIEN - IEN of #724
 ;    ECDUZ - User IEN of #200
 ;  Variable return
 ;    ^TMP($J,"ECMSG",n)=Success or failure to remove entries in #724^Message
 ;
 N ARRFND,DIK,DA,DIE,ECARR,ECDECS,GREF,FOUND,ECERR,ECFILE,ECUSR,DSSUSR,ECSIEN,DSSIEN,CNT
 S ECERR=0
 D CHKDT^ECMDECS I ECERR Q
 S DSSIEN=ECIEN
 S GREF="^ECH(""ADT"")",FOUND=0
 F  S GREF=$Q(@GREF) Q:$QS(GREF,1)'="ADT"  D  Q:FOUND
 . I $QS(GREF,4)=DSSIEN S FOUND=1,ARRFND($QS(GREF,2),$QS(GREF,3),$QS(GREF,4))=""
 I FOUND S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit had workload"_U_$G(ECIEN) Q
 I 'FOUND D ECHKSCR(DSSIEN,.ECDECS) Q:ECERR
 I '$D(ECDECS) S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit had workload on its Event Code Screens" Q
 D ECUSR^ECUMRPC(.DSSURES,DSSIEN)
 M DSSUSR=@DSSURES
 S CNT=0
 F CNT=$O(DSSUSR(CNT)) Q:'CNT  S ECUSR($P(DSSUSR(CNT),U,2))=""
 D DSSUSRDE(DSSIEN,.ECUSR) ;Deallocate users to DSS Unit
 I $D(ECDECS) D SENDMM(.ECDECS) ;Send MM to list DSS unit and its EC Screen to be deleted
 S ECSIEN=""
 F  S ECSIEN=$O(ECDECS(DSSIEN,ECSIEN)) Q:ECSIEN=""  D
 . S DIK="^ECJ(",DA=ECSIEN D ^DIK
 S DIK="^ECD(",DA=DSSIEN D ^DIK
 S ^TMP($J,"ECMSG",1)="1^DSS Unit Deleted"_U_$G(ECIEN)
 D KILLVAR^ECFLRPC
 K ^TMP($J,"ECUSR")
 S RESULTS=$NA(^TMP($J,"ECMSG"))
 Q
 ;
ECHKSCR(DSSUNT,DELECS) ;
 ;Get all EC Screen for the DSS Unit
 ;Check them again before delete EC screeens and DSS Unit
 N GLBREF,ECLOC,ECCAT,ECPROC,ECSCR,ECSOK
 S GLBREF="^ECJ(""AP"")"
 S ECSOK=1
 F  S GLBREF=$Q(@GLBREF) Q:$QS(GLBREF,1)'="AP"  D
 .I $QS(GLBREF,3)'=DSSUNT Q
 .S ECCAT=$QS(GLBREF,4),ECPROC=$QS(GLBREF,5),ECLOC=$QS(GLBREF,2),ECSCR=$QS(GLBREF,6)
 .S ECSOK=1 D CHKWRK(ECSCR,.ECSOK)
 .I ECSOK S DELECS(DSSUNT,ECSCR)=""
 I ECSOK,'$D(DELECS) S DELECS(DSSUNT,0)=""
 Q
 ;
CHKWRK(ECIEN,DELOK) ;
 N ECREC,ECSCR,ECL,ECD,ECC,ECCAT,ECP,ECHIEN,ECPROC
 N ARRFND,GREF,STR
 S ECSCR=$$GET1^DIQ(720.3,ECIEN,".01","I")
 S ECL=$P(ECSCR,"-"),ECD=$P(ECSCR,"-",2),ECC=$P(ECSCR,"-",3),ECP=$P(ECSCR,"-",4)
 I ECC="" S ECC=0
 S GREF="^ECH(""ADT"",ECL)"
 S STR=ECL_"-"_ECD_"-"_ECC_"-"_ECP
 F  S GREF=$Q(@GREF) Q:$QS(GREF,1)'["ADT"  Q:$QS(GREF,2)'=ECL  D  Q:'DELOK
 . I $QS(GREF,4)'=ECD Q
 . S ECHIEN=$QS(GREF,6)
 . S ECREC=^ECH(ECHIEN,0)
 . S ECCAT=$P(ECREC,U,8),ECPROC=$P(ECREC,U,9)
 . I (ECCAT=ECC),(ECPROC=ECP) D  Q:'DELOK
 .. S ARRFND(STR,ECHIEN)=ECIEN
 .. S DELOK=0
 Q
DSSUSRDE(DSSUNT,USRARR) ;Deallocate Users to DSS Unit
 N EDUZ,DIK,X,Y,DA
 S EDUZ=0
 F  S EDUZ=$O(^VA(200,EDUZ)) Q:'EDUZ  I $D(^VA(200,EDUZ,"EC",DSSUNT,0)) D
 . I '$D(USRARR(EDUZ)) Q
 . K DA,DIK S DA(1)=EDUZ,DA=DSSUNT,DIK="^VA(200,"_DA(1)_",""EC"","
 . D ^DIK K USRARR(EDUZ)
 Q
 ;
SENDMM(ECSARR) ;Send Mailman message
 N ECMSG,ECTEXT,XMSUB,XMY,XMTEXT,XMDUZ,CNT,SCRSTAT,SYN,LOC,LOCDS,DEFCL,DSSREC,DSS,DSSU,DSSNM
 N INACTDT,PN,PRO,PROC,ECREC,ECSCR,ECPI,SCR,CAT,CATD,IEN
 S XMSUB="DELETION OF UNUSED DSS UNIT FROM FILE #724",XMDUZ="EVENT CAPTURE PACKAGE"
 S XMTEXT="ECTEXT("
 D GETXMY^ECMDECS("ECMGR",.XMY)
 S CNT=1,SCR=""
 S DSS=$O(ECSARR(""))
 S DSSREC=^ECD(DSS,0)
 S DSSNM=$P(DSSREC,U)
 I $O(ECSARR(DSS,0))="" d  Q
 .S ECTEXT(CNT)="The following DSS Unit has been deleted, it had no workload associated with it.",CNT=CNT+1
 .S ECTEXT(CNT)="This DSS Unit had no Event Code Screens associated with it.",CNT=CNT+1
 .S ECTEXT(CNT)=" ",CNT=CNT+1
 .S ECTEXT(CNT)="DSS UNIT: "_$$GET1^DIQ(724,DSS,.01,"E")_" ("_DSS_")",CNT=CNT+1
 .S ECTEXT(CNT)=" ",CNT=CNT+1
 .D ^XMD
 S ECTEXT(CNT)="The following DSS Unit and its associated Event Code Screens have been deleted,",CNT=CNT+1
 S ECTEXT(CNT)="it had no workload associated with it.",CNT=CNT+1
 S ECTEXT(CNT)=" ",CNT=CNT+1
 S ECTEXT(CNT)="DSS UNIT: "_$$GET1^DIQ(724,DSS,.01,"E")_" ("_DSS_")",CNT=CNT+1
 S ECTEXT(CNT)=" ",CNT=CNT+1
 F  S SCR=$O(ECSARR(DSS,SCR)) Q:SCR=""  D
 .S ECREC=^ECJ(SCR,0),ECSCR=$P(ECREC,U),INACTDT=$P(ECREC,U,2)
 .S DSSU=$P(ECSCR,"-",2),LOC=$P(ECSCR,"-"),CAT=$P(ECSCR,"-",3)
 .S PRO=$G(^ECJ(SCR,"PRO")),SYN=$P(PRO,U,2),PROC=$P($P(PRO,U),";"),DEFCL=+$P(PRO,U,4),PRO=$P(PRO,U)
 .I PRO["EC" S PN=$G(^EC(725,PROC,0)),PROC=$P(PN,U,2)_" "_$P(PN,U)
 .I PRO["ICPT" S ECPI=$$CPT^ICPTCOD(+PRO) I +ECPI>0 D
 .. S PROC=$P(ECPI,U,3)_" ("_$P(ECPI,U,2)_")"
 .S SCRSTAT=$S(INACTDT'="":"Inactve",1:"Active")
 .S CATD=$S('CAT:"None",1:$P($G(^EC(726,CAT,0)),U))
 .S LOCDS=$$GET1^DIQ(4,LOC,.01,"E")
 .S ECTEXT(CNT)="  LOC: "_LOCDS_$$REPEAT^XLFSTR(" ",(27-$L(LOCDS)))_"PROC: "_PROC,CNT=CNT+1
 .S ECTEXT(CNT)="  CAT: "_CATD_$$REPEAT^XLFSTR(" ",(27-$L(CATD)))_"SYN: "_SYN,CNT=CNT+1
 .S ECTEXT(CNT)="  DEFAULT ASSOCIATED CLINIC: "_$$GET1^DIQ(44,DEFCL,.01,"E"),CNT=CNT+1
 .S ECTEXT(CNT)="  STATUS: "_SCRSTAT,CNT=CNT+1
 .S ECTEXT(CNT)=" ",CNT=CNT+1
 D ^XMD
 Q
