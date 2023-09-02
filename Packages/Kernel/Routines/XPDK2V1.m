XPDK2V1 ; VEN/SMH - Analyze KIDS file and extract information ;2014-03-18  11:57 AM
 ;;8.0;KERNEL;**11310**;Mar 28, 2014
 ; Inspired by the VISTA XML Parser, a State Machine
 ; Thank you Dr. Douglas Martin (SAIC/DKM)
 ;
 ; (C) Sam Habiel 2014, who needs more money than fame (but a rich wife will do!)
 ; License: Apache 2
 ;
 ; Conversion procedure from a VA PM HFS-extracted KIDS (complete):
 ;^TMP(28177,1,0)="Released TIU*1*241 SEQ #237" <-- $TXT prepended
 ;^TMP(28177,2,0)="Extracted from mail message" <-- this becomes the txt
 ;^TMP(28177,3,0)="**KIDS**:TIU*1.0*241^"       <-- $END TXT replaced
 ;^TMP(28177,4,0)="" --> becomes $KID append whatever is in 6
 ;^TMP(28177,5,0)="**INSTALL NAME**"
 ;^TMP(28177,6,0)="TIU*1.0*241"
 ;---
 ;^TMP(28177,1189,0)="**END**" --> becomes $END KID whatever is in 6
 ;^TMP(28177,1190,0)="**END**" --> DELETED
 ;
 ; A few random notes on various KIDS issues
 ; If the original is a mail message, it will looks like this
 ; 
 ; >> Released GMRA*4*44 SEQ #41
 ; >> Extracted from mail message
 ; >> **KIDS**:GMRA*4.0*44^
 ; >> 
 ; >> **INSTALL NAME** etc..
 ; >> kids contents
 ; >> **END**
 ; >> **END**
 ;
 ; If the original isn't a PM HFS-extracted KIDS build, but a Straight from 
 ; KIDS KIDS-build, then the KIDS first line looks like this:
 ;
 ; >> KIDS Distribution saved on Apr 30, 2013@05:31:47
 ; >> OR*371
 ; >> **KIDS**:OR*3.0*371^
 ; >> <blank line>
 ; >> **INSTALL NAME**
 ;
 ; Multibuilds look like this:
 ; 
 ; >> KIDS Distribution saved on Sep 23, 2011@17:42:57
 ; >> IB/PRCA Remedy Ticket Fixes
 ; >> **KIDS**:IB*2.0*459^PRCA*4.5*280^
 ; >> <blank line>
 ; >> **INSTALL NAME**
 ; >> text of first KIDS build
 ; >> **INSTALL NAME**
 ; >> text of second KIDS build
 ; >> **END**
 ; >> **END**
 ;
 ; A KIDS sent from another system via KIDS/MM has the following contents.
 ;$TXT Created by TESTMASTER,USER at VEN.SMH101.COM  (KIDS) on Thursday, 01/07/14 at 15:55
 ; <contents>
 ;$END TXT
 ;$KID ZZZ*1.0*1
 ;**INSTALL NAME**
 ; <contents>
 ;$END KID ZZZ*1.0*1
 ;
ANALYZE(RTN,MSGGREF,OPT) ; [PUBLIC] Proc ; Analyze a KIDS file in global MSGGREF. Return in RTN.
 ; RTN - Global name - use with subscript indirection.
 ; MSGREG - Global passed by name containing message. Use Sub Ind to get data.
 ; OPT - Value - Options. Only supported one is "D" - debug. Prints out lines as they are read.
 ;
 N CREF ; Current global reference
 N START,STATE,LINE,BUILD
 S STATE="BEGIN"
 N EOD S EOD=0 ; End of Document
 S CREF=MSGGREF ; Current reference for $Q
 N QL S QL=$QL(MSGGREF) ; QL of original global for quit next line.
 F  QUIT:EOD  D SEEK() QUIT:EOD  D @STATE  ; CENTRAL READING LOOP
 QUIT
 ;
 ; === REST OF EP'S ARE PRIVATE ===
 ;
