XWBDLOG ;ISF/RWF - Debug Logging for Broker ; 8/28/2013 10:38am
 ;;1.1;RPC BROKER;**35,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBDLOG is not callable at the top
 ;
 ; Change History:
 ;
 ; 2004 12 08 ISF/RWF: XWB*1.1*35 SEQ #30, NON-callback server. Original
 ; routine created.
 ;
 ; 2013 08 16-28 VEN/JLI&TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; LOG extended to save arrays. LOGSTART changed to echo style. Updated
 ; VIEW subroutines to show debugging arrays. Annotated. Change History
 ; added. in XWBDLOG, LOGSTART, LOG, VIEW, V1, V2, VL1, VL2, EOR.
 ;
 ;
LOGSTART(RTN) ;Setup the log, Clear the log location
 ; input:
 ;   RTN = name of initial logging routine
 ; output: new log started in ^XTMP("XWBLOG"_$J)
 ;
 Q:'$G(XWBDEBUG)  ; don't log unless XWBDEBUG parameter is set
 ;
 N LOG S LOG="XWBLOG"_$J ; this job's log subscript
 K ^XTMP(LOG) ; clear our log
 S ^XTMP(LOG,0)=$$HTFM^XLFDT($$HADD^XLFDT($H,7))_"^"_$$DT^XLFDT ; started
 S ^XTMP(LOG,.1)=0 ; initialize log-entry counter
 D LOG("Log start: "_$$HTE^XLFDT($H)) ; record start of log
 D LOG(RTN) ; record initial logging routine
 ;
 QUIT  ; end of LOGSTART
 ;
 ;
LOG(MSG,ROOT) ;Record Debug Info
 ; input:
 ;   MSG = text to record, up to 243 characters
 ;   ROOT = [optional] name of array to record
 ; output: new entry in ^XTMP("XWBLOG"_$J)
 ;
 Q:'$G(XWBDEBUG)  ; don't log unless XWBDEBUG parameter is set
 ;
 N LOG S LOG="XWBLOG"_$J ; this job's log subscript
 N CNT S CNT=1+$G(^XTMP(LOG,.1)) ; get next log #
 S ^XTMP(LOG,.1)=CNT ; update next log #
 S ^XTMP(LOG,CNT)=$E($H_"^"_MSG,1,255) ; record log message
 I $G(ROOT)'="" D  ; if there's an array to record
 . M ^XTMP(LOG,CNT)=@ROOT ; record it
 ;
 QUIT  ; end of LOG
 ;
 ;
VIEW ;View log files
 N DIRUT,XWB,DIR,IX,X,CON,IXNEXT
 D HOME^%ZIS
 W !,"Log Files"
 S XWB="XWBLOG",CON=""
 F  S XWB=$O(^XTMP(XWB)) Q:XWB'["XWBLOG"  D
 . D V1(.XWB)
 . I 'IXNEXT I $$WAIT(.CON) S:CON=3 XWB="XWC"
 . Q
 Q
 ;
V1(XWB) ;View one log
 N IX,X,CNT,V2LEN
 S IX=.9,X=$G(^XTMP(XWB,IX)),CON=0,CNT=+$G(^XTMP(XWB,.1))
 S IXNEXT=0
 Q:CNT<1
 W !!,"Log from Job ",$E(XWB,7,99)," ",CNT," Lines"
 F  S IX=$O(^XTMP(XWB,IX)) Q:'$L(IX)  S X=^XTMP(XWB,IX) D VL1(IX,X) Q:IXNEXT  I $D(^XTMP(XWB,IX))>1 S V2LEN=$L("^XTMP("""_XWB_""","_IX) D V2("^XTMP("""_XWB_""","_IX) ; JLI 130819
 Q
 ;
V2(GLOB) ; handle arrays under the top level
 N JX,X,ISDATA
 S JX=-1
 F  S JX=$O(@(GLOB_","""_JX_""")")) Q:'$L(JX)  S XGLOB=GLOB_","""_JX_""")" S ISDATA=$D(@XGLOB)#2 S:ISDATA X=@(XGLOB) D:ISDATA VL2(XGLOB,X) Q:IXNEXT  I $D(@(XGLOB))>1 D V2(GLOB_","""_JX_"""") Q:IXNEXT
 Q
 ;
VL1(J,K) ;Write a line
 I $Y'<IOSL,$$WAIT(.CON) S IXNEXT=1 S:CON=3 XWB="XWC" Q
 Q:'$D(^XTMP(XWB,IX))
 N H,D,T,I
 S H=$P($$HTE^XLFDT($P(K,"^"),"2S"),"@",2)_" = "
 S D=$P(K,"^",2,99),K=D
 I D?.E1C.E D
 . S D=""
 . F I=1:1:$L(K) S T=$A(K,I),D=D_$S(T>31:$E(K,I),1:"\"_$E((1000+T),3,4))
 . Q
 S T=$L(H)
 F  W !,H,?T,$E(D,1,68) S H="",D=$E(D,69,999) Q:'$L(D)
 Q
 ;
VL2(J,K) ; write line of array
 ; ZEXCEPT: IXNEXT   defined and newed in VIEW
 ; ZEXCEPT: IX,CNT,V2LEN   defined and newed in V1
 ; ZEXCEPT: XWB     argument to V1
 N D
 I $Y'<IOSL,$$WAIT(.CON) S IX="A",IXNEXT=1 S:CON=3 XWB="XWC" Q
 S D=$E(J,V2LEN+1,999)_" : "_K
 F  W !,?11,$E(D,1,68) S D=$E(D,69,999) Q:'$L(D)
 Q
 ;
WAIT(CON) ;continue/kill/exit
 S DIR("?")="Enter RETURN to continue, Next for next log, Kill to remove log, Exit to quit log view."
 S DIR("A")="Return to continue, Next log, Exit: "
 S DIR(0)="SAB^1:Continue;2:Next;3:Exit;4:Kill",DIR("B")="Continue"
 D ^DIR
 S CON=+Y
 I Y=4 D K1(XWB,0) H 1
 I Y=1 W @IOF
 Q Y>1
 ;
K1(REF,S) ;Kill one
 I REF["XWBLOG" K ^XTMP(REF)
 I 'S W !,"Log "_REF_" deleted."
 Q
 ;
KILLALL ;KILL ALL LOG Entries
 N DIR,XWB
 S DIR(0)="Y",DIR("A")="Remove all XWB log entries",DIR("B")="No"
 D ^DIR Q:Y'=1
 S XWB="XWBLOG"
 F  S XWB=$O(^XTMP(XWB)) Q:XWB'["XWBLOG"  D K1(XWB,1)
 W !,"Done"
 Q
 ;
 ;
EOR ; end of routine XWBDLOG
