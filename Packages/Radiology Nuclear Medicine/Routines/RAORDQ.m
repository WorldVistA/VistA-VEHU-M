RAORDQ ;HISC/CAH,FPT AISC/RMO-Queue Exam Request ; Jun 30, 2023@10:36:10
 ;;5.0;Radiology/Nuclear Medicine;**13,15,169,205**;Mar 16, 1998;Build 1
 ;
 ;w/RA*5.0*169 backdoor orders rejected by CPRS still prints
 ;a request (the RIS files pending before CPRS returns the
 ;cancellation) quitting on $D(RADERR) will prevent the print.
 I $D(RADERR)#2 K RADERR Q  ;gjc RA5P169
 S:$D(RALOCFLG) RALOC=+$P(RAORD0,"^",20)
 ; Find 1st Imaging Location for Imaging Type, or default to 1st on file.
 ;
 ;*** P205/GJC from: ^RA(79.1,RALOC,"DIV")=+RADIV     ***
 ;***            to: $G(^RA(79.1,RALOC,"DIV"))=+RADIV ***
 ;
 I '$D(RALOCFLG) D  S:RALOC="" RALOC=+$O(^RA(79,+RADIV,"L",0))
 .S RALOC=""
 .F  S RALOC=$O(^RA(79.1,"BIMG",RAIMGTYI,RALOC)) Q:RALOC=""  I $P(^RA(79.1,RALOC,0),U,16)]"",$G(^RA(79.1,RALOC,"DIV"))=+RADIV Q
 S RAREQPRT=$S($D(^RA(79.1,+RALOC,0)):$P(^(0),"^",16),1:"")
 Q:RAREQPRT']""
 S RAREQPRT=$P($G(^%ZIS(1,RAREQPRT,0)),"^") Q:RAREQPRT']""
 S RAGMTS=+$P($G(^RAMIS(71,+$P($G(^RAO(75.1,RAOIFN,0)),"^",2),0)),"^",13)
 S RAHSMULT(RAGMTS,RADFN)=+$G(RAHSMULT(RAGMTS,RADFN))+1
 S ION=RAREQPRT,IOP="Q;"_ION,ZTSAVE("RADFN")="",ZTSAVE("RAOIFN")=""
 S ZTSAVE("RALOC")="",ZTSAVE("RAGMTS")="",ZTSAVE("RAHSMULT(")=""
 S:$D(RAOPT) ZTSAVE("RAOPT(")="" S:$D(RAFOERR) ZTSAVE("RAFOERR")=""
 S ZTDTH=$H,ZTRTN="PRTORD^RAORDQ"
 S:'$D(RAMES) RAMES="W !?5,""...request has been submitted to "",ION,""."",!"
 D ZIS^RAUTL K IOP,RALOC,RAREQPRT
 Q
 ;
PRTORD ; Print Health Summary if applicable
 ; RAORD0 is defined in RAORD5
 U IO S RAX="",RAPGE=0 D ^RAORD5
 S GMTSTYP=RAGMTS
 I GMTSTYP>0,($G(RAHSMULT(RAGMTS,RADFN))'>1) D
 . W:$Y>0 @IOF D ENX^GMTSDVR(RADFN,GMTSTYP)
 . Q
 K RAOIFN,RAPGE,RAX
 I GMTSTYP>0,($G(RAHSMULT(RAGMTS,RADFN))'>1) K GMTSTYP,RADFN Q
 K GMTSTYP,RADFN W ! D CLOSE^RAUTL
 Q
OERR ;OERR ENTRY POINT TO PRINT/DISPLAY A RAD/NUC MED REPORT
 F RAI=0:0 S RAI=$O(RADUP(RAI)) Q:RAI'>0  S X=^TMP($J,"RAEX",RAI),RADUP(RAI)=$P(X,"^",10)_"^"_$P(X,"^",8)
 S ZTSAVE("RADUP(")="",ZTRTN="DQ^RAORDQ",ZTDESC="Print Rad/Nuc Med Reports" D ZIS^RAUTL G Q:RAPOP I IO=IO(0) D OERR^RART1 G Q
DQ U IO F RAI1=0:0 S RAI1=$O(RADUP(RAI1)) Q:RAI1'>0  S RARPT=+RADUP(RAI1),RACN=$P(RADUP(RAI1),"^",2) D CHK^RART1 D:$D(RARPT) ^RARTR
Q I $D(RAMIE) F RAI1=0:0 S RAI1=$O(^RA(78.7,RAI1)) Q:RAI1'>0  I $D(^(RAI1,0)) K @$P(^(0),"^",5)
 K RAI1,RADUP,RACN,RARPT,RAPOP D:'$D(RAMIE) CLOSE^RAUTL Q
