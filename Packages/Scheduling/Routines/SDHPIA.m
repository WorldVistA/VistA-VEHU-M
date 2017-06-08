SDHPIA ;MTC,PKE/ALB - Health Promotion initiative Study Main Routine; 3/12/96 [ 10/21/96   8:19 AM ]
 ;;5.3;Scheduling;**58,81,133,152**;March 12, 1996
 ; This routine will scan the OutPatient encounter file for patients
 ; for the date range provided that meet the following criteria:
 ; 1) Veterans, 2) Non-Employee, 3) Not dead, 4) Not an inpatient
 ; 5) for the clinic(s) identified.
 ;
 ; From the sample above, X number of male patients will be selected
 ; and Y number of female patients will be selected.
 ;
 ; The two Mail Messages will be generated to the a Mail Group
 ; at isc-albany.va.gov 
 ;
 ; For each record, the following data will be provided.
 ; SSN, Name, Street, City, Zip, Home Phone, Alt Phone, DoB, Sex,
 ; the date last seen within date range, and DSS Identifiers (Stop Codes).
 ;
 ; Run from the top to use parameters specified by the National
 ; Center for Health Promotion and Disease Prevention (D ^SDHPIA).
 ; The message will be transmitted automatically
 ;
EN D EN1(2971001,2980930,320,160,",301,318,319,322,323,",,1)
 ;      ^       ^      ^   ^           ^              ^
 ;     start   end    #M   #F     DSS Identifiers    MG  
 ;
 Q
 ;
EN1(SDHPSTD,SDHPEND,SDHPM,SDHPF,SDHPSCS,SDHPMG,SDHPFLAG) ;-- Entry point to queue job
 ;
 N %,X,Y,ZTDESC,ZTSAVE,ZTRTN,ZTIO,ZTSK
 ;
 I '$$CHECK G ENQ
 W !,">>> Veterans Health Survey Extract <<<",!
 W !,"    Please queue to run at a non-peak time."
 W !,"    This extract will generate 3 mail messages to you"
 W !,"    and to G.SD HPI EXTRACT@ISC-ALBANY.VA.GOV",!
 ;
 ;-- get parameter if not passed in
 D GETPARM(.SDHPSTD,.SDHPEND,.SDHPM,.SDHPF,.SDHPSCS,.SDHPMG)
 ;
 G:$D(SDHPERR) ENQ
 S ZTSAVE("SDHPSTD")="",ZTSAVE("SDHPEND")="",ZTSAVE("SDHPM")=""
 S ZTSAVE("SDHPF")="",ZTSAVE("SDHPSCS")="",ZTSAVE("SDHPMG")=""
 S ZTSAVE("SDHPFLAG")=""
 S ZTIO="",ZTRTN="GOGO^SDHPIA"
 S ZTDESC="SD*5.3*152 - Health Promotion Initiative Extract"
 D ^%ZTLOAD,HOME^%ZIS
 I $G(ZTSK) W !?30,"Task Number = ",ZTSK,!
ENQ Q
 ;
GETPARM(SDHPSTD,SDHPEND,SDHPM,SDHPF,SDHPSCS,SDHPMG) ;-- This routine will get the required parameters required to perform
 ;   the Health Promotion Extract.
 ;
 ;  Output : SDHPSTD - Start Date
 ;           SDHPEND - End Date
 ;           SDHPM   - Total Males
 ;           SDHPF   - Total Females
 ;           SDHPSCS - Stop Code String  (DSS Identifiers)
 ;           SDHPMG  - Mail Group
 ;           SDHPERR - Only on error will be defined
 ;
 ;
 K SDHPERR
START ;-- Start Date
 G:$D(SDHPSTD) END
 S %DT("A")="Enter START DATE: ",%DT="EA" D ^%DT D  G:$D(SDHPERR) Q S SDHPSTD=Y X ^DD("DD") S X=Y D QUES G:%=-1 Q I %'=1 K SDHPSTD G START
 . I Y'>0 S SDHPERR="" Q
 ;
END ;-- End Date
 G:$D(SDHPEND) MALES
 S %DT("A")="Enter END DATE: ",%DT="EA" D ^%DT G Q:Y<SDHPSTD S SDHPEND=Y X ^DD("DD") S X=Y D QUES G:%=-1 Q I %'=1 K SDHPEND G END
 ;
MALES ;-- Total Males
 G:$D(SDHPM) FEMALE
 K %DT R !!,"Enter TOTAL MALES:  ",SDHPM:DTIME G Q:'$T!(SDHPM["^") I 'SDHPM!'(SDHPM?1N.N) W !?4,*7,"Must be a number greater than zero!" K SDHPM G MALES
 S X=SDHPM D QUES G:%=-1 Q I %'=1 K SDHPM G MALES
 ;
FEMALE ;-- Total Females
 G:$D(SDHPF) STOP
 K %DT R !!,"Enter TOTAL FEMALES:  ",SDHPF:DTIME G Q:'$T!(SDHPF["^") I 'SDHPF!'(SDHPF?1N.N) W !?4,*7,"Must be a number greater than zero!" K SDHPF G FEMALE
 S X=SDHPF D QUES G:%=-1 Q I %'=1 K SDHPF G FEMALE
 ;
