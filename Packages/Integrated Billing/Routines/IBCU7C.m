IBCU7C ;EDE/WCJ - LINE LEVEL MODIFIER SELECTION ;10-NOV-2022
 ;;2.0;INTEGRATED BILLING;**742**;21-MAR-94;Build 36
 ;;Per VA Directive 6402, this routine should not be modified.
 G AWAY
AWAY Q
 ;
EN(IBPROCP) ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 N MODARR,SAVEDA,SAVEDIC,CNT,FIRST,DELETE
 M SAVEDA=DA,SAVEDIC=DIC
 N DA,DIC
 S FIRST=1
 ;
AGAIN K MODARR,DA,DIC,CNT,DIR
 M DA=SAVEDA,DIC=SAVEDIC
 S DELETE=0
 D GETXIST(IBPROCP,.MODARR,.DA)
 ; 
 S CNT=$O(MODARR("A"),-1)
 S DIR("?")="Type a unique sequence number between 1 and 10, 0 Decimal Digits"
 I CNT>0 D
 . N LAST
 . S DIR("?",1)="CPT MOD SEQ    CPT MODIFER"
 . F LOOP=1:1:CNT D
 .. S DIR("?",LOOP+1)="  "_$P(MODARR(LOOP),U,4)_"           "_$S($L($P(MODARR(LOOP),U,4))=1:" ",1:"")_$P(MODARR(LOOP),U)_"  "_$$GET1^DIQ(81.3,$P(MODARR(LOOP),U,2)_",",.02)
 . S LAST=$O(MODARR("ZZREF2",""),-1)
 . I FIRST,+LAST S DIR("B")=$P(MODARR("ZZREF2",LAST),U,4),FIRST=0
 ;
 S DIR(0)="FO^1:2"
 S DIR("A")="Select CPT MODIFIER SEQUENCE"
 D ^DIR
 Q:X=""!(X="^")
 ;
 Q:$D(DIROUT)!$D(DTOUT)   ; quit if ^ or time out ;WCJ;IB742 v15
 Q:$D(DIRUT)&'$G(DIR("B"))   ; if user entere @ but there was no default, quit because nothing to delete ;WCJ;IB742 v15
 ;
 ;WCJ;IB742 v15
 ;user entred an @ so they are delting the default
 I $D(DIRUT) D
 . S FIRST=1  ; rest so it defaults again after deletion
 . S X=$G(DIR("B"))
 . S DELETE=1  
 ;
 ; an existing exact match on an external modifier so the question is which one.
 I $D(MODARR("ZZREF3",X)) D  G AGAIN
 . S (DA,Y)=$P(MODARR("ZZREF3",X,$O(MODARR("ZZREF3",X,""))),U,3)   ; grab the first one for now.
 . I $O(MODARR("ZZREF3",X,""))'=$O(MODARR("ZZREF3",X,"A"),-1) D  Q:Y=-1   ; check to see if the first/last are the same  - quit for now if it isn't
 .. N DIC
 .. S DIC(0)="EMX"
 .. S DIC="^DGCR(399,"_DA(1)_",""CP"","_+IBPROCP_",""MOD"","
 .. D ^DIC
 .. Q:Y=-1
 .. S DA=+Y
 .;
 . S DA(2)=DA(1),DA(1)=+IBPROCP
 . S (DIC,DIE)="^DGCR(399,"_DA(2)_",""CP"",DA(1),""MOD"","
 . S DR=".01  CPT MODIFIER SEQUENCE;.02  CPT MODIFIER"
 . D ^DIE
 ; 
 I +X'=X!(X>10)!(X<1)!(X?.E1"."1N.N) D  G AGAIN  ; no exact match and not a whole number so question input and ask again
 . W !,DIR("?"),!
 . Q
 ;
 ; We have an existing SEQ number  (that kind of worked)
 I $D(MODARR("ZZREF2",X)) D  G AGAIN
 . N SEQ
 . S SEQ=X
 . S DA(2)=DA(1),DA(1)=+IBPROCP,(DA,Y)=$P(MODARR("ZZREF2",X),U,3)
 . S (DIC,DIE)="^DGCR(399,"_DA(2)_",""CP"",DA(1),""MOD"","
 . S DIC(0)="L"
 . S DR=".01  CPT MODIFIER SEQUENCE"_$S(DELETE:"////@",1:";.02  CPT MODIFER")   ;WCJ;IB742 v15
 . D ^DIE
 . I DELETE D EN^DDIOL("THE ENTIRE '"_SEQ_"'   CPT MODIFIER SEQUENCE WAS DELETED") ;WCJ;IB742 v15
 ;
 ; We have a new seq #
 I '$D(MODARR("ZZREF2",X)) D  G AGAIN
 . S DLAYGO=399
 . S DA(2)=DA(1),DA(1)=+IBPROCP
 . S DIC="^DGCR(399,"_DA(2)_",""CP"",DA(1),""MOD"","
 . S DIC("DR")=".02"
 . S DIC(0)="L"
 . K DD,DO
 . D FILE^DICN
 ;
 Q
 ;
