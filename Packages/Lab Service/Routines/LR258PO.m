LR258PO ;DALOI/FHS/RSH - LR*5.2*258 PATCH POST INSTALL ROUTINE
 ;;5.2;LAB SERVICE;**258**;Sep 27,1994
PRE ;
 ;$$HTE^XLFDT supported by DBIA #10103
 ;$$HTFE^XLFDT supported by DBIA #10103
 ;$$NOW^XLFDT supported by DBIA #10103
 ;$$CJ^XLFSTR supported by DBIA #10104
 ;^XMD supported by DBIA #10070
 ;$$PATCH^XPDUTL supported by DBIA #10141
 ;BMES^XPDUTL supported by DBIA #10141
 ;SETUP^XQALERT supported by DBIA $10081
 ;FILE^DIE supported by DBIA #10018
 ;GETS^DIQ supported by DBIA #2056
 ;EN^DIU2 supported by DBIA #10014
 ;$$SITE^VASITE supported by DBIA #10112
 ;$$FMTE^XLFDT supported by DBIA #10103
 ;$$THE^XLFDT supported by DBIA #10103
 ;$$HTFM^XLFDT supported by DBIA #10103
 Q:'$D(XPDNM)
 I $O(^LAM(0)) D  Q:$G(XPDQUIT)
 . Q:$$PATCH^XPDUTL("LR*5.2*263")
 . S XPDQUIT=2
 . W $$CJ^XLFSTR("You must install LR*5.2*263 Patch",80)
 S LRLAST=$O(^LAB(64.2,9999),-1)
 I '$D(^XTMP("LRNLT642")) D
 . S ^XTMP("LRNLT642",.01)=LRLAST
 . S ^XTMP("LRNLT642",0)=$$HTFM^XLFDT($H+60,1)_"^"_DT_"^ LAB(64.2 Save"
 . M ^XTMP("LRNLT642",1)=^LAB(64.2)
 S DIU="^LAB(64.81,",DIU(0)="DST" D EN^DIU2 K DIU
 S:$D(^LAB(64.2,0))#2 $P(^(0),U,3)=$G(LRLAST,1)
 K LRLAST
 Q
EN1 ;Find and correct existing spelling or duplicate numbers errors.
 N DA,DIC,DIK,DIU,X,Y,DIRUT,DTOUT,DUOUT
REINDEX ;Reindex LAM to fire new x-refs
 L +^LAM
 D BMES^XPDUTL($$CJ^XLFSTR("Re-indexing WKLD CODE (#64) file",80))
 S DIK="^LAM(" D IXALL^DIK K DIK
 D
 . N LRI,DIC,X,Y,LRFDA,LRANS
 . S DIC=64.3,DIC(0)="OX"
 . S LRI=0 F  S LRI=$O(^LAB(64.2,LRI)) Q:LRI<1  D
 . . Q:'$D(^LAB(64.2,LRI,2))  S X=$P(^(2),U,2)
 . . Q:'$L(X)  D ^DIC Q:Y<1
 . . K LRFDA,LRANS
 . . S LRFDA(64.2,LRI_",",11)=+Y
 . . D FILE^DIE("K","LRFDA","LRANS")
 D BMES^XPDUTL($$CJ^XLFSTR("Re-indexing completed",80))
 K ^XTMP("LRNLTERR",$J) S ^XTMP("LRNLTERR",$J,0)=$$HTFM^XLFDT($H+60,1)_"^"_DT_"^LR52 258 Error Messages"
 K ^XTMP("LRNLT",$J)
 S ^XTMP("LRNLT",$J,0)=$$HTFM^XLFDT($H+60,1)_"^"_DT_"^LR52 258 Messages"
 N DA,DIK,LRIEN,LRN0,LRN1,LRFILE
 S LRIEN=0 F  S LRIEN=$O(^LAB(64.81,LRIEN)) Q:LRIEN<1!(LRIEN>49)  D
 . W "." S LRN0=$G(^LAB(64.81,LRIEN,0)),LRN1=$G(^(1))
 . S LRFILE=$P(LRN1,U,4)
 . I 'LRFILE D DEL Q
 . D CHK
 D BMES^XPDUTL($$CJ^XLFSTR("*** Spelling errors corrected in existing database ***",80))
 D POST
ALERT ;
 D BMES^XPDUTL($$CJ^XLFSTR("Sending installation message to G.LMI mail group",80))
 N XQA,XQAMSG
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown Patch")_" complete "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 L -^LAM
 Q
