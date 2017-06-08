DSIVTSP ;DSS/NR -VALIDATE TYPE, SPECIALTY/SUBSPECIALTY, PROCEDURE/EVENT ;8/29/2011
 ;;2.2;INSURANCE CAPTURE BUFFER;**5**;May 19, 2009;Build 10
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Control Registrations  
 ;   5560 MAG4 INDEX GET TYPE (calls file 2005.83)                                        
 ;   5559 MAG4 INDEX GET SPECIALTY (calls file 2005.84)
 ;   5557 MAG4 INDEX GET EVENT (calls file 2005.85)
 Q
 ;
VLDTSP(DSIVDV,TYPE,SPEC,PROC) ;RPC: DSIV VALIDATE VI INDEX TERMS  
 ; Validate the interdependency of Index Terms. (From VALTUX2^MAGGTUX3)
 ; (If this RPC is changed, also make change in DSIVDV.)
 ; DSIVDV is the return array 
 ; DSIVDV(0)="1^Okay"  or   "-1^error message"
 ; 
 ; - TYPE is required.
 ; - Assure TYPE, PROC, and SPEC are Active if input.
 ; - TYPE must be entered and may be entered without PROC and SPEC.
 ; - If PROC is not pointing to any SPECs, then it is valid for all.
 ; - Validate the Procedure/Event <-> Specialty/SubSpecialty interdependency
 ; - Observations (NCR):
 ; ----All TYPEs are valid if PROC and SPEC are not input.
 ; ----Assure the TYPE is a Clinical TYPE if PROC or SPEC are input. 
 ; 
 K DSIVDV
 N TYPEIEN,SPECIEN,PROCIEN
 S DSIVDV(0)="",TYPEIEN=0
 S TYPE=$G(TYPE),PROC=$G(PROC),SPEC=$G(SPEC)
 I TYPE="" S DSIVDV(0)="-1^Type is Required." Q
 ; 
 I TYPE'="" D  I DSIVDV(0)'=""  Q 
 .S TYPEIEN=$O(^MAG(2005.83,"B",TYPE,""))
 .I 'TYPEIEN S DSIVDV(0)="-1^Invalid Type." Q
 .I $P(^MAG(2005.83,TYPEIEN,0),"^",3)="I" S DSIVDV(0)="-1^Type is Inactive." Q
 ;
 I SPEC'="" D  I DSIVDV(0)'="" Q
 .S SPECIEN=$O(^MAG(2005.84,"B",SPEC,""))
 .I 'SPECIEN S DSIVDV(0)="-1^Invalid Specialty." Q
 .I $P(^MAG(2005.84,SPECIEN,0),"^",4)="I" S DSIVDV(0)="-1^Specialty is Inactive." Q
 ;
 I PROC'="" D  I DSIVDV(0)'="" Q
 .S PROCIEN=$O(^MAG(2005.85,"B",PROC,""))
 .I 'PROCIEN S DSIVDV(0)="-1^Invalid Procedure." Q
 .I $P(^MAG(2005.85,PROCIEN,0),"^",3)="I" S DSIVDV(0)="-1^Procedure is Inactive." Q
 ;
 ; If PROC and SPEC are "", then Quit, any TYPE by itself is valid
 I (PROC=""),(SPEC="") S DSIVDV(0)="1^Okay" Q
 ; Here, TYPE has to be Clin if PROC or SPEC are input.
 I $P(^MAG(2005.83,TYPEIEN,0),"^",2)>7 S DSIVDV(0)="-1^The Type Index must be Clinical if Spec/SubSpec or Proc/Event is specified." Q
 I (PROC="")!(SPEC="") S DSIVDV(0)="1^Okay" Q
 ; we get here, we have to validate the interdependency of SPEC <-> PROC.
 ; 
 ; if PROC is not pointing to any SPECs, then it is okay for all
 I '$O(^MAG(2005.85,PROCIEN,1,0)) S DSIVDV(0)="1^Okay" Q
 ; if PROC doesn't point to SPEC - it is Invalid.
 I '$D(^MAG(2005.85,PROCIEN,1,"B",SPECIEN)) D  I DSIVDV(0)'="" Q
 .S DSIVDV(0)="-1^Invalid Association between Spec/SubSpec and Proc/Event." Q
 S DSIVDV(0)="1^Okay"
 Q 
 ; 
