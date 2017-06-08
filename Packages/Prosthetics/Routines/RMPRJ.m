RMPRJ ;PHX/HNB-Merge Prosthetics Database FILE 660 ;MAY 30, 1995
 ;;3.0V2;PROSTHETICS;;Dec 15, 1995
 ;;
 ;This is for sites that are to be consolidated.
 ;Expects file 665 to be defined for all patients from
 ;satellite system.  If not, records will be moved, and
 ;not show until patient is added.
 ;system variables from RMPRSIT,
 ;CAUTION:  Make sure the entry has been added in the site
 ;parameter file for satellite before merge. The AMIS grouper must be the
 ;same number as it is on the satellite system when you move over
 ;originally.  Never change the AMIS Grouper after that point.
 ;It would be helpful to have fileman make sure all HOST SYSTEM records
 ;have the HOST site, and not null in file 660.  
 ;Users may be on the system when this utility is run.
 ;On satellite system D ^RMPRJ to gather the data in global RMPRJ.
 ;Once the global has been created, move to Host system, or allow
 ;read access.
 ;
EN ;entry point for the satellite system
 D HOME^%ZIS K RMPR
 D DIV4^RMPRSIT Q:'$D(RMPR)
 K ^RMPRJ
 S RMPRDA=0
 F  S RMPRDA=$O(^RMPR(660,RMPRDA)) Q:RMPRDA'>0  D
 .;must have a delivery date, or marked as historical to be valid
 .Q:('$P(^RMPR(660,RMPRDA,0),U,12))&($P(^(0),U,15)="")
 .D GET
EXIT ;exit point
 K DR,DIC,DFN,DA,RMPRDA,RVDA
 Q
GET ;called from EN^RMPRJ
 ;build the array/global to send to permanent system
 S DA=RMPRDA,DIC=660,DIQ="R19",DR=".01:96"
 S DIQ(0)="I"
 D EN^DIQ1
 S DIQ(0)="E",DR="4;7" D EN^DIQ1
 K DIQ
 I $P(^RMPR(660,RMPRDA,0),U,9) D
 .S (DA,RVDA)=$P(^RMPR(660,RMPRDA,0),U,9)
 .S DIC=440,DR=".01:6",DIQ="RV"
 .D EN^DIQ1
 ;station
 S RMPR19(660,RMPRDA,90)=RMPR("NAME")
 ;historical item
 S RMPR19(660,RMPRDA,89)=R19(660,RMPRDA,4,"E")
 ;historical vendor
 S RMPR19(660,RMPRDA,91)=R19(660,RMPRDA,7,"E")
 I $D(RV) D
 .;historical vendor phone
 .S RMPR19(660,RMPRDA,92)=RV(440,RVDA,5)
 .;historical vendor street address
 .S RMPR19(660,RMPRDA,93)=RV(440,RVDA,1)
 .;historical vendor city
 .S RMPR19(660,RMPRDA,94)=RV(440,RVDA,4.2)
 .;historical vendor state
 .S RMPR19(660,RMPRDA,95)=RV(440,RVDA,4.4)
 .;historical vendor zip code
 .S RMPR19(660,RMPRDA,96)=RV(440,RVDA,4.6)
 ;
 ;bring over the extended description
 MERGE RMPR19(660,RMPRDA,"DES")=^RMPR(660,RMPRDA,"DES")
 N RMPRX,RMPRY
 F RMPRX=1:1:20 S RMPRY=$P($T(CHK+RMPRX),";",3) D
 .S RMPR19(660,RMPRDA,RMPRY)=R19(660,RMPRDA,RMPRY,"I")
 ;global is in file^die format
 MERGE ^RMPRJ=RMPR19
 ;B node = ien on satellite^entry date^patient name^ssn
 S DFN=$P(^RMPR(660,RMPRDA,0),U,2) D DEM^VADPT
 S ^RMPRJ("B",RMPRDA)=RMPRDA_U_$P(^RMPR(660,RMPRDA,0),U,1)_U_VADM(1)_U_VADM(2)
 K VADM,RMPR19,R19,RV
 Q
SET ;entry point to create records, in the permanent database
 ;expect read access to global RMPRJ
 ;on HOST System D SET^RMPRJ
 ;
 K RMPR D DIV4^RMPRSIT Q:'$D(RMPR)
 W !!,?5,"Checking Database And Merging File 660",!!
 S B=0
 F  S B=$O(^RMPRJ("B",B)) Q:B=""  D
 .;DFN is on satellite system
 .S DFN=$P(^RMPRJ("B",B),U,3) Q:DFN=""
 .;OLDDA is record ien to file 660 on satellite
 .S OLDDA=$P(^RMPRJ("B",B),U,1) Q:OLDDA=""
 .S SSN=$P(^RMPRJ("B",B),U,4) Q:SSN=""
 .;S DFN2="",DFN2=$O(^DPT("B",DFN,DFN2))
 .;DFN2 is on host system
 .S DFN2="",DFN2=$O(^DPT("SSN",SSN,DFN2))
 .;quit if the patient's ssn does not match
 .Q:DFN2=""
 .;check to see if record has already been merged
 .;NOADD will be 1 if record has prev. been created
 .S RI=0,NOADD=0
 .F  S RI=$O(^RMPR(660,"C",DFN2,RI)) Q:RI'>0  Q:NOADD=1  D
 ..;compair station and record number
 ..I $P($G(^RMPR(660,RI,"HST")),U,4)=OLDDA,$P(^RMPR(660,RI,0),U,10)=RMPR("STA") S NOADD=1
 .;check for duplicate record
 .Q:NOADD=1
 .S NAME2=$P(^DPT(DFN2,0),U,1),SSN2=$P(^DPT(DFN2,0),U,9)
 .;match on first 4 char of patient last name
 .;name2 is satellite name, name is host name
 .;ssn2 is satellite ssn, ssn is host ssn
 .S NAME2=$E(NAME2,1,4),NAME=$E(DFN,1,4)
 .I (NAME2'=NAME)&(SSN2'=SSN) W !,"Patient Not Matched ",DFN,"  Record:  ",B," Not Merged" Q
 .S X=$P(^RMPRJ("B",B),U,2)
 .I X="" W !,"NO ENTRY DATE RECORD NOT MOVED OVER:  ",B,!
 .K DD,DO
 .S DIC="^RMPR(660,",DLAYGO=660,DIC(0)="L" D FILE^DICN
 .S RMPRDA=+Y D DES,FILE
 W !,"ALL DONE!"
 Q
DES ;Extended Description, Word Processing field 28
 MERGE ^RMPR(660,RMPRDA,"DES")=^RMPRJ(660,OLDDA,"DES")
 K ^RMPRJ(660,OLDDA,"DES")
FILE ;set the record
 MERGE R19(660,RMPRDA_",")=^RMPRJ(660,OLDDA)
 ;set stn field 8 in new array
 S R19(660,RMPRDA_",",8)=RMPR("STA")
 ;set ien to patient
 S R19(660,RMPRDA_",",.02)=DFN2
 ;all records are now historical
 S R19(660,RMPRDA_",",15)="*"
 ;ien from the satellite site, for QA
 S R19(660,RMPRDA_",",97)=$P(^RMPRJ("B",B),U,1)
 D FILE^DIE("K","R19","ERROR")
 I $D(ERROR) W !,"ERROR ENCOUNTERED!, STOPPING!" G EXT
 Q
EXT ;exit on error
 Q
CHK ;;field number
 ;;1
 ;;2
 ;;5
 ;;6
 ;;6.5
 ;;9
 ;;10
 ;;11
 ;;12
 ;;14
 ;;16
 ;;17
 ;;21
 ;;23
 ;;25
 ;;52
 ;;60
 ;;62
 ;;63
 ;;68
 ;END
