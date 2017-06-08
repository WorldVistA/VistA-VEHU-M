PRSTDIS ; HISC/REL/WAA - Display Time Card ;11/2/89  14:31
 ;;3.5;PAID;;Jan 26, 1995
DISP ; Display Personnel Data
 W @IOF,!?24,"8 B   P E R S O N N E L   D A T A"
 S C0=^PRST(455,PP,1,DFN,0)
 S X=$P(C0,"^",5) W !!,"SSN:",?24,$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9)
 W ?49,"Normal Hours:",?68,$P(C0,"^",9)
 W !,"Employee:",?24,$P(^PRSPC($P(C0,"^",1),0),"^",1)
 W ?49,"Leave Group:" S Y=$P(C0,"^",8) W:Y]"" ?68,Y
 W !,"Duty Station:" S Y=$P(C0,"^",4) W:Y'="" ?24,Y
 W ?49,"Duty Basis:",?68,$P(C0,"^",11)
 W !,"T & L Unit:",?24,$P(C0,"^",7)
 W ?49,"Pay Plan:" W ?68,$P(C0,"^",10)
 W !,"FLSA Code:" W ?24,$P($G(^PRSPC(DFN,0)),U,12)
 W ?49,"Premium Pay:" W ?68,$P($G(^PRSPC(DFN,"PREMIUM")),U,6)
 W !,"Compressed Week:" W ?24,$P($G(^PRSPC(DFN,1)),U,7)
 G D2:CDIS=1,D1:$P(C0,"^",3)=""
 S CSTR="" F A=13:1:N1 S CODE=$P(C0,"^",A) I CODE'="" S CSTR=CSTR_$P(T0," ",A-12)_CODE_"   "
 I $D(^PRST(455,PP,1,DFN,1)) S Y=^(1) F A=1:1:N2 S CODE=$P(Y,"^",A) I CODE'="" S CSTR=CSTR_$P(T1," ",A)_CODE_"   "
 G:CSTR="" D1 S CSTR=$E(CSTR,1,$L(CSTR)-3)
 W !!,"Codes: " I $L(CSTR)<72 W CSTR
 E  S Y=$L(CSTR,"   ")\2 W $P(CSTR,"   ",1,Y),!!?7,$P(CSTR,"   ",Y+1,999)
 I CDIS=3 W !!?7,"CD" S CD=$P(C0,"^",3) W $E("00000"_CD,$L(CD),$L(CD)+5)
D1 I CDIS'=3!(PRSTLV<8) G D2
 S C0=$G(^PRST(455,PP,1,DFN,0))
 S C2=$G(^PRST(455,PP,1,DFN,2))
 S CURR=$P(C0,"^",2)
 W !!,"Current Status: ",$S(CURR="T":"Timekeeper Entered",CURR="P":"Payroll Reviewed",CURR="H":"Hold by Payroll",CURR="X":"Transmitted to Austin",CURR="":"No Timekeeper Data",1:"")
 W !,"Timekeeper Entry by:    " S Y=$P(C2,"^",1) D UR^PRSTRN2 S Y=$P(C2,"^",2) I Y W " on " D DT^PRSTRN2
 W !,"Verification by:        "
 I "T"'[$P(^PRST(455,PP,1,DFN,0),"^",2) S Y=$P(C2,"^",3) D UR^PRSTRN2 S Y=$P(C2,"^",4) I Y W " on " D DT^PRSTRN2
 W !,"--------------------------------------------------------------------------------"
 I '$D(^PRST(455,PP,"A",DFN)) G KIL
 W !,?34,"Audit Trail"
 W !,"Date Entered",?25,"Clerk:",?55,"Status"
 W !,"--------------------------------------------------------------------------------"
 S X=0
D11 S X=$O(^PRST(455,PP,"A",DFN,1,X)) G:X<1 D2
 S Y=^PRST(455,PP,"A",DFN,1,X,0),CLERK=$S($P(Y,"^",2)'="":$P(^VA(200,$P(Y,"^",2),0),"^",1),1:""),DATE=$P(Y,"^",3)
 S STAT=$P(Y,"^",4)
 S STATUS=$S(STAT="T":"Timekeeper Entered",STAT="P":"Payroll Reviewed",STAT="H":"Hold by Payroll",STAT="X":"Transmitted to Austin",STAT="":"No Timekeeper Data",1:"")
 S HDR=$P(Y,"^",5)
 W ! S Y=DATE D DT^PRSTRN2
 W ?25,CLERK,?55,STATUS
 W:HDR'="" !,?5,HDR
 G D11
D2 W !,"--------------------------------------------------------------------------------"
KIL K A,C0,CD,CDIS,CLERK,CODE,CSTR,CURR,DATE,HDR,STAT,STATUS,X,Y Q
