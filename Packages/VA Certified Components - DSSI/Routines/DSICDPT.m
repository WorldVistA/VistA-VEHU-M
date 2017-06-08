DSICDPT ;DSS/SGM - MAIN ENTRY TO DSICDPT ROUTINES ;03/07/2006 00:36
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This routine will be the main entry point into all of the DSICDPT*
 ;routines.  Starting Mar1, 2006 all new DSS applications should only
 ;call line labels in this routine.  As this routine will potentially
 ;have many entry points, detailed documentation for entry point will
 ;be in the DSICDPT* routine that is invoked.
 ;
 ;All Integration Agreements for DSICDPT*
 ;DBIA#  Supported Reference
 ;-----  ----------------------------------------------------
 ; 2051  $$FIND1^DIC
 ; 2056  $$GET1^DIQ
 ; 2701  ^MPIF001: $$GETICN, $$GETDFN, $$IFLOCAL
 ; 3065  STDNAME^XLFNAME
 ; 3744  $$TESTPAT^VADPT
 ;10035  Direct global read of ^DPT(DFN,0), ssn
 ;10061  ^VADPT: ADD,DEM,ELIG,IN5,KVA,OAD,OPD
 ;10062  $$PID^VADPT6
 ;10103  $$FMTE^XLFDT
 ;10141  $$PATCH^XPDUTL
 ;  427  Global read of ^DIC(8,D0,0) - cont. sub. - not a subscriber
 ;
 ;Common variable defintions for all entry points
 ;===================================================================
 ;        |----------------- LINE TAG ---------------------|
 ;Variable|DEM|ICN|ICN2DFN|ID|IN|INQ|NAMECOM|TEST|GET|STATE|
 ;--------|---|---|-------|--|--|---|-------|----|---|-----|
 ;DATE    |   |   |       |  | O|   |       |    |   |     |
 ;DFN     | E |   |       |  | R| R |       |    |   |     |
 ;DSICONF | O |   |       |  |  |   |       |    |   |     |
 ;DSIFLG  | O |   |       |  |  |   |       |    |   |  O  |
 ;FLAG    |   |   |       |  |  | O |       |    |   |     |
 ;FUN     |   | O |   O   | O|  | O |   O   |  O |   |     |
 ;ICN     |   |   |   R   |  |  |   |       |    |   |     |
 ;ISSSN   |   | O |       | R|  |   |       |  O |   |     |
 ;LODGE   |   |   |       |  | O| O |       |    |   |     |
 ;PAT     |   | R |       | R|  |   |       |  R | R |     |
 ;PERM    | O |   |       |  |  |   |       |    |   |     |
 ;SSN     | E |   |       |  |  |   |       |    |   |     |
 ;STATE   |   |   |       |  |  |   |       |    |   |  R  |
 ;TYPE    |   |   |       |  |  |   |       |    | O |     |
 ;VAPTYP  |   |   |       | O|  |   |       |    |   |     |
 ;VNAME   |   |   |       |  |  |   |   R   |    |   |     |
 ;  R:required  O:optional  E:one of these values is required
 ;
 ;Variable|Default|Description
 ;--------|-------|-----------------------------------------------------
 ;DATE    |  NOW  |FM format - get movement data as of date
 ;DFN     |       |pointer to the Patient file (#2)
 ;DSICONF |   0   |Flag to return confidential address
 ;DSICFLG |   0   |Boolean, if 1 return internal^external values
 ;FLAG    |       |String of codes determining which data to return
 ;FUN     |   0   |Boolean, 1:extrinsic function  0:DO w/params
 ;ICN     |       |ICN value to use a lookup value to convert to DFN
 ;ISSSN   |   0   |Boolean, 1:patient lookup is a SSN
 ;        |       |         0:then patient lookup is not a SSN
 ;LODGE   |   0   |Boolean, if 1 then include lodger movements
 ;PAT     |       |Patient file (#2) lookup value, DFN or name or SSN
 ;PERM    |   0   |Boolean, if 1 always return permanent address
 ;SSN     |       |9-digit SSN
 ;STATE   |       |lookup value
 ;TYPE    |   0   |Boolean, if 1 and PAT is 9-digits, then assume
 ;        |       |  PAT is a SSN
 ;VATYP   |       |pointer to file 8
 ;VNAME   |       |name to be parsed into components
 ;
OUT Q:'$G(FUN)  Q DSIC
 ;
 ;---------------------------------------------------------------
 ;                     CALLED BY RPCs or APIs
 ;---------------------------------------------------------------
DEM(DSICDAT,DFN,SSN,PERM,DSICONF,DSIFLG) ; RPC: DSIC DPT GET DEMO
 ;get patient demographics
 D DEM^DSICDPT1(.DSICDAT,$G(DFN),$G(SSN),$G(PERM),$G(DSICONF),$G(DSIFLG))
 Q
 ;
ICN(DSIC,PAT,ISSSN,FUN) ; RPC: DSIC DPT GET ICN
 ;Return icn^national/local flag or -1^msg
 D ICN^DSICDPT3(.DSIC,$G(PAT),$G(ISSSN))
 G OUT
 ;
ICN2DFN(DSIC,ICN,FUN) ; RPC: DSIC DPT ICN TO DFN
 ;Return DFN or -1^message
 D ICN2DFN^DSICDPT3(.DSIC,$G(ICN))
 G OUT
 ;
ID(DSIC,PAT,ISSSN,VAPTYP,FUN) ; RPC DSIC DPT GET ID
 ;Return external primary patient id ^ brief pat id
 ;or if problems return -1^msg
 ;For non-VA systems, this returns the patient identifier
 ;For VA, this is the SSN (dashed) ^ last 4 of ssn
 ;Defaults to VA identifier
 D ID^DSICDPT3(.DSIC,$G(PAT),$G(ISSSN),$G(VAPTYP),$G(FUN))
 G OUT
 ;
IN(DSIC,DFN,DATE,LODGE) ; RPC: DSIC DPT INP INFO
 ;Return information about a patient's inpatient stay
 D IN^DSICDPT2(.DSIC,$G(DFN),$G(DATE),$G(LODGE))
 Q
 ;
INQ(DSIC,DFN,FLAG,LODGE,FUN) ; RPC: DSIC DPT INP INFO BRIEF
 ;Return specific information about the current admission
 D INQ^DSICDPT2(.DSIC,$G(DFN),$G(FLAG),$G(LODGE))
 G OUT
 ;
NAMECOM(DSICDAT,VNAME,FUN) ; RPC: DSIC XUTIL NAME COMPONENT
 ;Return name components for standard VistA name
 ;Return: LastName^FirstName^Middle^Suffix/Title
 D NAMECOM^DSICDPT1(.DSICDAT,$G(VNAME))
 G OUT
 ;
TEST(DSIC,PAT,ISSSN,FUN) ; RPC: DSIC DPT TEST PATIENT
 ;Return 1 if this is a test patient, else return 0 or -1^msg
 S DSIC=$$TEST^DSICDPT3($G(PAT),$G(ISSSN))
 G OUT
 ; 
 ;---------------------------------------------------------------
 ;                           M APIs Only
 ;---------------------------------------------------------------
GET(PAT,TYPE) ; return DFN^name^ssn;dashed-ssn for lookup value PAT
 Q $$GET^DSICDPT1($G(PAT),$G(TYPE))
 ;
STATE(STATE,DSIFLG) ;  return state data
 ; DSIFLG - if 1 return state ien^name^abbreviation
 ;          if 0 return state abbreviation (or name if abbrev="")
 Q $$STATE^DSICDPT1($G(STATE),$G(DSIFLG))
