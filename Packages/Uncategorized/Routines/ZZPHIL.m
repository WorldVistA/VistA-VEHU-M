ZZPHIL  ;BIZ-CACHE/PHIL
 ;;1.0;Scheduling Calendar View;;May 5, 2015;Build 17
 ;;Utility to set up environment variables
SETUP ;
 S DUZ=1
 ;S DUZ=10000000229
 D ^XUP
 Q
PHIL   ;S DUZ=1
 S DUZ=10000000229
 D ^XUP
 Q
ELIG ;
 S XX=0 F  S XX=$O(^DPT(XX)) Q:XX'>0  D
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
MAKE ; 
 W !,"IN MAKE"
 S SD2=SD1
 F DFN=100840:1:100847  D
 .Q:'$D(^DPT(DFN,0))
 .S SD=$$FMADD^XLFDT(SD2,0,0,$G(LEN),0)
 .;Q:$P($G(SD),".",2)>16
 .W !,DFN,"  ",$G(SD),"  ",$G(SD1)
 .S SD2=SD
 .D MAKE^SDMAPI2(.RETURN,DFN,SC,SD,TYPE,SUBTYPE,LEN,SRT)
 Q
GETCLINIC ;
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
FIX ;
 S XX=3130101 F  S XX=$O(^DPT(237,"S",XX)) Q:XX'>0  D
 .W !,$P($G(^DPT(237,"S",XX,0)),"^",24,25)
 .S $P(^DPT(237,"S",XX,0),"^",24)=""
 .S $P(^DPT(237,"S",XX,0),"^",25)="N"
 .W !,$P($G(^DPT(237,"S",XX,0)),"^",24,25),!
 Q
GETPAT ;
 K PAT S PAT="100843^100844^100845^8^237^100840"
 W !,"NAME^SSN^DOB^AGE^GENDER"
 F I=1:1:6 S IEN=$P(PAT,"^",I) D ;W !,IEN ;Q:$P(IEN,"^",I)=""  W !,$G(IEN)
 .S PATNAME=$P(^DPT(IEN,0),"^",1),SSN=$P(^DPT(IEN,0),"^",9),DOB=$P(^DPT(IEN,0),"^",3),GENDER=$P(^DPT(IEN,0),"^",2)
 .S AGE=$E(DT,1,3)-$E(DOB,1,3),U="^"
 .W !,PATNAME_U_SSN_U_DOB_U_AGE_U_GENDER
 .K PATNAME,SSN,DOB,GENDER,AGE
 K PAT,IEN
DEA  ;S VA1=$E(X,3)+$E(X,5)+$E(X,7)+(2*($E(X,4)+$E(X,6)+$E(X,8)))
 ;S VA1=VA1#10,VA2=$E(X,9)
 K ^ZZPHIL("DEA")
 S CNT=1 F I=1000000:1:9999999 S X="AP"_I Q:CNT>20  D
 .Q:$L(I)>7
 .S VA1=$E(X,3)+$E(X,5)+$E(X,7)+(2*($E(X,4)+$E(X,6)+$E(X,8)))
 .S VA1=VA1#10,VA2=$E(X,9)
 .I VA1=VA2 S ^ZZPHIL("DEA",CNT)=X,CNT=CNT+1
 .K VA1,VA2,X
 K CNT,I,X
 Q
ALLTESTS(Y,FROM,DIR) ; from ORWLRR
 N I,IEN,CNT S I=0,CNT=999999999999999
 F  Q:I'<CNT  S FROM=$O(^LAB(60,"B",FROM),DIR) Q:FROM=""  D
 .S IEN=0 F  S IEN=$O(^LAB(60,"B",FROM,IEN)) Q:'IEN  D
 ..Q:"BO"'[$P($G(^LAB(60,IEN,0)),U,3)
 ..S I=I+1,Y(I)=IEN_U_FROM
 Q
MKSLOTS(RESULTS,SC,X,END) ; Utility to create appointment slots for booking
 ;NEEDS CLINIC ID SET IN THE CODE AND SET THE NUMBER OF DAYS FROM THE START DATE TO OPEN SLOTS
 ;Needs to look at each day and determine if it is a holiday or a weekend and if so don't make any slots
 S RESULTS=1
 S:$G(X)="" X=4
 I $G(SC)="" S RESULTS="0^CLINIC NOT DEFINED" Q
 I '$D(^SC(SC,0)) S RESULTS="0^CLINIC DOESN'T EXIST" Q
 I $G(END)'>0 S RESULTS="0^NUMBER OF DAYS IS NOT DEFINED" Q
 S START=DT F ST=1:1:END S START=$$FMADD^XLFDT(START,1,0,0,0),X1=$$DOW^XLFDT(START,1) I (X1>0&(X1<6)) D
 .Q:$D(^HOLIDAY(START,0))
 .S DAY=$E(START,6,7)
 .;Q:$D(^SC(SC,"ST",START,0))
 .S MON="MO "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"] "
 .S TUE="TU "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S WED="WE "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S THU="TH "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S FRI="FR "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .W !,ST,"  ",START,"  ",DAY,!,"     ",$S(X1=1:MON,X1=2:TUE,X1=3:WED,X1=4:THU,X1=5:FRI,1:"")
 .S ^SC(SC,"ST",START,0)=START,^SC(SC,"ST",START,1)=$S(X1=1:MON,X1=2:TUE,X1=3:WED,X1=4:THU,X1=5:FRI,1:"")
 .K DAY
 K END,SC,START,ST,X1,MON,TUE,WED,THU,FRI
 Q RESULTS
