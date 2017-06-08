VEJDSR0 ;AMC - Document Storage Systems;Surgery RPC's
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
UPDATE(AXY,IFN,ARRAY)   ;RPC - VEJD SR 130 UPDATE
 ;Input Variables
 ;       IFN - Internal Entry Number to file 130
 ;       ARRAY - 
 ;       Main Entry Level Data
 ;                 1              2                          3                                4                              5                                     6                       7                                    8                  9                              10  
 ;               MAIN ^ PRINCIPLE PROCEDURE (E) ^ PRINCIPLE PROCEDURE CODE (I;E) ^ MODIFIERS (See Modifier Note) ^ PRINCIPLE PRE-OP DIAGNOSIS (E) ^ PRINCIPLE DIAGNOSIS (E) ^ PRINCIPLE POST-OP DIAGNOSIS (E) ^ PRIN DIAGNOSIS CODE (I;E) ^ CODING COMPLETED BY (I;E) ^ DATE CODING COMPLETED
 ;                 1              2                3              4           5     6         7             8                 9                                              10
 ;               MAIN2 ^  SERVICE CONNECTED ^ AGENT ORANGE ^ ION RADIATION ^ MST ^ HNC ^ ENVIR CONTAM ^ COMBAT VET ^ CODING COMPLETE (1,0,"") ^ PRIN ASSOC DIAGNOSIS (Multiple IEN;DRG Code - patch 119 or 142)
 ;                       
 ;       Other Procedures Data
 ;                 1              2                      3                            4                                      5                                   6                                              7
 ;               OTHER ^ OTHER PROCEDURES IEN ^ OTHER PROCEDURE (E) ^ OTHER PROCEDURE CPT CODE (IEN - FILE 81) ^ OTHER PROCEDURE CPT CODE (I - E) ^ MODIFIERS (See Modifier Note) ^ OTHER ASSOC DIAGNOSIS (Multiple IEN;DRG Code - patch 119 or 142)
 ;       
 ;       Other Pre-Op Diagnosis Data
 ;                 1              2                             3                                 4
 ;               PREOP ^ OTHER PREOP DIAGNOSIS IEN ^ OTHER PREOP DIAGNOSIS (E) ^ DIAGNOSIS CODE (IEN;DRG CODE;DESCRIPTION)
 ;                       
 ;       Other Post-Op Diagnosis Data
 ;                 1                  2                           3                                 4                                   5                6                7         8     9         10             11
 ;               POSTOP ^ OTHER POSTOP DIAGNOSIS IEN ^ OTHER POSTOP DIAGNOSIS (E) ^ DIAGNOSIS CODE (IEN;DRG CODE;DESCRIPTION) ^ SERVICE CONNECTED ^ AGENT ORANGE ^ ION RADIATION ^ MST ^ HNC ^ ENVIR CONTAM ^ COMBAT VET
 ;                       
 ;       MODIFIER NOTE: 130 Multiple IEN;Modifier IEN;Modifier Code;Modifier Description : 130 Multiple IEN;Modifier IEN;Modifier Code;Modifier Description
 ;       
 ;       
 I '$G(IFN)!($O(ARRAY(""))="") S AXY="-1^INVALID INPUT!" Q
 N II,JJ,MM,MOD,DIC,DA,XX,YY,X,Y,ND,TYP,DATA,DATA2,VEJD,FIL,IENS,ADD,VEJD1,DIAGS S ND="VEJDSRF"
 K ^TMP($J,ND)
 ;rebuild array
 S II="",MM=1 F  S II=$O(ARRAY(II)) Q:II=""  D
 .S TYP=$P(ARRAY(II),U),DATA=$P(ARRAY(II),U,2,9999)
 .S ^TMP($J,ND,TYP,MM)=DATA,MM=MM+1
 I $$PROCHK S AXY="-2^"_VSRERR K ^TMP($J,ND) Q
 D PATCHES^VEJDSR
 I PAT142 D UPDATE^DSIPSR0(.AXY,IFN,.ARRAY) Q
 ;
 S II=0,FIL=130.18 F  S II=$O(^TMP($J,ND,"POSTOP",II)) Q:'II  S DATA=^(II),IENS=$S(DATA:+DATA,1:"+1")_","_IFN_"," D
 .N P01,DXS
 .S P01=$P(DATA,U,2),DXS=$P($P(DATA,U,3),";")
 .S:P01]"" VEJD(FIL,IENS,.01)=P01 S:DXS]"" VEJD(FIL,IENS,3)=DXS
 .I PAT119 F JJ=4:1:10 S VEJD(FIL,IENS,JJ)=$P(DATA,U,JJ)
 .I '$E(IENS) D UPDATE^DIE(,"VEJD") K VEJD
 .D:$D(VEJD) FILE^DIE(,"VEJD") K VEJD
 ;
 D:$D(^TMP($J,ND,"MAIN"))!$D(^TMP($J,ND,"MAIN2"))
 .S II=+$O(^TMP($J,ND,"MAIN",0)),DATA=$G(^TMP($J,ND,"MAIN",II)),II=+$O(^TMP($J,ND,"MAIN2",0)),DATA2=$G(^TMP($J,ND,"MAIN2",II))
 .S FIL=130,IENS=IFN_","
 .S:$P(DATA,U)]"" VEJD(FIL,IENS,26)=$P(DATA,U)
 .S:$P(DATA,U,2)]"" VEJD(FIL,IENS,27)=$P($P(DATA,U,2),";")
 .S:$P(DATA,U,4)]"" VEJD(FIL,IENS,32)=$P(DATA,U,4)
 .S:$P(DATA,U,5)]"" VEJD(FIL,IENS,33)=$P(DATA,U,5)
 .S:$P(DATA,U,6)]"" VEJD(FIL,IENS,34)=$P(DATA,U,6)
 .S:$P(DATA,U,7)]"" VEJD(FIL,IENS,66)=$P($P(DATA,U,7),";")
 .I PAT119 F II=1:1:7 S VEJD(FIL,IENS,$P(".016^.017^.018^.019^.022^.023^.024",U,II))=$P(DATA2,U,II)
 .D FILE^DIE(,"VEJD") K VEJD
 .D LOADDIAG(IFN)
 .S MOD=$P(DATA,U,3)
 .F II=1:1:$L(MOD,":") S MM=$P(MOD,":",II) D:MM]""
 ..N MO,MU S MU=$P(MM,";"),MO=$P(MM,";",2) K DA
 ..I MO="@",MU S DIK="^SRF("_IFN_",""OPMOD"",",DA(1)=IFN,DA=MU D ^DIK Q
 ..;I MU,MO S DIE="^SRF("_IFN_",""OPMOD"",",DA(1)=IFN,DA=MU,DR=".01////"_MO D ^DIE K DR Q
 ..I 'MU S DIC="^SRF("_IFN_",""OPMOD"",",DA(1)=IFN,X=MO,DIC(0)="L" D FILE^DICN
 .I PAT119,$P(DATA2,U,9) S FIL=130.275 D
 ..N DRGS,DRG S DRGS=$P(DATA2,U,9)
 ..F II=1:1:$L(DRGS,":") Q:'$D(^SRF(IFN,"PADX",+$P(DRGS,":",II)))  S VEJD(FIL,+$P(DRGS,":",II)_","_IENS,.01)=$$FINDDIAG($P($P(DRGS,":",II),";",2)) ;Set nodes for FILE^DIE
 ..D:$D(VEJD) FILE^DIE(,"VEJD") K VEJD
 ..F II=II:1:$L(DRGS,":") I '$D(^SRF(IFN,"PADX",+$P(DRGS,":",II))) S VEJD(FIL,"+"_+$P(DRGS,":",II)_","_IENS,.01)=$$FINDDIAG($P($P(DRGS,":",II),";",2)) ;Set nodes for UPDATE^DIE
 ..D:$D(VEJD) UPDATE^DIE(,"VEJD") K VEJD
 ..Q:'$O(^SRF(IFN,"PADX",II))
 ..F  S II=$O(^SRF(IFN,"PADX",II)) Q:'II  S VEJD(FIL,II_","_IENS,.01)="@" ;Set nodes to delete from multiple
 ..D:$D(VEJD) FILE^DIE(,"VEJD") K VEJD
 ;
 S II=0,FIL=130.16 F  S II=$O(^TMP($J,ND,"OTHER",II)) Q:'II  S DATA=^(II),IENS=$S(DATA:+DATA,1:"+1")_","_IFN_"," D
 .N P01,P3,MO,MM,MOD,MODS,DA,DIE,DR,DIC,X,Y,VEJD1,SRTN
 .S P01=$P(DATA,U,2),P3=$P(DATA,U,3),MODS=$P(DATA,U,5),SRTN=IFN
 .S:P01]"" VEJD(FIL,IENS,.01)=P01 S:P3]"" VEJD(FIL,IENS,3)=P3
 .I '$E(IENS) D UPDATE^DIE(,"VEJD","VEJD1") S $P(DATA,U)=+VEJD1(1) K VEJD1,VEJD
 .I $D(VEJD) D FILE^DIE(,"VEJD") K VEJD
 .F MO=1:1 S MOD=$P(MODS,":",MO) Q:MOD=""  D
 ..N DIC,DA,X,Y,DIK
 ..I MOD S DIK="^SRF("_IFN_",13,"_+DATA_",""MOD"",",DA(2)=IFN,DA(1)=+DATA,DA=+MOD D ^DIK Q
 ..S DIC="^SRF("_IFN_",13,"_+DATA_",""MOD"",",DA(2)=IFN,DA(1)=+DATA,DIC(0)="L",X=$P(MOD,";",2) D FILE^DICN
 .I PAT119,$P(DATA,U,6)]"" D OADX(IFN,+DATA,$P(DATA,U,6))
 ;
 S II=0,FIL=130.17 F  S II=$O(^TMP($J,ND,"PREOP",II)) Q:'II  S DATA=^(II),IENS=$S(DATA:+DATA,1:"+1,")_IFN_"," D
 .N P01,DXS
 .S P01=$P(DATA,U,2),DXS=$P($P(DATA,U,3),";")
 .S:P01]"" VEJD(FIL,IENS,.01)=P01 S:DXS]"" VEJD(FIL,IENS,3)=DXS
 .I '$E(IENS) D UPDATE^DIE(,"VEJD") K VEJD
 .D:$D(VEJD) FILE^DIE(,"VEJD") K VEJD
 ;
 S AXY=IFN Q
 ;
