ZVHPSORD ;CSP RX DUPLICATION UTILITY [9/19/09 1:53pm]
 ;; 1.0 VeHU Utilities;;;;Build 1
 Q
EN ; START HERE PLEASE
 N ORZRESP,ORZPT,ORZPRV,ORZLOC,ORZDG,ORZDFDLG,ORZORD,ORZLST,ORZPT,ORZDLG,ORZREL
 N DIR,DTOUT,DIROUT,DIRUT,X,Y,DIC
 W !!,"Do you want to copy Rx's to O-outpatient I-inpatient or V-VEHU patients?"
 R !,"Enter O I or V : ",X
 Q:X=""!(X="^")
 S DIR(0)="LO^600:800"
 I X="V" S DIR(0)="L0^0:600"
 I X="I" S DIR(0)="LO^800:999"
 D PATS I '$D(^TMP("ORZPT",$J)) W !!,"It's all about the patients! Can't go on without them.",! D KILL Q
 R !,"ENTER THE RX NUMBER TO COPY FROM: ",RX
 Q:RX=""!(RX="^")
 S RXN=$O(^PSRX("B",RX,"")),PSODRUG=$P(^PSRX(RXN,0),"^",6)
 S PSOSITE=$P($G(^PSRX(RXN,2)),"^",9),PSODRUG("DEA")=$P($G(^PSDRUG(PSODRUG,0)),"^",3)
 S DIR(0)="YA",DIR("A")="Are you ready to proceed? " D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($G(Y)<1) D KILL Q
 S ORZPT=0
 F  S ORZPT=$O(^TMP("ORZPT",$J,ORZPT)) Q:'ORZPT  D
 . K ^TMP("ORZRX",$J)
 . M ^TMP("ORZRX",$J)=^PSRX(RXN)
 . D AUTO^PSONRXN
 . I $G(PSONEW("RX #"))="" W !," AUTONUMBERING ERROR " Q
 . S $P(^TMP("ORZRX",$J,0),"^")=PSONEW("RX #"),$P(^TMP("ORZRX",$J,0),"^",2)=ORZPT
 . W !,"RX # "_$P($G(^TMP("ORZRX",$J,0)),"^")
 . S PSOIEN=$P($G(^PSRX(0)),"^",3)+1
 . M ^PSRX(PSOIEN)=^TMP("ORZRX",$J)
 . S $P(^PSRX(0),"^",3)=PSOIEN
 . D OERR,F55,F52,F525
 . W !," ",$P(^DPT(ORZPT,0),U)," ...done"
 Q
OERR ;UPDATES OR1 NODE
 ;THE SECOND PIECE IS KILLED BEFORE MAKING THE CALL
 S $P(^PSRX(PSOIEN,"OR1"),"^",2)=""
 S PSXRXIEN=PSOIEN,STAT="SN",PSSTAT="CM",COMM="",PSNOO="W"
 D EN^PSOHLSN1(PSXRXIEN,STAT,PSSTAT,COMM,PSNOO)
F55 ; - File data into ^PS(55)
 S PSODFN=ORZPT
 S:'$D(^PS(55,PSODFN,"P",0)) ^(0)="^55.03PA^^"
 F PSOX1=$P(^PS(55,PSODFN,"P",0),"^",3):1 Q:'$D(^PS(55,PSODFN,"P",PSOX1))
 S ^PS(55,PSODFN,"P",PSOX1,0)=PSOIEN,$P(^PS(55,PSODFN,"P",0),"^",3,4)=PSOX1_"^"_($P(^PS(55,PSODFN,"P",0),"^",4)+1)
 S ^PS(55,PSODFN,"P","A",$P($G(^PSRX(PSOIEN,2)),"^",6),PSOIEN)=""
 K PSOX1
 Q
F52 ;; - Re-indexing file 52 entry
 K DIK,DA S DIK="^PSRX(",DA=PSOIEN D IX1^DIK K DIK
 Q
 ;
F525 ;UPDATE SUSPENSE FILE
 Q:$G(^PSRX(PSOIEN,"STA"))'=5
 S DA=PSOIEN,X=PSOIEN,FDT=$P($G(^PSRX(PSOIEN,2)),"^",2),TYPE=$P($G(^PSRX(PSOIEN,0)),"^",11)
 S DIC="^PS(52.5,",DIC(0)="L",DLAYGO=52.5,DIC("DR")=".02///"_FDT_";.03////"_$P(^PSRX(PSOIEN,0),"^",2)_";.04////"_TYPE_";.05///0;.06////"_PSOSITE_";2///0" K DD,D0 D FILE^DICN K DD,D0
 Q
 ;
PATS ; GET LIST OF PATIENTS TO UPDATE
 N PTARR
 W !!,"Select patients to enter med orders for. "
 W !,"Example: Outpatient has a range of 600-800.  Choosing 601-609 will copy Rx's to"
 W !,"Outpatients One through Nine.",!!
 S DIR("A")="Select patient(s) to be updated"
 K ^TMP("ORZPT",$J)
 D ^DIR K DIR Q:Y=""!($D(DUOUT))!($D(DTOUT))
 D PARSE(Y,.PTARR) S J=0 F  S J=$O(Y(J)) Q:'+J  D PARSE(Y(J),.PTARR)
 M ^TMP("ORZPT",$J)=PTARR
 Q
 ;
PARSE(ARRAY,LIST) ;
 N NUM,R,LNUM,L4,SSN
 S NUM=$L(ARRAY,",")-1
 F R=1:1:NUM S LNUM=$P(ARRAY,",",R) S L4=$S(LNUM=0:"0000",1:$E("000",1,(4-$L(LNUM)))_LNUM) D
 .S SSN="66600"_L4
 .I $D(^DPT("SSN",SSN)) S LIST($O(^DPT("SSN",SSN,0)))=""
 Q
 ;
KILL ; CLEAN UP ^TMP ARRAYS
 K ^TMP("ORZRSP",$J),^TMP("ORZPT",$J),^TMP("ORECALL",$J)
 Q
