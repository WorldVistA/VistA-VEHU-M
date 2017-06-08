A3FLTR2 ;PTD/BHAM ISC-Print Letter for Further Review Required ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC;7/28/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 ;CALLING ROUTINE MUST PASS STATION POINTER NUMBER - Z
 W @IOF W !!!!!!!!!!!!?15,TODAY,!!!?15,"Director (00)",!?15,"VA Medical Center",!?15,$P(^DIZ(1300002,Z,0),"^",6),", ",$P(^DIC(5,($P(^DIZ(1300002,Z,3),"^")),0),"^",2),"  ",$P(^DIZ(1300002,Z,3),"^",2),!!
 W ?15,"SUBJ:  Licensure Screening for Physician Applicants",!!?15,"1.  The enclosed physician applicants' names were submitted",!?15,"to the FSMB for screening.  No disciplinary action was found"
 W !?15,"to have been reported; however, the FSMB has found it",!?15,"necessary to further review the data on some applicants",!?15,"in order to provide accurate screening.  Their final summary"
 W !?15,"report will indicate the presence or absence of disciplinary",!?15,"action on the following applicant(s):",!
 F J=0:0 S J=$O(LTR(Z,J)) Q:'J  S RES=LTR(Z,J) I RES=2 W !?25,$P(^DIZ(131000,J,0),"^")
 W !!?15,"You will be notified as soon as their final summary is",!?15,"received in our office.",!!
 W ?15,"2.  The FSMB reports only those disciplinary actions resulting",!?15,"from actions taken by medical licensing and disciplinary",!?15,"boards or similar official sources.  Therefore, you are"
 W !?15,"reminded that screening applicants with the Federation of",!?15,"State Medical Boards does not abrogate the Chief of Staff's",!?15,"responsibility to verify with State licensing boards all"
 W !?15,"medical licenses held by physician applicants prior to",!?15,"appointment (see DM&S Circular 10-86-23)."
 W !!!!!?15,$P(^DIZ(1100001,FSMBR,0),U,3),!?15,"Associate Deputy Regional Director",!!?15,"Enclosure"
 Q
 ;
