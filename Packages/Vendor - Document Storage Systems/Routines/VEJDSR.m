VEJDSR ;AMC-DSS;RPC's to the Surgery Package
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
PATCHES ;Set variables for surgery and cidc patches
 S PAT119=$$PATCH^XPDUTL("SR*3.0*119")
 ;S PAT142=0
 S PAT142=$$PATCH^XPDUTL("SR*3.0*142")
 Q
LOOKUP(AXY,DFN,STDT,ENDT)       ;RPC - VEJD SR 130 LOOKUP
 S AXY=$NA(^TMP("VEJDSR",$J))
 I '$G(DFN)!'$G(STDT) S ^TMP("VEJDSR",$J,0)="-1^INVALID INPUT!" Q
 I '$G(ENDT) D NOW^%DTC S ENDT=X
 S ENDT=ENDT+.3
 N XX,YY,II,DOO,AXYY,VST S (AXYY,YY)=0
 F  S YY=$O(^SRF("B",DFN,YY)) Q:'YY  D
 .S DOO=+$P($G(^SRF(YY,0)),U,9),VST=$P($G(^(0)),U,15)
 .I DOO'<STDT,DOO'>ENDT S ^TMP("VEJDSR",$J,AXYY)=YY_U_VST_U_DOO,AXYY=AXYY+1
 Q
