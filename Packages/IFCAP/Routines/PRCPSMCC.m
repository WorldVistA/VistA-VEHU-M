PRCPSMCC ;WISC/RFJ-create and transmit clm code sheet from tmp ;22 Mar 93
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
TRANSMIT(V1,V2,V3,V4) ;transmit code sheets from tmp global
 ;  v1=station number (ex: 688)
 ;  v2=batch type (CLI or CLM)
 ;  v3=transaction type (ex: 922.00)
 ;  v4=1stQueue^2ndQueue^... (ex: CLI or CLI^CLM)
 ;  tmp($j,"string",1:n)=code sheet data
 ;  returns prcpxmz(sequence number)=mailman message number_"^"_batch number
 ;
 N %,COUNT,CSHEET,DATA,LINE,PRCPBATC,PRCPDA,PRCPNOW,PRCPQUE,PRCPSITE,PRCPTRAN,PRCPTOTL,PRCPTYPE,SEQUENCE,X,XMZ,Y
 ;
 S PRCPSITE=V1,PRCPTYPE=V2,PRCPTRAN=V3,PRCPQUE=V4
 K ^TMP($J,"PRCPSMC0"),PRCPTOTL,PRCPXMZ
 ;
 ;  move code sheets to message number in tmp global
 S SEQUENCE=1,LINE=2,(COUNT,CSHEET)=0 F  S CSHEET=$O(^TMP($J,"STRING",CSHEET)) Q:'CSHEET  S DATA=^(CSHEET),COUNT=COUNT+1 D
 .   ;
 .   ;  build message in tmp;  prcptotl tracks number of lines for header
 .   S PRCPTOTL(SEQUENCE)=LINE-1,^TMP($J,"PRCPSMC0",SEQUENCE,LINE,0)=DATA,LINE=LINE+1
 .   ;
 .   ;  increment counters if line equals 50 (code sheets)
 .   I $O(^TMP($J,"STRING",CSHEET)),LINE=50 S SEQUENCE=SEQUENCE+1,LINE=2
 ;
 ;  transmit
 F COUNT=1:1:SEQUENCE Q:'$D(^TMP($J,"PRCPSMC0",COUNT))  D
 .   ;
 .   ;  set date.time stamp
 .   D NOW^%DTC S PRCPNOW=%
 .   ;
 .   ;  set up next batch
 .   S Y=$$BATCH(PRCPSITE,PRCPTYPE,PRCPNOW),PRCPBATC=$P(Y,"^"),PRCPDA=+$P(Y,"^",2)
 .   S Y=$P(PRCPBATC,"-",4),Y=$E(Y,1,2)_$E(Y,4,6)
 .   ;
 .   ;  create header
 .   S ^TMP($J,"PRCPSMC0",COUNT,1,0)="CLM."_PRCPSITE_".999."_$E("00",$L($G(PRCPTOTL(COUNT)))+1,2)_$G(PRCPTOTL(COUNT))_"."_$E(PRCPNOW,4,7)_$E(PRCPNOW,2,3)_"."_Y_".$"
 .   ;
 .   ;  create and transmit mail message
 .   D MAILMSG^PRCPSMCS(COUNT,SEQUENCE,PRCPTRAN,PRCPQUE)
 .   S PRCPXMZ(COUNT)=+$G(XMZ)_"^"_PRCPBATC
 .   I $G(XMZ) S %=$O(^PRC(411,PRCPSITE,2,"AC","F","")) I %'="" D PRINT^PRCPSMCL(XMZ,%)
 .   ;
 .   ;  set transmission record delivery information
 .   I PRCPDA,$D(^PRCF(421.2,PRCPDA,0)) D
 .   .   L +^PRCF(421.2,PRCPDA)
 .   .   S Y="" D ENCODE^PRCFAES1(PRCPDA,DUZ,.Y)
 .   .   S Y=^PRCF(421.2,PRCPDA,0),$P(Y,"^",4)=PRCPNOW,$P(Y,"^",12)=$G(XMZ),^PRCF(421.2,PRCPDA,0)=Y
 .   .   L -^PRCF(421.2,PRCPDA)
 ;
 K ^TMP($J,"PRCPSMC0")
 Q
 ;
 ;
BATCH(V1,V2,V3) ;  add new batch and return batch number_^_entry number
 ;  v1=station number
 ;  v2=batch type (example CLM or CLI)
 ;  v3=date.time stamp
 N %,D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,NOW,PRCPBATC,PRCPNOW,X,Y
 S PRCPNOW=V3,PRCPBATC=V1_"-"_V2_"-"_$E(PRCPNOW,2,3)
 ;
 ;  lookup batch counter
 I '$D(^PRCF(422.2,"B",PRCPBATC)) D
 .   L +^PRCF(422.2)
 .   ;  double check to make sure another job did not add entry
 .   I '$D(^PRCF(422.2,"B",PRCPBATC)) S DIC="^PRCF(422.2,",DIC(0)="MLX",DLAYGO=422.2,X=PRCPBATC D ^DIC
 .   L -^PRCF(422.2)
 ;
 S DA=+$O(^PRCF(422.2,"B",PRCPBATC,0))
 L +^PRCF(422.2,DA)
 ;
 ;  get next counter number
 S Y=$P($G(^PRCF(422.2,DA,0)),"^",2)+1 I Y>9999 S Y=1
 I $D(^PRCF(422.2,DA,0)) S $P(^(0),"^",2)=Y
 L -^PRCF(422.2,DA)
 S PRCPBATC=PRCPBATC_"-"_$E(PRCPNOW,4,5)_$E("0000",$L(Y)+1,4)_Y
 ;
 ;  add new batch as a transmission record
 K D0,DD S DIC="^PRCF(421.2,",DIC(0)="L",DLAYGO=421.2,DIC("DR")=".5////T;.7////"_PRCPNOW_";.8////"_DUZ,X=PRCPBATC D FILE^DICN
 Q PRCPBATC_"^"_+Y