OADX(FIEN,MIEN,DRGS) ;
 N VEJD,DRG,IENS,FIL,SRTN,II D LOADDIAG(FIEN) S SRTN=FIEN,FIL=130.165,IENS=MIEN_","_FIEN_","
 F II=1:1:$L(DRGS,":") Q:'$D(^SRF(FIEN,13,MIEN,"OADX",+$P(DRGS,":",II)))  S VEJD(FIL,+$P(DRGS,":",II)_","_IENS,.01)=$$FINDDIAG($P($P(DRGS,":",II),";",2)) ;Set nodes for FILE^DIE
 D:$D(VEJD) FILE^DIE(,"VEJD") K VEJD
 F II=II:1:$L(DRGS,":") I '$D(^SRF(FIEN,13,MIEN,"OADX",+$P(DRGS,":",II))) S VEJD(FIL,"+"_+$P(DRGS,":",II)_","_IENS,.01)=$$FINDDIAG($P($P(DRGS,":",II),";",2)) ;Set nodes for UPDATE^DIE
 D:$D(VEJD) UPDATE^DIE(,"VEJD") K VEJD
 Q:'$O(^SRF(FIEN,13,MIEN,"OADX",II))
 F  S II=$O(^SRF(FIEN,13,MIEN,"OADX",II)) Q:'II  S VEJD(FIL,II_","_IENS,.01)="@" ;Set nodes to delete from multiple
 D:$D(VEJD) FILE^DIE(,"VEJD") K VEJD
 Q
