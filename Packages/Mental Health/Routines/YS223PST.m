YS223PST ;SLC/KCM - Patch 223 Post-init ; 12/10/2020
 ;;5.01;MENTAL HEALTH;**223**;Dec 30, 1994;Build 22
 ;
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 D ADDRPC("YTQRCRD DLL")
 D SETURL
 D SETPROPS
 Q
 ;
SETURL ; set the CPRS DLL URL for this environment
 N SITE,PREFIX,VERSION,URL
 S SITE=$$STA^XUAF4($$KSP^XUPARAM("INST")),VERSION=""
 S PREFIX=$S($$PROD^XUPROD:"",1:"test.")
 S URL="https://"_PREFIX_"mha.domain.ext/"_VERSION_"assignment/cprs/"_SITE_"/"
 D EN^XPAR("SYS","YSCPRS DLL URL",1,URL)
 Q
SETPROPS ; save the current CPRS DLL properties to allow switching
 N WNDNM,WNDVER,WEBNM,WEBVER
 S WNDNM=$$GET^XPAR("SYS","YSCPRS DLL SAVE",1)
 ; save name of Windows DLL if first-time install
 I '$L(WNDNM) D
 . S WNDNM=$$GET^XPAR("SYS","YS MHA_A DLL NAME")
 . ; if this account is already set to web DLL (unlikely) --
 . I $E(WNDNM,1,12)="YS_MHA_A_WEB" S WNDNM="YS_MHA_A_XE10.dll"
 . D EN^XPAR("SYS","YSCPRS DLL SAVE",1,WNDNM)
 ; save version of Windows DLL if first-time install
 S WNDVER=$$GET^XPAR("SYS","YSCPRS DLL SAVE",2)
 I '$L(WNDVER) D
 . N VERDATA,YS
 . S YS("YSB")="YS BROKER1"
 . D VERSRV^YTQAPI7(.VERDATA,.YS)
 . S WNDVER=$G(VERDATA(3))
 . ; if this account already has web DLL version (unlikely) --
 . I WNDVER="1.0.5.14" S WNDVER="1.0.5.12" ; assuming CPRS 32b or 32c
 . D EN^XPAR("SYS","YSCPRS DLL SAVE",2,WNDVER)
 ; set the default web DLL name if first-time install
 S WEBNM=$$GET^XPAR("SYS","YSCPRS DLL SAVE",3)
 I '$L(WEBNM) D EN^XPAR("SYS","YSCPRS DLL SAVE",3,"YS_MHA_A_WEB.dll")
 ; set the default web DLL version if first-time install 
 S WEBVER=$$GET^XPAR("SYS","YSCPRS DLL SAVE",4)
 I '$L(WEBVER) D EN^XPAR("SYS","YSCPRS DLL SAVE",4,"1.0.5.14")
 Q
ADDRPC(YTRPC) ; Add RPC to YS BROKER1
 N YTOPT,YTIEN,YTERR,YTFDA
 S YTOPT=$$LKOPT^XPDMENU("YS BROKER1") QUIT:'YTOPT
 S YTIEN=$$FIND1^DIC(19.05,","_YTOPT_",","B",YTRPC,"","","YTERR") QUIT:YTIEN
 I $D(YTERR) D MES^XPDUTL("Find RPC: "_$G(YTERR("DIERR",1,"TEXT",1))) QUIT
 S YTFDA(19.05,"+1,"_YTOPT_",",.01)=YTRPC
 D UPDATE^DIE("E","YTFDA","","YTERR")
 I $D(YTERR) D MES^XPDUTL("Add RPC: "_$G(YTERR("DIERR",1,"TEXT",1)))
 Q
