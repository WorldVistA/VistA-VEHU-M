PSO7L529 ;WILM/BDB - MIGRATION REPORT ;04/30/2021
 ;;7.0;OUTPATIENT PHARMACY;**529**;DEC 1997;Build 94
 ;External reference to sub-file NEW DEA #S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 Q 
 ;
START ;
 N DEA,NPIEN,PSI,RET,PSOSTOP
 K RET
 S X=300 X ^%ZOSF("RM")
 D SELDEV Q:PSOSTOP
 D LOGON Q:PSOSTOP
 D PROCESS
 D LOGOFF
 Q
 ;
PROCESS ;
 S DEA="A"
 D
 .S RET="DEA NUMBER|DEA NUMBER|STATUS|SOURCE|DEA SUFFIX|BUSINESS CODE|NAME|ADDITIONAL COMPANY INFO|ADDRESS 1|ADDRESS 2|CITY|STATE|ZIP|DETOX NUMBER"
 .S RET=RET_"|EXPIR DATE|II N|II N-N|III N"
 .S RET=RET_"|III N-N|IV|V|INPAT"
 .W !,RET
 F  S DEA=$O(^VA(200,"PS1",DEA)) Q:DEA=""  D
 . S NPIEN=$O(^VA(200,"PS1",DEA,0))
 . D DEALIST(.RET,NPIEN)
 . I $D(RET) S PSI=0 F  S PSI=$O(RET(PSI)) Q:'PSI  D
 .. I PSI=1 S:$D(RET(2)) $P(RET(PSI),"|",3)="M",$P(RET(PSI),"|",4)="VISTA" W !,RET(PSI) Q
 .. I PSI>1 S $P(RET(PSI),"|",3)="M",$P(RET(PSI),"|",4)="DOJ" W !,RET(PSI) Q
 Q
 ;
DEALIST(RET,NPIEN)  ; -- return a List of DEA numbers and information for a single provider.
 ; INPUT:  NPIEN - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ;
 ; OUTPUT: RET - A STRING OF DEA INFORMATION DELIMITED BY THE "^"
 ;
 Q:'$G(NPIEN)
 N CNT,DNDEADAT,DNDEAIEN,NPDEADAT,NPDEAIEN,I,PSAR,IENS,SUB
 K RET S CNT=1
 D GETS^DIQ(200,NPIEN,".01;.111;.112;.113;.114;.115;53.2;53.11;55.1;55.2;55.3;55.4;55.5;55.6;.116","E","PSAR")
 D GETS^DIQ(200,NPIEN,"747.44","I","PSAR")
 S SUB=NPIEN_","
 ;
 S RET(CNT)=""
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,53.2,"E")_"|"        ; NEW PERSON DEA NUMBER
 S RET(CNT)=RET(CNT)_"|"            ; DEA POINTER NO EQUIVALENT
 S RET(CNT)=RET(CNT)_"E|"           ; MIGRATION STATUS
 S RET(CNT)=RET(CNT)_"VISTA|"       ; SOURCE
 S RET(CNT)=RET(CNT)_"|"            ; INDIVIDUAL DEA SUFFIX
 S RET(CNT)=RET(CNT)_"|"            ; BUSINDESS CODE 
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.01,"E")_"|"  ; NAME
 S RET(CNT)=RET(CNT)_"|"                          ; ADDITIONAL COMPANY INFO
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.111,"E")_"|"  ; ADDR 1
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.112,"E")_"|"  ; ADDR 2 
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.114,"E")_"|"  ; CITY
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.115,"E")_"|"  ; STATE
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.116,"E")_"|"  ; ZIP 
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,53.11,"E")_"|" ; DETOX NUMBER
 S RET(CNT)=RET(CNT)_$$FMTE^XLFDT(PSAR(200,SUB,747.44,"I"))_"|"  ; EXPIRATION DATE
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.1,"E"))_"|"  ; SCHEDULE II NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.2,"E"))_"|"  ; SCHEDULE II NON-NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.3,"E"))_"|"  ; SCHEDULE III NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.4,"E"))_"|"  ; SCHEDULE III NON-NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.5,"E"))_"|"  ; SCHEDULE IV
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.6,"E"))_"|"  ; SCHEDULE V
 S RET(CNT)=RET(CNT)_""      ; USE FOR INPATIENT ORDERS?
 S RET(CNT)=$$UPPER(RET(CNT))
 ;
 S NPDEAIEN=0 F CNT=2:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'+NPDEAIEN  D
 . S IENS=NPDEAIEN_","_NPIEN_","
 . K NPDEADAT D GETS^DIQ(200.5321,IENS,"**","","NPDEADAT") Q:'$D(NPDEADAT)
 . S DNDEAIEN=$$GET1^DIQ(200.5321,IENS,.03,"I") Q:'DNDEAIEN
 . K DNDEADAT D GETS^DIQ(8991.9,DNDEAIEN,"**","","DNDEADAT") Q:'$D(DNDEADAT)
 . ;
 . S RET(CNT)=""
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.01)_"|"        ; NEW PERSON DEA NUMBER
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.03)_"|"        ; NEW PERSON DEA NUMBER
 . S RET(CNT)=RET(CNT)_"M|"          ; MIGRATION STATUS
 . S RET(CNT)=RET(CNT)_"DOJ|"        ; SOURCE
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.02)_"|"        ; INDIVIDUAL DEA SUFFIX
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.02)_"|"  ; BUSINESS CODE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.1)_"|"  ; NAME 8991.9
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.2)_"|"  ; ADDL COMPANY INFO
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.3)_"|"  ; ADDR 1
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.4)_"|"  ; ADDR 2
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.5)_"|"  ; CITY
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.6)_"|"  ; STATE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.7)_"|"  ; ZIP
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.03)_"|"  ; DETOX NUMBER
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.04)_"|"  ; EXPIRATION DATE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.1)_"|"  ; SCHEDULE II NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.2)_"|"  ; SCHEDULE II NON-NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.3)_"|"  ; SCHEDULE III NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.4)_"|"  ; SCHEDULE III NON-NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.5)_"|"  ; SCHEDULE IV
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.6)_"|"  ; SCHEDULE V
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.06)      ; USE FOR INPATIENT ORDERS?
 . S RET(CNT)=$$UPPER(RET(CNT))
 Q
 ;
