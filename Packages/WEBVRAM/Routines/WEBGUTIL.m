WEBGUTIL ; SLC/JAS - WEBVRAM VISTA UTILITIES; Nov 2, 2023@12:30 PM
 ;;3.0;WEB VISTA REMOTE ACCESS MANAGEMENT;**13,17**;Apr 06, 2021;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to GETLST^XPAR  - Supported by ICR 2263
 ; Reference to file #200    - Supported by ICR 10060
 ; Reference to file #8989.3 - Supported by ICR 7430
 ; References to XLFDT       - Supported by ICR 10103
 ;
 Q
 ;
VERSRV(RETDLL) ; Return server version(s) for Vitals DLL
 ;
 ; Output: Active GMRV/VITALS DLL Version(s) in array format
 ;
 N ENTITY,ERR,PARAM,RESCNT,RESULTS,VERCNT
 S VERCNT=0
 S ENTITY="SYS"
 S PARAM="GMV DLL VERSION"
 ;
 D GETLST^XPAR(.RESULTS,ENTITY,PARAM,"E",.ERR)
 ;
 ; Exception checking
 ;
 I $G(ERR,0) D  Q
 . S RETDLL(VERCNT)="An error has occurred."
 I '$D(RESULTS) D  Q
 . S RETDLL(VERCNT)="No entries found."
 ;
 ; Filter out inactive results
 ;
 F RESCNT=1:1:RESULTS D
 . I $P($G(RESULTS(RESCNT)),"^",2)="YES" D
 . . S VERCNT=VERCNT+1
 . . S RETDLL(VERCNT)=$P($G(RESULTS(RESCNT)),"^")
 ;
 I 'VERCNT S RETDLL(VERCNT)="No active versions." Q
 ;
 S RETDLL(0)=VERCNT
 ;
 Q
 ;
VERCDEXP(RETEXP) ; Return the expiration date for current user's Verify Code
 ;
 ; Output: Expiration of DUZ's Verify Code in standard date format
 ;
 N EXPDATE,EXPDAYS,LASTCHG,NXTCHG
 ;
 S EXPDAYS=$$GET1^DIQ(8989.3,1,214,"I") ; LIFETIME OF VERIFY CODE in KERNEL SYSTEM PARAMETERS file
 I 'EXPDAYS S EXPDAYS=90  ; 90 is the standard default
 ;
 S LASTCHG=$$GET1^DIQ(200,DUZ,11.2,"I") ; DATE VERIFY CODE LAST CHANGED in NEW PERSON file
 ;
 S EXPDATE=$$HADD^XLFDT(LASTCHG,EXPDAYS)
 S RETEXP=$P($$HTE^XLFDT(EXPDATE,5),"@")
 Q
