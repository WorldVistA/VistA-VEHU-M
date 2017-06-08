ZZA7RDPACT ;HINES/RMS - REPLACE OINQ LOCAL SHOPPER NOTICE ; 12-22-99 [4/11/07 3:26pm]
 ;;2.0 AKA AJEY0028, AKA A4ECLK
 ;;NAMED INTO A7R NAMESPACE BECAUSE OF SO MANY DG PATCHES
 ;;OVERWRITING THE LOCAL MODIFICATION
EN Q:$E($G(IOST),1,2)'="C-"
 Q:$D(ZTQUEUED)
 Q:$G(DDSFILE)  ;SCREENMAN
 Q:$D(A7RQUIET)
 N AJEYIEN
NDBI D  ;INTEGRATION CODE
 .Q:'$L($T(TS^A7RU0002))  ;NOT AN INTEGRATION SITE
 .I $$TS^A7RU0002'="P" Q  ;Not on primary system if integration site
 .N A7R
 .S A7R=1
 .F  S A7R=$O(^A7RCP("B",A7R)) Q:'A7R  I $$OLD^A7RCP(2,+Y,A7R) D  
 ..W !! F I=1:1:IOM-1 W "*"
 ..W !,"This patient has historical data on the ",A7R," Legacy system."
 ..W ! F I=1:1:IOM-1 W "*"
 ..W ! H 1
DDTC D  ; CONTROL FOR PHARMACY DDTC INFORMATION
 .N AJEYIEN
 .Q:'$D(^AJEY(578160,"B",+Y))
 .S AJEYIEN=$O(^AJEY(578160,"B",+Y,0))
 .Q:$P($G(^AJEY(578160,AJEYIEN,2)),U,3)<DT
 .W !,$$REPEAT^XLFSTR("*",IOM)
 .W !,"This patient has a local notice with the following text:"
 .W !?2,"-->  ",$G(^AJEY(578160,AJEYIEN,1))
 .W !,$$REPEAT^XLFSTR("*",IOM)
 .S AJEYEND=1
OPTOUT D   ;For optout patients
 .S OPTOUT=$P($G(^DPT(DFN,.109)),U) I OPTOUT=1 D
 ..W !,$$REPEAT^XLFSTR("*",IOM)
 ..W !,"Patient chose not to be included in the Facility Directory for this admission"
 ..W !,$$REPEAT^XLFSTR("*",IOM),!
RSH D  ; CONTROL FOR RESEARCH PATIENT FLAG
 .N AJEYIEN,AJEYST,AJEYSTN,AJEYNM,AJEYPI,AJEYPN,AJEYPH,AJEYMFLG
 .N AJEYN2,AJEYN3
 .Q:'$D(^AJEY(578163,"B",+Y))
 .S AJEYIEN=$O(^AJEY(578163,"B",+Y,0))
 .S AJEYST=0 F  S AJEYST=$O(^AJEY(578163,AJEYIEN,1,AJEYST)) Q:AJEYST'=+AJEYST  D  ;
 ..S AJEYN3=$G(^AJEY(578163,AJEYIEN,1,AJEYST,0))
 ..Q:+$P(AJEYN3,"^",4)
 ..S AJEYSTN=$P(AJEYN3,"^",1)
 ..S AJEYN2=$G(^AJEY(578162,AJEYSTN,0))
 ..Q:+$P(AJEYN2,"^",5)
 ..W:'$G(AJEYMFLG) !,$$REPEAT^XLFSTR("*",IOM)
 ..W:'$G(AJEYMFLG) !,"This patient is enrolled in a RESEARCH STUDY. "
 ..S AJEYNM=$P(AJEYN2,"^",1)
 ..S AJEYPI=$P($G(^VA(200,+$P(AJEYN2,"^",2),0)),"^",1)
 ..S AJEYPH=$P(AJEYN2,"^",3)
 ..S AJEYPN=$P($G(^TIU(8925.1,+$P(AJEYN2,"^",4),0)),"^",1)
 ..W !,$$STNM
 ..W !!,"**** DO NOT WRITE OR CHANGE ANY MEDICATIONS PRIOR TO DISCUSSION ****"
 ..W !,"                      WITH DR. AINSLIE OR PAM MULLEN  "
 ..W !!,"Principal Investigator: "_AJEYPI
 ..W !,"Call "_AJEYPH_" if there are questions"
 ..W:$G(AJEYPN)]"" !,"See progress note "_$E(AJEYPN,1,39)_" for study information"
 ..W !,"Enrollment date: "_$$FMTE^XLFDT($P(AJEYN3,"^",2))
 ..W:$P(AJEYN3,"^",3) !,"Completion date: "_$$FMTE^XLFDT($P(AJEYN3,"^",3))
 ..S AJEYMFLG=1
 ..W !,$$REPEAT^XLFSTR("*",IOM)
 ..S AJEYEND=1
END I $G(AJEYEND) W !!,"... press RETURN to continue ..." R AJEY:DTIME
 K AJEY,AJEYIEN,AJEYEND
 Q
STNM() N AJEYERR
 Q $S($$ISA^USRLM(DUZ,"PROVIDER",.AJEYERR):AJEYNM,1:"STUDY NAME WITHHELD")
