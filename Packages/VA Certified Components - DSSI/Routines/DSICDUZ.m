DSICDUZ ;DSS/SGM - COMMON NEW PERSON FILE RPCS ;01/04/2007 06:48
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;this routine contains various common utilities to support access
 ;to the NEW PERSON file and/or user characteristics
 ;
 ;Documentation of Integration Agreements for all DSICDUZ* routines
 ;DBIA#  Supported References
 ;-----  ------------------------------------------
 ; 1625  $$GET^XUA4A72
 ; 2051  $$FIND1^DIC
 ; 2056  $$GETS^DIQ
 ; 2171  $$NS^XUAF4
 ; 2343  ^XUSER: $$ACTIVE, $$PROVIDER
 ; 2533  $$DIV4^XUSER [controled subscription]
 ; 3065  $$NAMEFMT^XLFNAME
 ;10060  FM read of all fields in file 200
 ;10076  Read of ^XUSEC(key,duz)
 ;10103  $$FMTE^XLFDT
 ;10104  $$UP^XLFSTR
 ;10112  $$SITE^VASITE
 ;
 ;  DESCRIPTION OF INPUT VARIABLES
 ;==================================
 ;     O:optional   R:required
 ;--------|----- LINE TAG LABELS -----|
 ;Variable|ACT|DIV|ID|LIST|PER|PROV|CK|
 ;--------|---|---|--|----|---|----|--|
 ;DATE    |   |   |  |    | O |    |  |
 ;DSISCR()| O |   |  |    |   |    |  |
 ;FUN     | O | O |  |    | O |  O |  |
 ;RDV     |   |   |  |    |   |  O |  |
 ;SCR()   |   |   |  |    |   |    |  |
 ;SITE    |   | O |  |    |   |    |  |
 ;USER    |   |   |  |    | O |  R |  |
 ;VAL     |   |   |  |  O |   |    |  |
 ;XDUZ    | R | O | O|    |   |    | R|
 ;
 ;  DATE - default=today
 ;         Fileman date to check for active person class
 ;DSISCR - array of additional screens to perform
 ;         DSISCR(n) = string   where n = 0,1,2,3,4,...
 ;         Allowable formats of DSISCR(n) = flag^val1^val2^val3^..
 ;          security key ck = KEY^security key name
 ;          kernel param ck = PARM^parameter name^parameter instance
 ;          M code = M^<return message>^<executable M code which sets $T>
 ;   FUN - I $G(FUN) then extrinsic function, else RPC
 ;   RDV - Boolean flag to indicate whether or not to include remote
 ;         data view visitors - default to 0 to not include
 ;   SCR - same as DSISCR
 ;  SITE - if SITE=1 and user has no divisions, then return facility's
 ;         default division
 ;  USER - same as XDUZ
 ;   VAL - lookup value for NEW PERSON file
 ;  XDUZ - pointer to NEW PERSON file, if optional default to DUZ
 ;
 ;Return values: see individual line labels for successful return val
 ;  if problems return -1^message
 ;
 ;EDIT HISTORY
 ;1/5/2006 - WLC - add division to return string for LIST
 ;3/2/2006 - SGM - reorganize, break into two routines,
 ;           add CK as an internal supportable call for DSS apps
 ;1/4/2007 - SGM - add ID
 ;
OUT Q:$D(FUN) DSIC Q
 ;
ACT(DSIC,XDUZ,DSISCR,FUN) ;  RPC: DSIC ACTIVE USER
 ; validate that user is an active user
 ; RETURN: user's DUZ value
 S DSIC=$$ACT^DSICDUZ1 G OUT
 ;
CK(XDUZ) ; basic check for valid DUZ
 ; Return 1 if valid DUZ
 Q $$CK^DSICDUZ1(XDUZ)
 ;
DIV(DSIC,XDUZ,SITE,FUN) ;  RPC: DSIC USER DEF DIV
 ;Return default division for user.  If that user has only one
 ;division in file 200 DIVISION multiple, then that entry is assumed
 ;to be the default division unless it is explicitly marked as NO
 ;DSIC - return p1^p2^p3
 ;       p1=pointer to file 4  p2=institution name  p3=station number
 S DSIC=$$DIV^DSICDUZ1 G OUT
 ;
ID(DSIC,XDUZ,FLAGS,FUN) ; RPC: DSIC USER ID
 ; Return all user IDs for a given user
 ; FLAGS - opt - default to AaDNSTVv
 ;   FLAGS["A" - return alternate IDS in field 21600 only
 ;         "a" - return default alternate ID only - either one must
 ;               be flagged as default or if there is only one entry
 ;               in alt id
 ;         "D" - return DEA#
 ;         "N" - return NPI#
 ;         "S" - return SSN
 ;         "T" - TAX ID
 ;         "v" - VA#
 ;         "V" - VPID
 ; Return DSIC(n) = p1^p2^p3^p4 for n=1,2,3,... where
 ;   If error, return -1^message
 ;   If RPC or M API, return List[n] = p1^p2^p3^p4  for n=1,2,3,4,...
 ;   If Ext. Function, return p1^p2^p3^p4;p1^p2^p3^p4;p1^p2^p3^p4;...
 ;   where p1 - ID mnemonic
 ;         p2 - ID value
 ;         p3 - location (valid for OAI mnemonics only)
 ;         p4 = 1 (valid for OAI only.  If 1, then default Alt ID)
 D ID^DSICDUZ1 G OUT
 ;
LIST(DSIC,VAL,SCR) ;  RPC: DSIC ACTIVE USER LIST
 ; Return list of active users for a lookup value
 ; Return ^TMP("DSIC",$J,"DILIST",#,0) = p1^p2^p3^...^p8  where
 ;    p1 = ien                      p6 = initials
 ;    p2 = name (.01 field)         p7 = title
 ;    p3 = sig block printed name   p8 = service
 ;    p4 = sig block title          p9 = division
 ;    p5 = first m last
 D LIST^DSICDUZ1
 Q
 ;
PER(DSIC,USER,DATE,FUN) ; RPC: DSIC ACTIVE PERSON CLASS
 ; Return user's current active person classification for PCE
 ; Return p1^p2^p3^...^p8  where
 ;    p1 = IEN to file 8932.1     p5 = Effective date
 ;    p2 = Occupation             p6 = expiration date
 ;    p3 = specialty              p7 = VA Code
 ;    p4 = sub-specialty          p8 = specialty code
 S DSIC=$$PER^DSICDUZ1 G OUT
 ;
PROV(DSIC,XDUZ,RDV,FUN) ; rpc: DSIC ACTIVE CPRS PROVIDER
 ; Return: 3 if active user
 ;         2 if user is active via the XUORES security key
 ;         1 if user is a RDV visitor and you passed RDV=1
 ;         0 if user is a RDV visitor and you passed RDV=0
 ;        -1^message if problems or not a provider
 S DSIC=$$PROV^DSICDUZ1 G OUT
