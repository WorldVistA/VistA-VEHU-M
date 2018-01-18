AQASRON ; SLC/JER,KER - Surgery Reports ; 11/02/1998
 ;;2.7;Health Summary;**11,28**;Oct 20, 1995
 ;;MOD-GCD/Prov: 8/13/99
 ;;copied from GMTSRON and modified for local tiu
 ;;object for non-or surgery rpt
WRT ; Write surgical case record
 N X,GMI,GMDT,ICD,ICD9,OPPRC,PAN,PRDX,PROVIDER,SPEC,STATUS,VER,ATTENDNG,Y
 I $P($G(^SRF(GMN,"NON")),U)'="Y" Q
 S GMCOUNT=GMCOUNT+1
NONOR ;Get NON-OR information
 S X=$P(^SRF(GMN,"NON"),U,3) D REGDT4^GMTSU S GMDT=X
 D STATUS^GMTSROB S:'$D(STATUS) STATUS="UNKNOWN"
 S X=$P(^SRF(GMN,"NON"),U,8) I X>0 D
 . S Y=X,C=$P(^DD(130,125,0),U,2) D Y^DIQ S SPEC=Y K Y
 . I $L($G(SPEC))>25 S SPEC=$$WRAP^GMTSORC(SPEC,25)
 S X=$P(^SRF(GMN,"NON"),U,6) I X>0 D
 . S Y=X,C=$P(^DD(130,123,0),U,2) D Y^DIQ S PROVIDER=Y K Y
 S X=$P(^SRF(GMN,"NON"),U,7) I X>0 D
 . S Y=X,C=$P(^DD(130,124,0),U,2) D Y^DIQ S ATTENDNG=Y K Y
 S X=$P($G(^SRF(GMN,.3)),U) I X>0 S Y=X,C=$P(^DD(130,.31,0),U,2) D Y^DIQ S PAN=Y K Y
WRT1 S VER=$S($G(^SRF(GMN,"VER"))'="Y":"(Unverified)",1:"")
 S PRDX=$S($G(^SRF(GMN,33))]"":$P(^(33),U,2),1:"")
 S ICD9="Unknown" S ICD=$S($G(^SRF(GMN,34))]"":$P(^(34),U,2),1:"") S:ICD]"" ICD9=" (ICD9 Code: "_$P($G(^ICD9(ICD,0)),U)_")"
 S OPPRC(0)=$P($G(^SRF(GMN,"OP")),U) S:$P(^SRF(GMN,"OP"),U,2)]"" OPPRC(0)=OPPRC(0)_" - "_$P($$CPT^ICPTCOD($P($G(^SRF(GMN,"OP")),U,2),""),U,3)_" (CPT Code: "_$P(^SRF(GMN,"OP"),U,2)_")" D
 . S GMI=0 F  S GMI=$O(^SRF(GMN,13,GMI)) Q:GMI'>0  S OPPRC(GMI)=$P($G(^SRF(GMN,13,GMI,0)),U) D
 . . S:$P($G(^SRF(GMN,13,GMI,2)),U)]"" OPPRC(GMI)=OPPRC(GMI)_" - "_$P($$CPT^ICPTCOD($P($G(^SRF(GMN,13,GMI,2)),U),""),U,3)_" (CPT Code: "_$P(^SRF(GMN,13,GMI,2),U)_")"
 S LINE=LINE+1,@TARGET@(LINE,0)="NON-OR Surgery Date: "_GMDT_"     "_$P($G(SPEC),"|")
 F GMI=2:1:$L($G(SPEC),"|") D
 .S LINE=LINE+1,@TARGET@(LINE,0)=$P($G(SPEC),"|",GMI)
 S GMI="" F  S GMI=$O(OPPRC(GMI)) Q:GMI=""  D
 .S OPPRC=$S($L(OPPRC(GMI))'>55:OPPRC(GMI),1:$$WRAP^GMTSORC($P(OPPRC(GMI),U),55)) F GMJ=1:1:$L($P(OPPRC,U),"|") D WRTPRC
 Q
WRTPRC ; Writes operative procedures
 S LINE=LINE+1,@TARGET@(LINE,0)=$S(GMJ=1:21,1:22)_" "_$P($P(OPPRC,U),"|",GMJ)
 S:GMJ=1&($P(OPPRC,U,2)]"") @TARGET@(LINE,0)=@TARGET@(LINE,0)_" - "_$P(OPPRC,U,2)
 Q