GET130(AXY,IFN) ;RPC - VEJD SR 130 GET
 ;Input Variables
 ;       IFN - Pointer to file 130
 ;       
 ;Return Array
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
 ;                         1              2                             3                                 4
 ;               PREOP ^ OTHER PREOP DIAGNOSIS IEN ^ OTHER PREOP DIAGNOSIS (E) ^ DIAGNOSIS CODE (IEN;DRG CODE;DESCRIPTION)
 ;                       
 ;       Other Post-Op Diagnosis Data
 ;                          1                  2                           3                                 4                          5                6                7         8     9         10             11
 ;               POSTOP ^ OTHER POSTOP DIAGNOSIS IEN ^ OTHER POSTOP DIAGNOSIS (E) ^ DIAGNOSIS CODE (IEN;DRG CODE;DESCRIPTION) ^ SERVICE CONNECTED ^ AGENT ORANGE ^ ION RADIATION ^ MST ^ HNC ^ ENVIR CONTAM ^ COMBAT VET
 ;                       
 ;       MODIFIER NOTE: 130 Multiple IEN;Modifier IEN;Modifier Code;Modifier Description : 130 Multiple IEN;Modifier IEN;Modifier Code;Modifier Description
 ;       
 ;       -1^INVALID INPUT!
 ;       
 S AXY=$NA(^TMP("VEJDSRG",$J))
 I '$G(IFN)!'$D(^SRF(+$G(IFN),0)) S ^TMP("VEJDSRG",$J,0)="-1^INVALID INPUT!" Q
 N XX,YY,AXYY,II,JJ,MM,MOD,FIL,IENS,FLDS,GET,DRG,PAT119,PAT142 D PATCHES S (YY,AXYY)=0
 I PAT142 D GET136^DSIPSR(AXY,IFN) Q
 S FIL=130,IENS=IFN_",",FLDS="26;27;32;33;34;66;69" S:PAT119 FLDS=".016;.017;.018;.019;.022;.023;.024;"_FLDS D GETS^DIQ(FIL,IENS,FLDS,"EI","GET")
 S:$G(GET(FIL,IENS,27,"I")) GET(FIL,IENS,27,"E")=$TR($P($G(^ICPT(GET(FIL,IENS,27,"I"),0)),U,1,2),U,";")
 S:$G(GET(FIL,IENS,66,"I")) MM=+GET(FIL,IENS,66,"I"),GET(FIL,IENS,66,"E")=$G(GET(FIL,IENS,66,"E"))_";"_$P(^ICD9(MM,0),U,3)
 S MM=0,MOD="" F  S MM=$O(^SRF(IFN,"OPMOD",MM)) Q:'MM  S:$G(^(MM,0)) JJ=+^(0),MOD=MOD_MM_";"_JJ_";"_$TR($P($G(^DIC(81.3,JJ,0)),U,1,2),U,";")_":"
 S MOD=$E(MOD,1,$L(MOD)-1)
 S XX="MAIN^"_$G(GET(FIL,IENS,26,"E"))_U_$S($G(GET(FIL,IENS,27,"I")):GET(FIL,IENS,27,"I")_";"_$G(GET(FIL,IENS,27,"E")),1:"")
 S XX=XX_U_MOD_U_$G(GET(FIL,IENS,32,"E"))_U_$G(GET(FIL,IENS,33,"E"))_U_$G(GET(FIL,IENS,34,"E"))
 S XX=XX_U_$S($G(GET(FIL,IENS,66,"I")):GET(FIL,IENS,66,"I")_";"_$G(GET(FIL,IENS,66,"E")),1:"")
 S XX=XX_U_$S($G(GET(FIL,IENS,69,"I")):GET(FIL,IENS,69,"I")_";"_$G(GET(FIL,IENS,69,"E")),1:"")
 S ^TMP("VEJDSRG",$J,AXYY)=XX,AXYY=AXYY+1
 D:PAT119
 .S XX="MAIN2^"_$G(GET(FIL,IENS,.016,"I"))_U_$G(GET(FIL,IENS,.017,"I"))_U_$G(GET(FIL,IENS,.018,"I"))_U_$G(GET(FIL,IENS,.019,"I"))_U_$G(GET(FIL,IENS,.022,"I"))_U_$G(GET(FIL,IENS,.023,"I"))_U_$G(GET(FIL,IENS,.024,"I"))
 .S MM=0,JJ="" F  S MM=$O(^SRF(IFN,"PADX",MM)) Q:'MM  S DRG=$P($G(^(MM,0)),U) D
 ..S DRG=$S(DRG:+$P($G(^SRF(IFN,15,DRG,0)),U,3),1:+$G(GET(130,IFN_",",66,"I")))
 ..Q:'DRG  S DRG=$P($G(^ICD9(DRG,0)),U)
 ..S JJ=JJ_MM_";"_DRG_":"
 .S JJ=$E(JJ,1,$L(JJ)-1),XX=XX_U_U_JJ
 .S ^TMP("VEJDSRG",$J,AXYY)=XX,AXYY=AXYY+1
 F  S YY=$O(^SRF(IFN,13,YY)) Q:'YY  D
 .S XX="OTHER^"_YY_U_$P($G(^SRF(IFN,13,YY,0)),U)_U
 .S II=+$G(^SRF(IFN,13,YY,2)),XX=XX_$S(II:II_U_$TR($P($G(^ICPT(II,0)),U,1,2),U,"-"),1:"")_U
 .S MM=0,JJ="" F  S MM=$O(^SRF(IFN,13,YY,"MOD",MM)) Q:'MM  S MOD=+$G(^(MM,0)) D:MOD
 ..S JJ=JJ_MM_";"_MOD_";"_$TR($P($G(^DIC(81.3,MOD,0)),U,1,2),U,";")_":"
 .S JJ=$E(JJ,1,$L(JJ)-1),XX=XX_JJ
 .D:PAT119
 ..S MM=0,JJ="" F  S MM=$O(^SRF(IFN,13,YY,"OADX",MM)) Q:'MM  S DRG=$P($G(^(MM,0)),U) D
 ...S DRG=$S(DRG:+$P($G(^SRF(IFN,15,DRG,0)),U,3),1:+$G(GET(130,IFN_",",66,"I")))
 ...Q:'DRG  S DRG=$P($G(^ICD9(DRG,0)),U)
 ...S JJ=JJ_MM_";"_DRG_":"
 ..S JJ=$E(JJ,1,$L(JJ)-1),XX=XX_U_JJ
 .S ^TMP("VEJDSRG",$J,AXYY)=XX,AXYY=AXYY+1
 S YY=0 F  S YY=$O(^SRF(IFN,14,YY)) Q:'YY  D
 .S XX="PREOP^"_YY_U_$P($G(^SRF(IFN,14,YY,0)),U)_U
 .S II=+$P($G(^SRF(IFN,14,YY,0)),U,3) I II S XX=XX_II_";"_$P($G(^ICD9(II,0)),U)_";"_$P($G(^ICD9(II,0)),U,3)
 .S ^TMP("VEJDSRG",$J,AXYY)=XX,AXYY=AXYY+1
 S YY=0 F  S YY=$O(^SRF(IFN,15,YY)) Q:'YY  D
 .S XX="POSTOP^"_YY_U_$P($G(^SRF(IFN,15,YY,0)),U)_U
 .S II=+$P($G(^SRF(IFN,15,YY,0)),U,3) I II S XX=XX_II_";"_$P($G(^ICD9(II,0)),U)_";"_$P($G(^ICD9(II,0)),U,3)
 .I PAT119 S XX=XX_U_$G(^SRF(IFN,15,YY,2))
 .S ^TMP("VEJDSRG",$J,AXYY)=XX,AXYY=AXYY+1
 Q
