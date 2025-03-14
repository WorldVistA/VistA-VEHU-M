IBJPS3 ;BP/YMG - IB Site Parameters, Pay-To Provider ;20-Oct-2008
 ;;2.0;INTEGRATED BILLING;**400,432,516,577,608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MRD;IB*2.0*516 - Added logic pertaining to TRICARE-Specific Pay-To
 ; Providers, which entailed adding the parameter IBTCFLAG to many
 ; procedures here and in ^IBJPS4.
 ;
EN(IBTCFLAG) ; -- main entry point for IBJP IB PAY-TO PROVIDERS
 D EN^VALM("IBJP IB "_$S(IBTCFLAG:"TRICARE PAY-TO PROVS",1:"PAY-TO PROVIDERS"))
 Q
 ;
HDR(IBTCFLAG) ; -- header code
 ; Not setting VALMHDR causes this tag to be called upon return from every action, 
 ; this is done to keep VALMSG displayed at all times, instead of the default message on the lower bar.
 S VALMSG="* = Default "_$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-to provider"
 Q
 ;
INIT(IBTCFLAG) ; -- init variables and list array
 N IBCNT,IBLN,IBSTR,PIEN,PDATA,IBNODE
 S IBNODE=$$NODE^IBJPS4(IBTCFLAG)
 ;
 S (VALMCNT,IBCNT,IBLN)=0
 S PIEN=0 F  S PIEN=$O(^IBE(350.9,1,IBNODE,PIEN)) Q:'PIEN  D
 .I $P($G(^IBE(350.9,1,IBNODE,PIEN,0)),U,5)'="" Q
 .S PDATA=$$PTG(PIEN,IBTCFLAG),IBCNT=IBCNT+1
 .S IBSTR=$$SETSTR^VALM1(IBCNT_".","",2,4)
 .I $$ISDFLT(PIEN,IBTCFLAG) S IBSTR=$$SETSTR^VALM1("*",IBSTR,7,1)
 .S IBSTR=$$SETSTR^VALM1("Name     : "_$P(PDATA,U),IBSTR,8,45)
 .;S IBSTR=$$SETSTR^VALM1("State   : "_$P(PDATA,U,8),IBSTR,54,25)  ;JRA IB*2.0*577 ';'
 .S IBLN=$$SET(IBLN,IBSTR)
 .;S IBSTR=$$SETSTR^VALM1("Address 1: "_$P(PDATA,U,5),"",8,45)  ;JRA IB*2.0*577 ';'
 .S IBSTR=$$SETSTR^VALM1("Address 1: "_$P(PDATA,U,5),"",8,66)  ;JRA IB*2.0*577 expand to 55 chars
 .;S IBSTR=$$SETSTR^VALM1("Zip Code: "_$P(PDATA,U,9),IBSTR,54,25)  ;JRA IB*2.0*577 ';'
 .S IBLN=$$SET(IBLN,IBSTR)
 .;S IBSTR=$$SETSTR^VALM1("Address 2: "_$P(PDATA,U,6),"",8,45)  ;JRA IB*2.0*577 ';'
 .S IBSTR=$$SETSTR^VALM1("Address 2: "_$P(PDATA,U,6),"",8,66)  ;JRA IB*2.0*577 expand to 55 chars
 .;S IBSTR=$$SETSTR^VALM1("Phone   : "_$P(PDATA,U,4),IBSTR,54,25)  ;JRA IB*2.0*577 ';'
 .S IBLN=$$SET(IBLN,IBSTR)
 .S IBSTR=$$SETSTR^VALM1("City     : "_$P(PDATA,U,7),"",8,45)
 .S IBLN=$$SET(IBLN,IBSTR)
 .;S IBSTR=$$SETSTR^VALM1("Tax ID  : "_$P(PDATA,U,3),IBSTR,54,25)  ;JRA IB*2.0*577 ';'
 .;JRA Move State, Zip Code, Phone and Tax ID under City to allow for longer address lines
 .S IBSTR=$$SETSTR^VALM1("State    : "_$P(PDATA,U,8),IBSTR,8,25)  ;JRA IB*2.0*577
 .S IBLN=$$SET(IBLN,IBSTR)  ;JRA IB*2.0*577
 .S IBSTR=$$SETSTR^VALM1("Zip Code : "_$P(PDATA,U,9),IBSTR,8,25)  ;JRA IB*2.0*577
 .S IBLN=$$SET(IBLN,IBSTR)  ;JRA IB*2.0*577
 .S IBSTR=$$SETSTR^VALM1("Phone    : "_$P(PDATA,U,4),IBSTR,8,25)  ;JRA IB*2.0*577
 .S IBLN=$$SET(IBLN,IBSTR)  ;JRA IB*2.0*577
 .S IBSTR=$$SETSTR^VALM1("Tax ID   : "_$P(PDATA,U,3),IBSTR,8,25)  ;JRA IB*2.0*577
 .S IBLN=$$SET(IBLN,IBSTR),IBLN=$$SET(IBLN,"")
 .S @VALMAR@("ZIDX",IBCNT,PIEN)=""
 .Q
 ;
 I 'IBLN S IBLN=$$SET(IBLN,$$SETSTR^VALM1("No "_$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-To Providers defined.","",13,40))
 ;
 S VALMCNT=IBLN,VALMBG=1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