CHK N DIC,X,Y
 K LRFDA,LRANS,LRNAMX,LRNUMX,LRNAMY,LRNUMY
 S DIC(0)="ZNMO",(LRNAMX,LRNAMY,X)=$P(LRN0,U)
 I $G(LRFILE)=64 D
 . S DIC=64,(LRNUMY,LRNUMX)=$P(LRN0,U,2)
 . S DIC("S")="I $P(^(0),U,2)=LRNUMX"
 . D ^DIC I Y<1 D DEL Q
 . W:$G(LRDEBUG) !,Y_" ( "_LRFILE
 . S LRIENS=+Y_","
 . I $L($P(LRN0,U,8)) D
 . . S LRNAMY=$P(LRN0,U,8)
 . . S LRFDA(LRFILE,LRIENS,.01)=LRNAMY
 . I $P(LRN0,U,3) D
 . . S LRNUMY=$P(LRN0,U,3)
 . . Q:$O(^LAM("C",LRNUMY_" ",0))
 . . S LRFDA(LRFILE,LRIENS,1)=LRNUMY
 I $G(LRFILE)=64.2 D
 . S (LRNAMX,LRNAMY,X)=$P(LRN0,U)
 . S DIC=64.2,LRNUMX=$P(LRN1,U,2)
 . S DIC("S")="I $P(^(0),U,2)=LRNUMX"
 . D ^DIC I Y<1 D DEL Q
 . S LRIENS=+Y_","
 . I $L($P(LRN0,U,8)) D
 . . S LRNAMY=$P(LRN0,U,8)
 . . S LRFDA(LRFILE,LRIENS,.01)=LRNAMY
 . I $P(LRN1,U,3) D
 . . S LRNUMY=$P(LRN1,U,3)
 . . S LRFDA(LRFILE,LRIENS,1)=LRNUMY
 . I $L($P(LRN1,U,7)) D
 . . S LRSYN=$P(LRN1,U,7),LRSYNIEN=$O(^LAB(64.2,+LRIENS,1,"B",LRSYN,0))
 . . Q:'LRSYNIEN
 . . S LRFDA(64.23,LRSYNIEN_","_LRIENS,.01)="@"
 . W:$G(LRDBUG) !,Y_" ( "_LRFILE
 I $D(LRFDA) D SET
 Q
SET ;
 D FILE^DIE("KS","LRFDA","LRANS")
 I '$D(LRANS) W:$G(LRDEBUG) !,"Okay" D  Q
 . D WRT,DEL
 Q  ; EDIT ERRORS are left in ^LAB(64.81)
 ;
DEL ;
 N DA,DIK
 S DA=LRIEN,DIK="^LAB(64.81," D ^DIK
 Q
ERR ;
 W !,LRIEN_" ( "_LRFILE_" ERROR"
 Q
WRT ;
 D SCR(LRNUMX_"    "_LRNAMX)
 D SCR("Was changed to: "_LRNUMY_"    "_LRNAMY)
 Q
POST ;TRANSPORT FILE 64.81 INTO FILE 64 IF REQUIRED
 S (LRLAST64,LRNEXT)=$O(^LAM(99999),-1)
 S $P(^LAM(0),U,3)=$G(LRNEXT,1)
 S LRN=$O(^XTMP("LRNLT642",1,99999),-1)
 S (LRADD,LRCHG,LRDOT)=0
 D SCR("==========================")
 D SCR("List of WKLD CODES added to ^LAM  (#64)")
 D SCR(" ")
 S LRNEXT=0,LRIEN=50
 F  S LRNEXT=$O(^LAB(64.81,LRIEN,2,LRNEXT)) Q:LRNEXT<1  D
 . K LRFDA,LROUT,LRAR1,LRSIXT4
 . S LRDOT=$G(LRDOT)+1 I LRDOT#50=0 W ". "
 . S LRREC=^LAB(64.81,LRIEN,2,LRNEXT,0),LRERR=0
 . I $G(LRDEBUG) W !,LRREC_" "
 . S LRTRIEN=$P(LRREC,U)
 . D CMP
 . Q:LRERR
 . I LRCHG D CHGNM
 . I LRADD D GNDE
 . I $S($G(LROUT(42,"DIERR")):0,$G(LROUT(45,"DIERR")):0,1:1) D KREC
 . K LROUT
 S $P(^LAM(0),U,3)=99999,LRVR=$T(+2)
 S ^LAM("VR")=LRVR
 F I=64.061,64.2,64.21,64.22,64.3 I $D(^LAB(I,0))#2 S ^("VR")=LRVR
 D:'$G(LRDEBUG) MAIL