SEEK(NOTRIM) ; Get next line
 ; ZEXCEPT: CREF,EOD,LINE,QL - Newd above
 ; ZEXCEPT: MSGGREF,OPT - Params
 S CREF=$QUERY(@CREF)
 I CREF="" S EOD=1 QUIT
 I $NA(@CREF,QL)'=$NA(@MSGGREF,QL) S EOD=1 QUIT  ; $Q went beyond deep end.
 S LINE=@CREF
 I '$G(NOTRIM) S LINE=$$TRIM^XLFSTR(LINE,"R") ; Remove the spaces from the right
 I $G(OPT)["D" WRITE LINE,! ; Debug mode
 QUIT
 ;
BEGIN ; Begin State
 ; ZEXCEPT: LINE,STATE
 D SEEK() ; Second line; first line already read. Discard both.
 S STATE="KIDSSS"
 QUIT
 ;
KIDSSS ; Process **KIDS**
 ; ZEXCEPT: LINE,STATE,RTN
 D ASSERT($E(LINE,1,8)="**KIDS**")
 N BUILDS S BUILDS=$P(LINE,"**KIDS**:",2)    ; Get the builds (even just one)
 N I,BUILD F I=1:1:$L(BUILDS,U) S BUILD=$P(BUILDS,U,I) Q:BUILD=""  S @RTN@(BUILD,0)=BUILD  ; Put them into an array
 D SEEK()                             ; Get rid of the blank line next.
 S STATE="INSTLNM"                    ; Move to process **INSTALL NAME**
 QUIT
 ;
INSTLNM ; Process **INSTALL NAME**
 ; ZEXCEPT: LINE,STATE,RTN,BUILD
 D ASSERT($E(LINE,1,$L("**INSTALL NAME**"))="**INSTALL NAME**")
 N OLDLINE S OLDLINE=LINE             ; Just preserve this for convenience
 D SEEK()                             ; Get the install Name
 S BUILD=LINE                         ; Build name. Build var is shared below.
 D ASSERT($D(@RTN@(BUILD)))           ; Must exist from KIDSSS
 S @RTN@(BUILD,1)="$KID "_BUILD       ; Build name
 S @RTN@(BUILD,2)=OLDLINE             ; **INSTALL NAME**
 S @RTN@(BUILD,3)=LINE                ; Actual build name
 S STATE="ZERO"                       ; Build file zero node
 QUIT
 ;
ZERO ; Process the ZERO node of the Build
 ; ZEXCEPT: LINE,STATE,RTN,BUILD
 D ASSERT(LINE?1"""BLD"","1.N1",0)")         ; Must look like "BLD",8190,0)
 N NS S NS=$O(@RTN@(BUILD," "),-1)+1         ; Next sub
 S @RTN@(BUILD,NS)=LINE                      ; Load this
 D SEEK()                                    ; Get next line
 S @RTN@(BUILD,NS+1)=LINE                    ; Load this... BUT...
 S @RTN@(BUILD,0)=LINE                       ; Put it also on our zero node
 S STATE="CONTENT"                           ; Load the rest of it.
 QUIT
 ;
CONTENT ; Process Content of KIDS build
 ; ZEXCEPT: BUILD,EOD,INSTLNM,LINE,RTN
 ; TODO: Load whether this is Multi-build or not from zero node.
 N NS S NS=$O(@RTN@(BUILD," "),-1)+1         ; Next sub
 ;
 ; If we had reverse $QUERY on GT.M, I won't need to use Goto. I can go back a line.
 I LINE="**INSTALL NAME**" DO  GOTO INSTLNM  ; Goto b/c we don't want to go back to SEEK in the main loop.
 . S @RTN@(BUILD,NS)="$END KID "_BUILD       ; End this build
 ;
 I LINE="**END**" DO  S EOD=1 QUIT           ; End this build and stop reading the KIDS file
 . S @RTN@(BUILD,NS)="$END KID "_BUILD       ; End this build
 ;
 S @RTN@(BUILD,NS)=LINE                      ; Just read the line
 QUIT
 ;
NOP ; No-Op State - Just use for debugging
 ; ZEXCEPT: LINE
 W LINE,!
 QUIT
 ;
ASSERT(X,Y) ; Assertion engine
 I 'X D EN^DDIOL($G(Y)) S $EC=",U-ASSERTION-ERROR,"
 QUIT
 ;
RED(X) ; Convenience method for Sam to see things on the screen.
 Q $C(27)_"[41;1m"_X_$C(27)_"[0m"
 ;
 ;
 ;
