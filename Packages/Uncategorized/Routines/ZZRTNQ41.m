ZZRTNQ41 ;MJK,PKE/TROY ISC;Expanded Record Inquiry cont; ; 9/4/90  9:57 AM ;
 ;;v 2.0;Record Tracking;**19**;10/22/91 
 S DFN=+RTE,(R3,R2)=""
 ;appointment
 S S=0 F I=1:1 S S=$O(^DPT(DFN,"S",S)) Q:'S  S Z(I)=S K Z(I-4)
 S CT=0 S S=$O(Z(0)) I S F S=Z(S):0 S S=$O(^DPT(DFN,"S",S)) Q:'S  I $D(^(S,0)),$P(^(0),U,2)'["C" S Y=S D D^DIQ S Y=$E($S($D(^SC(+^(0),0)):$P(^(0),"^"),1:"UNKNOWN"),1,19)_"^"_Y,CT=CT+1 S R3(4-CT)=Y
 ;admissions
 D ADM^VADPT2 S Y=VADMVT
 I +Y S CT=4,Y=^DGPM(VADMVT,0),M="adm" D ADM S M="dis",CT=5 D DIS Q
 I Y="" S M="dis",CT=5 K RTAD D DIS Q:'$D(RTAD)  S M="adm",Y=^DGPM(Y,0),CT=4 D ADM Q
 Q
Q K RTFUT,RTESC,RTE,RTFL,RTDTI,A1,A,S,RTVAR,RTPGM,RTDT,R,RT,M,P,DFN,RTG,RTH,RTI,T,V,^TMP($J,"RTCOMBO") D CLOSE^RTUTL
 K RTG1,%,%H,%I,N,POP,RTI1 Q
 ;
REC S V=$S('$D(^DIC(195.2,+$P(Y,"^",3),0)):"UNKNOWN",1:$P(^(0),"^",2))_+$P(Y,"^",7) Q
 ;
ADM ;
 S D1=+Y,D=9999999.9999-Y,Y=$S($D(^DIC(42,+$P(Y,"^",6),0)):$P(^(0),"^",1),R2(CT)=$E(Y,1,20)_";"_M,Y=$E(D1,1,12) D D^DIQ S R2(CT)=R2(CT)_"^"_Y
 Q
DIS ;
 Q:'$D(^DGPM("ATID3",DFN))  D NOW^%DTC S Y=$O(^DGPM("ATID3",DFN,9999999.9999999-%)) Q:Y=""  S Y=$O(^(Y,0)),Y=^DGPM(Y,0),RTAD=$S($P(Y,U,14):$P(Y,U,14),1:0)
 D NOW^%DTC S RTAD=$O(^DGPM("ATID2",DFN,9999999.999999-%)),RTAD=$O(^(RTAD,0)),RTAD=^DGPM(RTAD,0),RTAD=$S($P(RTAD,U,6):$P(RTAD,U,6),1:0)
 S Y=$E(Y,1,10)_"^^^^^"_RTAD D ADM K Z,Y1 Q
 ;
DPL ;Displays the admissions and discharges.
 D LINE^RTUTL3
 F CT=1:1:3 I $D(R3(CT)) W !,$P($T(LABELS+CT),";;",2),"   ",$E($P(R3(CT),"^")_"                     ",1,20),$P(R3(CT),"^",2)
XXX F CT=4:1:5 I $D(R2(CT)) W !,$P($T(LABELS+CT),";;",2),"   ",$E($P(R2(CT),"^")_"                   ",1,20),$P(R2(CT),"^",2)
 Q
LABELS ;;
 ;;Clinic appoint  :
 ;;Clinic appoint  :
 ;;Clinic appoint  :
 ;;Last Admission  :
 ;;Last Discharge  :
