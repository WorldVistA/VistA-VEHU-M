SDWLUI ;RGI/CBR - WAIT LIST UI UTILITIES;08/01/12
 ;;5.3;scheduling;**260003**;08/13/93;Build 8
SELPAT(STATUS) ; SELECT PATIENT
 ;STATUS    "O"=Return only OPEN entries,
 ;          "C"=Return only CLOSED entries,
 ;          ""=Return all entries. 
 ;          Default: ""
 ;RETURN    -1=failed to access patient file or user entered '^'
 ;          >0 Patient IEN
 N DFN,DIC,Y
 S STATUS=$E($G(STATUS))
 I (STATUS="O")!(STATUS="C") S DIC("S")="I $P(^SDWL(409.3,+Y,0),U,17)="""_STATUS_""""
 S DIC(0)="EMNQA",DIC=409.3 D ^DIC S DFN=$P(Y,U,2)
 I (Y<0)!$D(DUOUT)!(DFN="") Q -1
 Q DFN
 ;
SELDATE(SDBEG,SDEND) ;SELECT BEGIN/END DATE
 N DIR,%DT
 S SDBEG="",SDEND=""
 S %DT="AE",%DT("A")="Start with Date Entered: " D ^%DT
 I Y<1 Q 0
 S SDBEG=Y
 S %DT(0)=SDBEG,%DT("A")="End with Date Entered: " D ^%DT
 I Y<1 Q $$SELDATE(.SDBEG,.SDEND)
 S SDEND=Y
 K %DT(0),%DT("A")
 Q 1
 ;
MMDDYY(DATE) ;FORMAT DATE AS MMDDYY
 Q $E(DATE,4,5)_$E(DATE,6,7)_$E(DATE,2,3)
 ;
