SDES2QRYAPREQSB ;ALB/BWF - QUERY APPOINTMENT REQUESTS; JAN 4,2023
 ;;5.3;Scheduling;**869,873,875,877,878**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DGENA in ICR#3812
 ;
 Q
FLTRAPPTREQ(REQIEN,SDINPUT,FLTRORIGDATE,FLTRPIDDATE,STARTDT,ENDDT,PRIORITYGROUP,PATSVCCONN,PATSCPERCENT,COUNT,REQCNT) ;
 N REQIENS,CLINICIEN,APPTREQ,WAITDAYS,DATEENTERED,PATNAME,REQSUBTYPE
 Q:'REQIEN
 S REQIENS=REQIEN_","
 D GETS^DIQ(409.85,REQIENS,".01;1;2;4;8;8.5;10.5;15;22;23","IE","APPTREQ")
 Q:$G(APPTREQ(409.85,REQIENS,23,"I"))="C"
 ; filter appointment sub-type
 S REQSUBTYPE=$G(APPTREQ(409.85,REQIENS,4,"I"))
 I REQSUBTYPE="" S REQSUBTYPE="UNKNOWN"
 I '$D(SDINPUT("FILTER","REQUEST SUBTYPE",REQSUBTYPE)),('$D(SDINPUT("FILTER","REQUEST SUBTYPE","ALL"))) Q
 ; check clinics
 S CLINICIEN=$G(APPTREQ(409.85,REQIENS,8,"I"))
 I $D(SDINPUT("FILTER","CLINIC")),CLINICIEN="" Q
 I CLINICIEN'="",$D(SDINPUT("FILTER","CLINIC")),'$D(SDINPUT("FILTER","CLINIC",CLINICIEN)) Q
 ; check services
 S STOPIEN=$G(APPTREQ(409.85,REQIENS,8.5,"I"))
 I $D(SDINPUT("FILTER","SERVICE")),STOPIEN="" Q
 I STOPIEN'="",$D(SDINPUT("FILTER","SERVICE")),'$D(SDINPUT("FILTER","SERVICE",STOPIEN)) Q
 ; wait time
 S DATEENTERED=$G(APPTREQ(409.85,REQIENS,1,"I"))
 I DATEENTERED<STARTDT!(DATEENTERED>ENDDT) Q
 ; origination date
 I $D(SDINPUT("FILTER","ORIGINATION DATE")),$G(APPTREQ(409.85,REQIENS,1,"I"))'=FLTRORIGDATE Q
 ; pid (desired) date
 S PIDDATE=$G(APPTREQ(409.85,REQIENS,22,"I"))
 I PIDDATE="" S PIDDATE="UNKNOWN"
 I $D(SDINPUT("FILTER","PID")),PIDDATE'=FLTRPIDDATE Q
 S WAITDAYS=$$FMDIFF^XLFDT(DT,$G(APPTREQ(409.85,REQIENS,1,"I")))
 ;
 S PATNAME=$G(APPTREQ(409.85,REQIENS,.01,"E"))
 S CLINICNAME=$G(APPTREQ(409.85,REQIENS,8,"E"))
 I CLINICNAME="" S CLINICNAME="UNKNOWN"
 ; get service related from the request itself, set to 0 if null
 S SERVICEREL=$G(APPTREQ(409.85,REQIENS,15,"I"))
 I SERVICEREL="" S SERVICEREL=0
 ; SCPERCENT IS CONVERTED TO THE INVERSE IN THE ORIGINAL FOR SORTING
 S SCPERCENT=100-$G(PATSCPERCENT)
 S COUNT=$G(COUNT)+1,REQCNT=$G(REQCNT)+1
 D SETDATA($G(SDINPUT("SORT")),PATNAME,CLINICNAME,PRIORITYGROUP,PIDDATE,DATEENTERED,"A",REQIEN,SERVICEREL,SCPERCENT,WAITDAYS,COUNT)
 Q
 ;
