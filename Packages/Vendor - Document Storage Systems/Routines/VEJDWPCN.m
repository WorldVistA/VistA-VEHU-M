VEJDWPCN ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;5.0;Radiology/Nuclear Medicine;**1**;Mar 16, 1998
 ;RAO7PC2 ;HISC/GJC-Part two for Return Narrative (EN3^RAO7PC1);1/17/95 ;10/28/97  10:59
CASE(Y) ; Retrieve exam data for specified inverse exam date range.
 ; 'Y'-> Exam node IEN
 N RABNOR,RACNT,RAEXAM,RAIMPRES,RAINCLUD,RAOPRC,RAORD,RAPDIAG,RAPROC
 N RARPT,RARPTST,RARPTXT,RASBN,RASDIAG,RAVER,Z,Z1,Z2 S RACNT=1
 S RAEXAM(0)=$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,0)) Q:RAEXAM(0)']""
 S:$P(RAEXAM(0),"^",25)=2 RAPSET=1
 S:RAPSET=1 ^TMP($J,"RAE2",RADFN,"PRINT_SET")="" ; xam set with same rpt
 S RAPROC(0)=$G(^RAMIS(71,+$P(RAEXAM(0),"^",2),0))
 S RAPROC=$S($P(RAPROC(0),"^")]"":$P(RAPROC(0),"^"),1:"Unknown")
 S RAORD(0)=$G(^RAO(75.1,+$P(RAEXAM(0),"^",11),0))
 S RAORD(7)=$P(RAORD(0),"^",7) ; CPRS order ien
 S RAOPRC(0)=$G(^RAMIS(71,+$P(RAORD(0),"^",2),0))
 S RAOPRC=$S($P(RAOPRC(0),"^")]"":$P(RAOPRC(0),"^"),1:"Unknown")
 S RAPDIAG(0)=$G(^RA(78.3,+$P(RAEXAM(0),"^",13),0))
 S RAPDIAG=$P(RAPDIAG(0),"^"),RARPT=+$P(RAEXAM(0),"^",17)
 S RARPT(0)=$G(^RARPT(RARPT,0)),RARPTST=$P(RARPT(0),"^",5)
 S RARPTST=$S(RARPTST="V":"Verified",RARPTST="R":"Released/Not verified",RARPTST="D":"Draft",RARPTST="PD":"Problem Draft",1:"No Report")
 ; set the following flag variable: RAINCLUD
 ; RAINCLUD=$S(RPT STATUS=verif'd or released/unverif'd:1,1:0)
 S RAINCLUD=$S("RV"[$E(RARPTST):1,1:0)
 I $E(RARPTST)="V",(RAPSET'<0) D
 . S RAVER=$P(RARPT(0),"^",9),RASBN=$P($G(^VA(200,+RAVER,20)),"^",2)
 . S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"V")=RAVER_"^"_RASBN
 . Q
 S RABNOR=$$UP^XLFSTR($P(RAPDIAG(0),"^",4)) S:RABNOR'="Y" RABNOR=""
 I RAPDIAG]"",(RAINCLUD),(RAPSET'<0) D  ; if diag & verif'd or released/unverif'd & first pass if part of xam set (many xams - one rpt)
 . S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"D",RACNT)=RAPDIAG
 . Q
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"H",0)) D  ; save clin history
 . N RAI S (RAI,Z)=0
 . F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"H",Z)) Q:Z'>0  D
 .. S RAI=RAI+1
 .. S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"H",RAI)=$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"H",Z,0))
 .. Q
 . Q
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"M",0)) D  ; save modifiers
 . N RAI S (RAI,Z)=0
 . F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"M",Z)) Q:Z'>0  D
 .. S RAI=RAI+1
 .. S ^TMP($J,"RAE2",RADFN,Y,RAPROC,"M",RAI)=$P($G(^RAMIS(71.2,+$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"M",Z,0)),0)),"^")
 .. Q
 . Q
 I +$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"DX",0)),(RAPSET'<0) D
 . S Z=0 F  S Z=$O(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"DX",Z)) Q:Z'>0  D
 .. S RASDIAG=+$G(^RADPT(RADFN,"DT",RAINVXDT,"P",Y,"DX",Z,0))
 .. S RASDIAG(0)=$G(^RA(78.3,RASDIAG,0)),RASDIAG(1)=$P(RASDIAG(0),"^")
 .. I RASDIAG(1)]"",(RAINCLUD) D
 ... S RACNT=RACNT+1,^TMP($J,"RAE2",RADFN,Y,RAPROC,"D",RACNT)=RASDIAG(1)
 ... I RABNOR'="Y" D
 .... S RABNOR=$$UP^XLFSTR($P(RASDIAG(0),"^",4)) S:RABNOR'="Y" RABNOR=""
 .... Q
 ... Q
 .. Q
 . Q
 I RAINCLUD,(RAPSET'<0) D
 . I +$O(^RARPT(RARPT,"I",0)) S Z="I" D RPTXT(RARPT,Z)
 . I +$O(^RARPT(RARPT,"R",0)) S Z="R" D RPTXT(RARPT,Z)
 . Q
 I $P(RAEXAM(0),"^",25) S ^TMP($J,"RAE2",RADFN,"ORD")=RAOPRC
 I '$P(RAEXAM(0),"^",25) S ^TMP($J,"RAE2",RADFN,"ORD",Y)=RAOPRC
 S:RAPSET'<0 ^TMP($J,"RAE2",RADFN,Y,RAPROC)=RARPTST_"^"_$G(RABNOR)_"^"_$G(RAORD(7))
 S:RAPSET<0 ^TMP($J,"RAE2",RADFN,Y,RAPROC)=""
 S:RAPSET=1 RAPSET=-1
 Q
RPTXT(RARPT,Z) ; Retrieve report text & store in ^TMP
 ; 'RARPT' -> Report IEN
 ; 'Z'     -> "I":Impression Text <> "R":Report Text
 S (Z1,Z2)=0
 F  S Z1=$O(^RARPT(RARPT,Z,Z1)) Q:Z1'>0  D
 . S Z1(0)=$G(^RARPT(RARPT,Z,Z1,0)),Z2=Z2+1
 . S ^TMP($J,"RAE2",RADFN,Y,RAPROC,Z,Z2)=Z1(0)
 . Q
 Q
