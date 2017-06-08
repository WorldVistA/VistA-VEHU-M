VEJDWPB4 ;WPB/CAM routine modified for dental GUI;8/1/98;7/10/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; slc/CLA/REV - Functions which return patient problem list data ;12/15/97 [ 06/10/98  10:30 am ]
 ;ORQQPL;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
LIST(ORPY,DFN,STATUS)  ;return pt's problem list in format: ien^description^
 ; ICD^onset^last modified^SC^SpExp
 ; STATUS = status of problems to return: (A)CTIVE, (I)NACTIVE, ("")ALL 
 Q:'DFN
 N GMPL,I
 I $L($T(LIST^VEJDWPB6))>0 D
 .D LIST^VEJDWPB6(.GMPL,DFN,STATUS)
 .Q:'$D(GMPL(0))
 .F I=1:1:GMPL(0) S X=GMPL(I),ORPY(I)=$P(X,U)_U_$P(X,U,3)_U_$P(X,U,2)_U_$P(X,U,4)_U_$P(X,U,5)_U_$P(X,U,6)_U_$P(X,U,7)_U_$P(X,U,8)_U_$P(X,U,10)_U_$P(X,U,9)
 .S:+$G(ORPY(1))<1 ORPY(1)="^No problems found."
 I $L($T(LIST^VEJDWPB6))<1 S ORPY(1)="^Problem list not available.^"
 K X
 Q
DETAIL(Y,PROBIEN)  ; RETURN DETAILED PROBLEM DATA
 N GMPL,GMPDT
 I $G(^AUPNPROB(+$G(PROBIEN),0))]"" D DETAIL^VEJDWPB6(PROBIEN,.GMPL) D:$D(GMPL)
 .N CR,I,J S CR=$CHAR(13),I=1
 .S Y(I)=GMPL("NARRATIVE")_" ("_GMPL("DIAGNOSIS")_")",I=I+1
 .S Y(I)=" ",I=I+1
 .S Y(I)="   Onset: "_GMPL("ONSET"),I=I+1
 .S Y(I)="  Status: "_GMPL("STATUS"),I=I+1
 .S Y(I)=" SC Cond: "_GMPL("SC"),I=I+1
 .S Y(I)="Exposure: "_$S($G(GMPL("EXPOSURE"))>0:GMPL("EXPOSURE"),1:"None"),I=I+1
 .S Y(I)=" ",I=I+1
 .S Y(I)="Provider: "_GMPL("PROVIDER"),I=I+1
 .S Y(I)="  Clinic: "_GMPL("CLINIC"),I=I+1
 .S Y(I)=" ",I=I+1
 .S Y(I)="Recorded: "_$P(GMPL("RECORDED"),U)_", by "_$P(GMPL("RECORDED"),U,2),I=I+1
 .S Y(I)=" Entered: "_$P(GMPL("ENTERED"),U)_", by "_$P(GMPL("ENTERED"),U,2),I=I+1
 .S Y(I)=" Updated: "_GMPL("MODIFIED"),I=I+1
 .S Y(I)=" ",I=I+1
 .;S Y(I)=" Comment: "_$S($G(GMPL("COMMENT"))>0:GMPL("COMMENT"),1:"")
 .I $G(GMPL("COMMENT"))>0 D
 ..S Y(I)="----------- Comments -----------",I=I+1
 ..;F J=GMPL("COMMENT"):-1:1  D
 ..;.S Y(I)=GMPL("COMMENT",J)
 ..;.S Y(I)=$P(Y(I),U)_" by "_$P(Y(I),U,2)_": "_$P(Y(I),U,3),I=I+1
 ..F J=1:1:GMPL("COMMENT")  D
 ...S Y(I)=GMPL("COMMENT",J)
 ...S Y(I)=$P(Y(I),U)_" by "_$P(Y(I),U,2)_": "_$P(Y(I),U,3),I=I+1
 .S Y(I)=" ",I=I+1
 .D HIST^VEJDWPB5(.GMPDT,PROBIEN)
 .I $G(GMPDT(0))>0 D
 ..S Y(I)="----------- Audit History -----------",I=I+1
 ..F J=1:1:GMPDT(0)  S Y(I)=$P(GMPDT(J),U)_":  "_$P(GMPDT(J),U,2),I=I+1
 S:'$D(Y) Y(1)="-1^Problem entry does not exist"
 Q
HASPROB(ORDFN,ORPROB) ;extrinsic function returns 1^problem text;ICD9 if
 ;pt has an active problem which contains any piece of ORPROB
 ;ORDFN   patient DFN
 ;ORPROB  problems to check vs. active prob list in format: PROB1TEXT;PROB1ICD^PROB2TEXT;PROB2ICD^PROB3...
 ;if ICD includes "." an exact match will be sought
 ;if not, a match of general ICD category will be sought
 ;Note: All ICD codes passed must be preceded with ";"
 Q:+$G(ORDFN)<1 "0^Patient not identified."
 Q:'$L($G(ORPROB)) "0^Problem not identified."
 N ORQAPL,ORQY,ORI,ORJ,ORCNT,ORQPL,ORQICD,ORQRSLT
 D LIST(.ORQY,ORDFN,"A")
 Q:$P(ORQY(1),U)="" "0^No active problems found."
 S ORQRSLT="0^No matching problems found."
 S ORCNT=$L(ORPROB,U)
 S ORI=0 F  S ORI=$O(ORQY(ORI)) Q:ORI<1  D
 .S ORQAPL=ORQY(ORI)
 .F ORJ=1:1:ORCNT D
 ..S ORQPL=$P($P(ORPROB,U,ORJ),";"),ORQICD=$P($P(ORPROB,U,ORJ),";",2)
 ..;if problem text and pt's problem contains problem text passed:
 ..I $L(ORQPL),($P(ORQAPL,U,2)[ORQPL) D
 ...S ORQRSLT="1^"_$P(ORQAPL,U,2)_";"_$P(ORQAPL,U,4)
 ..;
 ..;if specific ICD (contains ".") and pt's ICD equals ICD passed:
 ..I $L(ORQICD),(ORQICD["."),($P(ORQAPL,U,4)=ORQICD) D
 ...S ORQRSLT="1^"_$P(ORQAPL,U,2)_";"_$P(ORQAPL,U,4)
 ..;
 ..;if non-specific ICD and pt's ICD category equals ICD category passed:
 ..I $L(ORQICD),(ORQICD'["."),($P($P(ORQAPL,U,4),".")=ORQICD) D
 ...S ORQRSLT="1^"_$P(ORQAPL,U,2)_";"_$P(ORQAPL,U,4)
 Q ORQRSLT