GETDAYA(RETURN,SC,SD) ; Get all day appointments Called by RPC MBAA APPOINTMENT MAKE
 N IND,I,D
 S I=$P(SD,".",1)
 ;F D=I-.01:0 S D=$O(^SC(SC,"S",D)) Q:$P(D,".",1)-I  S %=0 F  S %=$O(^SC(SC,"S",D,1,%)) Q:%'>0  D  ;ICR#: 6044 SC(
 F D=I-.01 S D=$O(^SC(SC,"S",D)) Q:$P(D,".",1)-I  S %=0 F  S %=$O(^SC(SC,"S",D,1,%)) Q:%'>0  D  ;ICR#: 6044 SC(
 . Q:'$D(^SC(SC,"S",D,1,%,0))  ;ICR#: 6044 SC(
 . S DIQ="CAPT(",DIC="^SC(SC,""S"",D,1,",DA=%,DR="310;9" D EN^DIQ1
 . S %=DA
 . S RETURN(%,"STATUS")=$G(CAPT(44.003,%,310))
 . S RETURN(%,"OB")=$G(CAPT(44.003,%,9))
 . K DIQ,DA,DR,DIC,CAPT
 . ;I $G(I)="" S I=$P(SD,".",1)
 . ;S RETURN(%,"STATUS")=$P(^SC(SC,"S",D,1,%,0),U,9)
 . ;S RETURN(%,"OB")=$D(^SC(SC,"S",D,1,%,"OB"))
 Q
TSTDIQ ; run a diq call to get data and put it into a tmp global, then only get out the data that is needed based on the appointment date
 S FILE=2,IFN=100681,STRF="1900*",FLAG="IER",FILE1=2.98
 K ^TMP($J,"REC"),REC
 D GETS^DIQ(FILE,IFN,STRF,FLAG,"^TMP($J,""REC""")
 S STRT=$$FMADD^XLFDT(DT,-1,0,0,0)_".2359" F  S STRT=$O(^TMP($J,"REC",FILE1,STRT)) Q:STRT'>0  S FLD="" F  S FLD=$O(^TMP($J,"REC",FILE1,STRT,FLD)) Q:FLD=""  S IDX="" F  S IDX=$O(^TMP($J,"REC",FILE1,STRT,FLD,IDX)) Q:IDX=""  D
 .Q:$G(STRT)<$$FMADD^XLFDT(DT,-1,0,0,0)
 .W !,STRT,"   ",FLD,"   ",IDX,"   = ",$G(^TMP($J,"REC",FILE1,STRT,FLD,IDX))
 .S REC(FILE1,STRT,FLD,IDX)=$G(^TMP($J,"REC",FILE1,STRT,FLD,IDX))
 W !!!
 ZW REC
 K FILE,IFN,STRF,FLAG
 ;K REC
 Q
TSTDATA ; create a bunch of appointments for a test patient in order to test the changes for the DIQ call in the TSTDIQ code above
 S DFN=100681,APTDT=2950103.10
 F XX=0:1:650  D
 .S APTDT=$$FMADD^XLFDT(APTDT,7,0,0,0),DOW=$$DOW^XLFDT(APTDT)
 .W !,XX,"  ",APTDT,"  ",$$DOW^XLFDT(APTDT),"   ",$$DOW^XLFDT(APTDT,1)
 .D MAKE^MBAAMRP2(.RESULTS,DFN,23,APTDT,11,"",15,"N","Make a lot of appointments",,,,,1,,1,)
 K XX,APTDT,DFN
 Q
CICO ; check in an out appts
 S DFN=100681,SC=23
 S XX=0 F  S XX=$O(^SC(23,"S",XX)) Q:XX'>0  D
 .Q:$G(XX)>3150101.09
 .S SD=XX
 .S RSP=$$CHECKIN^SDMAPI2(.RETURN,DFN,SD,SC)
 .W !,RSP
 .S RSP=$$CHECKO^SDMAPI2(.RETURN,DFN,SD,SC)
 K DFN,SC,SD,XX
 Q
DDR(RV,SC) ; MBAA RPC: MBAA GET CLINIC AVAILABILITY
 ;N STATUS,RESULT S STATUS=$$DETAILS(.RESULT,SC)
 D DETAILS(.RESULT,SC)
 ;I 'STATUS S RV=-1
 D MERGE^MBAAMRPC(.RV,.RESULT)
 Q