PROCHK()        ;
 N XX,YY,X
 S VSRERR=""
 S XX=0 F  S XX=$O(^TMP($J,ND,"MAIN",XX)) Q:'XX  S X=$P(^(XX),U) D PROC^VEJDSRPC Q:VSRERR]""
 Q:VSRERR]"" 1
 S XX=0 F  S XX=$O(^TMP($J,ND,"OTHER",XX)) Q:'XX  S X=$P(^(XX),U,2) D PROC^VEJDSRPC Q:VSRERR]""
 Q:VSRERR]"" 1 Q 0
LOADDIAG(DIFN) ;Load DIAGS array with diagnosis IFN and Location in 130
 N DIAG L +^SRF(DIFN,0):2 L -^SRF(DIFN,0)
 S DIAGS(+$P($G(^SRF(DIFN,34)),U,2))=0
 S DIAG=0 F  S DIAG=$O(^SRF(DIFN,15,DIAG)) Q:'DIAG  S DIAGS(+$P($G(^(DIAG,0)),U,3))=DIAG
 Q
FINDDIAG(CODE) ;Return the appropriate numeric value 0 - Principle, 1,2,3,4 etc entry in 15 subfile
 S CODE=CODE_$S(CODE[".":"",1:".")_" "
 N IEN S IEN=$O(^ICD9("AB",CODE,0)) Q:'IEN ""
 Q +$G(DIAGS(IEN))
