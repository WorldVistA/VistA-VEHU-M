FHGMVQAL ;SLC/NCD - Send Weight Alert to Clinicians ; Jan 8, 2024@08:20
 ;;5.5;Dietetics;**53**;Jan 28, 2005;Build 34
 ;
 ;
ALERT(DFN,SDHLOC) ;Send Alert - Weight Change Exceeded Threshold
 ; Called from WTNOTF^GMVWTCK to send Alert to Dietician(s)
 N MONTX,NOW,DTE,XQA,FHDFN,FHZ115,WRD,SDWARD,FHNLOC,FHCODE
 D NOW^%DTC S NOW=%,DTE=NOW
 I $G(SDHLOC)="" Q
 S FHNLOC="",SDWARD=$P($G(^SC(SDHLOC,42)),"^")
 I SDWARD]"" D  I FHNLOC="" Q  ;if it is a MAS ward with no nutrition location, don't check for a clinic location
 . N A
 . S A=0
 . F  S A=$O(^FH(119.6,"AW",SDWARD,A)) Q:'A  I $P($G(^FH(119.6,A,"I")),"^")'="Y" S FHNLOC=A Q
 I FHNLOC="" D
 . N A
 . S A=0
 . F  S A=$O(^FH(119.6,"AL",SDHLOC,A)) Q:'A  I $P($G(^FH(119.6,A,"I")),"^")'="Y" S FHNLOC=A Q
 S WRD=FHNLOC
 I WRD="" Q
 S FHZ115="P"_DFN
 S FHDFN=$O(^FHPT("B",FHZ115,""))
 I FHDFN="" Q  ;patient is not in Nutrition Person file
 I $P($G(^FH(119.6,WRD,1)),"^",10)'="Y" Q  ;This location is not set to receive alert.
 S MONTX="Weight Change Exceeded Threshold"
 D PATNAME^FHOMUTL
 S FHCODE=8 D ALRT^FHCTF5
 Q
