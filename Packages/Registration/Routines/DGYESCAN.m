DGYESCAN ;ALB/MTC - SCAN FUNCTIONS FOR EPRP PROCESSING ; 01 Nov 94 / 8:52 AM
 ;;1.0; DGYE ;**7,14**;28 Apr 92
 ;  This routine contains functions to scan a PTF record
 ;  for ICD flagged for EPRP.
 ;
SCAN501(PTF,GLB) ;-- this function will scan a 501 record designated by
 ; the parameter PTF. 
 ;   INPUT : PTF -ifn of the ptf record to be scanned.
 ;           GLB -variable that holds name of the global 
 ;                used to store output
B ;   OUTPUT: The following global nodes will be set 
 ;           if there are matches with the task list:
 ;           @GLB("DGYE",$J,PTF,"M",MOVEMENT #,TASK)
 ;           @GLB("DGYE",$J,"TASK",TASK,SEQ #,PTF)=""
 ;           @GLB("DGYE",$J,"TASK",TASK,0)=TOTAL COUNT FOR TASK
 ;
 N GNAME,I,J,Y,X,SEQ
 S GNAME=GLB_"$J)"
 F I=0:0 S I=$O(^DGPT(PTF,"M","AC",I)) Q:'I  S Y=$P($G(^ICD9(I,0)),U) Q:Y']""  I $D(^TMP("DGYE",$J,"D",Y)) S TSK=$O(^(Y,0)) D
 .I TSK="4A"!(TSK="4B")!(TSK="4E")!(TSK="5A") I $P(^DGPT(PTF,70),"^",10)'=I Q
 .S X="" F J=0:0 S X=$O(^TMP("DGYE",$J,"D",Y,X)) Q:X']""  D
 ..S @GNAME@(PTF,"M",$O(^DGPT(PTF,"M","AC",I,0)),X)="" I '$$CHKTSK(PTF,X) S ^(0)=$G(@GNAME@("TASK",X,0))+1,SEQ=^(0),@GNAME@("TASK",X,SEQ,PTF)=""
 Q
 ;
SCAN401(PTF,GLB) ;-- this function will scan a 401 record designated by
 ; the paramter PTF.
 ;  INPUT  : PTF -ifn of the ptf record to be scanned.
 ;           GLB -variable that hold the name of the global
 ;                where output will be stored.
 ;  OUTPUT : The following globals will be set if matches
 ;           are found with the task list:
 ;           @GLB("DGYE",$J,PTF,"S",SURGERY #,TASK)
 ;           @GLB("DGYE",$J,"TASK",TASK,SEQ #,PTF)=""
 ;           @GLB("DGYE",$J,"TASK",TASK,0)=TOTAL COUNT FOR TASK
 ;
 N GNAME,I,I1,I2,J,X,Y,SEQ
 S GNAME=GLB_"$J)"
 F I=0:0 S I=$O(^DGPT(PTF,"S","AO",I)) Q:'I  S Y=$P($G(^ICD0(I,0)),U) Q:Y']""  I $D(^TMP("DGYE",$J,"S",Y)) S I1=$O(^DGPT(PTF,"S","AO",I,0)),I2=$P($G(^DGPT(PTF,"S",I1,0)),"^",4) I I2'="N",I2'=5 D
 .S X="" F J=0:0 S X=$O(^TMP("DGYE",$J,"S",Y,X)) Q:X']""  D
 ..S @GNAME@(PTF,"S",+$O(^DGPT(PTF,"S","AO",I,0)),X)="" I '$$CHKTSK(PTF,X) S ^(0)=$G(@GNAME@("TASK",X,0))+1,SEQ=^(0),@GNAME@("TASK",X,SEQ,PTF)=""
 Q
 ;
SCAN601(PTF,GLB) ;-- this function will scan 601 record designated by
 ; the parameter PTF.
 ;  INPUT  : PTF -ifn of the ptf record to be scanned.
 ;           GLB -variable that holds the name of the global used
 ;                to store output.
 ;  OUTPUT : The following global nodes will be set if there are 
 ;           matches with the task list:
 ;           @GLB("DGYE",$J,PTF,"P",PROCEDURE #,TASK)
 ;           @GLB("DGYE",$J,"TASK",TASK,SEQ #,PTF)=""
 ;           @GLB("DGYE",$J,"TASK",TASK,0)=TOTAL COUNT FOR TASK
 N GNAME,I,J,X,Y,SEQ
 S GNAME=GLB_"$J)"
 F I=0:0 S I=$O(^DGPT(PTF,"P","AP6",I)) Q:'I  S Y=$P($G(^ICD0(I,0)),U) Q:Y']""  I $D(^TMP("DGYE",$J,"S",Y)) D
 .S X="" F J=0:0 S X=$O(^TMP("DGYE",$J,"S",Y,X)) Q:X']""  D
 ..S @GNAME@(PTF,"P",+$O(^DGPT(PTF,"P","AP6",I,0)),X)="" I '$$CHKTSK(PTF,X) S ^(0)=$G(@GNAME@("TASK",X,0))+1,SEQ=^(0),@GNAME@("TASK",X,SEQ,PTF)=""
 Q
 ;
CHKTSK(PTF,TASK) ;This function will determine if the task has been
 ; defined for the given PTF record.
 ;  INPUT : PTF - PTF record number
 ;          TASK - task to check for
 ;  OUTPUT: 1-YES, O -NO
 ;
 N SEQ,RESULT
 S RESULT=0
 F SEQ=0:0 S SEQ=$O(@GNAME@("TASK",TASK,SEQ)) Q:'SEQ  I $O(@GNAME@("TASK",TASK,SEQ,0))=PTF S RESULT=1
 Q RESULT
 ;
