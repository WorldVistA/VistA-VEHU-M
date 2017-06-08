DSICXPR ;DSS/SGM - RPCs/APIs FOR PARAMETERS ;01/09/2005 07:59
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#: 10086 - D HOME^%ZIS - supported
 ;
 ;For documentation of the entry points and input parameters: D ^DSICXPR0
ADD(RET,DATA,FUN) ;  RPC: DSIC XPAR ADD
 ;  add a new parameter
 ;  Exception: instance is optional even for multiple - see above
 G ADD^DSICXPR1
 ;
ADDWP(RET,DATA,DSICLT) ;  RPC:  DSIC XPAR ADDWP
 ;  Add an instance of a word-processing field inside a parameter.
 ;  Returns: RET(0) = text or on error return RET(0) = -1^error message
 ;
 ; convert DSICCLT
 ; 
 N DSIC,I
 F I=1:1 Q:'$D(DSICLT(I))  S DSIC(I,0)=DSICLT(I)
 K DSICLT M DSICLT=DSIC K DSIC
 G ADDWP^DSICXPR3
 ;
CHG(RET,DATA,FUN) ;  RPC: DSIC XPAR EDIT
 ;  edit a Value for an existing parameter
 G CHG^DSICXPR1
 ;
DEL(RET,DATA,FUN) ;  RPC: DSIC XPAR DEL
 ;  delete an existing parameter value
 ;  Exception: value is optional, but if passed must be equal to @
 G DEL^DSICXPR1
 ;
DELALL(RET,DATA,FUN) ;  RPC: DSIC XPAR DEL ALL
 ;  this will delete all instances for a given entity/parameter
 ;  Exception: instance and value are not required for this call
 G DELALL^DSICXPR1
 ;
GET(RET,DATA) ;  RPC: DSIC XPAR GET ALL FOR ENT
 ;  this will return values for all instances of an entity/param
 ;  Exception: only needed elements: entity, parameter, format
 ;  ARR(6) = input value ignored, always use 'B'
 ;           B - return list(#,"N")=iI^eI
 ;                      list(#,"V")=iV^eV
 ;  Return RET(#) = iI^eI^iV^eV
 ;     On error, return RET(1)=-1^error message
 G GET^DSICXPR1
 ;
GET1(RET,DATA,FUN) ;  RPC: DSIC XPAR GET VALUE
 ;  this will return the value of a single entity/param/instance combo
 ;  Format codes [ARR(6)] = [Q]uick    - return iV
 ;                          [E]xternal - return eV
 ;                          [B]oth     - return iV^eV
 G GET1^DSICXPR1
 ;
GETALL(RET,DATA) ;  RPC: DSIC XPAR GET ALL
 ;  Return VALUE for all ENTITYs for a parameter/instance combination
 ;  Exception: only need parameter, instance
 ;  Return @RET@(1) = -1^error message, or
 ;  @RET@(#)=3-char code^entity ien^value
 ;  return data will be sorted by 3-char code, entity
 G GETALL^DSICXPR1
 ;
GETWP(RET,DATA) ;  RPC: DSIC XPAR GETWP
 ;  return a parameter's value which is defined as word-processing
 ;  Returns: RET(#) = text or on error return RET(1) = -1^error message
 G GETWP^DSICXPR1
 ;
CHGWP(RET,DATA,DSICLIST) ;  RPC:  DSIC XPAR CHGWP
 ;  change an instance of a word-processing field inside a parameter.
 ;  Returns: RET(0) = text or on error return RET(0) = -1^error message
 ;  
 ; convert DSICLIST
 N DSICLT F I=1:1 Q:'$D(DSICLIST(I))  S DSICLT(I,0)=DSICLIST(I)
 G CHGWP^DSICXPR1
 ;
REPL(RET,DATA,FUN) ;  RPC: DSIC XPAR REPL INST
 ;  change an instance value for an existing entry
 ;  requires entity, parameter, current instance, new instance
 G REPL^DSICXPR1
 ;
MULT(DSICRET,DSICLIST) ;  RPC: DSIC XPAR MULT ACTION
 ;  this rpc will allow for multiple actions add, edit, delete, or
 ;  replace to occur with a single rpc call.  This is the equivalent
 ;  of calling ADD, CHG, DEL, or REPL multiple times.  Since each line
 ;  has an action flag, you can mix actions.
 G MULT^DSICXPR2
 ;
NMALL(DSIC,X,EXACT,FLDS) ;  API
 ;     X - req - parameter name lookup value (can be partial match)
 ; EXACT - opt - Boolean 1/0 - return param whose name matches X exactly
 ;               honored starting 9/20/2005
 ;  FLDS - opt - ';'-delimited field values from 8989.51 to return
 ;               default is ien^name - added 9/20/2005
 ;               If the FLDS list does not contain .01, it will be added
 ;               If the .01 field is not the first one in the FLDS list,
 ;               then it will be moved to the front
 ;               This program is not expecting FLDS to contain a ':'
 ;RETURN: DSIC(#) = ien ^ name - or - values for FLDS
 ;                  if problems, DSIC(1) = -1 ^ message
 ;                               DSIC(n) = additional text if needed
 ;Extrinsic function returns 1 if data found, -1^error message
 ;  If $G(EXACT) and match found, then ext funct returns field values
 G NMALL^DSICXPR1
 ;
EDIT(P) ; interactive prompt to select parameter then edit 8989.5
 ; P - req
 ; This can be the name or namespace of parameter to be used as a screen
 ; This can be an array of names (or namespaces) to be used in screen
 ;   eg., P("DSIR")="", P("DENTV DATE RANGE")=""
 G EDIT^DSICXPR3
 ;
LIST(DSICL,NAME,PREFIX) ; rpc: DSIC XPAR GET PARAM LIST
 ; this will return a single Parameter Definition or a list of them.
 ; NAME - opt - if you want the parameter definition for a single
 ;              parameter then pass that parameter name here
 ; PREFIX - opt - retrieve a list of parameter definitions starting with
 ;                the text you pass here, eg., DSIC for all DSIC params
 ; Note: you must pass either NAME or PREFIX.  If name is passed then
 ;       prefix is ignored.
 ; See LIST^DSICXPR3 for description of return array
 G LIST^DSICXPR3
 ;