STOP ;-- Stop Codes
 G:$D(SDHPSCS) Q
 R !!,"Enter DSS IDENTIFIERS (Stop Codes): 301,318,319,322,323// ",X:DTIME G Q:'$T!(X["^")
 I X="" S X="301,318,319,322,323"
 I '(X?3N.E) W !?4,*7,"Enter DSS Identifiers in the following format 100,200,300!",!?4,"It is recommended you accept the default provided." K SDHPSCS G STOP
 D QUES G:%=-1 Q I %'=1 K SDHPSCS G STOP
 S SDHPSCS=","_X_","
 ;
MAILG ;-- Mail Group
 G:$D(SDHPMG) Q
 S DIC="^XMB(3.8,",DIC(0)="AE" D ^DIC S:Y<0 SDHPERR="" S SDHPMG=X
 ;
Q I '$G(SDHPSTD)!'$G(SDHPEND)!'$G(SDHPM)!'$G(SDHPF)!($G(SDHPSCS)']"") S SDHPERR=1 ; data elements not defined properly
 K DGN,DGVER,DGDT,X,Y Q
 ;
QUES W !,"===> ",X,!,"IS THIS CORRECT" S %=2 D YN^DICN I '% W !?4,"YES - If this information is correct.",! G QUES
 Q
 ;
GOGO ;-- Main Driver
 N DFN,LOOP,SDHPFCNT,SDHPFT,SDHPMCNT,SDHPMT,SDHPSEX,SDTV
 N %,X,Y,DIC,XMDUZ,XMSUB,XMY,XMZ
 ;
 K ^TMP("SDHP-HPI",$J)
 D DT^DICRW
 ;
 ;-- build list
 S X=$$BLD^SDHPIA1(SDHPSTD-.1,SDHPEND+.9,SDHPSCS)
 S SDHPFT=$P(X,U),SDHPMT=$P(X,U,2)
 ;
 ;-- build and send messages for females
 D HPI("F",SDHPF,SDHPFT,$G(SDHPFLAG))
 ;
 ;-- build and send messages for males
 D HPI("M",SDHPM,SDHPMT,$G(SDHPFLAG))
 ;
 ;-- generate final mail message
 D FMAIL
 ;
 K ^TMP("SDHP-HPI",$J)
 Q
 ;
HPI(SEX,TOTAL,RECORD,FLAG) ;-- Function loops through the TMP global created by BLD function,
 ;   gets data and creates Mail messages.
 ;
 ; Input : SEX  - Sex to build message
 ;       : TOTAL - Total number of records to send
 ;       : RECORD - Total number of records found
 ;       : FLAG - 1 if messages goes to national center
 ;
 ;
 N SDHPX,SDHPX1,SDHPX2,SDHPY,SDHPZ,SDHPI,SDHPM,SDHPTOT,HLECH,HLQ,HLFS
 N SDSTOP,SDSTOP0
 ;
 ;-- init variables
 S HLQ="",HLECH="~|\&",HLFS="^"
 ;-- init counters
 S (SDHPI,SDHPTOT,SDHPM)=0
 ;
 I '$D(^TMP("SDHP-HPI",$J,SEX)) G HPIQ
 ;
 ;-- clear any possible mail junk
 D KILL^XM
 ;
 S LOOP=TOTAL,SDHPX=0
 I TOTAL>RECORD S LOOP=RECORD
 ;
 F SDHPI=1:1:LOOP D
 . I TOTAL'<RECORD S SDHPX=$O(^TMP("SDHP-HPI",$J,SEX,SDHPX))
 . I TOTAL<RECORD S SDHPX=$$GETRAN(RECORD,SEX)
 . S DFN=$O(^TMP("SDHP-HPI",$J,SEX,SDHPX,0)) Q:'DFN
 . ;-- if no current mail message create one
 . I '$D(XMZ) D INITMAIL(SEX,FLAG)
 . S SDHPTOT=SDHPTOT+1
 . S SDHPY=$G(^TMP("SDHP-HPI",$J,SEX,SDHPX,DFN)),SDHPX1=$$EN^VAFHLPID(DFN,"5,7,10,11,13,14,19")
 .;-- encounter date
 . S Y=$P(SDHPY,".")
 . S:Y Y=$E(Y,4,7)_(1700+$E(Y,1,3))
 . S $P(SDHPX2,U)=Y
 .;-- name
 .S Y=$P(SDHPX1,U,6),X=$F(Y,"~")
 . I '$F(Y,"~",X+1) S Y=Y_"~"
 .S $P(SDHPX2,U,2)=Y
 .;-- DoB
 . S Y=$P(^DPT(DFN,0),U,3)
 . S:Y $P(SDHPX2,U,3)=$E(Y,4,7)_(1700+$E(Y,1,3))
 .;-- address
 .S $P(SDHPX2,U,4)=$P(SDHPX1,U,12)
 .;-- home phone
 .S $P(SDHPX2,U,5)=$P(SDHPX1,U,14)
 .;-- alt phone
 .S Y=$S($P(SDHPX1,U,15):$P(SDHPX1,U,15),1:$P($G(^DPT(DFN,.21)),U,9))
 .S $P(SDHPX2,U,6)=Y
 .;-- SSN
 .S $P(SDHPX2,U,7)=$P(SDHPX1,U,20)
 .;-- SEX
 .S $P(SDHPX2,U,8)=SEX
 .;RACE
 .S $P(SDHPX2,U,9)=$P(SDHPX1,U,11)
 .;GET NUMBER OF VISITS
 .S $P(SDHPX2,U,10)=+$G(^TMP("SDHP-HPI",$J,"DT",DFN,"TOT"))
 .;-- get STOPS and sort --
 .S SDSTOP=$O(^TMP("SDHP-HPI",$J,DFN,0))
 .I SDSTOP DO
 . .S SDSTOP=$G(^TMP("SDHP-HPI",$J,DFN,SDSTOP))
 . .I SDSTOP="" Q
 . .S SDSTOP=$P(SDSTOP,"^",1,8)
 . .S SDSTOP0=""
 . .I SDSTOP[301 S $P(SDSTOP0,"^",1)=301
 . .I SDSTOP[318 S $P(SDSTOP0,"^",2)=318
 . .I SDSTOP[319 S $P(SDSTOP0,"^",3)=319
 . .I SDSTOP[322 S $P(SDSTOP0,"^",4)=322
 . .I SDSTOP[323 S $P(SDSTOP0,"^",5)=323
 . .F SDSTOP=1:1:5 I '$P(SDSTOP0,"^",SDSTOP) S $P(SDSTOP0,"^",SDSTOP)=0
 .E  S SDSTOP0="0^0^0^0^0^0^"
 .;
 .S ^XMB(3.9,XMZ,2,SDHPI,0)=SDHPX2_"^"_SDSTOP0
 .K ^TMP("SDHP-HPI",$J,SEX,SDHPX,DFN)
 D MAIL(SDHPI)
 ;
HPIQ Q
 ;
 ;
MAIL(TOTAL) ;-- Send Mail Message containing records so far
 ;
 ; INPUT TOTAL- Total Lines in Message
 ;
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_TOTAL_U_TOTAL_U_DT
 D ENT1^XMD
 D KILL^XM
 ;
MAILQ Q
 ;
INITMAIL(SEX,FLAG) ;-- This function will initialize mail variables
 ;
 S XMSUB="SD*5.3*152 HPI: "_$S(SEX="M":"MALES ",1:"FEMALES ")_$P($$SITE^VASITE,U,2)_" VAMC"
 S XMDUZ=.5,XMY(DUZ)=""
 I $G(FLAG) DO
 . S XMY("G.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 . S XMY("S.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 D GET^XMA2
 Q
 ;
FMAIL ;- This function will generate a summary mail message.
 ;
 N SDHPX,SDHPY
 S Y=SDHPSTD X ^DD("DD") S SDHPX=Y
 S Y=SDHPEND X ^DD("DD") S SDHPY=Y
 S XMSUB="SD*5.3*152 - HPI - Data Collection Summary"
 S XMDUZ=.5,XMY(DUZ)=""
 I $G(SDHPFLAG) DO
 . S XMY("G.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 . S XMY("S.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 D GET^XMA2
 S ^XMB(3.9,XMZ,2,1,0)="Health Promotion Initiative Extract has completed for the "_$P($$SITE^VASITE,U,2)_" VAMC."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Date Range: "_SDHPX_" to "_SDHPY
 S ^XMB(3.9,XMZ,2,4,0)=""
 S ^XMB(3.9,XMZ,2,5,0)="The total number of MALE   veterans identified:"_$J(SDHPMT,4)_"  Total Requested: "_SDHPM
 S ^XMB(3.9,XMZ,2,6,0)="The total number of MALE   visit-days: "_$G(SDTV("M"))
 S ^XMB(3.9,XMZ,2,7,0)="The total number of FEMALE veterans identified:"_$J(SDHPFT,4)_"  Total Requested: "_SDHPF
         S ^XMB(3.9,XMZ,2,8,0)="The total number of FEMALE visit-days: "_$G(SDTV("F"))
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_8_U_8_U_DT
 D ENT1^XMD
 D KILL^XM
 Q
 ;
CHECK() ;-- This function is an envoronment verification routine.
 ;   Input : NONE
 ;  OutPut : 1 if Ok else 0
 N RESULT
 ;
 ;-- Init
 S RESULT=1
 I '$D(DUZ) W *7,!,"You must have a valid DUZ defined before running this routine!" S RESULT=0
 Q RESULT
 ;
 ;
GETRAN(NUM,SEX) ;
 N Y
A ;
 S Y=$R(NUM)
 I '$D(^TMP("SDHP-HPI",$J,SEX,Y)) G A
 Q Y
 ;
XX S X=0 F  S X=$O(^SCE(X)) Q:'X  DO
 .S Y=+$P(^(X,0),"^",3) S X(Y)=$G(X(Y))+1
 .I 'Y Q
 .S Y(+$P($G(^DIC(40.7,Y,0)),"^",2))=Y
 Q