GETXIST(IBPROCP,MODARR,DA) ; check to see if this code has already been entered as a modifier for this procedure.
 ; IN
 ;   IBPROCP - conatins subfile IEN of which procedure we are working with
 ; OUT
 ;    MODARR - an array with modifier information for this procedure
 ;
 ;    MODARR("ZZREF1",EXTERNAL MODIFIER,CPTSEQNUMBER) = IEN81P3^IENSUBFILE^SEQUENCE NUMBER
 ;    MODARR("ZZREF2",IEN81P3,CPTSEQNUMBER) = IEN81P3^IENSUBFILE^SEQUENCE NUMBER
 ;    MODARR("ZZREF3",CPTSEQNUMBER) = IEN81P3^IENSUBFILE^SEQUENCE NUMBER
 ;    MODARR(COUNT) = IEN81P3^IENSUBFILE^SEQUENCE NUMBER
 ;
 N MOD,MODIEN,MODSFIEN,MODSEQNUM,MODDATA,MODSEQ,I
 ;
 S (MOD,MODIEN)=""
 F  S MODIEN=$O(^DGCR(399,DA(1),"CP",+IBPROCP,"MOD","C",MODIEN)) Q:MODIEN=""  D
 . S MOD=$$GET1^DIQ(81.3,MODIEN_",",.01,"E")
 . ;
 . S MODSFIEN=0
 . F  S MODSFIEN=$O(^DGCR(399,DA(1),"CP",+IBPROCP,"MOD","C",MODIEN,MODSFIEN)) Q:MODSFIEN=""  D
 .. S MODSEQNUM=+$G(^DGCR(399,DA(1),"CP",+IBPROCP,"MOD",MODSFIEN,0))
 .. S MODDATA=MOD_U_MODIEN_U_MODSFIEN_U_MODSEQNUM
 .. S MODARR("ZZREF1",MODIEN,MODSEQNUM)=MODDATA
 .. S MODARR("ZZREF2",MODSEQNUM)=MODDATA
 .. S MODARR("ZZREF3",MOD,MODSEQNUM)=MODDATA
 ;
 I $D(MODARR)<10 Q
 ;
 ; reorder for display starting with 1 
 S MODSEQ="" F I=1:1 S MODSEQ=$O(MODARR("ZZREF2",MODSEQ)) Q:MODSEQ=""  S MODARR(I)=MODARR("ZZREF2",MODSEQ)
 Q
 ;
TEST ; amusing myself with alternate methods
 ;LIST^DIC(file[,iens][,fields][,flags][,number][,[.]from][,[.]part][,index][,[.]screen][,identifier][,target_root][,msg_root])
 D LIST^DIC(399.30416,,".01;.02","X")
 ;
 ;FIND^DIC(file[,iens][,fields][,flags],[.]value[,number][,[.]indexes][,[.]screen][,identifier][,target_root][,msg_root])
 D FIND^DIC(399.30416,",1290176,2",".01;.02")
 Q
