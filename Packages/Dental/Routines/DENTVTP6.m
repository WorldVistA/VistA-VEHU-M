DENTVTP6 ;DSS/SGM - RPCS FOR TOOTH NOTES ;11/24/2003 16:41
 ;;1.2;DENTAL;**39,45,47,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine contains all the RPCs needed for the tooth notes file
 ;  DBIA#  Supported  Description
 ;  -----  ---------  ----------------
 ;   2053      x      ^DIE: UPDATE, WP
 ;  10003      x      ^%DT
 ;  10103      x      $$FMTE^XLFDT
 ;  10104      x      $$UP^XLFSTR
 ;  10013      x      ^DIK
 ;
NOTE(DENT,DATA) ;  RPC: DENTV TP FILE TOOTH NOTE
 ;this rpc will allow the addition, update, or deletion of a tooth note
 ;  DATA - required
 ;  DATA(1) = FLG ^ IEN ^ DFN ^ DATE ^ TOOTH ^ NOTE TYPE
 ;            if $G(FLG)="",$G(IEN)<1 then default to ADD
 ;            FLG - optional - A add new note
 ;                             U replace existing text
 ;                             D delete note for this patient,date,tooth
 ;            IEN - opt/req  - pointer to TP NOTE file (#228.6)
 ;                             required for Update or Delete
 ;            DFN - required - pointer to the patient file
 ;           DATE - optional - external date (time not allowed)
 ;                             default to today
 ;          TOOTH - required - 0, 1-32, 99
 ;      NOTE TYPE - optional - 0-5  (0=Unknown, 1=patient, 2=tooth, 3=nonTooth, 4=seq, 5=cover page)
 ;            
 ;  DATA(n) = text of note   where n =2,3,4,5,6,...
 ;  Return(n) = 1^message if action successful, else return -1^message
 ;  
 ;  NOTE TYPE=4 for sequencing notes (new in patch 45), others are set manually below
 N %DT,X,Y,Z,DATE,DEN,DENER,DENIEN,DENX,DFN,DIERR,IEN,TOOTH,TYP,FLG,I,TMP,DEND,DENTI,CNT,ERR
 I '$O(DATA(0)) D MSG(1) Q
 S I=0,CNT=1 F  S I=$O(DATA(I)) Q:'I  D
 .S TMP=$G(DATA(I))
 .I TMP="$END" D FILE Q
 .I TMP="$START" S DENTI=I+1 K DEND Q
 .S DEND(I)=TMP
 .Q
 S CNT=0 F I=0:0 S I=$O(DENT(I)) Q:'I  I +$G(DENT(I))=1 S CNT=CNT+1 K DENT(I)
 I CNT S DENT(1)="1^"_CNT_" Treatment Note"_$S(CNT>1:"s",1:"")_" successfully filed"
 Q
FILE ;file each note
 S Z="FLG^IEN^DFN^DATE^TOOTH^TYP",ERR=0
 F Y=1:1:6 S @$P(Z,U,Y)=$P(DEND(DENTI),U,Y)
 S X=$$DFN^DENTVRF0(DFN,1) I +X=-1 S CNT=CNT+1,DENT(CNT)=X Q
 I DATE="" S DATE=DT
 E  D  Q:ERR
 .S (%DT,Y)="",X=DATE D ^%DT I Y>0 S DATE=$P(Y,".")
 .E  D MSG(2)
 .Q
 I TOOTH="" D MSG(3) Q
 S X=0 I TOOTH\1'=TOOTH!(TOOTH<0) S X=1
 E  I TOOTH,TOOTH'=99,TOOTH>32 S X=1
 I X D MSG(4) Q
 S FLG=$E(FLG) S:FLG?1L FLG=$$UP^XLFSTR(X) I FLG="",IEN<1 S FLG="A"
 I "AaUudD"'[FLG D MSG(5) Q
 S TYP=+$G(TYP) I TYP=0 S TYP=$S(TOOTH=0:1,TOOTH=99:3,1:2)
 S DENIEN=$O(^DENT(228.6,"C",DFN,DATE,TOOTH,TYP,0))
 I IEN>0,DENIEN>0,IEN'=DENIEN D MSG(10) Q
 I DENIEN,FLG="A" D MSG(7) Q
 I "UD"[FLG,'DENIEN S:TYP=4 DENIEN=IEN I 'DENIEN D MSG(8) Q  ;P55 use passed in IEN for SEQ notes (date may have changed "C" xref lookup invalid)
 I FLG="D" D  Q  ;delete record
 .N DA,DD,DO,DIK S DA=DENIEN,DIK="^DENT(228.6," D ^DIK
 .I TYP=5 S CNT=CNT+1,DENT(CNT)=DENIEN_U_"Record deleted"
 .E  S CNT=CNT+1,DENT(CNT)="1^Record #"_DENIEN_" deleted"
 .Q
 I $O(DEND(DENTI))="" D MSG(6) Q
 ; set the WP nodes for filing
 K DEN S Y=0 F  S DENTI=$O(DEND(DENTI)) Q:'DENTI  S Y=Y+1,DEN(Y)=DEND(DENTI)
 I FLG="A" D  Q  ;add record
 .K DENIEN,DENX S DENX(228.6,"+1,",.01)=DFN
 .S DENX(228.6,"+1,",.02)=DATE
 .S DENX(228.6,"+1,",.03)=TOOTH
 .S DENX(228.6,"+1,",.04)=TYP
 .S DENX(228.6,"+1,",1)="DEN"
 .S DENIEN(1)=""
 .D UPDATE^DIE(,"DENX","DENIEN","DENER")
 .I '$D(DIERR) D
 ..I TYP=5 S CNT=CNT+1,DENT(CNT)=$G(DENIEN(1))_"^Record added"
 ..E  S CNT=CNT+1,DENT(CNT)="1^Record successfully added:"_$G(DENIEN(1))
 ..Q
 .E  D  Q
 ..S X=$$MSG^DSICFM01("VE",,,,"DENER")
 ..I $G(DENIEN(1))<1 S CNT=CNT+1,DENT(CNT)="-1^"_X
 ..E  S CNT=CNT+1,DENT(CNT)="1^"_X
 ..Q
 .Q
 ;update (wp info only)
 L +^DENT(228.6,DENIEN):2 E  D MSG(9) Q
 I $G(DATE) K DENTV S DENTV(228.6,DENIEN_",",.02)=DATE D FILE^DIE(,"DENTV") K DENTV
 D WP^DIE(228.6,DENIEN_",",1,,"DEN","DENER")
 L -^DENT(228.6,DENIEN)
 I '$D(DIERR) D
 .I TYP=5 S CNT=CNT+1,DENT(CNT)=DENIEN_"^Record updated"
 .E  S CNT=CNT+1,DENT(CNT)="1^Record #"_DENIEN_" updated"
 .Q
 E  S CNT=CNT+1,DENT(CNT)="-1^"_$$MSG^DSICFM01("VE","","","","DENER")
 Q
 ;
GET(DENT,DFN) ;  RPC: DENTV TP GET TOOTH NOTES
 ;  this will retreive all notes for a patient
 ;  DFN - required - pointer to the patient file
 ;  Return: global array ^TMP("DENT",$J,n)=value
 ;    if problems, ^TMP("DENT",$J,1) = -1^message
 ;    format of return of individual records:
 ;    ^TMP("DENT",$J,n) = $START
 ;                 n+1) = ien^external date^tooth number^TYPE
 ;                 n+2) = 1st line of text
 ;                 n+m) = last line of text
 ;               n+m+1) = $END
 ;  return data will be sorted by tooth then by reverse date
 N A,T,X,Y,Z,DATE,IEN,ROOT,STOP,TOOTH,TYP
 S DENT=$NA(^TMP("DENT",$J)) K @DENT
 S ROOT="^TMP(""DENT"",$J,TOOTH,DATE,TYP,A)"
 I '$G(DFN) S @DENT@(1)="-1^No patient received" Q
 I '$O(^DENT(228.6,"C",DFN,0)) S @DENT@(1)="-1^No notes found" Q
 S Z=$NA(^DENT(228.6,"C",DFN)),STOP=$P(Z,")")_","
 F  S Z=$Q(@Z) Q:Z=""  Q:Z'[STOP  D
 .S DATE=-$QS(Z,4),TOOTH=$QS(Z,5),TYP=$QS(Z,6),IEN=$QS(Z,7)
 .Q:TYP=5  ;5.8.2006 KC new type for Cover Page in P47
 .S X=$$FMTE^XLFDT(-DATE,5)
 .S Y=0,A=1,@ROOT="$START",^(2)=IEN_U_X_U_TOOTH_U_TYP,A=2
 .F  S Y=$O(^DENT(228.6,IEN,1,Y)) Q:'Y  S A=A+1,@ROOT=^(Y,0)
 .S A=A+1,@ROOT="$END"
 .Q
 I '$D(@DENT) S @DENT@(1)="-1^No records found"
 Q
 ;-------------------------  subroutines  -------------------------
MSG(X) ;
 I X=1 S X="No input array received"
 I X=2 S X="Invalid date received"
 I X=3 S X="No tooth designation received"
 I X=4 S X="Invalid tooth designation received: "_TOOTH
 I X=5 S X="Invalid filing flag received: "_FLG
 I X=6 S X="No tooth note text received"
 I X=7 S X="Cannot add this record as one already exists"
 I X=8 S X="No record exists to "_$S(FLG="U":"update",1:"delete")
 I X=9 S X="Unable to lock record #:"_DENIEN_", try again"
 I X=10 S X="Received TP Note record# "_IEN_", but it does not match record# "_DENIEN
 S CNT=CNT+1,DENT(CNT)="-1^"_X,ERR=1
 Q
