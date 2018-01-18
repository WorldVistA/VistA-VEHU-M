EVETR1 ;DALOI/KML - Procedure for HEALTH eVAULT rEGISTRATION option - Master Control ; 4/2/03 3:44pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;;get site specific data from file 9/12/02 - lel
 ;
 ;;usage of $$SITE^VASITE supported by IA #10112
 ;usage of TFL^VAFCTFU1 supported by IA #2990
 ;usage of $$GETICN^MPIF001 supported by IA #2701
 ;usage of MPIQ^MPIFAPI supported by subscription to IA #2748
 ;
 ;
ENTER ; ENTER EDIT REGISTRATION
 ;
 N DLAYGO,DIC,DIR,DIE,X,Y,EVRESP,EVETICN,EVETDA,EVLOOP,EVICNMSG,EVACTIV,EVTFLST,DA,DR,DFN,EVETERR,EVETNM,EVETSITE,FDA
 N EVUSRNM,EVFN,EVLN,EVEMAIL,EVPASSWD,EVETDFN,EVTSITE,EVTSITEN
 N EVTMP  ;replaces ^TMP global with passed array of data
 N X,Y  ;- dummy variables
 S X="ERR^EVETR1",@^%ZOSF("TRAP")
 S (X,Y,EVTSITE,EVTSITEN)=""
 D SITEPRMS^EVETU1(.X,.Y,.EVTSITE,.EVTSITEN)
 I $D(EVETSITE)=0 S EVETSITE=$P($$SITE^VASITE,U) D
 . I EVETSITE="" W !,"Site not defined" Q  ;NO SITE NO REGISTRATION
 S (DIC,DLAYGO)=2275
 S DIC("A")="Enter Veteran name: ",DIC(0)="QEALM"
 D ^DIC K DLAYGO I X["^"!(X="") Q
 I $D(Y)=0 G ENTER
 I +Y<0 W "Entry not found..." G ENTER
 S EVETDA=+Y,EVETDFN=$P(Y,U,2)
 L +^EVET(2275,EVETDA):0 ;lock file entry
 I '$T W !?5,"Another user is editing this entry. Try editing at a later time." Q
 D GETICN S EVACTIV=$S('$D(EVETICN):"N",1:"Y")
 S DA=EVETDA,DR=".01;.02;.04:.06",(DIC,DIE)=2275
 D ^DIE I X["^" Q
 S FDA(1,2275,EVETDA_",",.03)=EVACTIV  ; file active status silently
 S FDA(1,2275,EVETDA_",",.07)=DUZ  ;file entered by
 D FILE^DIE("","FDA(1)","")
W L -^EVET(2275,EVETDA)
 W !
 Q:'$D(EVETICN)  ; registration does not occur. Status is inactive.
 D TFL^VAFCTFU1(.EVTFLST,EVETDFN)  ; get list of treating facilities
 I +EVTFLST(1)<1 S EVTFLST(1)=$P($$SITE^VASITE,U,1,2)
 ;get test site specific values
 ;the next line is for non-production account testing...
 I EVTSITE="Y" K EVTFLST S EVTFLST(1)=EVTSITEN
 ;I EVTSITE="Y" K EVTFLST S EVTFLST(1)=99996
 ;end of mod
 D BLDMSG
 D CALLPROC  ;job routine to tx data to server
 S EVETERR=0
 W !!?5,"Transmitting Veteran's registration information"
 W !?5,"to Health eVet.  Could take up to 2 minutes or longer"
 W !?5,"to receive a response."
 F EVLOOP=1:1:60 D GETRESP Q:$D(EVRESP)  H 2  ;check for incoming response
 I '$D(EVRESP) D NOCOMM,RESET^EVETU1(EVETDA,EVACTIV,EVRESP)
 ;give user option of printing information
 D EVPRINT
 Q
 ;
GETICN ;
 ;get the ICN from the MPI
 ;MPI QUERY
 W !!?5,"Retrieving the Veteran's ICN.",!
 K MPIFRTN
 S DFN=EVETDFN
 D MPIQ^MPIFAPI(DFN)  ;ensure ICN will be coming from MPI
 K MPIFRTN
 ; 
 S EVETICN=$$GETICN^MPIF001(EVETDFN)
 I $P(EVETICN,U)'>0 W !?5,$P(EVETICN,U,2) K EVETICN S EVICNMSG="An ICN has not been assigned to the Veteran." D ICNERR Q
 ;following line is only to be used in production ie: EVTSITE="N" - lel
 I (EVTSITE="N")&($E(EVETICN,1,3)=$P($$SITE^VASITE,"^",3)) K EVETICN S EVICNMSG="A National ICN has not been assigned to the Veteran." D ICNERR Q
 ;example of National ICN ="1000720100V271387"
 Q
 ;
BLDMSG ;
 N EVRTN,EVETX
 S EVRTN="EVETR1",EVETX=""
 ;S EVTMPGBL="^TMP(EVRTN,$J,EVETDA)"
 K EVETZ
 D GETS^DIQ(2275,EVETDA_",",".01:.06","E","EVETZ","")
 S EVETNM=EVETZ(2275,EVETDA_",",.01,"E"),EVFN=$P(EVETNM,",",2),EVLN=$P(EVETNM,",")
 S (EVUSRNM,EVTMP("user_name"))=EVETZ(2275,EVETDA_",",.04,"E")
 S (EVPASSWD,EVTMP("password"))=EVETZ(2275,EVETDA_",",.05,"E")
 S EVTMP("first_name")=$P(EVFN," ")
 S EVTMP("middle_initial")=$P(EVFN," ",2)
 S EVTMP("last_name")=EVLN
 S (EVEMAIL,EVTMP("email"))=EVETZ(2275,EVETDA_",",.06,"E")
 S EVTMP("icn")=EVETICN
 ;S EVTMP("activation site_number")=$C(34)_$P(EVTFLST(1),U,1)_$C(34)
 F  S EVETX=$O(EVTFLST(EVETX)) Q:EVETX=""  D
 . S EVTMP("site_number",EVETX)=$P(EVTFLST(EVETX),U,1,2)
 I $D(^EVET(2275,EVETDA,2)) K ^EVET(2275,EVETDA,2)
 I $D(^EVET(2275,EVETDA,1)) K ^EVET(2275,EVETDA,1)
 Q
 ;
CALLPROC ;initiate call to EVETLIR routine
 N ZZEN,ZTSAVE,ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 K ZTSAVE S ZTSAVE("ZZEN")=""
 K ZTIO S ZTIO=""
 S ZTDESC="EVET REG TO SERVER"
 S ZTRTN="EN^EVETLIR("_$J_")"
 S ZTSAVE("EVTMP*")=""
 S ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
GETRESP ; process Health eVet response to VistA transmission of 
 ; registration message
 W ".. "
 I EVLOOP=15!(EVLOOP=30)!(EVLOOP=45) W !,"Waiting for Health eVet response"
 ;Q:'$D(^TMP("EVETR1_ACTIVATION_RESPONSE"))
 Q:'$D(^EVET(2275,EVETDA,2))
 S EVRESP=^EVET(2275,EVETDA,2)
 ;N EVIJOB
 ;S EVIJOB=0 F  S EVIJOB=$O(^TMP("EVETR1_ACTIVATION_RESPONSE",EVIJOB)) Q:EVIJOB<1  Q:$D(EVRESP)  I $D(^TMP("EVETR1_ACTIVATION_RESPONSE",EVIJOB,EVETDFN)) S EVRESP=^(EVETDFN) D
 W !!,"Health eVet response to transmission of the"
 W !,"Veteran's registration information >>> "_EVRESP,!
 I $P(EVRESP,":")["Err" D USRERR,RESET^EVETU1(EVETDA,EVACTIV,EVRESP)
 I $P(EVRESP,":")["Ok" D USRINFO
 ;K ^TMP("EVETR1_ACTIVATION_RESPONSE",EVIJOB,EVETDFN)
 Q
 ;
USRINFO ; activation successful
 W !?15,"***************************************"
 W !!?15,"Veteran has been activated to Health eVet."
 W !!?15,"Veteran's name: ",EVETNM
 W !?15,"Username: ",EVUSRNM
 W !?15,"Password: ",EVPASSWD
 W !?15,"Email: ",EVEMAIL
 W !?15,"Please write down above information.",!
 W !?15,"The Veteran will need this information"
 W !?15,"for Health eVet account access.",!
 W !?15,"It must be noted that due to security and privacy issues,"
 W !?15,"the Veteran will need to change the password"
 W !?15,"on initial logon to Health eVet account."
 W !!?15,"**************************************",!
 S EVRESP="",EVACTIV="Y"
 Q
 ;
 ;
USRERR ; activation not successful;  below list of error messages returned
 ; "Error: could not load xml"
 ; "Error: activation node is missing" 
 ; "Error: some of the required information is missing"
 ; "Error: failed to perform user registration"
 ; "Error: failed to perform registration for sites" with list of sites
 W !?15,"***************************************"
 W !!?15,"Activation to Health eVet did not occur."
 W !!?15,"Veteran's name: ",EVETNM
 W !!?15,"Assigned ICN: ",EVETICN
 W !?15,"Please contact the Health eVet Administrator"
 W !?15,"for action to be taken."
 W !!?15,"**************************************"
 S EVRESP=$P(EVRESP,":",2),EVACTIV="N"
 Q
 ;
NOCOMM ; activation not successful: no response from Health eVet
 W !?15,"***************************************"
 W !!?15,"Activation to Health eVet may not have occurred."
 W !?15,"VistA has not yet received the Health eVet response"
 W !?15,"to Veteran information transmission."
 W !?15,"To check for updates on outstanding incoming response"
 W !?15,"transmissions from Health eVet, please use the EVET option"
 W !?15,"that checks for updates on these incoming responses."
 W !!?15,"**************************************"
 S EVACTIV="N",EVRESP="Health eVet has not acknowledged VistA transmission" ; this reason description is stored in file 2275
 Q
 ;
ICNERR ; transmission to Health eVet did not occur because ICN was not 
 ; assigned to veteran
 W !?15,"***************************************"
 W !!?5,"Activation to Health eVet will not occur."
 W !?5,EVICNMSG
 W !?5,"Activation to Health eVet will not occur unless Veteran has a valid ICN."
 W !?5,"However, registration of the Veteran's information to the VistA"
 W !?5,$P(^EVET(2275,0),U)_" may still be performed."
 W !!?15,"***************************************"
 Q
 ;
EVPRINT ;give user the option to print information
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")="PRINT THE REGISTRATION INFORMATION: ",DIR("B")="Y"
 D ^DIR
 I ($E(X)="Y")!($E(X)="y") D EN2^EVETR4(EVETDFN,EVETNM)
 Q
ERR ;
 D ^%ZTER
 Q
