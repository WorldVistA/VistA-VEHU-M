%ZOSVKR ;SF/KAK - Collect RUM Statistics for MSM ;1/20/00  07:38
 ;;8.0;KERNEL;**90,94,107,122**;Jul 21, 1998
 ;
RO(OPT) ; Record option resource usage in ^XTMP("KMPR","JOB"
 ;
 N KMPRTYP S KMPRTYP=0  ; option
 G EN
 ;
RP(PRTCL) ; Record protocol resource usage in ^XTMP("KMPR","JOB"
 ;
 ; Variable PRTCL = option_name^protocol_name
 S OPT=$P(PRTCL,"^"),PRTCL=$P(PRTCL,"^",2) Q:PRTCL=""
 N KMPRTYP S KMPRTYP=1  ; protocol
 Q
 ;
RU(KMPROPT,KMPRTYP,KMPRSTAT) ;-- record resource usage in ^XTMP("KMPR","JOB"
 Q
 ;
EN ;
 Q
