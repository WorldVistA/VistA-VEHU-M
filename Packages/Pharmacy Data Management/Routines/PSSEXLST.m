PSSEXLST ; SLC/SS - One-time administration schedules excluded from start stop dates modifications ;Jan 09, 2024@15:08:20
 ;;1.0;PHARMACY DATA MANAGEMENT;**259**;9/30/97;Build 6
 ;
 ; Reference to SITE^VASITE in ICR #10112
 ; Reference to ^DIC(4 in ICR #10090
 ; Reference to ^XTV(8989.51,"B", in ICR #2992
 ; Reference to EDITPAR^XPAREDIT in ICR #2336
 ; Reference to ^SC( in ICR #10040
 ; Reference to ^DIC(4.2 in ICR #1966
 ; Reference to ENVAL^XPAR in ICR #2263
 ; Reference to GET1^DIQ in ICR #2056
 ; Reference to ^DIR in ICR #10026
 ; Reference to ^SC(IEN,42 in ICR #10040
 ;
EN ;set One-time administration schedules excluded from start stop dates modifications for division and site
 N DIR,X,Y
 W @IOF
 W "ONE-TIME administration schedules that would be excluded"
 W !,"from start/stop date and time modifications in CPRS.",!
 S DIR(0)="SO^E:Edit exclusion ONE-TIME items from start/stop modification;D:Display excluded ONE-TIME administration schedules"
 S DIR("A")="Enter Selection"
 D ^DIR
 I Y="E" D ENTER G EN
 I Y="D" D DSPLY G EN
 Q
 ;
ENTER ; Enter One-time administration schedules excluded from start stop dates modifications for Division and Site"
 N PARAM
 S PARAM=$O(^XTV(8989.51,"B","PSS EXCLUDE 1TIME STRSTP MODS",""))
 I PARAM="" Q  ;parameter doesn't exist
 D EDITPAR^XPAREDIT(+PARAM)
 Q
 ;
DSPLY ; Display parameter for Division and System
 N DIR,Y,X,FLR,PARAM,LOCTYP,LOCNAM,ORARY,HDCON,SCHED
 W !
 S DIR(0)="SO^D:Divisions;S:Systems;A:All"
 S DIR("A")="Enter Selection"
 D ^DIR
 I Y=""!(Y="^")!($G(DIRUT)) K DIRUT Q
 S FLR=$S(Y="D":4,Y="S":4.2,1:0)
 S PARAM=$O(^XTV(8989.51,"B","PSS EXCLUDE 1TIME STRSTP MODS",""))
 I PARAM="" Q  ;parameter doesn't exist
 S HDCON=0
 D GETDATA(.ORARY)
 I '$G(ORARY) W !,"Nothing to display" I $$PRESSKEY() Q
 D HDR
 S LOCTYP="" F  S LOCTYP=$O(ORARY(LOCTYP)) Q:LOCTYP=""  D
 . S LOCNAM="" F  S LOCNAM=$O(ORARY(LOCTYP,LOCNAM)) Q:LOCNAM=""  D
 .. S SCHED="" F  S SCHED=$O(ORARY(LOCTYP,LOCNAM,SCHED)) Q:SCHED=""  D
 ... I $Y+5>IOSL W ! Q:$$PRESSKEY()  D HDR
 ... N DISP S DISP=$G(ORARY(LOCTYP,LOCNAM,SCHED))
 ... W !,LOCTYP,?14,LOCNAM,?43,$P(DISP,U),?58,$P(DISP,U,3)
 I $$PRESSKEY()
 Q
 ;
GETDATA(ORARY) ; Sort and filter entries for display
 N ENT,VAL,CNT,LOCNAME,ORLST,PREF
 S CNT=0,ENT="",ORARY=0
 D GET I '$G(ORLST) Q
 F  S ENT=$O(ORLST(ENT)) Q:ENT=""  D
 . N FILENO,IEN
 . S FILENO=+$P(ENT,"DIC(",2)
 . I FLR>0,FLR'=FILENO Q
 . S LOCNAME=$$GET1^DIQ(FILENO,+ENT,.01)
 . S CNT=0
 . F  S CNT=$O(ORLST(ENT,CNT)) Q:CNT=""  D
 .. S IEN=+$G(ORLST(ENT,CNT))
 .. Q:IEN=0
 .. S VAL=$$GET1^DIQ(51.1,IEN,.01)
 .. S PREF=$$GET1^DIQ(51.1,IEN,4)
 .. S ORARY=ORARY+1,ORARY($S(FILENO=4:"Division",FILENO=4.2:"System",1:"Unknown"),$E(LOCNAME,1,27),IEN)=$E(VAL,1,24)_U_PREF_U_CNT
 Q
 ;
HDR ; header
 W @IOF
 W "Location type",?14,"Location Name",?43,"Schedule",?58,"Entry #"
 W !,"-------------",?14,"----------------------------",?43,"--------------",?58,"-------"
 Q
 ;
GET ; get the values for parameter PSS EXCLUDE 1TIME STRSTP MODS
 D ENVAL^XPAR(.ORLST,"PSS EXCLUDE 1TIME STRSTP MODS")
 Q
 ;
 ;Prevents duplicates - validates if the parameter value was already added in the multiple
 ; PSSVAL - the IEN of #51.1 selected/entered (e.g. 79)
 ; PSSENT - entity (e.g. "400;DIC(4.2,")
 ; CURINST - the entry # of the multiple, that the user has selected to add a new value
 ;returns
 ; 1 -passed (can be added)
 ; 0 -failed (cannot be added)
 ;Example of usage "I '$$VALIDAT^PSSEXLST(+Y,ENT,INST) K X"
VALIDAT(PSSVAL,PSSENT,CURINST) ;
 I PSSVAL=0,PSSENT="" Q 0
 N PSSINST
 N PSSLST D ENVAL^XPAR(.PSSLST,"PSS EXCLUDE 1TIME STRSTP MODS")
 S PSSINST=+$$IFEXISTS(.PSSLST,PSSENT,PSSVAL)
 ; if found and the user does NOT confirm the same entry (INST) then we cannot add a duplicate
 I PSSINST,PSSINST'=CURINST W !,"Was added previously." Q 0
 Q 1
 ;
 ;Do we have this value in the specified ENTITY in the multiple?
 ;Parameters:
 ; PSSLST - arrays with the content of parameter received by using ENVAL^XPAR
 ; PSSENTIT  - entity (e.g. "400;DIC(4.2,")
 ; PSSVAL - the IEN of #51.1 selected/entered (e.g. 79)
 ;Returns:
 ; not found : 0
 ; if found : instance # ^ PSSENTIT (e.g. "79^400;DIC(4.2,"
IFEXISTS(PSSLST,PSSENTIT,PSSVAL) ;
 I '$D(PSSLST) Q 0
 N PSSX,PSSFOUND S (PSSX,PSSFOUND)=0
 F  S PSSX=$O(PSSLST(PSSENTIT,PSSX)) Q:+PSSX=0  I PSSVAL=$G(PSSLST(PSSENTIT,PSSX)) S PSSFOUND=PSSX_U_PSSENTIT Q
 Q PSSFOUND
 ;
 ;API to call from "ADMIN ORWDPS2" RPC
 ;Checks:
 ; 1. if invalid parameters or if SCHED is not a ONE-TIME SCHEDULE then return 0
 ; 2. if this schedule is excluded from the start/stop override:
 ;  - first check on the system/site level, if excluded then return "1^Y",
 ;  - if not excluded the system/site level then check the "division" level
 ;    specified via HOSPLOC parameter (IEN of the file (#44),
 ;    and if excluded then return "1^Y"
 ;  - if ONE-TIME SCHEDULE is not excluded on neither levels then return "1^N"
 ;Note:
 ;  The ADMIN SCHEDULES (#51.1) file may have duplicate entries with the same name.
 ;  The purpose of this API to check whether the admin schedule selected by the CPRS user is excluded or not.
 ;  The CPRS user will not see any duplicates on the screen because the list of available schedules for the
 ;  user is prepared by  "ORWDPS1 SCHALL" RPC, which has a special logic to eliminate duplicates, and it is
 ;  implemented in SCHED^PSSSCHED. Thus, if in $$CHK1TIME^PSSEXLST we use the same API then we will get the
 ;  same list of  schedules as the user sees. And then when we locate the admin schedule by its name in that
 ;  list we always locate exactly the same admin schedule that was selected by user - just because other
 ;  duplicate names (if we have them) cannot be selected by the user.
 ;
 ;Input parameters:
 ; SCHED - (#.01) field value of (#51.1) file. (used for ONE-TIME entries that have "PSJ" in the field (#4) and "O" in the field (#5),
 ; others cannot be selected for the parameter "PSS EXCLUDE 1TIME STRSTP MODS" in #8989.51 file and therefore cannot be
 ; excluded - see the screening logic there)
 ; HOSPLOC - IEN of the HOSPITAL LOCATION FILE (#44)
 ;
 ;Returns:
 ; 0 if invalid parameters
 ; 0 if SCHED is not an ONE-TIME schedule
 ; 1^Y if SCHED excluded from start/stop override
 ; 1^N if SCHED NOT excluded from start/stop override
CHK1TIME(SCHED,HOSPLOC) ;
 N PSSX,DIVST,PSSSYS,PSSLST,SYST,SCHEDIEN,WARDLOC
 ; if no admin schedule
 I $G(SCHED)']"" Q 0
 I $G(HOSPLOC)']"" Q 0
 ;get WARD location
 S WARDLOC=+$$GET1^DIQ(44,HOSPLOC_",",42,"I")
 I $G(WARDLOC)']"" Q 0
 ; find IEN of the schedule with the name passed by GUI via RPC "ORWDPS2 ADMIN"
 ; that has the type="O" and which is compatible with the location.
 S SCHEDIEN=$$SCHEDIEN(+WARDLOC,SCHED)
 ; in the SCHED parameter is not an ONE-TIME schedule
 I SCHEDIEN=0 Q 0
 S (PSSX,DIVST,PSSSYS)=0
 ; "division", i.e. INSTITUTION (#4)
 S PSSX=$$DIVSYS(+HOSPLOC)
 ; "system", i.e. DOMAIN (#4.2)
 S PSSSYS=+$P(PSSX,U,2)
 ; get all entries in the parameter
 D ENVAL^XPAR(.PSSLST,"PSS EXCLUDE 1TIME STRSTP MODS")
 ; determine the system level
 S SYST=+PSSSYS_";DIC(4.2,"
 ; check on the system level
 I $$IFEXISTS(.PSSLST,SYST,SCHEDIEN) Q "1^Y"
 ; check on the user's division level
 I $G(DUZ(2))>0 S DIVST=+DUZ(2)_";DIC(4," I $$IFEXISTS(.PSSLST,DIVST,SCHEDIEN) Q "1^Y"
 Q "1^N"
 ;
 ; We need to find IEN of the ONE-TIME schedule (type="O") with the name that was passed to GUI
 ; and which is compatible with patient's location.
 ; We use the same logic that is used by the "ORWDPS1 SCHALL" RPC to prepare list of schedules
 ; for the CPRS user, only these schedules can be selected by the provider in GUI.
 ;
 ;Input:
 ; WARDIEN - location, IEN of the WARD LOCATION (#42)
 ; SCHNAME - schedule name (#.01) of the file #51.1
 ;Output:
 ; if found return IEN of the file #51.1
 ; if not found return 0
SCHEDIEN(WARDIEN,SCHNAME) ;
 N ARR,IEN,INDX
 S ARR="",IEN=0
 Q:'$G(WARDIEN) 0
 Q:$G(SCHNAME)="" 0
 D SCHED^PSSSCHED(WARDIEN,.ARR)
 ; find schedule with the SCHNAME name and type="O"
 ; Note: SCHED^PSSSCHED returns only one schedule per name, it does not allow duplicates - see comments for SCHED^PSSSCHED for details
 ; Therefore the first entry SCHNAME found is the only one with this name.
 S INDX=0 F  S INDX=$O(ARR(INDX)) Q:+INDX=0  I $P(ARR(INDX),U,2)=SCHNAME,$P(ARR(INDX),U,4)="O" S IEN=+ARR(INDX) Q
 Q IEN
 ;press any key
PRESSKEY() ;
 W ! K DIR S DIR(0)="E" D ^DIR
 I 'Y Q 1  ; if "^"
 Q 0  ;if "Enter key"
 ;
 ;
 ;Determine 'division' (INSTITUTION #4) and system (DOMAIN #4.2) by the HOSPITAL LOCATION (#44)
 ;Parameter:
 ; PTR44 - (#44) HOSPITAL LOCATION
 ;Returns:
 ; PTR4 - IEN of INSTITUTION (#4) - called 'division' in the PARAMETERS file (#8989.5)
 ; PTR42 - IEN of DOMAIN (#4.2) - called 'system' in the PARAMETERS file (#8989.5)
DIVSYS(PTR44) ;
 N PTR4,PTR42
 S (PTR4,PTR42)=0
 ; determine institution IEN (#4)
 S PTR4=$$GET1^DIQ(44,PTR44_",",3,"I") ; ICR #10040
 S PTR42=$$GET1^DIQ(4,PTR4_",",60,"I") ; ICR #10090
 Q PTR4_U_PTR42
 ;
