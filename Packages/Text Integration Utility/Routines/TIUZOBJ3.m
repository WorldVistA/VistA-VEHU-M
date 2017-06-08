TIUZOBJ3 ;SFVAMC/APC - TIU LAB OBJECTS ;9/18/97 [12/4/98 9:48am]
 ;;1;**654000**;
LAB(DFN,DISPLAY,TARGET,LINE,ARHLABN,MAX,RANGE) ;Entry point for labs for all specimens
 ; DFN     = patient dfn
 ; DISPLAY = 1 if write to screen
 ; TARGET  = array to store data
 ; LINE    = number of lines in array
 ; ARHLABN = exact lab test name
 ; MAX     = max occurances; default is 1
 ; RANGE   = date range in format nY,nM,nW,nD; default is 1Y
 N GMTS1,GMTS2,GMTSI,TEST,LRDFN,DA
 K @TARGET D HSINIT
 S TEST=$O(^LAB(60,"B",ARHLABN,0)) ;ien lab test
 S MAX=$S(+$G(MAX):MAX,1:1) ;max occurances
 S LRDFN=$G(^DPT(DFN,"LR"))
 K ^TMP("LRS",$J)
 I 'LRDFN D PRT G LABEX
 ;I $G(ARHDEBUG) D  I 1
 ;
 ;   local code added below to catch var SEX if not defined.  9/16/98 herb
 ;
 S:$D(SEX)'=1 SEX=$P($G(^DPT(DFN,0)),2)
 S GMTSI=1 D @$S($L($P(^LAB(60,TEST,0),U,5)):"^GMTSLRSE",1:"PANEL(TEST)")
 ;E  D ^GMTSLRSE
 D PRT
 ;
LABEX ;
 K ^TMP("LRS",$J)
 Q "~@"_$NA(@TARGET)
 ;
PANEL(ORGTEST) ;11/20/97
 N TEST,GMW,INDX
 S INDX=0 F  S INDX=$O(^LAB(60,ORGTEST,2,INDX)) Q:'INDX  S TEST=^(INDX,0) D
 .S:'$L($P(^LAB(60,TEST,0),U,5)) ORGTEST=TEST
 .        ;
 .  ;   local code added below to catch var SEX if not defined.  9/17/98 herb
 .  ;
 .S:$D(SEX)'=1 SEX=$P($G(^DPT(DFN,0)),2)
 .D @$S($L($P(^LAB(60,TEST,0),U,5)):"^GMTSLRSE",1:"PANEL(TEST)") ;added '(TEST)' to fix-SSpencer 11/2/99
 .S:$L($P(^LAB(60,TEST,0),U,5)) GMTSI=GMTSI+1
 Q
PRT ;
 N II,JJ,RESULT,NODE
 ;I '$D(^TMP("LRS",$J)) D NODATA("No "_ARHLABN_" results in last "_$G(RANGE)) Q
 ;extract data and parse
 S II="" F  S II=$O(^TMP("LRS",$J,II)) Q:'II  S JJ=0 F  S JJ=$O(^TMP("LRS",$J,II,JJ)) Q:'JJ  S NODE=^(JJ) D
 .;W !!,NODE,!,+$P(NODE,"^",4),!!
 .S RESULT=$E(NODE,1,10)_"  " ;collection date
 .S RESULT=$$SETSTR($P($P(NODE,U,3),";",2),RESULT,13,19) ;test name
 .;SFVAMC/APC 11/19/97 Allow for text results
 .;
 .;  LOCAL MODIFICATION 1/4/99 - HERB
 .;        ! in the lab global seen as spaces, used LOOP to fix the space problem.
 .;
 .F  Q:$E($P(NODE,"^",4),1,1)'=" "  S $P(NODE,"^",4)=$E($P(NODE,"^",4),2,$L($P(NODE,"^",4)))
 .;
 .;S RESULT=$$SETSTR($P(NODE,U,4),RESULT,34,$L($P(NODE,U,4))) ;result
 .I +$P(NODE,U,4)'=0 S RESULT=$$SETSTR($J($P(NODE,U,4),6,2),RESULT,34,6) ;numeric result
 .I $P(NODE,U,4)?." "1A.E S RESULT=$$SETSTR($P(NODE,U,4),RESULT,34,$L($P(NODE,U,4))) ;alpha result
 .S RESULT=$$SETSTR($P(NODE,U,5),RESULT,41,1) ;L or H
 .S RESULT=$$SETSTR($J($P(NODE,U,7),4)_"-"_$J($P(NODE,U,8),4),RESULT,44,12) ;ref range
 .S LINE=LINE+1
 .S @TARGET@(LINE,0)=RESULT
 S @TARGET@(0)="^^"_LINE_U_LINE_U_DT_"^^"
 Q
 ;