UPPER(PSOUCS) ;
 Q $TR(PSOUCS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
SELDEV ; Select Device
 ;
 N DIR,X,Y
 S PSOSTOP=0
 S DIR("A",1)=""
 S DIR("A",2)="   ************************************************************"
 S DIR("A",3)="   **  To avoid undesired wrapping, you may need to set your **"
 S DIR("A",4)="   **  terminal session display settings to 190 columns.     **"
 S DIR("A",5)="   ************************************************************"
 S DIR("A")=" Press return to continue "
 S DIR(0)="EA" D ^DIR K DIR W !
 I 'Y S PSOSTOP=1 Q
 ;
 K X,Y
 S DIR("T")=0
 S DIR("A",1)=""
 S DIR("A",2)="   ************************************************************"
 S DIR("A",3)="   **  This report is designed for a 190 column format.      **"
 S DIR("A",4)="   **  Please enter '0;190;9999' at the 'DEVICE:' prompt.    **"
 S DIR("A",5)="   **  You may queue this report to print at a later time.   **"
 S DIR("A",5)="   ************************************************************"
 S DIR("A")=""
 S DIR(0)="EA" D ^DIR K DIR W !
 ;
 K %ZIS,IOP,POP,ZTSK N I S PSOION=$I,%ZIS="QM"
 D ^%ZIS K %ZIS
 I POP S IOP=PSOION D ^%ZIS K IOP,PSOION D  Q
 .K X,Y
 .S DIR("A",1)=""
 .S DIR("A",2)="  ** No Device Selected **"
 .S DIR("A")="  Press return to continue "
 .S DIR(0)="EA" D ^DIR K DIR W !
 .S PSOSTOP=1
 Q
 ;
LOGON ; Turn on Logging Message
 N DIR
 S PSOSTOP=0
 S DIR("A",1)="     *****************************************************"
 S DIR("A",2)="     **  This is a Delimited report. Please verify you  **"
 S DIR("A",3)="     **  have identified a log file, and have turned    **"
 S DIR("A",4)="     **  logging on to capture the output.              **"
 S DIR("A",5)="     *****************************************************"
 S DIR("A",6)="",DIR("A",6)=""
 S DIR("A")=" Press return to continue "
 S DIR(0)="EA" D ^DIR W !
 S:'Y PSOSTOP=1
 Q
 ;
LOGOFF ; Turn off Logging Message
 N DIR
 S DIR("A",1)="     *******************************************************"
 S DIR("A",2)="     **  The report is complete. Please verify you have   **"
 S DIR("A",3)="     **  turned logging off to save the captured output.  **"
 S DIR("A",4)="     *******************************************************"
 S DIR("A",5)="",DIR("A",6)=""
 S DIR("A")=" Press return to continue "
 S DIR(0)="EA" D ^DIR W !
 Q
