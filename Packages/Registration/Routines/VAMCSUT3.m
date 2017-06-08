VAMCSUT3 ;ALB/JRP/EG/PB/MK - MPD UTILITY ROUTINES; [ 01/25/95  2:02 PM ] ;9/25/95  13:27
 ;;V1.0T.1;MINIMAL PATIENT DATASET;**2**;APR 3,1995 ;CFB MODIFIED ERRSTORE EXTRINSIC 19 SEP 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ERRSTORE(ERROR)     ;LOG ERROR
 ;INPUT    : ERROR - ERROR TEXT OR N^ERROR TEXT
 ;OUTPUT   : 0  SUCCESSFULLY STORED
 ;          -1  NOT STORED
 N DIC,X,Y,DINUM,DA,DD,DO,D0,DI,DIE,DQ,DR
 ;REMOVE N^ FROM TEXT
 S:(ERROR?1"-"1.N1"^".E) ERROR=$P(ERROR,"^",2)
 ;LOG ERROR
 D NOW^%DTC S (DINUM,X)=%,DIC="^VAM(394.94,1,""ERROR"","
 S DIC("DR")=".01///X;1///"_ERROR,DIC(0)="NL"
 S DIC("P")=$P(^DD(394.94,50,0),"^",2)
 S DA(1)=1,DIC("DR")="1///"_ERROR
 D FILE^DICN K DIC Q:$P(Y,"^",3) 0  Q -1
BUFFCNT(ARRAY)     ;COUNT BUFFERED SSNs IN OUTPUT ARRAY
 ;INPUT  : ARRAY - Output array (where extracted data is being stored)
 ;OUTPUT : n - Number of SSNs in output array
 ;        -1 - Error
 N TMP,LOOP
 S TMP=""
 F LOOP=0:1 D  Q:(TMP="")
 .S TMP=$$DDP^VAMCSDP1("ORDER",ARRAY,"""DONE"","_$C(34)_TMP_$C(34),"")
 .I (DEBUG) W "....BUFFCNT= "_TMP,!
 Q LOOP
CLEAR(ARRAY)       ;WAIT UNTIL BUFFER IS CLEARED.
 ;INPUT  : ARRAY - where array is located
 ;OUTPUT : 0 - Buffer is clear
 ;       : -1^ERROR TEXT - Error
 N TMP,LOOP,TIME,STOP
 S (TMP,STOP)=0
 ; SET A MAX OF 2 HOURS.
 S TIME=7200
 F LOOP=1:1:TIME D  Q:((TMP<1)!(STOP))
 .S TMP=$$BUFFCNT(ARRAY)
 .S STOP=$$ABORTREQ^VAMCSUT6(REQNUM)
 .H 1
 ;I (STOP) S TMP=$$SETABORT^VAMCSUT6(REQNUM,0)
 S:(LOOP=TIME) TMP="-1^Client not responding (VAMCSUT3)"
 Q:('STOP) TMP
 Q "-1^Server has stopped"
SEND(IN,OUT)         ;SEND AN ARRAY THROUGH DDP
 ;INPUT  : IN - LOCATION OF INPUT ARRAY 
 ;       : OUT - LOCATION OF OUTPUT ARRAY (FULL GLOBAL REF)
 ;OUTPUT : 0 - BUFFER SUCCESSFULLY FILLED
 ;       : -1^ERROR TEST - ERROR
 ;This routine will copy everything below IN and graft it to OUT.
 ;NOTE: The IN array must not have a value in it's first location.
 ;Ex: if IN=^ZTMP("A") then ^ZTMP("A") can not exist, but
 ;    ^ZTMP("A","B") is fine.
 N ERR,BASE,TMP,STOP,SUBSCRPT,OUTGLB,OUTSUB,INSUB
 S IN=$G(IN)
 Q:(IN="") "-1^Input array not defined"
 S OUT=$G(OUT)
 Q:(OUT="") "-1^Output array not defined"
 S (STOP,ERR)=0
 I (IN'["(") S IN=IN_"("_$C(34)_$C(34)_")"
 S BASE=$P(IN,")",1)
 I (BASE[($C(34)_$C(34))) S BASE=$P(BASE,$C(34)_$C(34),1)
 S OUTGLB=$P(OUT,"(",1)
 S OUTSUB=$P($P(OUT,")",1),"(",2)
 S:(OUTSUB=($C(34)_$C(34))) OUTSUB=""
 ;USE $Q TO GO THROUGH ARRAY AND FIND ALL NODES
 F  Q:(STOP=1)  D
 .I (IN'[BASE) S STOP=1 Q
 .I ($P(IN,($C(34)_$C(34)),1)=IN) D
 ..I ($D(@IN)#2) D
 ...S INSUB=$P($P(IN,BASE,2),")",1)
 ...S:(($E(INSUB,1,1)'=$C(44))&(OUTSUB'="")) INSUB=","_INSUB
 ...S SUBSCRPT=OUTSUB_INSUB
 ...S:($E(SUBSCRPT,1,1)=$C(44)) SUBSCRPT=$P(SUBSCRPT,",",2,$L(SUBSCRPT,","))
 ...;USE DDP TO RETURN INFORMATION TO CLIENT
 ...S ERR=$$DDP^VAMCSDP1("WRITE",OUTGLB,SUBSCRPT,$G(@IN))
 ...I (DEBUG) W "...WRITING",!
 .I (ERR<0) S STOP=1 Q
 .S IN=$Q(@IN)
 .S:(IN="") STOP=1
 S:(ERR="") ERR=0
 Q ERR