SETSTR(S,V,X,L) ;insert S into V. Copied from VALM1
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
LAB2(DFN,DISPLAY,TARGET,LINE,MAX,RANGE) ;Entry point for Chem&Hemo
 N GMTS1,GMTS2,GMTSI,TEST,LRDFN,DA
 K @TARGET D HSINIT
 S RWIDTH=8
 S MAX=$S(+$G(MAX):MAX,1:1) ;max occurances
 S LRDFN=$G(^DPT(DFN,"LR"))
 ;
 ;   local code added below to catch var SEX if not defined.  9/17/98 herb
 ;
 S:$D(SEX)'=1 SEX=$P($G(^DPT(DFN,0)),2)
 D:+LRDFN ^GMTSLRCE
 D PRT2
 K ^TMP("LRC",$J)
 Q "~@"_$NA(@TARGET)
PRT2 ;Copied from GMTSLRC v2.7
 N IX,IX0,PTR,CTR,RESULT,NODE,GMI
 I '$D(^TMP("LRC",$J)) D NODATA("No Chem & Hematology results in last "_$G(RANGE)) Q
 ;extract data and parse
 S IX=GMTS1 F IX0=1:1:MAX  S IX=$O(^TMP("LRC",$J,IX)) Q:IX=""!(IX>GMTS2)  S (PTR,CNT)=0 F  S PTR=$O(^TMP("LRC",$J,IX,PTR)) Q:PTR=""  D
 .I PTR="C",($D(^TMP("LRC",$J,IX,"C"))>10) D  Q
 ..S GMI=+$O(^TMP("LRC",$J,IX,"C",0))
 ..S RESULT=$$SETSTR(^TMP("LRC",$J,IX,"C",GMI),RESULT,41,30)
 ..S @TARGET@(LINE-1,0)=RESULT
 .;
 .; UNDEFINED ERROR IN NODE BELOW 12/4/98 - HERB 
 .; MODIFIED TO A $GET TO FIX UNDEFINED, ADD NOTIFY IRM IF BAD NODE
 .;
 .S NODE=$G(^TMP("LRC",$J,IX,PTR))  
 .S RESULT=$E(NODE,1,10)_"  " ;collection date
 .S RESULT=$$SETSTR($P(NODE,U,3),RESULT,13,19) ;test name
 .S RESULT=$$SETSTR($J($TR($P(NODE,U,4)," ",""),6,2),RESULT,34,6) ;result
 .S RESULT=$$SETSTR($P(NODE,U,5),RESULT,41,1) ;L or H
 .;S RESULT=$$SETSTR($J($P(NODE,U,7),4)_"-"_$J($P(NODE,U,8),4),RESULT,44,12) ;ref range
 .S LINE=LINE+1
 .S:NODE="" RESULT=RESULT_"  ** ERROR - NOTIFY IRM - BAD ^TMP(""LRC"",$J,"_IX_","_PTR_")"
 .S @TARGET@(LINE,0)=RESULT
 S @TARGET@(0)="^^"_LINE_U_LINE_U_DT_"^^"
 Q
 ;