PRVADD(IBTCFLAG) ; add new pay-to provider
 N X,Y,DIC,DA,DLAYGO,DIE,DR,DIR,DIRUT,DUOUT,DTOUT,IEN,IBNODE
 S IBNODE=$$NODE^IBJPS4(IBTCFLAG)
 D FULL^VALM1
 S VALMBCK="R"
 S DIC="^IBE(350.9,1,"_IBNODE_",",DIC(0)="AELMQ",DA(1)=1,DLAYGO=350.9
 S DIC("A")="Enter "_$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-to Provider: "
 D ^DIC S IEN=+Y
 I IEN'>0 Q
 D PRVEDIT1
 I $P($G(^IBE(350.9,1,IBNODE,IEN,0)),U,2)="" D PRVDEL1
 Q
 ;
PRVDEL(IBTCFLAG) ; delete a pay-to provider
 N DA,DR,DIE,X,Y,DIR,DIRUT,DUOUT,DTOUT,I,IEN,DIVS,DFLT,IBNODE,IBDISP
 S IBNODE=$$NODE^IBJPS4(IBTCFLAG)
 S IBDISP=$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-To Provider"
 S VALMBCK="R"
 D FULL^VALM1
 S IEN=$$SEL(IBTCFLAG) Q:'IEN
 S DFLT=$$ISDFLT(IEN,IBTCFLAG)
 I DFLT W !!,"WARNING: This is the default "_IBDISP_"."
 D GETDIVS^IBJPS4(IEN,.DIVS,IBTCFLAG)
 I 'DFLT D
 .W !!,"The following divisions are currently associated with this "_IBDISP_": "
 .S I="" F  S I=$O(DIVS(I)) Q:I=""  W !,?5,DIVS(I)
 .W:'$D(DIVS) "None",! W !
 .Q
 S DIR("?")="Enter Yes to delete this "_IBDISP_"."
 S DIR("A")="Delete "_IBDISP_" "_$P($G(^IBE(350.9,1,IBNODE,IEN,0)),U,2)
 S DIR(0)="YO",DIR("B")="NO" D ^DIR Q:'Y
 I DFLT S DIE="^IBE(350.9,",DA=1,DR=$S(IBTCFLAG:"11.04",1:"11.03")_"////@" D ^DIE
 I $D(DIVS) K DIK S DIK="^IBE(350.9,1,"_IBNODE_",",DA(1)=1,I="" F  S I=$O(DIVS(I)) Q:I=""  S DA=I D ^DIK
 K DIK