FLTRCONSULT(CONSIEN,SDINPUT,FLTRORIGDATE,FLTRPIDDATE,STARTDT,ENDDT,PRIORITYGROUP,PATSVCCONN,PATSCPERCENT,COUNT,REQCNT) ;
 N CONSIENS,CONSULT,CLINICIEN,SERVICEIEN,WAITDAYS,DATEENTERED,PATNAME,CLINICNAME,SERVICEREL,PIDDATE
 Q:'CONSIEN
 S CONSIENS=CONSIEN_","
 D GETS^DIQ(123,CONSIENS,".01;.02;.05;.07;1;2","IE","CONSULT")
 ; clinics
 S CLINICIEN=$G(CONSULT(123,CONSIENS,2,"I"))
 I CLINICIEN'="",$D(SDINPUT("FILTER","CLINIC")),'$D(SDINPUT("FILTER","CLINIC",CLINICIEN)) Q
 ; services
 S SERVICEIEN=$G(CONSULT(123,CONSIENS,1,"I"))
 I SERVICEIEN,$D(SDINPUT("FILTER","SERVICE")) Q:'$$CHECKSERVICES^SDES2QRYAPREQSA(.SDINPUT,SERVICEIEN)
 ; wait time
 S DATEENTERED=$P($G(CONSULT(123,CONSIENS,.01,"I")),".")
 I DATEENTERED<STARTDT!(DATEENTERED>ENDDT) Q
 ; origination date
 I $D(SDINPUT("FILTER","ORIGINATION DATE")),$P($G(CONSULT(123,CONSIENS,.01,"I")),".")'=FLTRORIGDATE Q
 ; pid (desired) date - uses $$PRIO^SDES2QRYAPREQSA to determine PID date for consults
 S PIDDATE=$$PRIO^SDES2QRYAPREQSA(CONSIEN)
 I PIDDATE="" S PIDDATE=DATEENTERED
 I $D(SDINPUT("FILTER","PID")),PIDDATE'=FLTRPIDDATE Q
 ; urgency
 I $D(SDINPUT("FILTER","URGENCY")),$$GET1^DIQ(123,CONSIEN,5,"I")'=$G(SDINPUT("FILTER","URGENCY")) Q
 ;
 S WAITDAYS=$$FMDIFF^XLFDT(DT,DATEENTERED)
 S PATNAME=$G(CONSULT(123,CONSIENS,.02,"E"))
 I PATNAME="" S PATNAME="UNKNOWN"
 S CLINICNAME=$G(CONSULT(123,CONSIENS,2,"E"))
 I CLINICNAME="" S CLINICNAME="UNKNOWN"
 S SERVICEREL=$S(PRIORITYGROUP="GROUP 1":1,1:0)
 ; SCPERCENT IS CONVERTED TO THE INVERSE IN THE ORIGINAL FOR SORTING
 S SCPERCENT=100-$G(PATSCPERCENT)
 S COUNT=$G(COUNT)+1,REQCNT=$G(REQCNT)+1
 D SETDATA($G(SDINPUT("SORT")),PATNAME,CLINICNAME,PRIORITYGROUP,PIDDATE,DATEENTERED,"C",CONSIEN,SERVICEREL,SCPERCENT,WAITDAYS,COUNT)
 Q
 ;
FLTRRECALL(RECALLIEN,SDINPUT,FLTRORIGDATE,FLTRPIDDATE,STARTDT,ENDDT,PRIORITYGROUP,PATSVCCONN,PATSCPERCENT,COUNT,REQCNT) ;
 N RECALLIENS,RECALL,CLINICIEN,STOPIEN,DATEENTERED,RECALLDATE,WAITDAYS,PATNAME,CLINICNAME,SERVICEREL,SCPERCENT
 S RECALLIENS=RECALLIEN_","
 D GETS^DIQ(403.5,RECALLIENS,".01;4.5;5;5.5;7.5","IE","RECALL")
 ; clinics
 S CLINICIEN=$G(RECALL(403.5,RECALLIENS,4.5,"I"))
 I CLINICIEN'="",$D(SDINPUT("FILTER","CLINIC")),'$D(SDINPUT("FILTER","CLINIC",CLINICIEN)) Q
 I $$GET1^DIQ(44,CLINICIEN,50.01,"I")=1 Q  ;do not return if OOS? is yes
 ; services
 S STOPIEN=$$GET1^DIQ(44,CLINICIEN,8,"I")
 I STOPIEN,$D(SDINPUT("FILTER","SERVICE")),'$D(SDINPUT("FILTER","SERVICE",STOPIEN)) Q
 S DATEENTERED=$P($G(RECALL(403.5,RECALLIENS,7.5,"I")),".")
 I DATEENTERED="" S DATEENTERED=$G(RECALL(403.5,RECALLIENS,5,"I"))
 ; origination date
 I $D(SDINPUT("FILTER","ORIGINATION DATE")),DATEENTERED'=FLTRORIGDATE Q
 ; wait time
 S RECALLDATE=$G(RECALL(403.5,RECALLIENS,5.5,"I"))
 I 'RECALLDATE S RECALLDATE=$G(RECALL(403.5,RECALLIENS,5,"I"))
 I RECALLDATE<STARTDT!(RECALLDATE>ENDDT) Q
 ; pid (desired) date
 I $D(SDINPUT("FILTER","PID")),RECALLDATE'=FLTRPIDDATE Q
 S WAITDAYS=$$FMDIFF^XLFDT(DT,RECALLDATE)
 S PATNAME=$G(RECALL(403.5,RECALLIENS,.01,"E"))
 I PATNAME="" S PATNAME="UNKNOWN"
 S CLINICNAME=$G(RECALL(403.5,RECALLIENS,4.5,"E"))
 I CLINICNAME="" S CLINICNAME="UNKNOWN"
 S SERVICEREL=PATSVCCONN
 ; SCPERCENT IS CONVERTED TO THE INVERSE OF THE ORIGINAL FOR SORTING
 S SCPERCENT=100-PATSCPERCENT
 S COUNT=$G(COUNT)+1,REQCNT=$G(REQCNT)+1
 D SETDATA($G(SDINPUT("SORT")),PATNAME,CLINICNAME,PRIORITYGROUP,RECALLDATE,DATEENTERED,"R",RECALLIEN,SERVICEREL,SCPERCENT,WAITDAYS,COUNT)
 Q
 ; set data into ^TMP for final processing