CYTOPAT(DFN,DISPLAY,TARGET,LINE,ARHLABN,MAX,RANGE) ;10/29/97 Cytopathology. Copied from GMTSLRCP v2.7
 N GMI,IX0,MAX,LRDFN,IX,GMTS1,GMTS2,GMTSI,TEST,LRDFN,DA
 K @TARGET D HSINIT
 S:'$G(MAX) MAX=999
 K ^TMP("LRCY",$J)
 S LRDFN=+$G(^DPT(DFN,"LR"))
 D:+LRDFN ^GMTSLRPE
 I '$D(^TMP("LRCY",$J)) D NODATA("No cytopathology results.") Q "~@"_$NA(@TARGET)
 S IX=""
 F GMI=1:1:MAX S IX=$O(^TMP("LRCY",$J,IX)) Q:IX=""  S IX0="" F  S IX0=$O(^TMP("LRCY",$J,IX,IX0)) Q:IX0=""  D TRVRS
 S @TARGET@(0)="^^"_LINE_U_LINE_U_DT_"^^"
 K ^TMP("LRCY",$J)
 Q "~@"_$NA(@TARGET)
 ;
TRVRS ; Traverses/Interprets ^TMP("LRCY",$J,
 N GMS,SPEC
 I IX0=0 S LINE=LINE+1 S @TARGET@(LINE,0)="Collected: "_$P(^TMP("LRCY",$J,IX,IX0),U)_"    Acc: "_$P(^TMP("LRCY",$J,IX,IX0),U,2) Q
 I IX0=1 S LINE=LINE+1 S @TARGET@(LINE,0)="Specimen:" S GMS=0 F  S GMS=$O(^TMP("LRCY",$J,IX,IX0,GMS)) Q:GMS'>0  S LINE=LINE+1,@TARGET@(LINE,0)="   "_^TMP("LRCY",$J,IX,IX0,GMS)
 I IX0=1,($P(^TMP("LRCY",$J,IX,IX0),U,2)'>0) S LINE=LINE+1,@TARGET@(LINE,0)="** REPORT NOT YET RELEASED **"
 Q:IX0=1
 I IX0="MI" D PRT3("Microscopic Exam:")
 I IX0="ND" D PRT3("Cytopathology Dx:")
 Q
 ;
PRT3(HDR) ;
 N GMTSM,GMTSML,GMTSMLI
 S LINE=LINE+1,@TARGET@(LINE,0)=" "
 S LINE=LINE+1,@TARGET@(LINE,0)=HDR
 S GMTSM=0
 F  S GMTSM=$O(^TMP("LRCY",$J,IX,IX0,GMTSM)) Q:GMTSM'>0  S GMTSML=^(GMTSM) D
 .I $L(GMTSML)>78 S GMTSML=$$WRAP^GMTSORC(GMTSML,78)
 .S LINE=LINE+1,@TARGET@(LINE,0)=$P(GMTSML,"|")
 .F GMTSMLI=2:1:$L(GMTSML,"|") S:$P(GMTSML,"|",GMTSMLI)]"" @TARGET@(LINE,0)=@TARGET@(LINE,0)_$P(GMTSML,"|",GMTSMLI)
 Q
 ;
D ; Writes Disease Field
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:OT="D1"!(GMTSNPG) ?9,"Diseases:" W ?21,^TMP("LRCY",$J,IX,IX0,OT),!
 Q
 ;
NODATA(MSG) ;
 N II,JJ,RESULT,NODE
 S LINE=LINE+1,@TARGET@(LINE,0)=MSG
 S LINE=LINE+1,@TARGET@(LINE,0)=" "
 S @TARGET@(0)="^^"_LINE_U_LINE_U_DT_"^^"
 Q
 ;
HSINIT ;Initialize HS variables
 S GMTS1=9999999-(DT+1) ;reverse date time first date
 S:+$G(RANGE) X2=+RANGE*$S(RANGE["Y":365,RANGE["M":31,RANGE["W":7,RANGE["D":1,1:1)*-1
 I '$G(RANGE) S RANGE="1Y",X2=-365
 S X1=DT D C^%DTC
 S GMTS2=9999999-$P(X,".",1) ;reverse dt/tm last date
 S GMTSI=1
 Q