KIL K LRADD,LRANS,LRAR1,LRBEG,LRCHG,LRCNT,LRCODE,LRCTR,LRDOT,LREND
 K LRENODE,LRERR,LRFDA,LRFILE,LRFLD,LRFLE,LRFNAM,LRI,LRIEN,LRIENS
 K LRMLT,LRN,LRN0,LRN1,LRNAMX,LRNAMY,LRNEXT,LRNIEN,LRNODE,LRNUM
 K LRNUMX,LRNUMY,LRNX,LROUT,LRPROCNM,LRREC,LRSC,LRSCR,LRSEQ,LRSIXT4
 K LRSUBFLE,LRSYN,LRSYNIEN,LRTRIEN,LRVAL,LRVR,X,Y
 Q
CHGNM ; CHANGE THE PROCEDURE NAME IN THE RECORD
 K LRFDA
 S LRFDA(42,64,LRCHG_",",.01)=LRPROCNM
 D FILE^DIE("K","LRFDA(42)","LROUT(42)")
 I $G(LROUT(42,"DIERR")) D
 . S LRERR=1
 . S LRENODE="LROUT(42,""DIERR"")"
 . D ERMSG
 I '$G(LROUT(42,"DIERR")) D SCR("|"_LRCODE_"|"_LRPROCNM_"|"_"**Procedure Name Changed**")
 K LRFDA(42),LRPROCNM
 Q
CMP ; COMPARE FOUND CODES AND PROCEDURE NAMES
 N DIC,X,Y
 S (LRADD,LRCHG,LRERR)=0
 S LRCODE=$P(LRREC,U,3),LRPROCNM=$P(LRREC,U,2)
 S DIC="^LAM(",DIC(0)="MXZ",X=LRCODE
 D ^DIC
 I Y=-1 D
 . I '$D(^LAM("C",LRCODE_" ")) S LRADD=1 Q
 . I $D(^LAM("C",LRCODE_" ")) D
 . . S LRN=LRN+1
 . . S ^XTMP("LRNLT642",1,LRN,0)="|"_LRCODE_"|"_LRPROCNM_"|"_"**Duplicate codes**"
 . . S LRERR=1
 I Y>0 D  ;COMPARE THE NAME IN BOTH FILES
 . S LRFNAM=$P(Y(0),U)
 . I LRPROCNM=LRFNAM S (LRADD,LRCHG)=0 Q
 . I LRPROCNM'=LRFNAM S LRCHG=+Y
 ;I LRADD!LRCHG W !,"ADD=",LRADD," CHG=",LRCHG
 Q
