VEJDWPBH ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;;SLC/DLT/DCM - Discontinue Action taken from List Manager ;6/17/98  10:22
 ;GMRCADC;3.0;CONSULT/REQUEST TRACKING;**1,5**;DEC 27, 1997
EXAC(MSG) ;Exit message asking for user to press <ENTER>; EXAC=Exit Action
 N ND
 W $C(7),!,MSG I $O(MSG(0)) S ND=0 F  S ND=$O(MSG(ND)) Q:ND=""  W !,MSG(ND)
 W !,"Press <RETURN> to continue: " R X:DTIME W !!
 Q
DC(GMRCO,GMRCA) ;Discontinue a consult logic from DC^GMRCA1
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 N GMRCDA,GMRCACTM,ORBADUZ
 K GMRCQUT,GMRCQIT
 ; blj/dss 14/6/2000 Routine VEGMRCA2 doesn't exist.  Kill it dead.
 ; I '+$G(GMRCO) D SELECT^VEGMRCA2(.GMRCO) I $D(GMRCQUT) Q
 I '+$G(GMRCO) S GMRCQUT=1 Q
 ;
 S GMRC(0)=^GMR(123,GMRCO,0),GMRCDA=GMRCO
 S (GMRCDFN,DFN)=$P(GMRC(0),"^",2)
 I $D(GMRCA),+GMRCA S GMRCACTM=$S(GMRCA=6:"Discontinued",GMRCA=19:"Cancelled",1:$P($G(GMR(123.1,+GMRCA,0)),"^",1))
 ;
 D PROC I $D(GMRCQUT) S GMRCQUT=1 Q
 ;
 S GMRCTRLC=$S(GMRCA=19:"OC",1:"OD")
 ; blj/dss 14/6/2000  Routine ^VEGMRCHL7 doesn't exist.
 ; D EN^VEGMRCHL7(DFN,GMRCO,$G(GMRCTYPE),$G(GMRCRB),GMRCTRLC,GMRCORNP,$G(GMRCVSIT),.GMRCOM)
 Q
 ;
PROC ;Check validity of action and if valid process the discontinue action
 I $P(GMRC(0),"^",12)=1 S GMRCMSG="This consult has already been discontinued!" D EXAC(GMRCMSG) S GMRCQUT=1 Q
 I $P(GMRC(0),"^",12)=2 S GMRCMSG="This consult has already been completed!" D EXAC(GMRCMSG) S GMRCQUT=1 Q
 I $P(GMRC(0),"^",12)=9 S GMRCMSG="Action invalid. This consult has partial results!",GMRCMSG(1)="Remove the associated results and then discontinue." D EXAC(.GMRCMSG) S GMRCQUT=1 Q
 I $P(GMRC(0),"^",12)=13 S GMRCMSG="This consult has already been cancelled!" D EXAC(GMRCMSG) S GMRCQUT=1 Q
 ;
 ; blj/dss 14/6/2000  Routines ^VEGMRCAU and ^VEGMRCP don't exist. Since it appears that the rest of this
 ; routine depends pretty heavily on what they should have done, we're just going to dike it out.  
 S GMRCQUT=1 Q
 ; S GMRCORVP=GMRCDFN_";DPT("
 ; N GETPROV D GETPROV^VEGMRCAU I $D(DIROUT)!$D(DTOUT)!$D(DUOUT) S GMRCQUT=1 Q
 ; N GETDT D GETDT^VEGMRCAU I $D(DIROUT)!$D(DTOUT)!$D(DUOUT) S GMRCQUT=1 Q  ;Returns GMRCAD as the entered date.
 ; S GMRCSTS=$S(GMRCA=6:1,1:13),$P(GMRC(0),"^",12)=GMRCSTS
 ; S GMRCOM=1
 ; D STATUS^VEGMRCP
 ; D AUDIT^VEGMRCP
 ;
 ; S GMRCORTX=$S($L($G(GMRCACTM)):GMRCACTM,+GMRCA:$P(^GMR(123.1,GMRCA,0),U,1),1:"ACTION UNKNOWN FOR")_" consult "
 ; blj/dss 14/6/2000 Routine ^VEGMRCAU doesn't exist.
 ; $$ORTX^VEGMRCAU(+GMRCO)
 ; S ORBADUZ="",GMRCFL=0
 ; I +$P($G(^GMR(123,+GMRCO,0)),"^",14),+$P(^(0),"^",14)'=DUZ S ORBADUZ($P(^(0),"^",14))=""
 ; I +$P($G(^GMR(123,+GMRCO,0)),"^",14)=DUZ S GMRCFL=1
 ;send notification info to routine to be sent to OERR
 ; D MSG^VEGMRCP(GMRCDFN,GMRCORTX,+GMRCO,$S(GMRCA=6:23,1:30),.ORBADUZ,GMRCFL)
 ; Q