PRVDEL1 ;
 N DIK
 K DA
 S DIK="^IBE(350.9,1,"_IBNODE_","
 S DA(1)=1,DA=IEN
 D ^DIK
 D CLEAN^VALM10,INIT(IBTCFLAG)
 Q
 ;
PRVEDIT(IBTCFLAG) ; edit existing pay-to provider
 N IEN,IBNODE
 S IBNODE=$$NODE^IBJPS4(IBTCFLAG)
 S VALMBCK="R"
 D FULL^VALM1
 S IEN=$$SEL(IBTCFLAG) Q:'IEN
PRVEDIT1 ;
 N DIE,DA,DR,DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIE="^IBE(350.9,1,"_IBNODE_","
 S DA=IEN,DA(1)=1
 S DR=".02T;1.01T;1.02T;1.03T;1.04T;1.05T;.04T;.03T;.05///@"
 D ^DIE
 S DIR("?")="Enter Yes to make this entry the default "_$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-to Provider."
 S DIR("A")="Is this the default "_$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-To Provider"
 S DIR(0)="YO"
 S DIR("B")="YES" I $$GETDFLT(IBTCFLAG),'$$ISDFLT(IEN,IBTCFLAG) S DIR("B")="NO"
 D ^DIR I Y K DA S DIE="^IBE(350.9,",DA=1,DR=$S(IBTCFLAG:"11.04",1:"11.03")_"////"_IEN D ^DIE
 D CLEAN^VALM10,INIT(IBTCFLAG)
 Q
 ;
SET(IBLN,IBSTR) ; add a line to display list
 ; returns line number added
 S IBLN=IBLN+1 D SET^VALM10(IBLN,IBSTR)
 Q IBLN
 ;
ISDFLT(PIEN,IBTCFLAG) ; returns 1 if provider with ien PIEN is the default pay-to provider, 0 otherwise
 Q:PIEN="" 0
 Q $$GETDFLT(IBTCFLAG)=PIEN
 ;
GETDFLT(IBTCFLAG) ; returns ien of default pay-to provider
 Q $P($G(^IBE(350.9,1,11)),U,$S(IBTCFLAG:4,1:3))
 ;
SEL(IBTCFLAG) ; select pay-to provider
 ; returns ien of selected pay-to provider, or 0 if nothing is selected
 N DIR,IEN,MAX,X,Y
 S IEN=0
 I VALMLST>4 D
 . ; there is at least one entry
 . S MAX=$O(@VALMAR@("ZIDX",""),-1) S:MAX=1 Y=1
 . I MAX>1 D
 . . S DIR("A")="Select "_$S(IBTCFLAG:"Non-MCCF ",1:"")_"Pay-To Provider (1-"_MAX_"): "
 . . S DIR(0)="NA^"_1_":"_MAX_":0"
 . . D ^DIR
 . . Q
 . S:+Y>0 IEN=$O(@VALMAR@("ZIDX",Y,""))
 . Q
 Q +IEN
 ;