DETAILS(ARRAY,SC)  ; Get clinic details
 S FILE=44,FIELDS=".01;1;2;7;8;9;9.5;10;24;1912;1914;1917;1918;2500;2503",FLAG="IE"
 K ARRAY D GETS^DIQ(44,SC_",",FIELDS,FLAG,"ARRAY")
 I $G(ARRAY(44,SC_",",1914,"E"))="" S ARRAY(44,SC_",",1914,"E")=8 
 I $G(ARRAY(44,SC_",",1914,"I"))="" S ARRAY(44,SC_",",1914,"I")=8
 K FILE,FIELDS,FLAG
 Q
SUMI;
 S DFN=8 D DEM^VADPT,ADD^VADPT
 ZW 
 Q
ZZZ ;
 S X=4,DAY=31
 S TEST="MO "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 W X,!,DAY,!,TEST
 Q
WAR ; test warfarin rpc
 ;WAR,ORFROM,ORSTATUS,ORSERV,LABFROM,ANTICOAG,VITK,LABTST,PATLIST) ;
 N WAR,ORFROM,ORSTATUS,ORSERV,LABFROM,ANTICOAG,VITK,LABTST,PATLIST
 S ORFROM=3141201,ORSTATUS="23,3,4,18",ORSERV=2,LABFROM=3141201,ANTICOAG="WARFARIN",VITK="VITAMIN K,PHYTONAD",LABTST="HDB,INR,PT,PTT"
 ;S PATLIST(8)=8,PATLIST(10)=10,PATLIST(237)=237,PATLIST(100484)=100484
 D WARFARIN^MBABWAR1(.WAR,ORFROM,ORSTATUS,ORSERV,LABFROM,ANTICOAG,VITK,LABTST,.PATLIST) W WAR
 Q
ERR ; TEST ERROR TRAPPING
 W !,"1"
 N $ET,ERR S $ET="D ERR1"
 S ERR=$$EC^%ZOSV
 W !,"$STACK ",$ST
 W !,"NEW ERR= ",$G(ERR)
 I $G(ERR)["ZTER" D UNWIND^%ZTER
 W !,"ERR= ",$G(ERR)
 W !,"2"
 X "D A"
 W !,"HERE"
 Q
A1 S A=$$B()
 Q
B() ;
 Q 1
ERR1
 D ^%ZTER,UNWIND^%ZTER
 Q
ETR    
  NEW $ETRAP
  SET $ETRAP="WRITE !,""$ETRAP invoked at Context Level "",$STACK"
    ; Initiate an XECUTE context that initiates a DO context
  XECUTE "DO A2"
  QUIT
    ; Initiate a user-defined function context
A2
  SET A=$$B2
  QUIT
    ; A User-defined function that generates an error
B2()    
  QUIT 1
MKSLOTS3(RESULTS,SC,X,END) ; Utility to create appointment slots for booking
 ;NEEDS CLINIC ID SET IN THE CODE AND SET THE NUMBER OF DAYS FROM THE START DATE TO OPEN SLOTS
 ;Needs to look at each day and determine if it is a holiday or a weekend and if so don't make any slots
 S RESULTS=1
 S:$G(X)="" X=4
 I $G(SC)="" S RESULTS="0^CLINIC NOT DEFINED" Q
 I '$D(^SC(SC,0)) S RESULTS="0^CLINIC DOESN'T EXIST" Q
 I $G(END)'>0 S RESULTS="0^NUMBER OF DAYS IS NOT DEFINED" Q
 S START=DT F ST=1:1:END S START=$$FMADD^XLFDT(START,1,0,0,0),X1=$$DOW^XLFDT(START,1) I (X1>0&(X1<6)) D
 .S DAY=$E(START,6,7)
 .;Q:$D(^SC(SC,"ST",START,0))
 .S MON="MO "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S TUE="TU "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S WED="WE "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S THU="TH "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .S FRI="FR "_DAY_"  |       ["_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"|"_$G(X)_" "_$G(X)_" "_$G(X)_"]"
 .W !,ST,"  ",START,"  ",DAY,!,"     ",$S(X1=1:MON,X1=2:TUE,X1=3:WED,X1=4:THU,X1=5:FRI,1:"")
 .S ^SC(SC,"ST",START,0)=START,^SC(SC,"ST",START,1)=$S(X1=1:MON,X1=2:TUE,X1=3:WED,X1=4:THU,X1=5:FRI,1:"")
 .K DAY
 K END,SC,START,ST,X1,MON,TUE,WED,THU,FRI
 Q RESULTS
SAML(PATH,FILE) ;Extrinsic Function.
 ;For testing validation from a global:
 ;  1. Loads XML file into global ^TMP("XUCERT",$J)
 ;  2. Runs $$VALIDATE with global input
 ;Returns: Success=1
 ;         Failure="-1^Error message"
 N X,Y
 K ^TMP("XUCERT",$J)
 S Y=$$FTG^%ZISH(PATH,FILE,$NA(^TMP("XUCERT",$J,1)),3)
 I +Y<1 Q "-1^Failed to load file into global"
 ;S XUREAD=$$READER^XUCERT1($NA(^TMP("XUCERT",$J)))  S RTN=XUREAD
 S X=$$VALIDATE^XUCERT($NA(^TMP("XUCERT",$J))) S RTN="X = "_X
 ;K ^TMP("XUCERT",$J)
 Q RTN
