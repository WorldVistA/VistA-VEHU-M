FBXIP19A ;WCIOFO/SAB-PATCH INSTALL ROUTINE (cont) ;10/25/2000
 ;;3.5;FEE BASIS;**19**;JAN 30, 1995
 ; This routine invokes IA #3228
 Q
 ;
LOADBI(FBM) ; Load Before Image data from MERGE IMAGES file
 ; input
 ;   FBM - node of MERGE IMAGES subfile
 ;         =1 for 'from patient' and =2 for 'to patient'
 ;   FBDA - ien of entry in MERGE IMAGES file
 ;   FBFR - 'merged from' patient ien
 ; output
 ;   ^TMP($J,FBFR,file#,patient,...
 ;     where "^TMP($J,FBFR,file#," is used in place of original file root
 ;         file# is 161 or 162
 ;         patient is ien of 'from patient' or 'to patient'
 ;         ... before image of file
 ;
 N FBDA1,FBDA2,FBFILE,FBGD,FBGN,FBX
 ; loop thru FBM before images and save selected FEE files to TMP
 S FBX="FEE"
 F  S FBX=$O(^XDRM(FBDA,FBM,"B",FBX)) Q:FBX=""!($E(FBX,1,3)'="FEE")  D
 . S FBFILE=""
 . I FBX="FEE BASIS PATIENT" S FBFILE=161
 . I FBX="FEE BASIS PAYMENT" S FBFILE=162
 . Q:FBFILE=""  ; not one of the fee files that need to be examined
 . ; save image to TMP
 . ; get ien
 . S FBDA1=$O(^XDRM(FBDA,FBM,"B",FBX,0))
 . Q:'FBDA1
 . ; loop thru global data
 . S FBDA2=0 F  S FBDA2=$O(^XDRM(FBDA,FBM,FBDA1,1,FBDA2)) Q:'FBDA2  D
 . . S FBGN=$P($G(^XDRM(FBDA,FBM,FBDA1,1,FBDA2,0)),U)
 . . S FBGD=$G(^XDRM(FBDA,FBM,FBDA1,1,FBDA2,1))
 . . S FBGN="^TMP($J,FBFR,FBFILE,"_$E(FBGN,7,999)
 . . S @FBGN=FBGD
 Q
 ;
FB16101 ; process FEE BASIS PATIENT file authorization multiple (161.01)
 ;   a) check for potential merge problem
 ;   b) determine if FBFR authorization ien was changed during merge
 ; input
 ;   FBFR
 ;   FBTO
 ;   ^TMP($J,FBFR,161,...
 ; output
 ;   FBAUTCHG(original authorization ien, changed ien)=""
 ;   if problem detected
 ;     ^TMP($J,"PROB",FBFR,161.01,from before image iens)=problem text
 ;     ^TMP($J,"PROB",FBFR)=FBTO
 ;
 N FBAUTC,FBAUTF,FBAUTT,FBC,FBDIF,FBFD,FBFND,FBFRIENS,FBI,FBX,FBXC
 K FBAUTCHG
 ;
 ; if no data in 161.01 before image for 'to' patient then 'from' data
 ; is merged to the new location and there are no authorization issues
 I '$O(^TMP($J,FBFR,161,FBTO,1,0)) D  Q
 . ;I $O(^TMP($J,FBFR,161,FBFR,1,0)) W !,"OK "_FBFR_" PATIENT DOESN'T HAVE DATA IN "_FBTO_" BEFORE IMAGE."
 ;
 ; loop thru authorizations in before image of 'from' patient
 S FBAUTF=0 F  S FBAUTF=$O(^TMP($J,FBFR,161,FBFR,1,FBAUTF)) Q:'FBAUTF  D
 . S FBX=$G(^TMP($J,FBFR,161,FBFR,1,FBAUTF,0))
 . S FBFD=$P(FBX,U)
 . Q:FBFD=""
 . S FBFRIENS=FBAUTF_","_FBFR_","
 . ;
 . ; if the FROM DATE value is also in the "B" x-ref of the before image
 . ; of the 'to' patient then it may have been inappropriately combined
 . S FBAUTT=$S(FBFD:$O(^TMP($J,FBFR,161,FBTO,1,"B",FBFD,0)),1:"")
 . I FBAUTT D  Q
 . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . S ^TMP($J,"PROB",FBFR,161.01,FBAUTF_","_FBFR_",")=FBTO_" patient before image has from date in x-ref"
 . ;
 . ; loop thru current FEE BASIS PATIENT authorizations to find it
 . S FBC=0 ; count of entries that match data
 . S FBFND="" ; ien of authorization in current file
 . S FBAUTC=0 F  S FBAUTC=$O(^FBAAA(FBTO,1,FBAUTC)) Q:'FBAUTC  D
 . . ; ignore if in the before image of 'merged to' patient since it
 . . ; could not have been moved during the merge
 . . Q:$D(^TMP($J,FBFR,161,FBTO,1,FBAUTC,0))
 . . S FBXC=$G(^FBAAA(FBTO,1,FBAUTC,0))
 . . S FBDIF=0
 . . F FBI=1,3,13 I $P(FBX,U,FBI)'=$P(FBXC,U,FBI) S FBDIF=1
 . . I 'FBDIF S FBFND=FBAUTC_","_FBTO_",",FBC=FBC+1
 . ;
 . ; if 1 found then if authorization ien changed store in list for
 . ;   later updates to 'free-text' pointers
 . I FBC=1 D
 . . ;W !,"AUTH IENS OLD: "_FBFRIENS_" NEW: "_FBFND
 . . I $P(FBFND,",")'=FBAUTF S FBAUTCHG(FBAUTF,$P(FBFND,","))=""
 . I FBC=0 D
 . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . S ^TMP($J,"PROB",FBFR,161.01,FBFRIENS)="Authorization not found in "_FBTO_" current data."
 . I FBC>1 D
 . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . S ^TMP($J,"PROB",FBFR,161.01,FBFRIENS)=FBC_" matching authorizations found in "_FBTO_" current data."
 Q
 ;
FB16203 ; process FEE BASIS PAYMENT file service provided multiple (162.03)
 ; input
 ;   FBFR
 ;   FBTO
 ;   ^TMP($J,FBFR,162,...
 ; output
 ;   store old & new payments iens
 ;   update 'free-text' pointer
 ;   if problems detected
 ;     ^TMP($J,"PROB",FBFR,162.03,from before image iens)=problem text
 ;     ^TMP($J,"PROB",FBFR)=FBTO
 ;
 N FBC,FBC2,FBC3,FBDIF,FBFND,FBFR2,FBFR3,FBFRIENS,FBFTPC,FBFTPN,FBFTPU
 N FBI,FBTD,FBV,FBX,FBXC
 ; loop thru vendors in before image of FBFR patient
 S FBV=0 F  S FBV=$O(^TMP($J,FBFR,162,FBFR,1,FBV)) Q:'FBV  D
 . ; since vendor multiple is dinumed we know ien in current 162 file
 . ; loop thru initial treatment date in before image of FBFR
 . S FBFR2=0
 . F  S FBFR2=$O(^TMP($J,FBFR,162,FBFR,1,FBV,1,FBFR2)) Q:'FBFR2  D
 . . ; get date
 . . S FBTD=$P($G(^TMP($J,FBFR,162,FBFR,1,FBV,1,FBFR2,0)),U)
 . . S FBFTPU=0 ; init flag (set true if free-text pointer updated)
 . . ; loop thru service provided in before image of FBFR
 . . S FBFR3=0
 . . F  S FBFR3=$O(^TMP($J,FBFR,162,FBFR,1,FBV,1,FBFR2,1,FBFR3)) Q:'FBFR3  D
 . . . S FBFRIENS=FBFR3_","_FBFR2_","_FBV_","_FBFR_","
 . . . S FBX=$G(^TMP($J,FBFR,162,FBFR,1,FBV,1,FBFR2,1,FBFR3,0))
 . . . ;
 . . . ; find iens in current file 162.03
 . . . ; if no data in 161.03 before image for 'to' patient then 'from'
 . . . ; data is merged to the new location and only patient ien changes
 . . . I '$O(^TMP($J,FBFR,162,FBTO,1,0)),$D(^FBAAC(FBTO,1,FBV,1,FBFR2,1,FBFR3,0)) S FBFND=FBFR3_","_FBFR2_","_FBV_","_FBTO_",",FBC=1
 . . . E  D
 . . . . S FBC=0 ; count of entries that match data
 . . . . S FBFND="" ; iens of entry in current file
 . . . . S FBC2=0
 . . . . F  S FBC2=$O(^FBAAC(FBTO,FBV,"AD",(9999999.9999-FBTD),FBC2)) Q:'FBC2  D
 . . . . . S FBC3=0
 . . . . . F  S FBC3=$O(^FBAAC(FBTO,1,FBV,1,FBC2,1,FBC3)) Q:'FBC3  D
 . . . . . . ; ignore if in the before image of the 'merged to' patient
 . . . . . . Q:$D(^TMP($J,FBFR,162,FBTO,1,FBV,1,FBC2,1,FBC3,0))
 . . . . . . S FBXC=$G(^FBAAC(FBTO,1,FBV,1,FBC2,1,FBC3,0))
 . . . . . . S FBDIF=0
 . . . . . . F FBI=1,9 I $P(FBX,U,FBI)'=$P(FBXC,U,FBI) S FBDIF=1
 . . . . . . I 'FBDIF S FBFND=FBC3_","_FBC2_","_FBV_","_FBTO_",",FBC=FBC+1
 . . . ;
 . . . I FBC=1 D
 . . . . ;W !,"SVC IENS OLD: "_FBFRIENS_" NEW: "_FBFND
 . . . . ; save in file
 . . . . N FBFDA
 . . . . S FBFDA(161.45,"+1,",.01)="162.03"
 . . . . S FBFDA(161.45,"+1,",1)=FBFRIENS
 . . . . S FBFDA(161.45,"+1,",2)=FBFND
 . . . . D UPDATE^DIE("","FBFDA") ;***temp quit for testing
 . . . . ;
 . . . . ; update 'free-text' authorization pointer if it changed
 . . . . I 'FBFTPU D
 . . . . . S FBFTPC=$$GET1^DIQ(162.02,$P(FBFND,",",2,5),3) ; current
 . . . . . S FBFTPN=$S(FBFTPC:$O(FBAUTCHG(FBFTPC,0)),1:"") ; new if diff
 . . . . . I FBFTPN,FBFTPN'=FBFTPC D
 . . . . . . N FBFDA
 . . . . . . S FBFDA(162.02,$P(FBFND,",",2,5),3)=FBFTPN
 . . . . . . D FILE^DIE("","FBFDA") ;***temp quit for testing
 . . . . . . S FBFTPU=1 ; set flag
 . . . ;
 . . . I FBC=0 D
 . . . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . . . S ^TMP($J,"PROB",FBFR,162.03,FBFRIENS)="Medical payment not found in "_FBTO_" current data."
 . . . ;
 . . . I FBC>1 D
 . . . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . . . S ^TMP($J,"PROB",FBFR,162.03,FBFRIENS)=FBC_" matching medical payments found in "_FBTO_" current data."
 Q
 ;
FB16204 ; process FEE BASIS PAYMENT file travel payment multiple (162.04)
 ; input
 ;   FBFR
 ;   FBTO
 ;   ^TMP($J,FBFR,162,...
 ; output
 ;   store old & new payment iens
 ;   if problems detected
 ;     ^TMP($J,"PROB",FBFR,162.04,from before image iens)=problem text
 ;     ^TMP($J,"PROB",FBFR)=FBTO
 ;
 N FBC,FBC1,FBDIF,FBFND,FBFR1,FBFRIENS
 N FBI,FBTD,FBV,FBX,FBXC
 ; loop thru travel payments in before image of FBFR
 S FBFR1=0
 F  S FBFR1=$O(^TMP($J,FBFR,162,FBFR,3,FBFR1)) Q:'FBFR1  D
 . S FBFRIENS=FBFR1_","_FBFR_","
 . S FBX=$G(^TMP($J,FBFR,162,FBFR,3,FBFR1,0))
 . Q:$P(FBX,U)=""
 . ;
 . ; find iens in current file 162.04
 . ; if no data in 161.04 before image for 'to' patient then 'from'
 . ; data is merged to the new location and only patient ien changes
 . I '$O(^TMP($J,FBFR,162,FBTO,3,0)),$D(^FBAAC(FBTO,3,FBFR1,0)) S FBFND=FBFR1_","_FBTO_",",FBC=1
 . E  D
 . . S FBC=0 ; count of entries that match data
 . . S FBFND="" ; iens of entry in current file
 . . S FBC1=0 F  S FBC1=$O(^FBAAC(FBTO,3,"AB",$P(FBX,U),FBC1)) Q:'FBC1  D
 . . . ; ignore if in the before image of the 'merged to' patient
 . . . Q:$D(^TMP($J,FBFR,162,FBTO,3,FBC1,0))
 . . . S FBXC=$G(^FBAAC(FBTO,3,FBC1,0))
 . . . S FBDIF=0
 . . . F FBI=1 I $P(FBX,U,FBI)'=$P(FBXC,U,FBI) S FBDIF=1
 . . . I 'FBDIF S FBFND=FBC1_","_FBTO_",",FBC=FBC+1
 . ;
 . I FBC=1 D
 . . ;W !,"TRAVEL IENS OLD: "_FBFRIENS_" NEW: "_FBFND
 . . ; save in file
 . . N FBFDA
 . . S FBFDA(161.45,"+1,",.01)="162.04"
 . . S FBFDA(161.45,"+1,",1)=FBFRIENS
 . . S FBFDA(161.45,"+1,",2)=FBFND
 . . D UPDATE^DIE("","FBFDA") ;***temp quit for testing
 . ;
 . I FBC=0 D
 . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . S ^TMP($J,"PROB",FBFR,162.04,FBFRIENS)="Travel payment not found in "_FBTO_" current data."
 . ;
 . I FBC>1 D
 . . S:'$D(^TMP($J,"PROB",FBFR)) ^TMP($J,"PROB",FBFR)=FBTO
 . . S ^TMP($J,"PROB",FBFR,162.04,FBFRIENS)=FBC_" matching travel payments found in "_FBTO_" current data."
 Q
 ;
 ;FBXIP19A
