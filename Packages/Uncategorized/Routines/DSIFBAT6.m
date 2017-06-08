DSIFBAT6 ;DSS/RED - RPC FOR FEE BASIS BATCHES ;09/13/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ;  Integration Agreements
 ;   2056  GETS^DIQ              
 ;   5080  ENV^FBAACCB0
 ;   5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL
 ;   5096  $$ADJLRA^FBCHFA
 ;   5097  $$NAME^FBCHREQ2
 ;   5273  ^FBAA(161.7
 ;   5400  ^FBAA(161.27
 ;   5277  ^FBAAI
 ;
 Q
LISTBAT(FBOUT,CHBAT) ;
 ; Input: Batch IEN
 ; Output:  FBOUT(0)=FBTYPE
 ; If Type = B9 (Civil Hospital) 
 ;   ^TMP($J,"DSIFBAT6",CNT,0)="ID"^PAT^SSN^Batch^Totals
 ;   ^TMP($J,"DSIFBAT6",CNT,1)="Pat"^Vendor^Vendor ID^Invoice^Date Inv Received^Flag^Vendor invoice date
 ;            FLAG - * Reimbursement to Veteran; + Cancellation Activity; # Voided Payment
 ;   ^TMP($J,"DSIFBAT6",CNT,2)="Date"^From date^To date^Amount claimed^Paid^Adjustment Flag^Discharge
 ;   ^TMP($J,"DSIFBAT6",CNT,3)="FPPS"^FPPS Claim ID^FPPS Line
 ;   ^TMP($J,"DSIFBAT6",CNT,3+(N))=CNT^"DIAG"^ICD(N)[I];ICD(N)[E]^POA(N)[I];POA(N)[E] DSIF*3.2*2 
 ;   ^TMP($J,"DSIFBAT6",CNT,28+(M))=CNT^"Proc"^P(M) DSIF*3.2*2 
 ;   ^TMP($J,"DSIFBAT6",CNT,54)=CNT^"Check"^Check #^Date Paid^Interest^Amount paid altered to^Check cancelled on^Reason^Text 
 ;   ^R=Check WILL be replaced or C=Check WILL be re-issued or X=Check WILL NOT be replaced DSIF*3.2*2 
 ; [Logic from LISTC^FBAACCB1]
 ; B9 Called from DSIFBAT2, to leave FBOUT intact.
 K ^TMP($J,"DSIFBAT6") S FBOUT=$NA(^TMP($J,"DSIFBAT6"))
 N FBTYPE
B9 ;  @FBOUT@(0) nodes removed below, left code for possible future use.
 N BATNUM,FBAAOUT,CNT,B,FBIN,ARRAY,MSG,FLAG,FBADJ,FBSC,DATA,DATA1,FBAC,FBADJLR,FBAP,FBLCNT,FBTOTAL
 N FBVP,FBX,FIELD,FILE,FLAGS,I,IENS,J,K,N,S,Z,ZS,TARGET
 I '$D(^FBAA(161.7,CHBAT)) S @FBOUT@(0)="-1^Batch #"_CHBAT_" is not a valid CH batch number" Q
 S CNT=0,B=CHBAT,BATNUM=$P(^FBAA(161.7,B,0),U) S:$G(FBTYPE)="" FBTYPE=$P(^FBAA(161.7,B,0),U,3)
 I $P($G(^FBAA(161.7,B,0)),U,3)'="B9" S @FBOUT@(0)="-1^#"_BATNUM_" Is not a CH/CNH Batch type" Q
 ;S @FBOUT@(0)="Batch"_U_$P($G(^FBAA(161.7,B,0)),U,3)
 S CNT=1 F I=0:0 S I=$O(^FBAAI("AC",B,I)) Q:I'>0  I $D(^FBAAI(I,0)) S Z(0)=^(0) D CMORE,ENM^DSIFBAT2
 ;D CNTTOT^FBAARB(B) S @FBOUT@(0)="Batch"_U_FBTYPE_U_FBLCNT_U_$J(FBTOTAL,1,2)
 I '$D(@FBOUT) S @FBOUT@(0)="-1^Batch "_BATNUM_" has no payments" Q
 Q
CMORE ;
 N INV,LCNTR,OCNTR,GATE ;DSIF*3.2*2 
 S K=$P(Z(0),"^",3),J=$P(Z(0),"^",4) D ENV^FBAACCB0 S N=$$NAME^FBCHREQ2(J),S=$$SSN^FBAAUTL(J),FBIN=I,FBAC=$P(Z(0),"^",8)+.0001,FBAP=$P(Z(0),"^",9)+.0001,FBVP=$P(Z(0),"^",14),ZS=$P(Z(0),"^",13)
 K ARRAY,MSG,VEND,MSG1
 ;S $P(@FBOUT@(0),U,3)=FBIN
 S FILE=162.5,IENS=FBIN_",",FIELD="**" ;DSIF*3.2*  read all fields
 S TARGET="ARRAY",MSG="MSG",FLAGS="IEZ"
 D GETS^DIQ(FILE,IENS,FIELD,FLAGS,TARGET,MSG) S DATA=$NA(ARRAY(162.5,IENS))
 I $G(@DATA@(2,"I"))]"" D GETS^DIQ(161.2,@DATA@(2,"I")_",",1,"IE","VEND","MSG1") S DATA1=$NA(VEND(161.2,@DATA@(2,"I")_","))
 ;Set adjustment data and Flag
 S FLAG=$S('$D(@DATA@(12,"I")):"",@DATA@(12,"I")="R":"*",1:"")
 S FBX=$$ADJLRA^FBCHFA(FBIN_","),FBADJLR=$P(FBX,U),FBSC=$G(@DATA@(10,"I")),FBSC=$S(FBSC="":"",$D(^FBAA(161.27,FBSC,0)):$P(^(0),"^",1),1:""),FBADJ=$S(FBADJLR]"":FBADJLR,1:FBSC)
 S @FBOUT@(FBIN,CNT,0)=CNT_"^ID^"_J_";"_N_U_$TR(S,"-","")_";"_S_U_B
 S @FBOUT@(FBIN,CNT,1)=CNT_"^Pat^"_U_$G(@DATA@(2,"I"))_";"_$G(@DATA@(2,"E"))_U_$G(@DATA1@(1,"I"))_";"_$G(@DATA1@(1,"E"))_U_FBIN
 S @FBOUT@(FBIN,CNT,1)=@FBOUT@(FBIN,CNT,1)_U_$G(@DATA@(1,"I"))_";"_$G(@DATA@(1,"E"))_U_FLAG_U_$G(@DATA@(46,"I"))_";"_$G(@DATA@(46,"E"))
 S @FBOUT@(FBIN,CNT,2)=CNT_"^Date^"_$G(@DATA@(5,"I"))_";"_$G(@DATA@(5,"E"))_U_$G(@DATA@(6,"I"))_";"_$G(@DATA@(6,"E"))_U_$J($G(@DATA@(7,"E")),".",2)_U_$J($G(@DATA@(8,"E")),".",2)
 S @FBOUT@(FBIN,CNT,2)=@FBOUT@(FBIN,CNT,2)_U_FBADJ_U_$G(@DATA@(24,"I"))_";"_$G(@DATA@(24,"E"))
 S @FBOUT@(FBIN,CNT,3)=CNT_"^Fpps^"_$G(@DATA@(56,"E"))_U_$G(@DATA@(57,"E"))
 ; Loop through 30-36.92 to read ICDs and POAs, format them in the pre-arranged way DSIF*3.2*2 
 S INV=29.999,LCNTR=1,OCNTR=0,GATE=1 F  S INV=$O(@DATA@(INV)) Q:+INV>36.92   I $G(@DATA@(INV,"I"))  D   ;DSIF*3.2*2 iterate and output ICDs and POAs
 .I LCNTR'=OCNTR S OCNTR=LCNTR,@FBOUT@(FBIN,CNT,3+LCNTR)=CNT_U_"DIAG"_U ;DSIF*3.2*2 
 .I $L($P(INV,".",2))'=2 D   ;DSIF*3.2*2  if it doesn't end in 0.02, it's ICD, not POA
 ..S @FBOUT@(FBIN,CNT,3+LCNTR)=@FBOUT@(FBIN,CNT,3+LCNTR)_$G(@DATA@(INV,"I"))_";"_$G(@DATA@(INV,"E"))_U,GATE=0
 .E  D   ;DSIF*3.2*2  it's POA
 ..S @FBOUT@(FBIN,CNT,3+LCNTR)=@FBOUT@(FBIN,CNT,3+LCNTR)_$G(@DATA@(INV,"I"))_";"_$G(@DATA@(INV,"E")),GATE=1
 .I GATE S LCNTR=LCNTR+1 ;DSIF*3.2*2 update counter to move to next line in array
 K INV,LCNTR S INV=39.999,LCNTR=1 ;DSIF*3.2*2 recycle variables
 F  S INV=$O(@DATA@(INV)) Q:+INV>44.25  D   ;DSIF*3.2*2  for loop to retrieve all PROC
 .I $G(@DATA@(INV,"I")) D   ;DSIF*3.2*2 don't output empty data
 ..S @FBOUT@(FBIN,CNT,28+LCNTR)=CNT_U_"PROC"_U_$G(@DATA@(INV,"I"))_";"_$G(@DATA@(INV,"E")),LCNTR=LCNTR+1 ;DSIF*3.2*2 update LCNTR
 S FBCK=$G(@DATA@(48,"I")) S FBAP=$G(@DATA@(8,"I"))+.0001,FBAP=$P(FBAP,".",1)_"."_$E($P(FBAP,".",2),1,2) D PMNT
 S CNT=CNT+1
 Q
PMNT ; displays check and cancellation information if any exist
 ; Logic from PMNT^FBAACCB2
 N CHROW S CHROW=54 ;DSIF*3.2*2 this is the last row in the return array, feel free to update it to reflect any change
 S @FBOUT@(FBIN,CNT,CHROW)=CNT_"^Check^"
 I $G(FBCK)]"" S $P(@FBOUT@(FBIN,CNT,CHROW),U,3)=FBCK I $G(@DATA@(45,"I")) S $P(@FBOUT@(FBIN,CNT,CHROW),U,4)=$G(@DATA@(45,"I"))_";"_$G(@DATA@(45,"E")) ;DSIF*3.2*2  fixed a bug where piece was overwriting previous data
 S FBCKIN=$G(^FBAAI(FBIN,2))
 S FBCKDT=+FBCKIN,FBCK=$P(FBCKIN,U,4),FBCANDT=$P(FBCKIN,U,5),FBCANR=$P(FBCKIN,U,6),FBCAN=$P(FBCKIN,U,7),FBDIS=$P(FBCKIN,U,8),FBCKINT=$P(FBCKIN,U,9) K FBCKIN
 S $P(@FBOUT@(FBIN,CNT,CHROW),U,5)=$S($G(@DATA@(53,"I"))>0:$FN(@DATA@(53,"I"),",",2),1:"") D
 .I FBDIS-FBCKINT'=+FBAP S $P(@FBOUT@(FBIN,CNT,CHROW),U,6)=$FN((FBDIS-FBCKINT),",",2)
 I $G(FBCANDT)>0 S $P(@FBOUT@(FBIN,CNT,CHROW),U,7)=FBCANDT_";"_$$DATX^FBAAUTL(FBCANDT) I +FBCANR S $P(@FBOUT@(FBIN,CNT,CHROW),U,8)=$P($G(^FB(162.95,+FBCANR,0)),"^") D
 .S $P(@FBOUT@(FBIN,CNT,CHROW),U,9)=$S(FBCAN="R":"Check WILL be replaced.",FBCAN="C":"Check WILL be re-issued.",FBCAN="X":"Check WILL NOT be replaced.",1:"")
 K FBCAN,FBCK,FBCKDT,FBCANDT,FBCANR,FBCKINT,FBDIS,FBCKIN
 Q
