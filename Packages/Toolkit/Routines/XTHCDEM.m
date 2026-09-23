XTHCDEM ;HCIOFO/SG - HTTP 1.0 CLIENT (DEMO) ; Oct 01, 2025  10:54
 ;;7.3;TOOLKIT;**123,162**;Apr 25, 1995;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;##### DEMO ENTRY POINT
 ;
 ; The ^TMP($J,"XTHC") global node is used by the entry point.
 ;
DEMO(OPTION) ;XT162
 N BODY,DIR,DIRUT,DTOUT,DUOUT,HEADER,RC,URL,X,Y
 S BODY=$NA(^TMP($J,"XTHC"))
 S OPTION=$G(OPTION) ;XT162
 I OPTION=1 D
 . S URL="https://www.amazon.com"  ;native https
 E  I OPTION=2 D
 . S URL="https://www.howsmyssl.com/"  ;native https
 E  I OPTION=3 D
 . S URL="https://postman-echo.com/get" ;native https
 E  I OPTION=4 D
 . S URL="https://httpbin.org/get"
 E  I OPTION=5 D
 . S URL="http://httpforever.com" ;permanent http site
 E  S URL="http://www.hardhats.org" ;this will redirect
 ;
 S RC=0
 F  D  Q:RC
 . K @BODY,HEADER  W !
 . ;--- Request a URL from the user
 . K DIR  S DIR(0)="F"
 . S DIR("A")="URL",DIR("B")=URL
 . D ^DIR  I $D(DIRUT)  S RC=1  Q
 . S URL=$$TRIM^XLFSTR(Y)
 . ;--- Request the resource
 . S RC=$$GETURL^XTHC10(URL,,BODY,.HEADER)
 . I RC<0  W !,RC S RC=0 Q  ; D PRTERRS^XTERROR1(RC)  S RC=0  Q
 . ;--- Print the data
 . D PRINT(BODY,.HEADER)
 . S RC=0
 ;
 ;--- Cleanup
 K @BODY
 Q
 ;
 ;+++++ PRINTS THE RESPONSE
PRINT(XTHC8DAT,HEADER) ;
 N I,J
 ;---
 I $D(HEADER)>0  D  Q:$$PAGE
 . W @IOF,"----- HTTP HEADER -----",!!
 . W $G(HEADER),!
 . S I=""
 . F  S I=$O(HEADER(I))  Q:I=""  W I_"="_HEADER(I),!
 ;---
 D:$D(@XTHC8DAT)>1
 . W @IOF,"----- MESSAGE XTHC8DAT -----",!!
 . S I=""
 . F  S I=$O(@XTHC8DAT@(I))  Q:I=""  W @XTHC8DAT@(I)  D  W !
 . . S J=""  F  S J=$O(@XTHC8DAT@(I,J))  Q:J=""  W @XTHC8DAT@(I,J)
 Q
 ;
PAGE() ;Page break
 N DIR,DIROUT,DTOUT,DUOUT
 S DIR(0)="E"
 D ^DIR
 Q $S($D(DUOUT):1,$D(DTOUT):1,1:0)
 ;
