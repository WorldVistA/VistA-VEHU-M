DENTVTPE ;DSS/KC - UPDATE PCE DATA FOR TP ;04/11/2007 9:05
 ;;1.2;DENTAL;**53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  -----------------------------------
 ;  1889  cont sub   $$DATA2PCE^PXAPI, ENCEVENT^PXAPI
 ;  2056      x      $$GET1^DIQ
 ;
UPD(DENTRET,DATA) ;rpc DENTV UPDATE PCE
 ;returns RET(n)=0^OK, or -1^error
 ;DATA = array(n) where n=txn id that was deleted from DRM
 ;
 ;  PCE stores data differently than DRM, for instance 4 extract (D7140) txns
 ;  are stored as 1 D7140 with a qty=4.  The API to delete does NOT allow
 ;  deletion by qty, only by CPT code, so if the user wants to delete 2 of the 4
 ;  extractions, we have to delete all 4, and then re-add 2 back into PCE
 ;  
 ;  Because a user can delete ANY txn(s), there may be txns from multiple
 ;  visits to delete in one call - we have to do them by visit for the API
 ;  
 ;  If the user deletes the PCE Primary Dx, we have to prompt for a new one
 ;  and then refile (see the PDX linetag) with another rpc call
 ;
 N PKG,SOURCE,I,N0,N1,H0,VIEN,VIEDT,DENICD,DENVIEN
 S DENTRET=$NA(^TMP("DENTRET",$J)) K @DENTRET
 S PKG=0 D PKG I PKG<0 S @DENTRET@(1)="-1^No Dental package file entry found" Q
 K ^TMP("DENTVD",$J)
 I $D(DATA("ENC")) D  Q:$D(@DENTRET)  ;deleting entire encounter
 .S ENC=$O(DATA(0)) K DATA D ENC^DENTVTPF
 .I 'ENC S @DENTRET@(1)="-1^Encounter not sent"
 .Q
 S I=0 F  S I=$O(DATA(I)) Q:'I  D
 .S N0=$G(^DENT(228.2,I,0)),N1=$G(^(1))
 .I $P(N0,U,4)="" Q  ;no ada code (placeholder txn)
 .S H0=$G(^DENT(228.1,+$P(N1,U,15),0)) Q:'H0
 .S VIEN=$P(H0,U,5) Q:'VIEN  ;no PCE visit
 .I $D(^TMP("DENTVD",$J,VIEN,+$P(N0,U,4))) Q  ;already listed
 .S ^TMP("DENTVD",$J,VIEN,"PRV",+$P(N0,U,3))=""
 .I $P(H0,U,8) S ^TMP("DENTVD",$J,VIEN,"PRV",+$P(H0,U,8))="" ;dist prov
 .S ^TMP("DENTVD",$J,VIEN,"CPT",+$P(N0,U,4))=$P(N0,U,3)_U_$P(N1,U,6,10)
 .F J=6:1:10 S DENICD=$P(N1,U,J) S:DENICD ^TMP("DENTVD",$J,VIEN,"POV",DENICD)=$P(N0,U,3)
 .Q
 ;now you have something like this, READY to delete from PCE
 ;^TMP("DENTVD",2800,4785,"CPT",100318)=13561^10000000046
 ;                               104362)=2855^10000000046
 ;^TMP("DENTVD",2800,4785,"POV",2855)=10000000046
 ;                              13561)=10000000046
 ;^TMP("DENTVD",2800,4785,"PRV",10000000046)=
 ;
 ;loop for EACH visit we have deletions to perform'
 I '$D(^TMP("DENTVD",$J)) S @DENTRET@(1)="-1^No data to delete" Q
 S DENVIEN=0 F  S DENVIEN=$O(^TMP("DENTVD",$J,DENVIEN)) Q:'DENVIEN  D DEL(DENVIEN)
 K ^TMP("DENTVD",$J)
 Q
 ;
