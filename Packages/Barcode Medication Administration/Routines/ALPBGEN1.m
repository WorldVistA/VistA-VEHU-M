ALPBGEN1 ;SFVAMC/JC - Parse and File HL7 PMU messages ;May 26, 2023@16:17
 ;;3.0;BAR CODE MED ADMIN;**8,37,102,122,125,144**;Mar 2004;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PARSIT ;PARSE MESSAGE ON RECEIVING SIDE
 N FS,EC,CS,RS,ESC,SS,EEC,EFS,ECS,ERS,ESS,ALPBID,ALPBKY,ALPBMENU,ALPBMT,ALPBVC,DATE,DIK,DLAYGO,STF
 S FS=$G(HL("FS")) I FS="" W !,"NO SEPARATOR" Q:FS=""  ;Field separator
 S EC=$G(HL("ECH")) Q:EC=""  ;Encoding Charaters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repitition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field sep
 S ECS=ESC_"S"_ESC ;escaped component sep
 S ERS=ESC_"R"_ESC ; escaped repitition sep
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
 N ALPBI,ALBPJ,ALPBX,ALPBAC,ACLPVC,ALPBSSN,ALPBERR,ALPBNAM,ALPBTRM
 F  X HLNEXT Q:$G(HLQUIT)'>0  D
 . I $E(HLNODE,1,3)="EVN" S ALPBMT=$P(HLNODE,2)
 . I $E(HLNODE,1,3)="STF" S STF=$E(HLNODE,5,9999) D PSTF
 Q
PSTF ;Process STF segment
 S ALPBKY=$P(STF,FS,1) Q:ALPBKY'[200_CS_"VISTA"
 S ALPBID=$P(STF,FS,2) S ALPBSSN=$E(ALPBID,1,9),ALPBAC=$P(ALPBID,RS,2),ALPBVC=$P(ALPBID,RS,3) D
 . S ALPBSSN=$TR(ALPBSSN,"-","")
 . I ALPBAC']"" S ALERR("ACCESS")="MISSING ACCESS CODE"
 . ;Unescape Access Code
 . S ALPBAC=$$UNESC(ALPBAC)
 . ;Unescape Verify Code
 . S ALPBVC=$$UNESC(ALPBVC)
 S ALPBNAM=$P(STF,FS,3),ALPBNAM=$P(ALPBNAM,CS,1)_","_$P(ALPBNAM,CS,2)_" "_$P(ALPBNAM,CS,3)_" "_$P(ALPBNAM,CS,4)
 I ALPBNAM["  " S ALPBNAM=$TR(ALPBNAM," ","") I ALPBNAM']"" S ALERR("NAME")="MISSING NAME"
 I $D(ALERR) G PERR
 S ALPBDIS=$S($P(STF,FS,7)="I":1,1:0)
 I $P(STF,FS,13)]"" S ALPBTRM=$$HL7TFM^XLFDT($P(STF,FS,13),"L")
FILE ;Store File 200 data on backup system
 N Y,DIC,DIE,DA,DR
 Q:'$D(ALPBNAM)
 Q:$L(ALPBSSN)'=9
 ;Try exact SSn lookup first
 K Y S DIC="^VA(200,",DIC(0)="X",X=ALPBSSN,D="SSN" D IX^DIC
 ;
 ;If SSN lookup fails, try name lookup and add User only if Termination Date (if it exists)
 ;is greater than today.
 ;PSB*3.0*144: Evaluate termination date.
 ;             ALPBTRMX=1 if termination date exists and is today or earlier.           
 N ALPBTRMX
 S ALPBTRMX=$S('$G(ALPBTRM):0,$$FMDIFF^XLFDT(ALPBTRM,DT)>0:0,1:1)
 I +Y<1,'ALPBTRMX,'$G(ALPBDIS) S DLAYGO=200,DIC="^VA(200,",DIC(0)="LMX",X=ALPBNAM D ^DIC K DIC,DA,DR
 I +Y>0 S (ALPBDA,DA)=+Y S ALPBMENU=$O(^DIC(19,"B","PSB BCBU WRKSTN MAIN",0)) D
 . ;Update name too
 . S DIE="^VA(200,",DR=".01////"_ALPBNAM
 . S DR=DR_";7////"_$S('$G(ALPBDIS):"@",1:ALPBDIS)
 . I ALPBSSN]"",$L(ALPBSSN)=9 S DR=DR_";9////"_ALPBSSN
 . I +ALPBMENU S DR=DR_";201////"_ALPBMENU
 . S DR=DR_";9.2////"_$S('$G(ALPBTRM):"@",1:ALPBTRM)
 . I $G(DR)]"" D ^DIE K DIC,DA,DR S DIK=DIE,DA=ALPBDA
 . ; Direct set used for the ACCESS CODE value because it may contain semi-colon (;), which affects the DIE call
 . I $D(^VA(200,ALPBDA,0)) D
 . . S $P(^VA(200,ALPBDA,0),"^",3)=ALPBAC
 . D IX1^DIK
 . ; VERIFY CODE needs to be set after re-indexing the record otherwise it will delete it because the ACCESS CODE was set
 . I $D(^VA(200,ALPBDA,0)) D
 . . ;PSB*3.0*144: Do not null out Verify Code.
 . . ;             Previous logic nulled out the Verify Code if Termination
 . . ;             Date exists. There is no need to check variable ALPBTRMX
 . . ;             because the logic will not get to this point if ALPBTRMX=1.
 . . S $P(^VA(200,ALPBDA,.1),"^",2)=ALPBVC
 . . S $P(^VA(200,ALPBDA,.1),"^",1)=$H
 K ALPBDA,HL,ALPBDIS,ALPBI,ALBPJ,ALPBX,ALPBAC,ACLPVC,ALPBSSN,ALERR,ALPBNAM,ALPBTRM
 Q
UNESC(ST,PR) ;Unescape string from message
 ;ST=String to translate
 ;PR=Event Protocol to set up HL array variables (optional)
 ;First, do the escape character
 I $G(ST)="" Q ""
 S PR=$G(PR) I PR]"" D INIT^HLFNC2(PR,.HL)
 I '$D(HL) D
 . S HL("FS")="^"
 . S HL("ECH")="~|\&"
 S FS=$G(HL("FS")) I FS="" Q "" ;Field separator
 S EC=$G(HL("ECH")) I EC="" Q ""  ;Encoding Charaters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repitition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field sep
 S ECS=ESC_"S"_ESC ;escaped component sep
 S ERS=ESC_"R"_ESC ; escaped repitition sep
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
 K I,J,K,L,X F  S X=$F(ST,EEC) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K($G(I)+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[EEC K(I)=$P(K(I),EEC)_ESC S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X F  S X=$F(ST,EFS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K($G(I)+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[EFS K(I)=$P(K(I),EFS)_FS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ECS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ECS K(I)=$P(K(I),ECS)_CS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ERS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ERS K(I)=$P(K(I),ERS)_RS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ESS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ESS K(I)=$P(K(I),ESS)_SS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 K I,J,K,L,X
 Q ST
PERR ;PROCESSING ERRORS
 H 1 S DATE=$$NOW^XLFDT M ^TMP("BCBU",$J,$S($G(ALPBSSN)'="":ALPBSSN,1:0),DATE)=ALERR
 K ALERR
 Q
