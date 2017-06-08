PRCF88 ;WCIOFO/ERC-Enter Disc. or Late Pay date in 421.5 ; 7/7/97
V ;;5.0;IFCAP;**88**;4/21/95
 ; This routine is to be used as a post-init routine for patch
 ; PRC*5*88, stuffing dates in the Discount Date field and/or
 ; the Late Payment fields of file 421.5 (Invoice Tracking File)
 ; so that the Late Payment Report will function properly.  It
 ; is not called from any IFCAP routines or Data Dictionaries.
 ;
 N DISC,INVDT,J,NDISC,NET,NODE0,NODE2,NODE6,PRCFDT1,PRCFDT2,PRCFINV
 N SVCDT,X,X1,X2
 S PRCFINV=0
 F  S PRCFINV=$O(^PRCF(421.5,PRCFINV)) Q:'PRCFINV  D
 . ; Quit if the transaction is complete
 . S NODE2=$G(^PRCF(421.5,PRCFINV,2)) Q:NODE2=""!(+NODE2>19)
 . S PRCFDT1=$P(NODE2,U,6),PRCFDT2=$P(NODE2,U,7)
 . I $G(PRCFDT1)]""!($G(PRCFDT2)]"") Q
 . Q:'$D(^PRCF(421.5,PRCFINV,6))
 . S NODE0=$G(^PRCF(421.5,PRCFINV,0))
 . S INVDT=$P(NODE0,U,5),SVCDT=$P(NODE0,U,21)
 . I '$G(INVDT),('$G(SVCDT)) Q
 . S DISC=-1
 . S J=0 F  S J=$O(^PRCF(421.5,PRCFINV,6,J)) Q:+J'>0  D
 . . S NODE6=$G(^PRCF(421.5,PRCFINV,6,J,0)) Q:NODE6=""
 . . I $P(NODE6,U,3)="NET",$P(NODE6,U,5)>0 S NET=$P(NODE6,U,5)
 . . I "NET"'[$P(NODE6,U,3),$P(NODE6,U,5)>0 D
 . . . S NDISC=$P(NODE6,U,5) I DISC=-1 S DISC=NDISC
 . . . I NDISC<DISC S DICS=NDISC
 . I $G(DISC)>0 S X1=INVDT,X2=DISC D C^%DTC S $P(^PRCF(421.5,PRCFINV,2),U,6)=X
 . I $G(NET)]"" D
 . . I INVDT>SVCDT S X1=INVDT,X2=NET D C^%DTC S $P(^PRCF(421.5,PRCFINV,2),U,7)=X
 . . I INVDT'>SVCDT S X1=SVCDT,X2=NET D C^%DTC S $P(^PRCF(421.5,PRCFINV,2),U,7)=X
 Q