DEL(DENVIEN) ;entry for each visit to perform deletes/adds as necessary
 N CNT,I,N,DENVIEDT
 S DENVIEDT=$$GET1^DIQ(9000010,DENVIEN,.01,"I") ;get the visit date
 ;Setup the data to be deleted for the DATA2PCE API
 S CNT=0,I=0 K ^TMP("DENTVTPE",$J)
 F  S I=$O(^TMP("DENTVD",$J,DENVIEN,"CPT",I)) Q:'I  S N=$G(^(I)),CNT=CNT+1 D
 .S ^TMP("DENTVTPE",$J,"PROCEDURE",CNT,"PROCEDURE")=I
 .S ^TMP("DENTVTPE",$J,"PROCEDURE",CNT,"QTY")=1
 .S ^TMP("DENTVTPE",$J,"PROCEDURE",CNT,"DIAGNOSIS")=$P(N,U,2)
 .S ^TMP("DENTVTPE",$J,"PROCEDURE",CNT,"ENC PROVIDER")=$P(N,U,1)
 .S ^TMP("DENTVTPE",$J,"PROCEDURE",CNT,"EVENT D/T")=DENVIEDT
 .S ^TMP("DENTVTPE",$J,"PROCEDURE",CNT,"DELETE")=1
 .Q
 S CNT=0,I=0
 F  S I=$O(^TMP("DENTVD",$J,DENVIEN,"POV",I)) Q:'I  S N=$G(^(I)),CNT=CNT+1 D
 .S ^TMP("DENTVTPE",$J,"DX/PL",CNT,"DIAGNOSIS")=I
 .S ^TMP("DENTVTPE",$J,"DX/PL",CNT,"ENC PROVIDER")=N
 .S ^TMP("DENTVTPE",$J,"DX/PL",CNT,"EVENT D/T")=DENVIEDT
 .S ^TMP("DENTVTPE",$J,"DX/PL",CNT,"DELETE")=1
 .Q
 S CNT=0,I=0
 F  S I=$O(^TMP("DENTVD",$J,DENVIEN,"PRV",I)) Q:'I  S CNT=CNT+1 D
 .S ^TMP("DENTVTPE",$J,"PROVIDER",CNT,"NAME")=I
 .S ^TMP("DENTVTPE",$J,"PROVIDER",CNT,"DELETE")=1
 .Q
 ;delete the data from PCE
 S VAR=$$DATA2PCE^PXAPI("^TMP(""DENTVTPE"",$J)",PKG,SOURCE,DENVIEN,"")
 K ^TMP("DENTVTPE",$J)
 ;
 ;get all REMAINING completed codes for the VISIT
 N J,N0,N1,H0,ADA,PROV,K
 K ^TMP("DENTVA",$J)
 S I=0 F  S I=$O(^DENT(228.1,"AV",DENVIEN,I)) Q:'I  D
 .S J=0 F  S J=$O(^DENT(228.2,"AG",I,J)) Q:'J  D
 ..S N0=$G(^DENT(228.2,J,0)),N1=$G(^(1)),H0=$G(^DENT(228.1,+$P(N1,U,15),0))
 ..I $P(N0,U,12)'=104 Q  ;not completed
 ..I $P(N1,U,3) Q  ;deleted
 ..I '$P(N1,U,19) Q  ;not filed to PCE
 ..S ADA=$P(N0,U,4),PROV=$P(N0,U,3)
 ..I ADA="" Q  ;no ada code (placeholder txn)
 ..I $D(^TMP("DENTVA",$J,DENVIEN,"CPT",ADA)) D  Q  ;already listed
 ...S ^TMP("DENTVA",$J,DENVIEN,"CPT",ADA,"QTY")=$G(^TMP("DENTVA",$J,DENVIEN,"CPT",ADA,"QTY"))+1
 ..S ^TMP("DENTVA",$J,DENVIEN,"PRV",PROV)=""
 ..I $P(H0,U,8) S ^TMP("DENTVA",$J,DENVIEN,"PRV",+$P(H0,U,8))="P" ;dist prov
 ..S ^TMP("DENTVA",$J,DENVIEN,"CPT",ADA)=PROV_U_$P(N1,U,6,10)
 ..S ^TMP("DENTVA",$J,DENVIEN,"CPT",ADA,"QTY")=1
 ..F K=6:1:10 S DENICD=$P(N1,U,K) S:DENICD ^TMP("DENTVA",$J,DENVIEN,"POV",DENICD)=PROV
 ..Q
 .Q
 ;get what's left in the visit according to PCE after the delete
 K ^TMP("PXKENC",$J)
 D ENCEVENT^PXAPI(DENVIEN)
 ;now you have something like this.  CPT=procs, POV=dxs, PRV=providers
 ;^TMP("PXKENC",2800,4785,"CPT",3876,0)=104362^363^4785^1289^2855^^^^^^^^^^^1
 ;                                  12)=^^^10000000046
 ;                                 812)=^58^21
 ;^TMP("PXKENC",2800,4785,"POV",2103,0)=2855^363^4785^1802^^^^^^^^P
 ;                                  12)=3070409.13^^^10000000046
 ;                                 812)=^58^21
 ;^TMP("PXKENC",2800,4785,"PRV",3264,0)=10000000048^363^4785^P^^8
 ;                                 812)=^58^21
 ;^TMP("PXKENC",2800,4785,"PRV",3265,0)=10000000046^363^4785^S^^209
 ;                                 812)=^58^21
 ;^TMP("PXKENC",2800,4785,"VST",4785,0)=3070409.13^3070409.100611^V^^363^515.6^A^1
 ;60^10^^^^3070411.105409^^^^^^^^16^228^10000000046^11868
 ;                                 150)=1745-ALN^0^P
 ;                                 800)=0^^^^^^^^^^0^0^0^0^0^0^0
 ;                                 812)=^507^21
 ;compare the two to see what needs to be re-added
 N QTY,Y S CNT=0,I=0 K ^TMP("DENTVTPA",$J)
 F  S I=$O(^TMP("DENTVA",$J,DENVIEN,"CPT",I)) Q:'I  I '$$EXIST("CPT",I) D
 .S CNT=CNT+1,N=$G(^TMP("DENTVA",$J,DENVIEN,"CPT",I)),QTY=$G(^(I,"QTY"))
 .S ^TMP("DENTVTPA",$J,"PROCEDURE",CNT,"PROCEDURE")=I
 .S ^TMP("DENTVTPA",$J,"PROCEDURE",CNT,"QTY")=QTY
 .S ^TMP("DENTVTPA",$J,"PROCEDURE",CNT,"ENC PROVIDER")=$P(N,U)
 .S ^TMP("DENTVTPA",$J,"PROCEDURE",CNT,"EVENT D/T")=DENVIEDT
 .S ^TMP("DENTVTPA",$J,"PROCEDURE",CNT,"NARRATIVE")=$P($$CPT^DSICCPT("",I,"","","",1),U,3)
 .F J=2:1:6 S Y=$P(N,U,J) D:Y
 ..S X=$$DX(),^TMP("DENTVTPA",$J,"PROCEDURE",CNT,X)=Y
 ..Q
 .Q
 S CNT=0,I=0
 F  S I=$O(^TMP("DENTVA",$J,DENVIEN,"POV",I)) Q:'I  I '$$EXIST("POV",I) D
 .S CNT=CNT+1,N=$G(^TMP("DENTVA",$J,DENVIEN,"POV",I))
 .S ^TMP("DENTVTPA",$J,"DX/PL",CNT,"DIAGNOSIS")=I
 .S ^TMP("DENTVTPA",$J,"DX/PL",CNT,"ENC PROVIDER")=N
 .S ^TMP("DENTVTPA",$J,"DX/PL",CNT,"EVENT D/T")=DENVIEDT
 .Q
 S CNT=0,I=0
 F  S I=$O(^TMP("DENTVA",$J,DENVIEN,"PRV",I)) Q:'I  I '$$EXIST("PRV",I) D
 .S CNT=CNT+1
 .S ^TMP("DENTVTPA",$J,"PROVIDER",CNT,"NAME")=I
 .I $G(^TMP("DENTVA",$J,DENVIEN,"PRV",I))="P" S ^TMP("DENTVTPA",$J,"PROVIDER",CNT,"PRIMARY")=1
 .Q
 ;
 I '$D(^TMP("DENTVTPA",$J)) D FIN Q
 ;add data back to PCE
 S VAR=$$DATA2PCE^PXAPI("^TMP(""DENTVTPA"",$J)",PKG,SOURCE,DENVIEN,"")
 K ^TMP("DENTVTPA",$J),^TMP("DENTVA",$J)
 D FIN
 Q
