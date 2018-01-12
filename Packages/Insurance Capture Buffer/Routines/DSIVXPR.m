DSIVXPR ;DSS/AJ - RPCs/APIs FOR PARAMETERS ;4/27/2016 11:52
 ;;2.2;INSURANCE CAPTURE BUFFER;**3,5,11,12**;May 19, 2009;Build 13
 ;Copyright 1995-2016, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#: 10086 - D HOME^%ZIS - supported
 ;
 ;For documentation of the entry points and input parameters: D ^DSIVXPR0
ADD(RET,DATA,FUN) ;  RPC: DSIV XPAR ADD
 ;  add a new parameter
 ;  Exception: instance is optional even for multiple - see above
 G ADD^DSIVXPR1
 ;
ADDWP(RET,DATA,DSIVLT) ;  RPC:  DSIV XPAR ADD WP
 ;  Add an instance of a word-processing field inside a parameter.
 ;  Returns: RET(0) = text or on error return RET(0) = -1^error message
 ;
 ; convert DSIVCLT
 ; 
 N DSIV,I
 F I=1:1 Q:'$D(DSIVLT(I))  S DSIV(I,0)=DSIVLT(I)
 K DSIVLT M DSIVLT=DSIV K DSIV
 G ADDWP^DSIVXPR3
 ;
CHG(RET,DATA,FUN) ;  RPC: DSIV XPAR EDIT
 ;  edit a Value for an existing parameter
 G CHG^DSIVXPR1
 ;
DEL(RET,DATA,FUN) ;  RPC: DSIV XPAR DEL
 ;  delete an existing parameter value
 ;  Exception: value is optional, but if passed must be equal to @
 G DEL^DSIVXPR1
 ;
DELALL(RET,DATA,FUN) ;  RPC: DSIV XPAR DEL ALL
 ;  this will delete all instances for a given entity/parameter
 ;  Exception: instance and value are not required for this call
 G DELALL^DSIVXPR1
 ;
GET(RET,DATA) ;  RPC: DSIV XPAR GET ALL FOR ENT
 ;  this will return values for all instances of an entity/param
 ;  Exception: only needed elements: entity, parameter, format
 ;  ARR(6) = input value ignored, always use 'B'
 ;           B - return list(#,"N")=iI^eI
 ;                      list(#,"V")=iV^eV
 ;  Return RET(#) = iI^eI^iV^eV
 ;     On error, return RET(1)=-1^error message
 G GET^DSIVXPR1
 ;
GET1(RET,DATA,FUN) ;  RPC: DSIV XPAR GET VALUE
 ;  this will return the value of a single entity/param/instance combo
 ;  Format codes [ARR(6)] = [Q]uick    - return iV
 ;                          [E]xternal - return eV
 ;                          [B]oth     - return iV^eV
 G GET1^DSIVXPR1
 ;
GETALL(RET,DATA) ;  RPC: DSIV XPAR GET ALL
 ;  Return VALUE for all ENTITYs for a parameter/instance combination
 ;  Exception: only need parameter, instance
 ;  Return @RET@(1) = -1^error message, or
 ;  @RET@(#)=3-char code^entity ien^value
 ;  return data will be sorted by 3-char code, entity
 G GETALL^DSIVXPR1
 ;
GETWP(RET,DATA) ;  RPC: DSIV XPAR GET WP
 ;  return a parameter's value which is defined as word-processing
 ;  Returns: RET(#) = text or on error return RET(1) = -1^error message
 G GETWP^DSIVXPR1
 ;
CHGWP(RET,DATA,DSIVLIST) ;  RPC:  DSIV XPAR CHG WP
 ;  change an instance of a word-processing field inside a parameter.
 ;  Returns: RET(0) = text or on error return RET(0) = -1^error message
 ;  
 ; convert DSIVLIST
 N DSIVLT F I=1:1 Q:'$D(DSIVLIST(I))  S DSIVLT(I,0)=DSIVLIST(I)
 G CHGWP^DSIVXPR1
 ;
REPL(RET,DATA,FUN) ;  RPC: DSIV XPAR REPLACE INST
 ;  change an instance value for an existing entry
 ;  requires entity, parameter, current instance, new instance
 G REPL^DSIVXPR1
 ;
MULT(DSIVRET,DSIVLIST) ;  RPC: DSIV XPAR MULT ACTION
 ;  this rpc will allow for multiple actions add, edit, delete, or
 ;  replace to occur with a single rpc call.  This is the equivalent
 ;  of calling ADD, CHG, DEL, or REPL multiple times.  Since each line
 ;  has an action flag, you can mix actions.
 G MULT^DSIVXPR2
 ;
NMALL(DSIV,X,EXACT,FLDS) ;  API
 ;     X - req - parameter name lookup value (can be partial match)
 ; EXACT - opt - Boolean 1/0 - return param whose name matches X exactly
 ;               honored starting 9/20/2005
 ;  FLDS - opt - ';'-delimited field values from 8989.51 to return
 ;               default is ien^name - added 9/20/2005
 ;               If the FLDS list does not contain .01, it will be added
 ;               If the .01 field is not the first one in the FLDS list,
 ;               then it will be moved to the front
 ;               This program is not expecting FLDS to contain a ':'
 ;RETURN: DSIV(#) = ien ^ name - or - values for FLDS
 ;                  if problems, DSIV(1) = -1 ^ message
 ;                               DSIV(n) = additional text if needed
 ;Extrinsic function returns 1 if data found, -1^error message
 ;  If $G(EXACT) and match found, then ext funct returns field values
 G NMALL^DSIVXPR1
 ;
EDIT(P) ; interactive prompt to select parameter then edit 8989.5
 ; P - req
 ; This can be the name or namespace of parameter to be used as a screen
 ; This can be an array of names (or namespaces) to be used in screen
 ;   eg., P("DSIR")="", P("DENTV DATE RANGE")=""
 G EDIT^DSIVXPR3
 ;
LIST(DSIVL,NAME,PREFIX) ; rpc: DSIV XPAR GET PARAM LIST
 ; this will return a single Parameter Definition or a list of them.
 ; NAME - opt - if you want the parameter definition for a single
 ;              parameter then pass that parameter name here
 ; PREFIX - opt - retrieve a list of parameter definitions starting with
 ;                the text you pass here, eg., DSIV for all DSIV params
 ; Note: you must pass either NAME or PREFIX.  If name is passed then
 ;       prefix is ignored.
 ; See LIST^DSIVXPR3 for description of return array
 G LIST^DSIVXPR3
 ;
