PSA81PI ;PER/ME-Post-install routine for Patch PSA*3.0*81 ; 04 Jul 2020  2:00 PM
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**81**;Oct 24,1997;Build 10
 Q
POST ; Entry point
 K ^TMP("PSA81PI"),^XTMP("PSA81PI")
 S $P(SETTXT,"=",80)="",$P(SETTXT1,"-",80)=""
 D BMES^XPDUTL("  Starting post-install for PSA*3*81")
 S PSOLINE=0
 D SETTXT(SETTXT)
 D SETTXT("        This report displays drugs with a negative balance in the")
 D SETTXT("                 Controlled Substance master vault(s).")
 D SETTXT(SETTXT1)
 D SETTXT("        If any negative balances are found that require assistance")
 D SETTXT("        to correct, please log a ticket and request it be sent to")
 D SETTXT("        SPM.Health.PCS.Sub_1.")
 D SETTXT(SETTXT)
 ;
REPORT ;
 S VAULT=0
 F  S VAULT=$O(^PSD(58.8,VAULT)) Q:+VAULT=0  D
 .I $P(^PSD(58.8,VAULT,0),U,2)="M" S PSDS=VAULT,PSDSN=$P(^PSD(58.8,VAULT,0),U) D START
 D MAIL
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Finished post-install for PSA*3*81.")
 D BMES^XPDUTL("")
 Q
 ;
START ;entry for compile report data
 K ^TMP("PSDBALI"),CNT
 F PSD=0:0 S PSD=$O(^PSD(58.8,+PSDS,1,PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) D
 .S DEA=+$P($G(^PSDRUG(PSD,0)),"^",3)
 .S PSDR(+PSD)=""
 F PSD=0:0 S PSD=$O(PSDR(PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) S NODE=^(0) D
 .S PSDOK="" I +$P(NODE,"^",14),+$P(NODE,"^",14)'>DT Q:'+$P(NODE,"^",4)  S PSDOK="*"
 .S BAL=+$P(NODE,"^",4),DRUGN=$S($P($G(^PSDRUG(+PSD,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSD_" NAME MISSING"),SLVL=+$P(NODE,"^",3),EXP=$S(+$P(NODE,"^",12):+$P(NODE,"^",12),1:"")
 .I EXP S Y=EXP X ^DD("DD") S EXP=Y
 .S ^TMP("PSDBALI",$J,DRUGN,PSD)=BAL_"^"_PSDOK_"^"_SLVL_"^"_EXP_"^"_$P($G(^PSDRUG(+PSD,0)),"^",3)
PRINT ;set each drug line in the report
 S (PSDOUT)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 D HDR
 I '$D(^TMP("PSDBALI",$J)) W !!,?15,"**** NO STOCK BALANCE DATA AVAILABLE ****",!!
 S PSDR="" F  S PSDR=$O(^TMP("PSDBALI",$J,PSDR)) Q:PSDR=""!(PSDOUT)  F PSD=0:0 S PSD=$O(^TMP("PSDBALI",$J,PSDR,PSD)) Q:'PSD  D  Q:PSDOUT
 .S NODE=^TMP("PSDBALI",$J,PSDR,PSD),BAL=+NODE,PSDOK=$P(NODE,"^",2),SLVL=$P(NODE,"^",3),EXP=$P(NODE,"^",4)
 .S PSD=PSD_$J("",15-$L(PSD))
 .S PSDR=PSDR_$J("",41-$L(PSDR))
 .S BAL=BAL_$J("",10-$L(BAL))
 .I BAL<0 S RPLINE=PSD_PSDR_"         "_BAL D SETTXT(RPLINE) S CNT=1
 I '$D(CNT) D SETTXT("NO NEGATIVE BALANCES FOUND")
 D SETTXT("")
 ;D SETTXT("END OF REPORT FOR THE "_PSDSN_" ("_VAULT_")")
 D SETTXT("End of report for the "_PSDSN_" ("_VAULT_")")
 D SETTXT(""),SETTXT("")
 Q
 ;
END ;
 K %,BAL,DRUGN,EXP,NODE,PSD,PSDOK,PSDOUT,PSDR,PSDRN,PSDS,PSDSN,PSOLINE,SETTXT,SETTXT1,SLVL,RPDT,RPLINE,VAULT,Y
 K ^TMP("PSDBALI",$J),ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,DEA,SCH
 K ^TMP("PSA81PI",$J),^XTMP("PSA81PI",$J)
 Q
 ;
HDR ;header
 D SETTXT("")
 D SETTXT($J("",12)_"Negative balance report for the "_PSDSN_" ("_VAULT_")")
 D SETTXT($J("",29)_RPDT)
 D SETTXT("")
 D SETTXT("DRUG IEN"_$J("",14)_"DRUG"_$J("",34)_"CURRENT BALANCE")
 D SETTXT(SETTXT1)
 D SETTXT("")
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSA81PI",$J,PSOLINE)=TXT
 Q
 ;
MAIL ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSA*3*81 - Negative balances in Controlled Substance Vault Report"
 S XMDUZ=.5,XMTEXT="^XTMP(""PSA81PI"",$J," N DIFROM D ^XMD
 Q
