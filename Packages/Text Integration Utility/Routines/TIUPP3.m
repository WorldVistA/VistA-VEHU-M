TIUPP3 ;SLC/DJP - Patient Posting Cover Sheet API ;10:22 AM  2 Dec 1999
 ;;1.0;TEXT INTEGRATION UTILITIES;**4,54,80**;Jun 20, 1997
 ;
ENCOVER(DFN) ; Supports CWAD Display.
 I DFN'>0 S MSG="-1^DFN required." Q
 K ^TMP("TIUPPCV",$J)
 D PTPLKP I TIUPP("DATA")="" S MSG="-1^No Patient Postings on file" Q
 S MSG="0^Patient Postings on file"
CLEANUP ;Clear out variables
 K PTP,TIUPP,TIUPPCN,TIUPPCW,TIUPPAVD,TIUPPADD,IEN,ADD,CTR,GMRARXN
 K TIUPPA,TIUPPADV,TIUPPSTS
 Q
 ;
PTPLKP ;Lookup and listing of Patient Posting indicators
 D DOCDEF S TIUPP("DATA")="",CTR=0,TIUPPA=""
 D EN1^GMRAOR1(DFN,"GMRARXN") I $G(GMRARXN) S PTP("IEN")="",PTP("ACRN")="A",PTP("CN")="ALLERGIES",PTP("MOD")="Known allergies",PTP("DATE")="" D BLDG
 F TIUPPSTS=7,8 D
 .I $D(^TIU(8925,"ADCPT",+DFN,TIUPPCN,TIUPPSTS)) S PTP("ACRN")="C",TIUPP("DOCTYPE")=TIUPPCN,PTP("CN")="CRISIS NOTE" D BUILD
 .I $D(^TIU(8925,"ADCPT",+DFN,TIUPPCW,TIUPPSTS)) S PTP("ACRN")="W",TIUPP("DOCTYPE")=TIUPPCW,PTP("CN")="CLINICAL WARNING" D BUILD
 .I $D(^TIU(8925,"ADCPT",+DFN,TIUPPADV,TIUPPSTS)) S PTP("ACRN")="D",TIUPP("DOCTYPE")=TIUPPADV,PTP("CN")="ADVANCE DIRECTIVE" D BUILD
 Q
 ;
BUILD ;Builds ^TMP("TIUPPCV" 
 N IEN S TIUPP("DATA")=TIUPP("DATA")_PTP("ACRN"),TIUPP("DATE")=0
 F  S TIUPP("DATE")=$O(^TIU(8925,"ADCPT",+DFN,TIUPP("DOCTYPE"),TIUPPSTS,TIUPP("DATE"))) Q:'TIUPP("DATE")  D
 .S IEN="",IEN=$O(^TIU(8925,"ADCPT",+DFN,TIUPP("DOCTYPE"),TIUPPSTS,TIUPP("DATE"),IEN)) S PTP("IEN")=IEN D
 ..S PTP("TITLE")=$$PNAME^TIULC1(+$G(^TIU(8925,IEN,0)))
 ..S PTP("MOD")=$P($G(^TIU(8925,IEN,17)),U,1)
 ..S X=9999999-TIUPP("DATE") S PTP("DATE")=X
 ..I '$D(ADD) D ADDEND
 ..D BLDG
 K ADD,PTP,IEN
 Q
 ;
BLDG ;Actual build of ^TMP node.  IEN^Acronym^Category Name^Optional Modifier^Date/Time^Optional Addendum
 S CTR=CTR+1,PTP("ENTRY")=PTP("IEN")_"^"_PTP("ACRN")_"^"_$S($L($G(PTP("TITLE"))):$G(PTP("TITLE")),1:PTP("CN"))_"^"_PTP("MOD")_"^"_PTP("DATE")
 I $D(PTP("ADD")) S PTP("ENTRY")=PTP("ENTRY")_"^"_PTP("ADD")
 S ^TMP("TIUPPCV",$J,CTR)=PTP("ENTRY")
 Q
 ;
ADDEND  ;Checks if posting has addendums
 N X
 I '$D(^TIU(8925,"DAD",IEN)) K IEN Q
 S ADD="",ADD=$O(^TIU(8925,"DAD",IEN,ADD),-1)
 I $P($G(^TIU(8925,ADD,0)),U,5)'=TIUPPSTS K ADD Q
 S ADD("DT")=$P($G(^TIU(8925,ADD,12)),U,1) I ADD("DT")="" K ADD Q
 S X=ADD("DT") D REGDTM
 S PTP("ADD")=" (addendum "_$E(X,1,14)_")"
 Q
 ;
DOCDEF ;Sets IENs for lookup on specific Document Types/Status
 N TIUDC,TIUX,TIUST
 S TIUX="CLINICAL WARNING"
 S TIUDC=0 F  S TIUDC=$O(^TIU(8925.1,"B",TIUX,TIUDC)) Q:+TIUDC'>0!+$G(TIUPPCW)  D
 . I $P($G(^TIU(8925.1,+TIUDC,0)),U,4)="DC" S TIUPPCW=+TIUDC
 S TIUX="CRISIS NOTE"
 S TIUDC=0 F  S TIUDC=$O(^TIU(8925.1,"B",TIUX,TIUDC)) Q:+TIUDC'>0!+$G(TIUPPCN)  D
 . I $P($G(^TIU(8925.1,+TIUDC,0)),U,4)="DC" S TIUPPCN=+TIUDC
 S TIUX="ADVANCE DIRECTIVE"
 S TIUDC=0 F  S TIUDC=$O(^TIU(8925.1,"B",TIUX,TIUDC)) Q:+TIUDC'>0!+$G(TIUPPADV)  D
 . I $P($G(^TIU(8925.1,+TIUDC,0)),U,4)="DC" S TIUPPADV=+TIUDC
 S TIUX="ADDENDUM"
 S TIUDC=0 F  S TIUDC=$O(^TIU(8925.1,"B",TIUX,TIUDC)) Q:+TIUDC'>0!+$G(TIUPPADD)  D
 . I $P($G(^TIU(8925.1,+TIUDC,0)),U,4)="DC" S TIUPPADD=+TIUDC
 S:'$D(TIUPPCW) TIUPPCW=0
 S:'$D(TIUPPCN) TIUPPCN=0
 S:'$D(TIUPPADV) TIUPPADV=0
 S:'$D(TIUPPADD) TIUPPADD=0
 Q
 ;
REGDTM ;Requires X-Internal Date.Time  Returns:  X=MM/DD/YY TT.TT
 Q:'$G(X)  N T
 S T=$P(X,".",2),X=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")_" "_$S(T:$E(T,1,2)_$E("00",0,2-$L($E(T,1,2)))_":"_$E(T,3,4)_$E("00",0,2-$L($E(T,3,4))),1:"")
 Q
 ;
