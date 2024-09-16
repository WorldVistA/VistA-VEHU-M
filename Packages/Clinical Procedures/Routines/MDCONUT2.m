MDCONUT2 ; HDSO/RJH - CP Conversion Utility ;31 Oct 2018 2:31 PM
 ;;1.0;CLINICAL PROCEDURES;**89**;May 07, 2024;Build 2
 ;
 ; Integration Control Registration (ICR's):
 ; Reference to File 100.01 in ICR #2638
 ; Reference to File 123 in ICR #3067
 ; Reference to ^GMR(123,"AE" in ICR #5062
 ; Reference to File 123.3 in ICR #6926
 ; Reference to File 123.5 in ICR #6927
 ; Reference to ^MAG(2006.5831 in ICR #6959
 ;
 ; MD*89/RJH - New routine created to divert the MD PROCONVERT functionality 
 ;             from the MDCONUTL routine in order not to affect the MD 
 ;             CONCONVERT functionality which previously shared the logic. 
 ;             Added prompt to the user for the REQUEST SERVICE within the 
 ;             procedure to convert TO which removes bug in that processing.
 ;
 Q
 ;
EN ; Entry point for this routine
 N MDFPRC,MDFPRCD,MDFSVC,MDFSVCD,MDTPRC,MDTPRCD,MDTSVC,MDTSVCD,MDCOUNT,MDCP
 N MDFDA,MDSTS,MDSTSD,MDDT,MDIEN,MDPRT,STOP,FROM
 S (MDCOUNT,STOP)=0
 ;
 D INTRO
 F FROM=1,0 Q:STOP  D GETPR(FROM)
 Q:STOP 
 D CONVERT
 Q
 ;
INTRO ; 
 W !!,"This utility will get all pending, active, and scheduled"
 W !,"procedures of a selected REQUEST SERVICES and convert them to"
 W !,"the selected REQUEST SERVICES in the selected GMRC procedure."
 W !
 W !,"Note that procedures currently setup with DICOM (in the CLINICAL "
 W !,"SPECIALTY DICOM & HL7 file) cannot be converted to CP with this"
 W !,"utility. DICOM procedures will need to discontinued and reordered."
 W !
 Q
 ;
GETPR(FROM) ; Get the user-selected procedure
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^GMR(123.3,",DIC(0)="AEMNQ",DIC("A")="Select a GMRC Procedure to convert "_$S(FROM:"FROM: ",1:"TO: ")
 D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) S STOP=1 Q
 I FROM D  Q
 . I $$GET1^DIQ(123.3,+Y,.04)]"" D  Q
 .. W !!,"This procedure is already a Clinical Procedure - Cannot convert. Quitting...",!
 .. S STOP=1
 .. Q
 . S MDFPRC=+Y,MDFPRCD=$P(Y,U,2)
 . D GETRS(FROM)
 . Q
 ;
 Q:STOP
 S MDTPRC=+Y,MDTPRCD=$P(Y,U,2)
 D GETRS(FROM)
 Q
 ;
GETRS(FROM) ; Get the Related Service from #123.32
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^GMR(123.5,",DIC(0)="AEMNQ"
 ; Next line - screen to only allow service related to selected procedure
 S DIC("S")="I ($D(^GMR(123.3,"_$S(FROM:"MDFPRC",1:"MDTPRC")_",2,""B"",+Y)))"
 D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) S STOP=1 Q
 I FROM D  Q
 . I $D(^MAG(2006.5831,"C",+Y,MDFPRC)) D  Q
 .. W !!,"Procedure/Service setup for DICOM - Cannot convert. Quitting...",!
 .. S STOP=1
 .. Q
 . S MDFSVC=+Y,MDFSVCD=$P(Y,U,2)
 . Q
 ;
 Q:STOP
 S MDTSVC=+Y,MDTSVCD=$P(Y,U,2)
 Q
 ;
CONVERT ; Convert the requested data
 S MDCP=$$GET1^DIQ(123.3,+MDTPRC_",",.04,"I")
 I 'MDCP D GETCP Q:STOP
 ;
 W !!,"We will proceed to convert ",MDFPRCD," in ",MDFSVCD
 W !,"to ",MDTPRCD," procedures in ",MDTSVCD,!
 ;
 ; ^GMR(123,"AE",RequestService,OrderStatus,ReverseDate,IEN)
 S MDSTS=""
 F  S MDSTS=$O(^GMR(123,"AE",MDFSVC,MDSTS)) Q:'MDSTS  D
 . S MDSTSD=$$GET1^DIQ(100.01,MDSTS,.01,"E")
 . I MDSTSD'="PENDING",MDSTSD'="ACTIVE",MDSTSD'="SCHEDULED" Q
 . S MDDT=0
 . F  S MDDT=$O(^GMR(123,"AE",MDFSVC,MDSTS,MDDT)) Q:MDDT=""  D
 .. S MDIEN=0
 .. F  S MDIEN=$O(^GMR(123,"AE",MDFSVC,MDSTS,MDDT,MDIEN)) Q:'MDIEN  D
 ... S MDPRT=$$GET1^DIQ(123,MDIEN,4,"E")
 ... I MDPRT'=MDFPRCD Q
 ... S MDFDA(123,MDIEN_",",1)=+MDTSVC                    ; To Service
 ... S MDFDA(123,MDIEN_",",1.01)=+MDCP                   ; Clinical Procedure
 ... S MDFDA(123,MDIEN_",",4)=+MDTPRC_";"_"GMR(123.3,"   ; Procedure/Request Type
 ... S MDFDA(123,MDIEN_",",13)="P"                       ; Request Type
 ... L +^GMR(123,MDIEN):1 I '$T Q
 ... D FILE^DIE("","MDFDA")
 ... L -^GMR(123,MDIEN)
 ... S MDCOUNT=MDCOUNT+1 W !,"  Record # ",MDIEN," converted."
 ... Q
 .. Q
 . Q
 ;
 W !!,"Total records converted = ",MDCOUNT,!
 Q
 ;
GETCP ; Get/define a clinical procedure for the target/TO procedure
 N DIC,X,Y,DTOUT,DUOUT
 W !,"Missing Clinical Procedure Definition in ",$$GET1^DIQ(123.3,+MDTPRC,.01),!
 S DIC="^MDS(702.01,",DIC(0)="AEMNQ"
 D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) S STOP=1 Q
 S MDCP=+Y
 S MDFDA(123.3,MDTPRC_",",.04)=+MDCP
 L +^GMR(123.3,MDTPRC):1 I '$T D  Q
 . W !!,"Unable to lock the "_MDTPRCD_" record. Quitting..."
 . S STOP=1
 . Q
 ;
 D FILE^DIE("","MDFDA") K MDFDA
 L -^GMR(123.3,MDTPRC)
 Q
