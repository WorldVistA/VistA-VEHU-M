DSIVXPR ;DSS/KC - RPC TO GET PARAMETERS ;10/26/2010 09:40
 ;;2.2;INSURANCE CAPTURE BUFFER;**3,5**;May 19, 2009;Build 10
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  Supported - Description
 ; -----  --------------------------------------------------
 ;  2051  $$FIND1^DIC
 ;  2263  GETLST^XPAR
 ;  2263  CHG^XPAR
 ;  
 Q
 ;
GETALL(DSILIST,DATA) ;  RPC: DSIV XPAR GET ALL FOR ENT
 ;  this will return values for all instances of an entity/param
 ;  Exception: only needed elements: entity, parameter, format
 ;  DATA = "ARR(1)~ARR(2)~ARR(3)~ARR(4)~ARR(5)~ARR(6)"
 ;     e.g. "SYS~DSIV PAGE SETUP~~~~"
 ;  ARR(1) = entity     ARR(2) = param name    ARR(3) = instance
 ;  ARR(4) = value      ARR(5) = new instance value
 ;  ARR(6) = format for GET1, Default = "Q"
 ;        "Q" - quick,    #)=internal instance^internal value
 ;        "E" - external, #)=external instance^external value
 ;        "B" - both,     #,"N")=internal instance^external instance
 ;                        #,"V")=internal value^external value
 ;        "N" - external instance)=internal value^external value
 ;     some of those pieces may be <null> depends upon ARR(6)
 ;     On error, return DSILIST(1)=-1^error message
 N I,P,X,Y,Z,ARR,DSIERR
 S X=$$PARSE(234) I X<1 S DSILIST(1)=X Q
 D GETLST^XPAR(.DSILIST,ARR(1),ARR(2),ARR(6),.DSIERR)
 I $G(DSIERR)'=0 S DSILIST(1)="-1^"_$P(DSIERR,U,2) Q
 I '$G(DSILIST) S DSILIST(1)="-1^No data found" Q
 Q
 ;
 ;--------------------  subroutines  -----------------------
PARSE(FLG) ;  parse up DATA string and set up ARR() array
 ;  FLG - optional
 ;    If FLG[1 then explicit entity required - default to USR
 ;    If FLG[4 then explicit entity required - default to ALL
 ;    If FLG[2 then set GET format to B
 ;    If FLG[3 then value not needed
 ;  Return: PARAMETER DEFINITION ien
 ;     else return -1^error message
 ;
 N I,X,Y,Z,RTN K ARR S FLG=$G(FLG)
 F I=1:1:6 S ARR(I)=$P($G(DATA),"~",I)
 I FLG[1,ARR(1)="" S ARR(1)="USR"
 I FLG[4,ARR(1)="" S ARR(1)="ALL"
 I "QEBN"'[ARR(6)!(ARR(6)'?1U) S ARR(6)=""
 I ARR(6)="" S ARR(6)="Q"
 I ARR(2)="" Q "-1^No parameter name received"
 S RTN=$$NM(ARR(2))
 I 'RTN S RTN="-1^Parameter Definition "_ARR(2)_" not found"
 I RTN>0,FLG'[3,ARR(4)="" S RTN="-1^No value received"
 Q RTN
NM(P) ;  return the ien for a parameter definition P (#8989.51)
 N DIERR,DSIERR
 Q $$FIND1^DIC(8989.51,,"QX",$G(P),"B",,"DSIERR")
 ;
CHGWP(RET,DATA,DSIVLIST) ;  RPC: DSIV XPAR CHGWP
 ;  change an instance of a word-processing field inside a parameter.
 ;  Returns: RET(0) = text or on error return RET(0) = -1^error message
 ;  
 ; convert DSIVLIST
 N DSIVLT,ENT,PAR,ERR,INST,WPA,I
 S ERR="" K RET  F I=1:1 Q:'$D(DSIVLIST(I))  S DSIVLT(I,0)=DSIVLIST(I)
 I DATA']"" S RET(0)="-1^No Data string defined" Q
 S ENT=$S($P(DATA,"~",1)'="":$P(DATA,"~",1),1:"SYS")
 S PAR=$P(DATA,"~",2) I PAR="" S RET(0)="-1^No parameter defined in Data string" Q
 S INST=$P(DATA,"~",3) ;INST may not be numeric (may be `ien with grave accent)
 D INTERN^XPAR1 I ERR S RET(0)="-1^Parameter not defined" Q
 D CHG^XPAR(ENT,PAR,INST,.DSIVLT,.WPA) I +WPA S RET(0)="-1^"_$P(WPA,U,2) Q
 S RET(0)="1^Parameter changed successfully"
 Q
