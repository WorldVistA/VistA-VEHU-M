ENLOG12 ;(WASH ISC)/DH-Add LOG1 to AEMS/MERS ;1-31-92
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 I $D(ENADLOG("CKCOST")),$D(^ENZ(6914.5,ENLOG,1)) S ENCOST=$P(^(1),U,3) I ENCOST]"",ENCOST<300,$P(^(0),U,6)'=2 Q  ;Expendable item
ADD L ^ENG(6914,0) S X=$P(^ENG(6914,0),U,3)
IEN S X=X+1 I $D(^ENG(6914,X)) G IEN
 K DD,DO S DIC="^ENG(6914,",DIC(0)="X",DINUM=X
 D FILE^DICN L  Q:+Y'>0  S ENMERS=+Y
 L ^ENG(6914,ENMERS) S EN=^ENZ(6914.5,ENLOG,0),ENNXRN=$P(EN,U),$P(^ENG(6914,ENMERS,2),U,7)=ENNXRN
 S ENCMR=$P(EN,U,4) I ENCMR]"" S ENCMR(0)=$S($D(^ENG(6914.1,"B",ENCMR)):$O(^ENG(6914.1,"B",ENCMR,0)),1:"") D:ENCMR(0)="" ADDCMR S $P(^ENG(6914,ENMERS,2),U,9)=$S(ENCMR(0)]"":ENCMR(0),1:ENCMR)
 S ENPMN=$P(EN,U,2) I ENPMN]"" S $P(^ENG(6914,ENMERS,3),U,6)=ENPMN
 S ENUSE=$P(EN,U,5) I ENUSE]"" S $P(^ENG(6914,ENMERS,3),U)=ENUSE
 S ENOWN=$P(EN,U,6) I ENOWN]"" S $P(^ENG(6914,ENMERS,3),U,4)=ENOWN
 G:'$D(^ENZ(6914.5,ENLOG,1)) SN S EN=^ENZ(6914.5,ENLOG,1)
 S ENPO=$P(EN,U) I ENPO]"" S $P(^ENG(6914,ENMERS,2),U,2)=ENPO
 S ENAD=$P(EN,U,2) I ENAD]"" S $P(^ENG(6914,ENMERS,2),U,4)=ENAD
 S ENCOST=$P(EN,U,3)
 I ENCOST>0,ENOWN=2 S $P(^ENG(6914,ENMERS,2),U,3)="",$P(^(2),U,12)=ENCOST
 I ENCOST>0,ENOWN'=2 S $P(^ENG(6914,ENMERS,2),U,3)=ENCOST,$P(^(2),U,12)=""
 S ENLIFE=$P(EN,U,4) I ENLIFE]"" S $P(^ENG(6914,ENMERS,2),U,6)=ENLIFE
 S ENRD=$P(EN,U,5) I ENRD]"" S $P(^ENG(6914,ENMERS,2),U,10)=ENRD
 S ENCSN=$P(EN,U,6) I ENCSN]"" D CSNPTR
SN G:'$D(^ENZ(6914.5,ENLOG,2)) SPEX S EN=^ENZ(6914.5,ENLOG,2)
 S ENSN=$P(EN,U,3) I ENSN]"" S $P(^ENG(6914,ENMERS,1),U,3)=ENSN
 S ENSORC=$P(EN,U,5) I ENSORC]"",ENSORC'=9,ENSORC'=10 S $P(^ENG(6914,ENMERS,2),U,14)=ENSORC
SPEX I $D(^ENZ(6914.5,ENLOG,21)) D SPEX^ENLOG13
 S $P(^ENG(6914,ENMERS,0),U,4)="NX",$P(^ENZ(6914.5,ENLOG,31),U,2)=1
 S ENLDGR=$S($D(^ENZ(6914.5,ENLOG,2)):$P(^(2),U,7),1:"") I ENLDGR]"",'$D(^ENG(6914,ENMERS,8)) S $P(^ENG(6914,ENMERS,8),U,6)=ENLDGR
 I ENLDGR]"",$P(^ENG(6914,ENMERS,8),U,6)="" S $P(^(8),U,6)=ENLDGR
 L
 Q  ;Return to ENLOG10 for next record
 ;
CSNPTR I ENCSN?10N S X=$E(ENCSN,1,4)_"-"_$E(ENCSN,5,10)
 E  S X=ENCSN
 I $D(^ENCSN(6917,"B",X)) S ENCSN(0)=$O(^ENCSN(6917,"B",X,0)) I ENCSN(0)>0,$D(^ENCSN(6917,ENCSN(0),0)) S X=ENCSN(0)
 S $P(^ENG(6914,ENMERS,2),U,8)=X
 Q
 ;
ADDCMR S DIC="^ENG(6914.1,",DIC(0)="LX",X=ENCMR K DD,DO D FILE^DICN
 I Y>0 S ENCMR(0)=+Y
 Q
 ;ENLOG12