SETDATA(SORT,PATNAME,CLINICNAME,PRIOGROUP,DESIREDDATE,ORIGDATE,REQTYPE,REQIEN,SERVICEREL,SCPERCENT,WAITDAYS,COUNT) ;
 ;
 I $G(SORT)="DEFAULT" D
 .S ^TMP("SDES2QUERY",$J,"DATA",PRIOGROUP,'SERVICEREL,DESIREDDATE,ORIGDATE,REQIEN)=REQTYPE
 I $G(SORT)="PRIORITY GROUP" D
 .S ^TMP("SDES2QUERY",$J,"DATA",PRIOGROUP,'SERVICEREL,DESIREDDATE,ORIGDATE,REQIEN)=REQTYPE
 I $G(SORT)="PATIENT NAME" D
 .I PATNAME="" S PATNAME="**MISSING PATIENT NAME**"
 .S ^TMP("SDES2QUERY",$J,"DATA",PATNAME,REQIEN)=REQTYPE
 I $G(SORT)="CLINIC" D
 .I CLINICNAME="" S CLINICNAME="**MISSING CLINIC NAME**"
 .S ^TMP("SDES2QUERY",$J,"DATA",CLINICNAME,REQIEN)=REQTYPE
 I $G(SORT)="REQUEST" D
 .S ^TMP("SDES2QUERY",$J,"DATA",REQTYPE,REQIEN)=REQTYPE
 I $G(SORT)="WAIT TIME" D
 .S ^TMP("SDES2QUERY",$J,"DATA",WAITDAYS,REQIEN)=REQTYPE
 I $G(SORT)="ORIGINATION DATE" D
 .S ^TMP("SDES2QUERY",$J,"DATA",ORIGDATE,REQIEN)=REQTYPE
 I $G(SORT)="PID DATE" D
 .S ^TMP("SDES2QUERY",$J,"DATA",DESIREDDATE,REQIEN)=REQTYPE
 I $G(SORT)="SERVICE RELATED" D
 .S ^TMP("SDES2QUERY",$J,"DATA",SERVICEREL,REQIEN)=REQTYPE
 I $G(SORT)="SCVISIT" D
 .S ^TMP("SDES2QUERY",$J,"DATA",SCPERCENT,REQIEN)=REQTYPE
 S ^TMP("SDES2QUERY",$J,"COUNT")=COUNT
 Q
 ;
GETPATENR(DFN,PRIORITYGROUP,CURRENTENR,PATSVCCONN,PATSCPERCENT) ;
 N ENRRET
 Q:'DFN
 S PRIORITYGROUP=$$PRIORITY^DGENA(DFN)
 ; default group to 0 if undefined
 I PRIORITYGROUP="" S PRIORITYGROUP=0
 ; Set service connected and service connected percent to 0
 S (PATSVCCONN,PATSCPERCENT)=0
 S CURRENTENR=$$FINDCUR^DGENA(DFN)
 I CURRENTENR'="" D
 .D GET^DGENA(CURRENTENR,.ENRRET)
 .S PATSVCCONN=$G(ENRRET("ELIG","SC"))
 .S PATSVCCONN=$S(PATSVCCONN="Y":1,1:0)
 .S PATSCPERCENT=$G(ENRRET("ELIG","SCPER"))
 .S PATSCPERCENT=$S(PATSCPERCENT'="":PATSCPERCENT,1:0)
 Q
