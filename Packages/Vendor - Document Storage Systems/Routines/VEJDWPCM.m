VEJDWPCM ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;5.0;Radiology/Nuclear Medicine;**1**;Mar 16, 1998
 ;RAO7PC1A ;HISC/GJC-Procedure Call utilities (cont) ;11/18/97  13:01
SETDATA ; Called from within the EN1 subroutine of RAO7PC1
 ; Sets the ^TMP($J,"RAE1",patient ien,Exam ID) node.
 ; See EN1^RAO7PC1 for further explanation.
 S RANO=0,RAREX(0)=$G(^RADPT(RADFN,"DT",RAIBDT,0))
 S RAITY=+$P(RAREX(0),"^",2),RAILOC=+$P(RAREX(0),"^",4)
 S RAILOC=$P($G(^SC(+$P($G(^RA(79.1,RAILOC,0)),"^"),0)),"^")
 S RAITY(0)=$G(^RA(79.2,RAITY,0))
 F  S RANO=$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO)) Q:RANO'>0  D  Q:RAXIT
 . S RAXAM(0)=$G(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,0))
 . S RAORDER=+$P(RAXAM(0),"^",11)
 . S RAORDER(7)=$P($G(^RAO(75.1,RAORDER,0)),"^",7) ; CPRS order ien
 . S RAXSTAT=+$P(RAXAM(0),"^",3),RAXSTAT(0)=$G(^RA(72,RAXSTAT,0))
 . S RAXID=RAIBDT_"-"_RANO
 . S RACSE=$S($P(RAXAM(0),U)]"":$P(RAXAM(0),U),1:"Unknown")
 . S RAPRC=$G(^RAMIS(71,+$P(RAXAM(0),U,2),0))
 . S RACPT=+$P(RAPRC,"^",9) ; pntr to 81
 . S RACPT=$S($D(^ICPT(RACPT,0)):$P(^(0),"^"),1:"")
 . S RAPRC=$S($P(RAPRC,U)]"":$P(RAPRC,U),1:"Unknown")
 . Q:$P($G(^RA(72,+$P(RAXAM(0),"^",3),0)),"^",3)=0  ; cancelled xam
 . S RADIAG=+$P(RAXAM(0),U,13),RARPT=+$P(RAXAM(0),U,17)
 . S RABNOR=$$UP^XLFSTR($P($G(^RA(78.3,RADIAG,0)),U,4))
 . S:RABNOR'="Y" RABNOR=""
 . S RABNORMR=$$UP^XLFSTR($P($G(^RA(78.3,RADIAG,0)),U,3))
 . S:RABNORMR'="Y" RABNORMR=""
 . S RARPTST=$P($G(^RARPT(RARPT,0)),U,5)
 . S RARPTST=$S(RARPTST="V":"Verified",RARPTST="R":"Released/Not verified",RARPTST="D":"Draft",RARPTST="PD":"Problem Draft",1:"No Report")
 . S ^TMP($J,"RAE1",RADFN,RAXID)=RAPRC_U_RACSE_U_RARPTST_U_RABNOR_U_$S(RARPT=0:"",1:RARPT)_U_$P(RAXSTAT(0),"^",3)_"~"_$P(RAXSTAT(0),"^")_U_RAILOC_U_$P(RAITY(0),"^",3)_"~"_$P(RAITY(0),"^")_U_RABNORMR_U_RACPT_U_$G(RAORDER(7))
 . S RACNT=RACNT+1 S:RACNT=RAEXN RAXIT=1
 . K RAXSTAT,RAORDER
 . Q
 K RAILOC,RAITY
 Q
