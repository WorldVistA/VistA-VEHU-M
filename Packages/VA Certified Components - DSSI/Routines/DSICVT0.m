DSICVT0 ;DSS/WLC - DRIVER EVENTS FOR APPT RPC ROUTINES ;06/06/2006 14:57
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Driver events for Appointment RPC calls
 ; This routine is a re-write of the DSICVST calls formerly defined within
 ; CORE RPCs.  The re-write has been done to incorporate the new
 ; Replacement Scheduling Application (RSA) APIs.
 ; 
APPT(RET,DATA,SCR) ; rpc: DSIC GET SCHED APPTS
 ;      
 ; Retrieve Appointment data
 N DSIR,ASCR,I
 S DATA=$G(DATA),SCR=$G(SCR)
 S (RET,DSIR)=$NA(^TMP("DSIC",$J,"APPT")) K @DSIR
 ;
 ; convert screens to array
 K ASCR
 I SCR'="" D
 . F I=1:1:$L(SCR,";") D
 . . N DSI1,DSI2,DSI3
 . . S DSI1=$P(SCR,";",I)
 . . S DSI2=$P(DSI1,U,1),DSI3=$P(DSI1,U,2)
 . . ; convert to internal for stop codes
 . . S DSI3=$S(DSI2="S":$O(^DIC(40.7,"C",DSI3,"")),1:DSI3)
 . . S ASCR(DSI2,DSI3)=""
 D APPT^DSICVT1(.DSIR,DATA,.ASCR)
 Q
 ;
VST(RETX,DFN,BEG,END,ZLOC,CAT,SCR) ; RPC:  DSIC GET VISITS ONLY
 ; this gets visits only
 N DSIR
 S (RETX,DSIR)=$NA(^TMP("DSIC",$J,"VSIT"))
 N I,J F I=1:1:6 S J=$P("DFN^BEG^END^ZLOC^CAT^SCR",U,I),@J=$G(@J)
 D VS^DSICVT3(.DSIR,DFN,BEG,END,ZLOC,CAT,SCR)
 Q
 ;
VSIT(RETV,DATA,SCR) ; RPC:  DSIC GET VISITS/APPOINTMENT
 ; visits and appointments
 N DSIR
 S (RETV,DSIR)=$NA(^TMP("DSIC",$J,"RET"))
 S SCR=$G(SCR)
 D VSIT^DSICVT1(.DSIR,DATA,.SCR)
 Q
 ;
APPL(DSIC,SDT,EDT,DATA)  ; RPC:  VEJDSD GET SCHEDULED APPTS
 ; This gets active sceduled appts for one or more clinics
 N DSIR
 S (DSIC,DSIR)=$NA(^TMP("VEJD",$J))
 S SDT=$G(SDT),EDT=$G(EDT)
 D APPL^DSICVT2(DSIC,SDT,EDT,DATA)
 Q
 ;       