SCR(LRMSG) ;Store message in ^XTMP("LRNLT" Global
 S LRSCR=$G(^XTMP("LRNLT",$J,1,0))+1,^(0)=LRSCR
 S ^XTMP("LRNLT",$J,1,LRSCR)=LRMSG
 Q
SETUP ; SETS UP THE FDA ARRAY TO ADD A NODE
 F  S LRNODE=$Q(@LRNODE) Q:LRNODE=""  D
 . S LRFLE=$QS(LRNODE,1)
 . S LRFLD=$QS(LRNODE,3)
 . I LRFLE=64.8117 D
 . . S LRSUBFLE=64
 . . I LRFLD=1 S LRFLD=.01
 . . I LRFLD>1 S LRFLD=LRFLD-1
 . . S LRIENS="+"_LRTRIEN_","
 . I LRFLE'=64.8117 D
 . .; CONSTRUCT THE SUBFILE NUMBER FOR FILE 64 FROM 64.81
 . . S LRBEG=$P(LRFLE,"8117")
 . . S LREND=$P(LRFLE,"8117",2)
 . . S LRSUBFLE=LRBEG_"0"_LREND
 . . I LRFLD=.01 S LRSEQ=LRSEQ+1
 . . S LRIENS="+"_LRSEQ_","_"+"_LRTRIEN_","
 . S LRVAL=@LRNODE
 . S LRFDA(45,LRSUBFLE,LRIENS,LRFLD)=LRVAL
 . ;W !,"LRFDA(45,"_LRSUBFLE_","_LRIENS_LRFLD_")="_LRVAL
 K LRAR1
 Q
GNDE ; RETRIEVES NODES FROM THE TRANSPORT MULTIPLE
 S LRMLT="",LRCTR=1
 D GETS^DIQ(64.8117,LRTRIEN_","_LRIEN_",",LRMLT_"*","INZ","LRAR1")
 S LRNODE="LRAR1(64.8117_LRMLT)"
 D SETUP
 I $D(^LAB(64.81,50,2,LRTRIEN,1,0)) S LRNUM=$P(^LAB(64.81,50,2,LRTRIEN,1,0),U,4),LRSEQ=LRNUM+1
 E  I '$D(^LAB(64.81,50,2,LRTRIEN,1,0)) S LRSEQ=2
 S LRMLT=18
 D GETS^DIQ(64.8117,LRTRIEN_","_LRIEN_",",LRMLT_"*","INZ","LRAR1")
 S LRNODE="LRAR1(64.8117_LRMLT)"
 D SETUP
 S LRMLT=19,LRSEQ=1
 D GETS^DIQ(64.8117,LRTRIEN_","_LRIEN_",",LRMLT_"*","INZ","LRAR1")
 S LRNODE="LRAR1(64.8117_LRMLT)"
 D SETUP
 D AREC I $G(LRDEBUG) W !,"NEW IEN=",$G(LRSIXT4(LRTRIEN))
 K LRSIXT4,LRFDA(45)
 Q
AREC ; ADDS ENTRIES FROM THE TRANSPORT MULTIPLE TO FILE 64
 D UPDATE^DIE("","LRFDA(45)","LRSIXT4","LROUT(45)")
 I $G(LROUT(45,"DIERR")) D
 . S LRENODE="LROUT(45,""DIERR"")"
 . D ERMSG
 K LRFDA(45)
 Q
ERMSG ;STUFF THE TEMP GLOBAL WITH ANY ERROR MESSAGES
 S LRN=LRN+1
 S ^XTMP("LRNLT642",1,LRN,0)="|"_LRTRIEN_"|"_LRCODE_"|"_LRPROCNM_"|"
 F  S LRENODE=$Q(@LRENODE) Q:LRENODE=""  D
 . S LRN=LRN+1
 . S ^XTMP("LRNLT642",1,LRN,0)="|"_LRENODE_"|="_@LRENODE
 S LRERR=1
 K LRENODE
 Q
KREC ; DELETES THE RECORD FROM THE FILE
 Q:$G(LRDEBUG)
 N DA,DIK
 S DA(1)=LRIEN,DA=LRTRIEN
 S DIK="^LAB(64.81,"_DA(1)_",2," D ^DIK
 Q
MAIL ;Send message to G.LMI local mail group of added 64 codes
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY,LRIEN,LRN
NEWLST ;Build list of added WKLD CODES
 D
 . D BMES^XPDUTL($$CJ^XLFSTR("Building List Of Added WKLD CODEs",80))
 . N LRN,LRIEN,LRSTR,LRCNT
 . S LRCNT=0
 . S LRN="^LAM(""B"")" S:'$G(LRLAST64) LRLAST64=3203
 . F  S LRN=$Q(@LRN) Q:$QS(LRN,1)'="B"  I '@LRN D
 . . S LRIEN=$QS(LRN,3)
 . . I LRIEN>LRLAST64,LRIEN<99999,$D(^LAM(LRIEN,0))#2 S LRSTR=$P(^(0),U,1,2) D
 . . . S LRCNT=$G(LRCNT)+1
 . . . S LRSTR=LRCNT_"|"_$TR(LRSTR,"^","|")_"|IEN= "_LRIEN
 . . . D SCR(LRSTR)
 . D BMES^XPDUTL($$CJ^XLFSTR("List Of Added WKLD CODEs Complete",80))
 K LRLAST64
 I '$O(^XTMP("LRNLT",$J,1,3)) D
 . I '$G(LRPRT) D
 . . D SCR("No WKLD CODES Added to Database")
 D BMES^XPDUTL($$CJ^XLFSTR("Sending message to LMI Mail Group.",80))
 S XMSUB="ADDED WKLD CODE REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 S XMY("G.LMI")="",XMTEXT="^XTMP(""LRNLT"","_$J_",1,",XMDUZ=.5
 D ^XMD
CHK642 ;Looking for locally added suffix
 K DIFROM,XMSUB,XMDUZ,XMTEXT,XMY
 N LRSC,LRCNT,LRNX,LRI
 S LRSC="",LRCNT=0
 F  S LRCNT=$O(^XTMP("LRNLT642",1,LRCNT)) Q:LRCNT<1  K ^XTMP("LRNLT642",1,LRCNT,1)
 S LRNX="^XTMP(""LRNLT642"",1,""C"")"
 F  S LRNX=$Q(@LRNX) Q:$QS(LRNX,3)'="C"  D
 . I $D(^LAB(64.2,"C",$QS(LRNX,4))) D  Q
 . . K ^XTMP("LRNLT642",1,$QS(LRNX,5))
 . W:$G(LRDBUG) !,LRNX
 F LRI="AC","B","C","D","E","F" K ^XTMP("LRNLT642",1,LRI)
MES642 ;
 I '$O(^XTMP("LRNLT642",1,0)) K ^XTMP("LRNLT642") Q
 S XMSUB=$TR($P($$SITE^VASITE,U,1,2),U,"|")_" LR 258 - 64 2 "_DT
 S XMY("G.LMI@ISC-DALLAS")=""
 S XMTEXT="^XTMP(""LRNLT642"",1,",XMDUZ=.5
 D ^XMD
 Q
