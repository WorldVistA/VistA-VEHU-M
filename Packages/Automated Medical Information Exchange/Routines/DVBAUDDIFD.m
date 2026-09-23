DVBAUDDIFD   ;ALB/CP - File Deletion Utility ;09/13/16  15:52
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;       HOME^%ZIS     ; IA #10086
 ;           ^DIC      ; IA #10006
 ;           ^DIU2     ; IA #10014
 ;
 Q
 ;
ENTER ; Primary entry point for this API utility routine
 N DVBASK,DVBFILE,DVBMETHOD,DVBOPTION,DVBQUIT,X,Y
 ; ZEXCEPT: DTIME
 ;
 D:'$D(IOF) HOME^%ZIS S:'$D(DTIME) DTIME=300
 I '$G(DUZ)!($G(DUZ(0))="") D  G EXIT
 . W !
 . D CENTER^DVBAUDPRT1("Both the DUZ and DUZ(0) need to be defined.")
 . D CONTINUE^DVBAUDPRT1(2,"R") ; Press <Enter> to continue.
 S DVBOPTION="FILE DELETION UTILITY"
 S DVBQUIT=0
PROMPT ; Present user prompts
 D SHOWOPT^DVBAUDPRT2(DVBOPTION) ; Show option text, set DVBQUIT=0
 D GETFILES ; Return DVBFILE(DVBFILENUM)="" ; Array of file numbers
 G:DVBQUIT EXIT ; Exit, once the user is done deleting
 D ASKMETH G:DVBQUIT PROMPT ; Which deletion method do you prefer
 D ASKOK(.DVBFILE) G:DVBQUIT PROMPT D DELETE(DVBASK,.DVBFILE)
 G PROMPT
EXIT ; Exit the file deletion utility API
 Q
 ;------------------------------------------------------------------
ASKMETH ; Prompt: 'Which deletion method do you prefer'
 ;
 W !!,"Which deletion method do you prefer"
 W !?4,"1. Ask before deleting DATA & TEMPLATES"
 W !?4,"2. Delete DATA & TEMPLATES without asking"
 W !
 S DVBASK=$$ASKNUM^DVBAUDASK1(2,2)
 I DVBASK="^" S DVBQUIT=1 Q
 ;
 Q
 ;------------------------------------------------------------------
ASKOK(DVBFILE) ; Prompt: OK TO DELETE?
 ;
 N DVBFILENUM
 ; ZEXCEPT: IOF,DVBASK,DVBQUIT
 ;
 W @IOF
 W !,"WARNING! The following file(s) are selected for DELETION:",!
 S DVBFILENUM=""
 F  S DVBFILENUM=$O(DVBFILE(DVBFILENUM)) Q:DVBFILENUM=""  D  Q:DVBQUIT
 . N DIERR
 . W !?2,$$GET1^DIQ(1,DVBFILENUM,.01)
 . I $D(DIERR) D DIERR^DVBAUDDILG1(60,5,"DVBERROR","ASKOK^"_$T(+0)) Q
 Q:DVBQUIT
 ;
 ; Previous FOR loop eliminated do to direct global access as follows
 ;F  S DVBFILENUM=$O(DVBFILE(DVBFILENUM)) Q:DVBFILENUM=""  W !?2,$P(^DIC(DVBFILENUM,0),U,1)
 W !
 S DVBASK=$$ASKYESNO^DVBAUDASK1("OK TO DELETE","NO")
 I "^N"[DVBASK S DVBQUIT=1 Q  ; User answered with "N" or "^"
 ;
 Q
 ;------------------------------------------------------------------
GETFILES ; Build DVBFILE(array)
 ;
 N @($$DIC^DVBAUDNEW1())
 N DVBCNT,DIC,Y
 ; ZEXCEPT: DVBFILE,DVBQUIT
 ;
 K DVBFILE ; Refresh output array.
 S DVBCNT=1
 S DIC="^DIC(" ; File #1 (file of files)
 S DIC(0)="AEMQ" ; (A)sk  (E)cho  (M)ultiple index  (Q)uestion errs
 S DIC("S")="I '$D(DVBFILE(+Y))" ; Prevent picking the same file
 W !!,"Select file(s) you wish deleted:"
GETFILE1 ; Loop branching label for prompting for multiple files
 S DIC("A")="Select FILE "_DVBCNT_": "
 W !
 D ^DIC I Y<0 S:'$D(DVBFILE) DVBQUIT=1 G GETFILEX
 I '$D(^DIC(+Y,0)) W "   Invalid File ??" G GETFILE1
 ;
 S DVBFILE(+Y)=""
 S DVBCNT=DVBCNT+1
 G GETFILE1
 ;
GETFILEX ; Exit GETFILES
 Q
 ;------------------------------------------------------------------
DELETE(DVBASK,DVBFILE) ; Delete files
 N @($$DIC^DVBAUDNEW1())
 N DIC,DVBFILENUM
 ;
 I DVBASK=2 W !!
 S DVBFILENUM=""
 F  S DVBFILENUM=$O(DVBFILE(DVBFILENUM)) Q:DVBFILENUM=""  D  ;
 . N @($$DIU2^DVBAUDNEW1())
 . ; ZEXCEPT: DIU,DVBQUIT
 . I DVBASK=1 W !!
 . W "FILE: ",$P($G(^DIC(DVBFILENUM,0)),"^",1)
 . D TEMP I DVBQUIT S DVBQUIT=0 Q
 . S DIU=DVBFILENUM
 . D EN^DIU2
 ;
 D CONTINUE^DVBAUDPRT1(2,"R") ; Press <Enter> to continue
 ;
 Q
 ;------------------------------------------------------------------
TEMP ; Delete templates & data?
 ; 
 ; ZEXCEPT: DIU,DVBASK,DVBQUIT
 ;
 I DVBASK=2 S DIU(0)="DT" Q
 S DVBASK=$$ASKYESNO^DVBAUDASK1("Do you want to delete templates","No")
 I DVBASK="^" S DVBQUIT=1 Q
 ;
 S DIU(0)=$S(DVBASK="Y":"DET",1:"DE")
 ;
 Q