PRVDATA(IBIFN) ; Return a string of Pay-To provider information in the following format
 ;  [1] name
 ;  [2] npi
 ;  [3] tax id#
 ;  [4] phone#
 ;  [5] street 1
 ;  [6] street 2
 ;  [7] city
 ;  [8] state abbreviation
 ;  [9] zip
 ; [10] list of IB error messages if any of this data is missing in IBXX1;IBXX2;IBXX3;IBXX4; format
 ; [11] Institution (File 4) ien
 ;
 ; **NOTE:  pieces 12,13,14 are added to this string in output formatter data element #1624 for PRV1-1.5 for PRV1
 ; pieces 2,3,5.  If pieces are added here to this string, then adjust the code in PRV1-1.5,2,3,5 accordingly.
 ;
 N DATA,IB0,EVDT,IBDIV,INST,PIEN,IBER,IBTCFLAG
 S DATA="",IBER=""
 ;
 S IBTCFLAG=$$TRICARE^IBJPS4(IBIFN) ; Set IBTCFLAG to '1' if TRICARE claim, otherwise '0'.
 ;
 S IB0=$G(^DGCR(399,IBIFN,0))
 S EVDT=$P(IB0,U,3)                             ; event date on claim
 I 'EVDT S EVDT=DT
 S IBDIV=+$P(IB0,U,22)                          ; division on claim
 I 'IBDIV S IBDIV=$$PRIM^VASITE(EVDT)
 I IBDIV'>0 S IBDIV=$$PRIM^VASITE()
 I IBDIV'>0 G PRVDATX                           ; get out if no division
 S INST=+$$SITE^VASITE(EVDT,IBDIV)              ; inst file 4 pointer
 I INST'>0 S INST=+$$SITE^VASITE(DT,IBDIV)
 I INST'>0 S INST=+$$SITE^VASITE()
 I INST'>0 G PRVDATX                            ; get out if no institution
 ;
 ; check to see if this institution exists as a separate Pay-To Provider subfile entry
 S PIEN=+$O(^IBE(350.9,1,$S(IBTCFLAG:29,1:19),"B",INST,""))
 ;
 I 'PIEN D  G PRVDATX      ; this institution does not exist in 350.9004/350.929.
 . ; check to see if the default Pay-To provider information is defined (350.9;11.03/11.04)
 . S PIEN=+$P($G(^IBE(350.9,1,11)),U,$S(IBTCFLAG:4,1:3)) Q:'PIEN
 . S DATA=$$PTG(PIEN,IBTCFLAG)
 . Q
 ;
 ; here PIEN exists and the institution pointer was found in the 350.9004 subfile
 ; find parent pay-to provider
 S PIEN=$$GETPROV^IBJPS4(PIEN,IBTCFLAG) S:PIEN DATA=$$PTG(PIEN,IBTCFLAG)
 ;
PRVDATX ;
 I DATA="" S IBER=IBER_"IB177;",$P(DATA,U,10)=IBER
 Q DATA
 ;
PTG(PIEN,IBTCFLAG) ; gather pay-to provider info
 N N0,N1,IBORG,NPI,STIEN,STATE,Z,IBER,IBNODE
 ;
 S IBNODE=$$NODE^IBJPS4(+$G(IBTCFLAG))
 ;
 S Z="",IBER="",PIEN=+$G(PIEN)
 ;
 I '$D(^IBE(350.9,1,IBNODE,PIEN)) S IBER=IBER_"IB177;",$P(Z,U,10)=IBER G PTGX
 S N0=$G(^IBE(350.9,1,IBNODE,PIEN,0))
 S N1=$G(^IBE(350.9,1,IBNODE,PIEN,1))
 ;
 ; get the NPI# from the Institution file
 S IBORG=+$P(N0,U,1),NPI=""
 I IBORG S NPI=$P($$NPI^XUSNPI("Organization_ID",IBORG),U,1)
 ;
 ; get the state abbreviation
 S STIEN=+$P(N1,U,4),STATE=""
 I STIEN S STATE=$$GET1^DIQ(5,STIEN_",",1)
 ;
 ; check for missing data
 I '$L($P(N0,U,2)) S IBER=IBER_"IB178;"     ; missing name
 I NPI'>0 S IBER=IBER_"IB179;"              ; missing npi
 ; Patch 432 enh5:  The IB system shall no longer prevent users from authorizing (fatal error message) a claim because the system can not find the human providers SSN or EIN
 ;I '$L($P(N0,U,3)) S IBER=IBER_"IB180;"     ; missing tax ID
 I '$L($P(N1,U,1))!'$L($P(N1,U,3))!'$L(STATE)!'$L($P(N1,U,5)) S IBER=IBER_"IB181;"     ; missing address part(s)
 ;
 S Z=$P(N0,U,2)_U_NPI_U_$P(N0,U,3)_U_$P(N0,U,4)_U_$P(N1,U,1)_U_$P(N1,U,2)_U_$P(N1,U,3)_U_STATE_U_$P(N1,U,5)_U_IBER_U_IBORG
