RTIPOST4 ;ISC-ALBANY/PKE-postinit-add file 4 entries; 6/26/90 10:00AM
 ;;v 2.0;Record Tracking;;10/22/91 
 D START
 K RT,RTNUM,RTNUM0,N,Y,X,XA,X97,DIC,DIE,DR,DA,D0,DO,DQ,DE,D,DZ
 Q
START S DIC("S")="I $P(^(0),U)[""FEDERAL RECORDS""!($P(^(0),U)[""NATIONAL"")"
 S X="FED",DIC="^DIC(4,"
 F N=0:1 S X=$O(^DIC(4,"B",X)) Q:X=""!(X]"FEDZ")
 I N S DIC(0)="",D="B",DZ="??" D W7,DQ^DICQ,W8 F RT=1:1:16 D DATA,PRT
 K DIC I N Q
 ;
ADD W !!?3,"Adding Federal Record Centers to the Institution file #4",!
 F RT=1:1:15 D DATA I X(.02) D FILE K X
 ;376 special case, should be there
 S RT=16
 S RTNUM0=$O(^DIC(4,"D",376,0)) I RTNUM0 D 376 Q
 D W3 D DATA I X(.02) S DIC("DR")=DIC("DR")_";99///376;" D FILE K X Q
 Q
FILE D LOC S DINUM=RTNUM
 S DIC(0)="L",DIC="^DIC(4,",X=X(.01)
 K DD,DO D FILE^DICN K DIC,D0,DQ,DE,DINUM,RTNUM
 I +Y<0 D W5
 I +Y D W6 
 Q
376 ;adds .04 to existing 376 entry
 D DATA K DIC
 I $O(^DIC(4,"D",376,RTNUM0)) D W4 Q
 S DA=RTNUM0,DIE="^DIC(4,",DR=".04///"_X(.04)_";" D ^DIE Q
 Q
DATA S X=""
 S X(.01)=$P($T(NAM+RT),";",3)
 S XA=$P($T(ADDR+RT),";",1,99)
 S X(103)=$P(XA,";",4)
 S X(.02)=$P(XA,";",5),X(.02,RT)=$O(^DIC(5,"B",X(.02),0)) D CHK1 I $T Q
 S X(.02)=X(.02,RT)
 S X(.04)=$P($T(LNAM+RT),";",3)
 ;
 S DIC("DR")=".02////"_X(.02)_";.04///"_X(.04)_";1.03///"_X(103)
 ;I X97 S DIC("DR")=DIC("DR")_";97////"_X97
 Q
CHK1 I 'X(.02,RT) D W1 Q
 E  I $O(^DIC(5,"B",X(.02),X(.02,RT))) D W2 Q
 Q
LOC S I=$P(^DIC(4,0),"^",3)
LOCK S I=I+1 L +^DIC(4,I):1 I '$T!$D(^DIC(4,I)) L -^DIC(4,I) G LOCK
 S RTNUM=I L -^DIC(4,I) K I Q
 ;
W1 W !!?5,"Lookup failed in State file ""B"" cross-ref for :",X(.02),! Q
W2 W !!?5,"Duplicate ""B"" cross-ref in State file for :",X(.02),! Q
W3 W !!?5,"Lookup failed in ""D"" cross-ref for Station Number 376"
 W !?10,"... adding this entry",! Q
W4 W !!?5,"Duplicate ""D"" cross-ref for Station Number 376",! Q
W5 W !!?5,"Failed to add '",X(.01),"  ",$S(X(.01)["GSA":"",1:"      "),X(103),"'",!!
W6 W !?5,"Added   '",X(.01),"  ",$S(X(.01)["GSA":"",1:"      "),X(103),"'"
 Q
W7 W !!?5,"Checking the INSTITUTION file #4"
 W $C(7),!!,?5,"You already have the following entries: " Q
W8 W !!?2,"Please add or edit with Fileman; We would have added these entries: " Q
 ;
PRT W !!?6,"         Name: ",X(.01)
 W !?6,"Output Header: ",X(.04)
 W !?6,"         City: ",X(103)
 W !?6,"        State: ",$P(^DIC(5,X(.02),0),U)
 I RT=16 W !?5,"Station Number: ",376
 W !
 Q  ;
NAM ;;1.......10........20........30
 ;;FEDERAL RECORDS CENTER GSA-1
 ;;FEDERAL RECORDS CENTER GSA-2
 ;;FEDERAL RECORDS CENTER GSA-3
 ;;FEDERAL RECORDS CENTER
 ;;FEDERAL RECORDS CENTER GSA-4
 ;;FEDERAL RECORDS CENTER GSA-5
 ;;FEDERAL RECORDS CENTER
 ;;FEDERAL RECORDS CENTER GSA-6
 ;;FEDERAL RECORDS CENTER GSA-7
 ;;FEDERAL RECORDS CENTER GSA-8
 ;;FEDERAL RECORDS CENTER GSA-9
 ;;FEDERAL RECORDS CENTER
 ;;FEDERAL RECORDS CENTER GSA-10
 ;;NATIONAL RECORDS CENTER
 ;;NATIONAL PERSONAL RECORDS CIV
 ;;ST LOUIS RPC
LNAM ;
 ;;Federal Archives and Records Center
 ;;Federal Archives and Records Center
 ;;Federal Archives and Records Center
 ;;Federal Records Center
 ;;Federal Archives and Records Center
 ;;Federal Archives and Records Center
 ;;Federal Records Center
 ;;Federal Archives and Records Center
 ;;Federal Archives and Records Center
 ;;Federal Archives and Records Center
 ;;Federal Archives and Records Center
 ;;Federal Records Center
 ;;Federal Archives and Records Center
 ;;Washingtion National Records Center
 ;;National Personal Records Center (Civilian)
 ;;National Personal Records Center (Military)
 ;            4       5        
ADDR ;fields city 1.03   state.02   
 ;; GSA-1;WALTHAM;MASSACHUSETTS;
 ;; GSA-2;BAYONNE;NEW JERSEY;   
 ;; GSA-3;PHILADELPHIA;PENNSYLVANIA;
 ;;      ;MECHANICSBURG;PENNSYLVANIA;
 ;; GSA-4;EAST POINT;GEORGIA;
 ;; GSA-5;CHICAGO;ILLINOIS;
 ;;      ;DAYTON;OHIO;
 ;; GSA-6;KANSAS CITY;MISSOURI;
 ;; GSA-7;FORT WORTH;TEXAS;
 ;; GSA-8;DENVER;COLORADO;
 ;; GSA-9;SAN BRUNO;CALIFORNIA;
 ;;      ;LAGUNA NIGUEL;CALIFORNIA;
 ;; GSA-10;SEATTLE;WASHINGTON;
 ;;      ;WASHINGTON;DISTRICT OF COLUMBIA;
 ;;      ;ST. LOUIS;MISSOURI;
 ;;      ;ST. LOUIS;MISSOURI;
 Q
