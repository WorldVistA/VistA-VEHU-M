YTQRCRT ;SLC/KCM - MH Reminder Dialog DLL Tools ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**223**;Dec 30, 1994;Build 22
 ;
DLLTGL ; Used by option, YS223 TOGGLE WEB DLL
 ; YS CPRS DLL SAVE stores the following on first install of patch 223
 ;   1:InitialName
 ;   2:InitialVersion
 ;   3:WebName
 ;   4:WebVersion
 N WNDNM,WNDVER,WEBNM,WEBVER,CURNM,CURVER,VERDATA,YS,DIR,DIRUT,DUOUT,X,Y
 S WNDNM=$$GET^XPAR("SYS","YSCPRS DLL SAVE",1)
 S WNDVER=$$GET^XPAR("SYS","YSCPRS DLL SAVE",2)
 S WEBNM=$$GET^XPAR("SYS","YSCPRS DLL SAVE",3)
 S WEBVER=$$GET^XPAR("SYS","YSCPRS DLL SAVE",4)
 S YS("YSB")="YS BROKER1"
 D VERSRV^YTQAPI7(.VERDATA,.YS)
 S CURVER=$G(VERDATA(3))
 S CURNM=$$GET^XPAR("SYS","YS MHA_A DLL NAME")
 I CURVER=WEBVER D
 . W !!,"The web version of the Mental Health DLL for CPRS is currently ENABLED."
 . W !,"The previous version was ",WNDVER," ("_WNDNM_")."
 . W !,"DISABLE the WEB version and reinstate the previous version?"
 . S DIR(0)="Y",DIR("B")="NO" D ^DIR
 . I Y D SETVER(WNDVER,WNDNM) W !,"done"
 E  D
 . W !!,"The web version of the Mental Health DLL for CPRS is currently DISABLED."
 . W !,"The web version is ",WEBVER," ("_WEBNM_")."
 . W !,"ENABLE the WEB version and stop using the current version?"
 . S DIR(0)="Y",DIR("B")="YES" D ^DIR
 . I Y D SETVER(WEBVER,WEBNM) W !,"done"
 Q
SETVER(NEWVER,NEWNM) ; set DLL version and name
 N YTERR
 D UPDVER^YTQAPI7(2,NEWVER)
 D EN^XPAR("SYS","YS MHA_A DLL NAME",1,NEWNM,.YTERR)
 I YTERR W !,"Error updating DLL name to "_NEWNM
 Q