EXIST(TYP,ITEM) ;check for this drm data in the PCE data
 S EXIST=0,Z=0
 F  S Z=$O(^TMP("PXKENC",$J,DENVIEN,TYP,Z)) Q:'Z!EXIST  I +$G(^(Z,0))=ITEM S EXIST=1
 Q EXIST
DX() ;file ALL dxs to each procedure as entered by user
 S Z=$O(^TMP("DENTVTPA",$J,"PROCEDURE",CNT,"DIAGNOSIS 9"),-1)
 I Z="" Q "DIAGNOSIS"
 S Z=$E(Z,11),Z=$S(Z="":2,1:Z+1)
 I Z>8 Q ""
 Q "DIAGNOSIS "_Z
 ;
FIN ;final check - if no primary dx or provider, prompt user for one
 K ^TMP("PXKENC",$J),^TMP("DENTVTPA",$J)
 D ENCEVENT^PXAPI(DENVIEN)
 I $D(^TMP("PXKENC",$J,DENVIEN,"POV")) D  ;has dx left - are any Primary?
 .S Z=0,PRIDX=0,CNT=0
 .F  S Z=$O(^TMP("PXKENC",$J,DENVIEN,"POV",Z)) Q:'Z!PRIDX  D
 ..S N0=$G(^(Z,0)) I $P(N0,U,12)="P" S PRIDX=+N0 Q
 ..S DX=$P($$ICD9^DSICDRG(,+N0,,,,1),U,1,4)
 ..S CNT=CNT+1,@DENTRET@(DENVIEN,"POV",CNT)="1^POV^"_DX
 ..Q
 .I PRIDX K @DENTRET@(DENVIEN,"POV") ;PCE has a primary dx, user doesn't need to pick one
 .I CNT=1 D  ;if only 1 dx left, it's primary by default
 ..S ^TMP("DENTVTPA",$J,"DX/PL",CNT,"DIAGNOSIS")=+DX
 ..S ^TMP("DENTVTPA",$J,"DX/PL",CNT,"PRIMARY")=1
 ..K @DENTRET@(DENVIEN,"POV") ;don't send single dx to the user to "decide" it's primary
 ..Q
 .Q
 I $D(^TMP("PXKENC",$J,DENVIEN,"PRV")) D  ;has providers left - are any Primary?
 .S Z=0,PRIPRV=0,CNT=0
 .F  S Z=$O(^TMP("PXKENC",$J,DENVIEN,"PRV",Z)) Q:'Z!PRIPRV  D
 ..S N0=$G(^(Z,0)) I $P(N0,U,4)="P" S PRIPRV=+N0 Q
 ..S CNT=CNT+1,@DENTRET@(DENVIEN,"PRV",CNT)="1^PRV^"_+N0_U_$$GET1^DIQ(200,+N0,.01)
 ..Q
 .I PRIPRV K @DENTRET@(DENVIEN,"PRV")
 .Q
 ;
 ;updating PCE (again) to set primary dx if there's only one
 I $D(^TMP("DENTVTPA",$J)) D
 .S VAR=$$DATA2PCE^PXAPI("^TMP(""DENTVTPA"",$J)",PKG,SOURCE,DENVIEN,"")
 .K ^TMP("DENTVTPA",$J)
 .Q
 S @DENTRET@(DENVIEN)="$START$^"_DENVIEN_U_$$FMTE^XLFDT(DENVIEDT)
 I $O(@DENTRET@(DENVIEN,0))="" S @DENTRET@(DENVIEN,1)="0^OK"
 S @DENTRET@(DENVIEN,"~")="$END$^"
 Q
PKG ;  check for valid dental package pointer for use with PCE
 S X=+$$FIND1^DIC(9.4,,"MOQ","DENT","B^C",,"DENXER")
 I X<1 S PKG=-1 Q
 S PKG=X,SOURCE="DENTV DSS GUI"
 Q
