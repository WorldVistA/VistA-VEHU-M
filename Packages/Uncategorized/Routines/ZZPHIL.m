ZZPHIL  ;BIZ-CACHE/PHIL
        ;;1.0
        ;;Utility to set up environment variables
SETUP   S DUZ=1
        D ^XUP
        Q
ELIG    S XX=0 F  S XX=$O(^DPT(XX)) Q:XX'>0  D
        .S DFN=XX
        .D ELIG^VADPT
        .I +$G(VAEL(3))=1 S ^TMP("SC",DFN)=$G(VAEL(3))
        .K DFN
        K XX
        Q
MAKEAPT ; Make some appointments for patients
        K SD,SC,TYPE,SUBTYPE,LEN,SRT,DFN
        S SC=23,TYPE="REGULAR",SUBTYPE="",LEN=60,SRT="ROUTINE"
        F SD1=3130415.0700:1.0:3130419.1630 D MAKE
        Q
MAKE    W !,"IN MAKE"
        S SD2=SD1
        F DFN=100840:1:100847  D
        .Q:'$D(^DPT(DFN,0))
        .S SD=$$FMADD^XLFDT(SD2,0,0,$G(LEN),0)
        .;Q:$P($G(SD),".",2)>16
        .W !,DFN,"  ",$G(SD),"  ",$G(SD1)
        .S SD2=SD
        .D MAKE^SDMAPI2(.RETURN,DFN,SC,SD,TYPE,SUBTYPE,LEN,SRT)
        Q
GETCLINIC;
        W !,"CLINIC ID,CLINIC NAME,SERVICE,SPECIALTY"
        S Z=","
        S XX=0 F  S XX=$O(^SC(XX)) Q:XX'>0  D
        .K CLINIC,SERVICE,SPECIALTY,S1,S2
        .Q:$P(^SC(XX,0),"^",3)'="C"
        .S CLINIC=$P(^SC(XX,0),"^")
        .S S2=$P(^SC(XX,0),"^",8)
        .S:$G(S2)'="" SERVICE=$S(S2="M":"MEDICINE",S2="S":"SURGERY",S2="P":"PSYCHIATRY",S2="R":"REHAB MEDICINE",S2="N":"NEUROLOGY",S2=0:"NO SERVICE",1:"NO SERVICE")
        .S:$G(S2)="" SERVICE="NO SERVICE"
        .S S1=$P(^SC(XX,0),"^",20) S:$G(S1)'="" SPECIALTY=$P(^DIC(45.7,S1,0),"^")
        .S:$G(S1)="" SPECIALTY="NO SPECIALTY"
        .W !,XX,Z,$G(CLINIC),Z,$G(SERVICE),Z,$G(SPECIALTY)
        Q
FIX     S XX=3130101 F  S XX=$O(^DPT(237,"S",XX)) Q:XX'>0  D
        .W !,$P($G(^DPT(237,"S",XX,0)),"^",24,25)
        .S $P(^DPT(237,"S",XX,0),"^",24)=""
        .S $P(^DPT(237,"S",XX,0),"^",25)="N"
        .W !,$P($G(^DPT(237,"S",XX,0)),"^",24,25),!
        Q
GETPAT	K PAT S PAT="100843^100844^100845^8^237^100840"
		W !,"NAME^SSN^DOB^AGE^GENDER"
		F I=1:1:6 S IEN=$P(PAT,"^",I) D ;W !,IEN ;Q:$P(IEN,"^",I)=""  W !,$G(IEN)
		.S PATNAME=$P(^DPT(IEN,0),"^",1),SSN=$P(^DPT(IEN,0),"^",9),DOB=$P(^DPT(IEN,0),"^",3),GENDER=$P(^DPT(IEN,0),"^",2)
		.S AGE=$E(DT,1,3)-$E(DOB,1,3),U="^"
		.W !,PATNAME_U_SSN_U_DOB_U_AGE_U_GENDER
		.K PATNAME,SSN,DOB,GENDER,AGE
		K PAT,IEN
		Q