PTGX ;
 Q Z
 ;
PRVPHONE(IBIFN) ; Return Pay-to provider phone# for a given claim
 ; IBIFN - internal claim# (optional parameter)
 ; If IBIFN is not passed in, then the phone# from the default pay-to provider entry will be returned.
 ; For example, AR option 'EDI Lockbox 3rd Party Exceptions' needs the phone# for the process of transfering an
 ; EEOB to another site, but the claim# is not available to this process.
 N PTPP,PIEN
 S PTPP=""
 I +$G(IBIFN) S PTPP=$P($$PRVDATA(IBIFN),U,4) G PRVPHNX
 ;
 S PIEN=+$P($G(^IBE(350.9,1,11)),U,3) I 'PIEN G PRVPHNX   ; no claim#, default pay-to provider
 S PTPP=$P($$PTG(PIEN),U,4)                               ; phone#
 ;
PRVPHNX ;
 Q PTPP
 ;
DEF(INST,DA,IBTCFLAG) ; This procedure is called by new style x-ref in
 ; order to default name and address fields.
 ; INST - IEN to file #4, Institution.  This is the value in the .01
 ;      field of the Pay-to or TRICARE Pay-to Providers sub-fil.
 ; DA - DA array as passed in from FileMan.  DA(1) should equal 1 since
 ;      this is the IB site params and there is only 1 entry.  DA should
 ;      equal the IEN to the pay-to provider multiple entry
 ; This procedure is called only if a new institution is being added to
 ; the sub-file or an entry in the sub-file is being changed from one
 ; institution to another.
 ;
 NEW NAD,IENS,ST,STIEN,IBTAXID,IBFILE
 ;
 I '$G(INST) G DEFX
 ;
 I IBTCFLAG S IBFILE=350.929
 E  S IBFILE=350.9004
 ;
 S ST=$$WHAT^XUAF4(INST,.02)             ; full state name
 S STIEN=$$FIND1^DIC(5,,"BX",ST,"B")     ; state ien
 ;
 ; if the selected pay-to provider institution is the same as the main
 ; facility name field from the IB site parameters, then also default
 ; the federal tax ID# from the IB site parameters into the pay-to
 ; provider tax ID# field.
 S IBTAXID=""
 I INST=$P($G(^IBE(350.9,1,0)),U,2) S IBTAXID=$P($G(^IBE(350.9,1,1)),U,5)
 ;
 S IENS=DA_",1,"
 S NAD(IBFILE,IENS,.02)=$$WHAT^XUAF4(INST,100)     ; official VA name
 S NAD(IBFILE,IENS,.03)=IBTAXID                    ; tax#
 S NAD(IBFILE,IENS,.04)=""                         ; phone# - blank it out
 S NAD(IBFILE,IENS,.05)=""                         ; parent - blank it out
 S NAD(IBFILE,IENS,1.01)=$$WHAT^XUAF4(INST,1.01)   ; address line 1
 S NAD(IBFILE,IENS,1.02)=$$WHAT^XUAF4(INST,1.02)   ; address line 2
 S NAD(IBFILE,IENS,1.03)=$$WHAT^XUAF4(INST,1.03)   ; city
 I STIEN S NAD(IBFILE,IENS,1.04)=STIEN             ; state
 S NAD(IBFILE,IENS,1.05)=$$WHAT^XUAF4(INST,1.04)   ; zip
 D FILE^DIE(,"NAD")
DEFX ;
 Q
 ;
