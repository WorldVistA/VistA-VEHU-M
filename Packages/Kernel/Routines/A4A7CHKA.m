A4A7CHKA ;CLKS/SO  CHECK NEW PERSON, USER, & PERSON FILES CONT. ;3/4/94  15:22 [ 07/17/95  11:15 AM ]
 ;;1.01;A4A7;**7**;12/29/94
RPT ; Report Entry Point
 D HDR S A4UX=A4UBIEN F  S A4UX=+$O(^VA(200,+A4UX)) Q:'A4UX!(+A4UX>A4UEIEN)  D CHK D:($Y>(IOSL-5)) HDR
 Q
CHK ; Check various New Person, User, Person file conditions
 ; A4UCS=1=compare .01 fields for equality  A4UCS=0=skip .01 field comp.
VA200 ; Check New Person File Relationships
 S (A4UO,A4UO(200),A4UO(3),A4UO(16))="",A4UO("C")="Out of SYNC",A4UCS=1
 I '$D(^VA(200,+A4UX,0))#2 S A4UO(200)="Missing Zeroeth Node",(A4UO(3),A4UO(16))="Can't chain to",A4UO("C")="" D SUMMW,W Q
 S A4UO(200)=$P($G(^VA(200,+A4UX,0)),U) I A4UO(200)="" S A4UO(200)=".01 field is NULL",A4UCS=0,A4UO("C")="" D SUMMW
DIC3 ; Check User File Relationships
 I '$D(^DIC(3,+A4UX,0))#2 S A4UO(3)="Missing Zeroeth Node",A4UO(16)="Can't chain to",A4UO("C")="" D SUMMW,W Q
 S X=$G(^DIC(3,+A4UX,0)),A4UO(3)=$P(X,U),A4UY=+$P(X,U,16) I A4UO(3)="" S A4UO(3)=".01 field is NULL",A4UCS=0,A4UO("C")="" D SUMMW
DIC16 ; Check Person File Relationships
 I 'A4UY S A4UO(16)="Missing Person File Pointer",A4UO("C")="" D SUMMW,W Q
 I '$D(^DIC(16,+A4UY,0))#2 S A4UO(16)="Missing Zeroeth Node",A4UO("C")="" D SUMMW,W Q
 S A4UO(16)=$P($G(^DIC(16,+A4UY,0)),U) I A4UO(16)="" S A4UO(16)=".01 field is NULL",A4UCS=0,A4UO("C")="" D SUMMW
 S A4UA3=+$P($G(^DIC(16,+A4UY,"A3")),U) I A4UA3'=+A4UX B   S A4UO("C")="IEN'=A3 Value" D SUMMW,W K A4UA3,A4UY Q
 K A4UA3,A4UY I A4UCS I A4UO(200)=A4UO(3),A4UO(3)=A4UO(16) S A4UO("C")="OK"
 Q:A4UO("C")="OK"
 I 'A4USD,'A4UCS D W Q
 I 'A4USD,A4UCS D SUMM Q
 I A4USD D W
 Q
W W !,+A4UX,?10,A4UO(200),?45,A4UO(3),?80,A4UO(16),?115,A4UO("C") Q
HDR ; Header Sub-Routine
 I '$D(A4UHDR) S (A4UHDR,A4UPG)=0 D NOW^%DTC,YX^%DTC S Y=$TR(Y,"@"," "),A4URDT=$P(Y,":",1,2) D DW^%DTC S A4URDW=X,A4UNPL=$P(^VA(200,0),U,3),A4UUL=$P(^DIC(3,0),U,3),A4UPL=$P(^DIC(16,0),U,3) W !
 I A4UHDR W @IOF
 S A4UHDR=1,A4UPG=A4UPG+1 W "New Person - User - Person Diagnostic Report",$S('A4USD:" (SUMMARY)",A4USD:" (DETAIL)"),"     ",A4URDW,"     ",A4URDT,?(IOM-10),"Page: ",A4UPG
 W !,?10,"Last New Person IEN: ",A4UNPL,?45,"Last User IEN: ",A4UUL,?80,"Last Person IEN: ",A4UPL
 W !,"N.P. IEN",?10,"New Person",?45,"User",?80,"Person",?115,"Comments"
 S A4UX1="",$P(A4UX1,"=",IOM)="" W !,A4UX1 K A4UX1
 Q
SUMM ; Out of SYNC summary only
 I '$D(A4UBS) S (A4UBS,A4UES)=+A4UX Q
 S A4UES=+A4UX Q
SUMMW ; Print summary line
 Q:'$D(A4UBS)  W !,"OUT of SYNC started with New Person IEN: ",A4UBS," and ended with New Person IEN: ",A4UES K A4UBS,A4UES Q
 Q
