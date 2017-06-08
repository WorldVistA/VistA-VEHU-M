A3FDUP ;PTD/BHAM ISC-Print Letter for Duplicate Request ; 07/12/89 8:15
 ;MODIFIED SLL/TROY ISC; 07/27/89
 ;;CLASS III RD3 SOFTWARE V1.0;
 ;VARIABLES: I - STATION POINTER NUMBER; J - DATE SUBMITTED BY STATION; K - PHYSICIAN DA; L - DATE FROM FSMB.
 W !!,"This option should be selected ONLY after receiving a",!,"MailMan message stating that a duplicate request",!,"has been entered.",!
 I '$O(^DIZ(131000,"ADUP",0)) W !!,"There are NO duplicate requests in the file!" G END
DEV W !! K %ZIS,IOP S %ZIS="M",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 U IO S Y=DT D D^DIQ S TODAY=Y
 F I=0:0 S I=$O(^DIZ(131000,"ADUP",I)) Q:'I  F J=0:0 S J=$O(^DIZ(131000,"ADUP",I,J)) Q:'J  F K=0:0 S K=$O(^DIZ(131000,"ADUP",I,J,K)) Q:'K  F L=0:0 S L=$O(^DIZ(131000,"ADUP",I,J,K,L)) Q:'L  D DUPLTR
 W:$E(IOST)'="C" @IOF X ^%ZIS("C")
REPRINT W @IOF,*7,!!!,"If you need to reprint the 'Duplicate Request' letter(s)",!,"for any reason, you may do so now.",!!,"Do you wish to reprint? "
 R ANS:DTIME G:'$T!("^"[ANS) END I "YyNn"'[$E(ANS) W !!,"Answer ""yes"" if you wish to reprint; ""no"" if you do not." G REPRINT
 I "Yy"[$E(ANS) K ANS,I,J,K,L,POP G DEV
 I "Nn"[$E(ANS) D KXREF
END K ANS,BCH,I,J,K,L,M,N,P,POP,R,TODAY,Y
 Q
 ;
DUPLTR W @IOF W !!!!!!!!!!!!?15,TODAY,!!!?15,"Director (00)",!?15,"VA Medical Center",!?15,$P(^DIZ(1300002,I,0),"^",6),", ",$P(^DIC(5,($P(^DIZ(1300002,I,3),"^")),0),"^",2),"  ",$P(^DIZ(1300002,I,3),"^",2)
ONE W !!?15,"SUBJ:  Licensure Screening for Physician Applicants",!!?15,"1.  On " S Y=J D D^DIQ W Y," we received a request from your facility",!?15,"that the following applicant be screened through the FSMB:",!!?25,$P(^DIZ(131000,K,0),"^")
 W !!?15,"Upon checking our records, it was noted that this name was",!?15,"submitted on " S Y=L D D^DIQ W Y," by another VAMC.  The response from",!?15,"FSMB at that time revealed that no disciplinary action was"
 W !?15,"found.  Therefore, we do not feel it is necessary to resubmit",!?15,"the name to the FSMB at this time."
TWO W !!?15,"2.  However, if you feel it is necessary to resubmit this",!?15,"name please notify",$P(^DIZ(1100001,FSMBR,0),"^",4),", Regional Nurse, at the"
 W !?15,"Albany RD Office, FTS 8-562-2846.  If we are not",!?15,"notified by your office to resubmit this name, no further",!?15,"action will be taken."
THR W !!?15,"3.  The FSMB reports only those disciplinary actions resulting",!?15,"from actions taken by medical licensing and disciplinary",!?15,"boards or similar official sources.  Therefore, you are"
 W !?15,"reminded that screening applicants with the Federation of",!?15,"State Medical Boards does not abrogate the Chief of Staff's",!?15,"responsibility to verify with State licensing boards all"
 W !?15,"medical licenses held by physician applicants prior to",!?15,"appointment (see DM&S Circular 10-86-23)."
 W !!!!!?15,$P(^DIZ(1100001,FSMBR,0),U,3),!?15,"Associate Deputy Regional Director"
 Q
 ;
KXREF ;DELETE THE "ADUP" X-REF AND THE "ABATCH" X-REF
 F M=0:0 S M=$O(^DIZ(131000,"ADUP",M)) Q:'M  F N=0:0 S N=$O(^DIZ(131000,"ADUP",M,N)) Q:'N  F P=0:0 S P=$O(^DIZ(131000,"ADUP",M,N,P)) Q:'P  F R=0:0 S R=$O(^DIZ(131000,"ADUP",M,N,P,R)) Q:'R  D ZAP
 Q
 ;
ZAP S BCH=^DIZ(131000,"ADUP",M,N,P,R) K ^DIZ(131000,"ADUP",M,N,P,R) K ^DIZ(131000,"ABATCH",BCH,P,M) S ^DIZ(131000,"ADPLTRPRT",P,M,BCH)=""
 Q
 ;
