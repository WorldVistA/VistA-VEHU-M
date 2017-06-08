ICD142A1 ;ALB/EG/ABR - ADD NEW ICD DX/OPS/UPDATES ;DEC 15, 1993
 ;;14.0;DRG Grouper;**2**;Apr 03, 1997
ACT ;activate VA expanded diagnosis and procedure codes
 N DA,I,J,X,Y,Y1,STR
 D BMES^XPDUTL("Inactivating the following ICD Operation/Procedure and Diagnosis Codes")
 F I=1:1 S X=$P($T(DX+I),";;",2) Q:X=""  F J=1:1 S DA=$P(X,"^",J),REF=$S(DA>0:"^ICD9",1:"^ICD0") Q:'DA  S DA=$S(DA<0:DA*(-1),1:DA),Y=@REF@(DA,0),Y1=$S($D(^(1))>0:$E($P(^(1),"^"),1,60),1:0) I DA'=0&(ICDDEBUG) D ACT1
 Q
ACT1 Q:ICDTEST=1
 S $P(@REF@(DA,0),"^",9)=1,$P(@REF@(DA,0),"^",11)=2971001 S Y=@REF@(DA,0),Y1=$S($D(^(1))>0:$E($P(^(1),"^"),1,60),1:0) I ICDDEBUG D DEBUG
 Q
DEBUG S STR=" "_$P(Y,"^")_"     "_$S(Y1'=0&($L(Y1)>0):Y1,1:$S(REF["9":$P(Y,"^",3),1:$P(Y,"^",4)))
 D MES^XPDUTL(STR)
 Q
DX ;Diagnosis codes to inactivate, 11 ifn's per line, proc. codes prefaced by '-'
 ;;8180^974^9071^9104^9575^5225^5405^10133^11244^11342^11381
 ;;11522^11549^11595^11778
 ;;
 ;;
 Q
