MAGDLB4 ;WIRMFO/LB ;Patient lookup in Radiology files[ 05/09/2000  15:31 PM ]
 ;;2.5T;DICOM41F;;6-October-1999
 ;;
 ;; ********************************************************************
 ;; ********************************************************************
 ;; **  Property of the US Government.  No permission to copy or      **
 ;; **  redistribute this software is given. Use of this software     **
 ;; **  requires the user to execute a written test agreement with    **
 ;; **  the VistA Imaging Development Office of the Department of     **
 ;; **  Veterans Affairs, telephone (301) 734-0100.                   **
 ;; **                                                                **
 ;; **  The Food and Drug Administration classifies this software as  **
 ;; **  a medical device.  As such, it may not be changed in any way. **
 ;; **  Modifications of the software may result in an adulterated    **
 ;; **  medical device under 21CFR820 and may be a violation of US    **
 ;; **  Federal Statutes.                                             **
 ;; ********************************************************************
 ;; ********************************************************************
 ;;
 ;
 Q:'$D(MAGDFN)
 N MAGCN,MAGCNI,MAGCNT,MAGDATE,MAGDTE,MAGDTI,MAGDTPRT,MAGELOC,MAGERR
 N MAGF1,MAGHEAD,MAGIMGTY,MAGNME,MAGPRC,MAGREPOR,MAGRPT,MAGSSN,MAGST
 N MAGCSE,MAGSTP,MAGTESC,MAGTFL,MAGPIEN,PC,P,PP,X,Y
 S MAGHEAD="Case Lookup by Patient",P="Print set for "
 ; needed if not called by another routine.
CASE D SEL
 S:'MAGCNT X="^" G Q:X="^"!($D(MAGF1))
 S MAGDFN=$P(Y,"^"),MAGDTI=$P(Y,"^",2),MAGCNI=$P(Y,"^",3)
 S MAGNME=$P(Y,"^",4),MAGSSN=$P(Y,"^",5),MAGCN=$P(Y,"^",13)
 S MAGPRC=$P(Y,"^",9),MAGPIEN=$P(Y,"^",12),PP=$P(Y,"^",14)
 S MAGDY=MAGDFN_"^"_MAGNME_"^"_MAGSSN_"^"_MAGCN_"^"_MAGPRC
 S MAGDY=MAGDY_"^"_MAGDTI_"^"_MAGCNI_"^"_MAGPIEN_"^"_PP
 S MAGDY(0)=^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI,0)
Q K AA,^TMP($J,"MAGEX") Q
 ;
SEL Q:'$D(^DPT(MAGDFN,0))
 S MAGNME=^(0),MAGSSN=$P(MAGNME,"^",9),MAGNME=$P(MAGNME,"^")
 K ^TMP($J,"MAGEX") D HD S X="",MAGCNT=0
 S X=""
 F MAGDTI=0:0 Q:X="^"!(X>0)  S MAGDTI=$O(^RADPT(MAGDFN,"DT",MAGDTI)) Q:MAGDTI'>0  D
 . I $D(^(MAGDTI,0)) S MAGDTE=+^(0),(PP,PC)="" D
 . . F MAGCNI=0:0 S MAGCNI=$O(^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI)) Q:MAGCNI'>0  D  Q:X="^"!(X>0)
 . . . I $D(^(MAGCNI,0)) S MAGCN=^(0) D PRT Q:X="^"!(X>0)
 Q:X="^"!(X>0)  I 'MAGCNT W !?3,*7,"No matches found!" Q
 D ASK^MAGDLB3 S:X="" X="^" Q
PRT ;
 I $P(MAGCN,"^",25)=2 S PC=$S(MAGCNI>1:".",1:"+")
 I PC="." S PP=P_+MAGCN
 S MAGRPT=+$P(MAGCN,"^",17),MAGST=+$P(MAGCN,"^",3)
 S MAGPIEN=$P(MAGCN,"^",2)
 S MAGPRC=$S($D(^RAMIS(71,+$P(MAGCN,"^",2),0)):$P(^(0),"^"),1:"Unknown"),MAGCN=+MAGCN
 I MAGRPT,$D(^RARPT(+MAGRPT,2005)) S MAGPRC="(i)"_MAGPRC
 S (MAGDTPRT,Y)=MAGDTE D DT^MAGDLB2 S MAGDATE=Y
 I +MAGRPT,$D(^RARPT(+MAGRPT,0)) S MAGCSE=$P(^RARPT(+MAGRPT,0),"^")
 E  S MAGCSE=+MAGCN
 S MAGELOC=$P($G(^SC(+$P($G(^RA(79.1,+$P($G(^RADPT(MAGDFN,"DT",MAGDTI,0)),U,4),0)),U),0)),U)
 S MAGDTPRT=$E(MAGDTPRT,4,5)_"/"_$E(MAGDTPRT,6,7)_"/"_$E(MAGDTPRT,2,3)
 S MAGCNT=MAGCNT+1
 S ^TMP($J,"MAGEX",MAGCNT)=MAGDFN_"^"_MAGDTI_"^"_MAGCNI_"^"_MAGNME_"^"_MAGSSN_"^"_MAGDATE_"^"_MAGDTE_"^"_MAGCN_"^"_MAGPRC_"^"_MAGRPT_"^"_MAGST_"^"_MAGPIEN_"^"_MAGCSE_"^"_PP
 I $D(MAGREPOR) D
 . S MAGSTP=$S($D(^RARPT(MAGRPT,0)):$P(^(0),"^",5),1:"")
 . S AA=$P(^RADPT(+MAGDFN,"DT",MAGDTI,0),"^",2)
 . S MAGIMGTY=$P($G(^RA(79.2,AA,0)),"^")
 . I MAGIMGTY="" S MAGIMGTY="Unkown"
 . S MAGSTP=$S(MAGSTP="V":"VERIFIED",MAGSTP="PD":"PROBLEM DRAFT",MAGSTP="D":"DRAFT",MAGSTP="R":"RELEASED/NOT VERIFIED",1:"None"_$S($D(^RA(72,"AA",MAGIMGTY,0,+MAGST)):" (Exam Dc'd)",1:""))
 . Q
 I '$D(MAGREPOR) S MAGSTP=$S($D(^RA(72,MAGST,0)):$P(^(0),"^"),1:"Unknown")
 W !,MAGCNT,?5,MAGCN_PC,?13,$E(MAGPRC,1,26),?41,MAGDTPRT
 W ?52,$E(MAGSTP,1,16),?69,$E(MAGELOC,1,11)
 I (($Y+6)>IOSL),($O(^RADPT(MAGDFN,"DT",MAGDTI,"P",MAGCNI))!($O(^RADPT(MAGDFN,"DT",MAGDTI)))) D ASK^MAGDLB3 W @IOF
 Q
 ;
HD I $Y+6>IOSL D
 . W @IOF,?25,MAGHEAD,!!,"Patient's Name: ",$E(MAGNME,1,20),"  ",MAGSSN
 . W ?55,"Run Date: " S Y=DT D DT^DIO2
 I $Y+6>IOSL Q:$D(MAGTESC)  W !!,"============================ Exam Procedure Profile =========================="
 W !!?3,"Case No.",?13,"Procedure",?41,"Exam Date",?52,"Status of "
 W $S($D(MAGREPOR):"Report",1:"Exam"),?69,"Imaging Loc"
 W !?3,"--------",?13,"-------------",?41,"---------",?52,"----------------",?69,"-----------" Q
 ;
 Q