DIFF(IBIFN,EDI) ; This function will determine if there are any differences between
 ; the Billing Provider name and address and the Pay-to Provider name and address.
 ; When these two are the same, then the Pay-to Provider information is
 ; suppressed and is not printed or transmitted.
 ; This function returns a 1 if differences are found, and 0 if they are the same.
 ;
 ; EDI=1 if this is being called for the electronic claim transmission
 ; EDI=0 if this is being called for the printed UB-04 claim form
 ;
 N BPZ,PTP,DIFF,BPNAME,BPAD1,BPAD2,BPCITY,BPST,BPZIP,IBZ
 S DIFF=0,EDI=+$G(EDI)
 S BPZ=+$$B^IBCEF79(IBIFN)            ; billing provider ien to file 4
 S PTP=$$UP^XLFSTR($$PRVDATA(IBIFN))  ; pay-to provider information
 ;
 ; for EDI claims, use the GETBP utility to get the billing provider data
 I EDI D
 . D GETBP^IBCEF79(IBIFN,"",BPZ,"DIFF",.IBZ)
 . S BPNAME=$$UP^XLFSTR($G(IBZ("DIFF","NAME")))
 . S BPAD1=$$UP^XLFSTR($G(IBZ("DIFF","ADDR1")))
 . S BPAD2=$$UP^XLFSTR($G(IBZ("DIFF","ADDR2")))
 . S BPCITY=$$UP^XLFSTR($G(IBZ("DIFF","CITY")))
 . S BPST=$$UP^XLFSTR($G(IBZ("DIFF","ST")))
 . S BPZIP=$$NOPUNCT^IBCEF($$UP^XLFSTR($G(IBZ("DIFF","ZIP"))))
 . Q
 ;
 ; for printed UB claims, use the Institution file for FL-1 data
 I 'EDI D
 . S BPNAME=$$UP^XLFSTR($$GETFAC^IBCEP8(BPZ,0,0))
 . S BPAD1=$$UP^XLFSTR($$GETFAC^IBCEP8(BPZ,0,1))
 . S BPAD2=$$UP^XLFSTR($$GETFAC^IBCEP8(BPZ,0,2))
 . S BPCITY=$$UP^XLFSTR($$GETFAC^IBCEP8(BPZ,0,"3C"))
 . S BPST=$$UP^XLFSTR($$GETFAC^IBCEP8(BPZ,0,"3S"))
 . S BPZIP=$$NOPUNCT^IBCEF($$UP^XLFSTR($$GETFAC^IBCEP8(BPZ,0,"3Z")))
 . Q
 ;
 I BPNAME'=$P(PTP,U,1) S DIFF=1 G DIFFX
 I BPAD1'=$P(PTP,U,5) S DIFF=1 G DIFFX
 I BPAD2'=$P(PTP,U,6) S DIFF=1 G DIFFX
 I BPCITY'=$P(PTP,U,7) S DIFF=1 G DIFFX
 I BPST'=$P(PTP,U,8) S DIFF=1 G DIFFX
 I BPZIP'=$$NOPUNCT^IBCEF($P(PTP,U,9)) S DIFF=1 G DIFFX
DIFFX ;
 Q DIFF
 ;
MAINPRV(IBTCFLAG) ; Return Pay-To provider information for main VAMC
 N DATA,IBER,IEN4,PIEN,IBNODE
 S IBNODE=$$NODE^IBJPS4(IBTCFLAG)
 S (DATA,IBER)="",IEN4=+$$SITE^VASITE I 'IEN4 G MAINPRVX
 S PIEN=$O(^IBE(350.9,1,IBNODE,"B",IEN4,"")) I 'PIEN G MAINPRVX
 I $P($G(^IBE(350.9,1,IBNODE,PIEN,0)),U,5)'="" G MAINPRVX   ; if this sub-entry is not a pay-to provider, then get out
 S DATA=$$PTG(PIEN,IBTCFLAG)
MAINPRVX ;
 I DATA="" S IBER=IBER_"IB177;",$P(DATA,U,10)=IBER
 Q DATA
 ;