CASE ; Return the case numbers and the total number of case numbers
 ; associated with a particular order.  Called from CASE^RAO7PC1.
 ; Sets RARRAY(case #)="" for all cases associated with an order.
 ; Sets first piece of RATTL to the number of cases found for an
 ; order, and the second piece is PRINTSET if the report covers
 ; multiple cases.  See CASE^RAO7PC1 for more information.
 I '$D(^RAO(75.1,RAOIFN,0))#2 S RATTL="-1^invalid order ien" Q
 I '$D(^RADPT("AO",RAOIFN)) D  Q  ; case has yet to be registered
 . S RATTL="-2^no case registered to date"
 . Q
 N RACNI,RADFN,RADTI,RAEXAM S RADFN=0
 F  S RADFN=$O(^RADPT("AO",RAOIFN,RADFN)) Q:RADFN'>0  D
 . S RADTI=0
 . F  S RADTI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI)) Q:RADTI'>0  D
 .. S RACNI=0
 .. F  S RACNI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 ... S RAEXAM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ... Q:$P($G(^RA(72,+$P(RAEXAM,"^",3),0)),"^",3)=0  ; xam cancelled
 ... S RATTL=+$G(RATTL)+1,@(RARRAY_"("_+RAEXAM_")")=""
 ... Q
 .. Q
 . Q
 I 'RATTL S RATTL="-2^cases cancelled" Q
 S:$P(RAEXAM,"^",25)=2 RATTL=RATTL_"^PRINTSET" ; combined reports
 Q
EN2 ; Return last 7 days of non-cancelled exams
 ; Required: RADFN (valid patient ien)
 ; Output:
 ; ^TMP($J,"RAE7",Patient IEN,Exam ID)=procedure name^case number^
 ;       report status^imaging location IEN^imaging location name^
 ;       m(edia) OR b(ARIUM) OR c(holecystogram)
 ;
 ; Exam ID: exam date/time (inverse) concatenated with the case IEN
 ;
 Q:'$D(RADFN)  Q:'RADFN  K ^TMP($J,"RAE7")
 N RABAR,RABDT,RACGRAM,RACNST,RACNTST,RACSE,RADT,RAEDT,RAIBDT
 N RAIEDT,RALOC,RAMEDIA,RANO,RAPRC,RAREX,RARPT,RARPTST,RAXAM,RAXID
 N RAXSTAT
 S RADT=$S($D(DT)#2:DT,1:$$DT^XLFDT()),RACNST=9999999.9999
 S RABDT=$$FMADD^XLFDT(RADT,-7,0,0,0),RAEDT=RADT
 S RAIBDT=RACNST-(RAEDT+.9999),RAIEDT=RACNST-(RABDT-.0001)
 F  S RAIBDT=$O(^RADPT(RADFN,"DT",RAIBDT)) Q:RAIBDT'>0!(RAIBDT>RAIEDT)  D
 . S RANO=0,RAREX(0)=$G(^RADPT(RADFN,"DT",RAIBDT,0))
 . S RALOC=+$P(RAREX(0),U,4),RALOC(0)=$G(^RA(79.1,RALOC,0))
 . S RALOC=$P($G(^SC(+RALOC(0),0)),"^")
 . F  S RANO=$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO)) Q:RANO'>0  D
 .. S RAXAM(0)=$G(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,0))
 .. S RAXID=RAIBDT_"-"_RANO
 .. S RACSE=$S($P(RAXAM(0),U)]"":$P(RAXAM(0),U),1:"Unknown")
 .. S RAPRC=$G(^RAMIS(71,+$P(RAXAM(0),U,2),0))
 .. S RAPRC=$S($P(RAPRC,U)]"":$P(RAPRC,U),1:"Unknown")
 .. Q:$P($G(^RA(72,+$P(RAXAM(0),"^",3),0)),"^",3)=0  ; cancelled xam
 .. S RABAR=$$UP^XLFSTR($P(RAXAM(0),U,5))
 .. S RABAR=$S(RABAR="Y":"b",1:"")
 .. S RACMEDIA=$$UP^XLFSTR($P(RAXAM(0),U,10))
 .. S RACMEDIA=$S(RACMEDIA="Y":"m",1:"")
 .. S RACGRAM=$S($D(^RAMIS(71,"AC",11,+$P(RAXAM(0),U,2))):"c",1:"")
 .. S RACNTST=RABAR_RACGRAM_RACMEDIA
 .. S RARPT=+$P(RAXAM(0),U,17)
 .. S RARPTST=$P($G(^RARPT(RARPT,0)),U,5)
 .. S RARPTST=$S(RARPTST="V":"Verified",RARPTST="R":"Released/Not verified",RARPTST="D":"Draft",RARPTST="PD":"Problem Draft",1:"No Report")
 .. S ^TMP($J,"RAE7",RADFN,RAXID)=RAPRC_U_RACSE_U_RARPTST_U_+RALOC(0)_U_RALOC_U_RACNTST
 .. Q
 . Q
 Q
