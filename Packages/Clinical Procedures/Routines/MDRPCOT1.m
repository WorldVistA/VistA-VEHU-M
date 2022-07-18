MDRPCOT1 ;HOIFO/NCA/DP,WOIFO/PMK - Object RPCs (TMDTransaction) - Continued ;03 Jul 2018 9:09 AM
 ;;1.0;CLINICAL PROCEDURES;**5,11,21,41,60,78**;Apr 01, 2004;Build 7
 ; Integration Agreements:
 ; IA# 10000 [Supported] calls to NOW^%DTC
 ; IA# 2053 [Supported] calls to FILE^DIE
 ; IA# 10013 [Supported] calls to DIK
 ; IA# 2056 [Supported] calls to $$GET1^DIQ
 ; IA# 2056 [Supported] calls to GETS^DIQ
 ; IA# 3468 [Subscription] $$CPDOC^GMRCCP
 ; IA# 6931 [Private] call to $$GMRCACN^MAGDFCNV
 ; IA# 3567 [Subscription] IMPORT^MAGGSIUI
 ; IA# 10061 [Supported] Calls to IN5^VADPT
 ; IA# 10103 [Supported] Calls to $$NOW^XLFDT.
 ; IA# 5844 [Supported] Calls to $$CONVERT^XLFIPV
 ; IA# 2263 [Supported] calls to $$GET^XPAR and GETLST^XPAR
 ; IA# 3067 [Private] Reads fields in Consults file (#123).
 ; IA# 10040 [Supported] Hospital Location File Access
 ;
 ; 09/25/15 KAM Remedy Call 1095728  Patch MD*1*41 IPv6 modifications
 ;
DELERR(MDTIEN) ; [Procedure] Delete Imaging Error Messages
 S MDLP=0 F  S MDLP=$O(^MDD(702,MDTIEN,.091,MDLP)) Q:'MDLP  D
 .K DA,DIK
 .S DA=+MDLP,DA(1)=+MDTIEN,DIK="^MDD(702,"_DA(1)_",.091," D ^DIK
 .Q
 Q
 ;
IMGSTAT(STUDY,MDSTAT) ; [Procedure] Update the Image Status.
 N MDL
 S MDL=0 F  S MDL=$O(^MDD(702,STUDY,.1,MDL)) Q:MDL<1  S $P(^(MDL,0),"^",9)=MDSTAT
 Q
 ;
GETVSTR(DFN,MDSSTR,MDPR,MDTR) ; [Function] Check the Visit String
 N MDCLOC,MDHOLD,MDLOC,MDINPT,VAIP
 N MDPR12,MDAPP ; Patch 11
 I '$G(MDTR) Q 0
 I '$G(MDPR) Q 0
 I $G(MDSSTR)="" Q 0
 S VAIP("D")=MDTR ; DT of Transaction Created
 D IN5^VADPT S MDINPT=$S(+VAIP(13):1,1:0)
 S (MDCLOC,MDHOLD)=$$GET1^DIQ(702.01,+MDPR_",",.05,"I")
 ; Patch 11
 S MDPR12=$$GET1^DIQ(702.01,+MDPR_",",.12,"I")
 S:MDPR12=1 MDCLOC=""
 S MDAPP=$$GET^XPAR("SYS","MD USE APPOINTMENT",1)
 ; End Patch 11 code
 I 'MDCLOC S MDCLOC=+$P(MDSSTR,";",3) I 'MDCLOC S MDCLOC=MDHOLD I 'MDCLOC Q 0
 I +MDAPP S MDCLOC=$S(+$P(MDSSTR,";",3)>1:+$P(MDSSTR,";",3),1:MDCLOC) I 'MDCLOC Q 0
 S Y=MDCLOC_";"_$P(MDSSTR,";",2)_";"_$P(MDSSTR,";")
 I $P(Y,";",3)="A" Q Y
 S:$P(Y,";",3)="" $P(Y,";",3)="A"
 S:+MDINPT $P(Y,";",3)="A"
 S:$P(Y,";",3)="V" $P(Y,";",3)="A"
 Q Y
 ;
PDT(STUDIE) ; [Function] Loop through the attachments for Date/Time Performed.
 N MDL,MDDT
 S MDL=0,MDDT=""
 F  S MDL=$O(^MDD(702,STUDIE,.1,MDL)) Q:'MDL  D  Q:MDDT
 .S MDDT=$P($G(^MDD(702,STUDIE,.1,MDL,0)),"^",3)
 I MDDT S MDDT=$P($G(^MDD(703.1,+MDDT,0)),"^",3) ; Get Date/Time Performed
 ;S:'MDDT MDDT=$$NOW^XLFDT()
 Q MDDT
 ;
SUBMIT(STUDY) ; [Function] Submit all non-pending/uncomplete images in transaction to Imaging
 N DATA,DEVIEN,MDACQ,MDC,MDCRES,MDCTR,MDLOC,MDAR,MDARR,MDDT,MDFDA,MDDEL,MDIEN,MDIENS,MDIMG,MDL,MDLPB,MDMAG,MDMULT,MDR,MDST,MDX,MDY,MDZ
 S MDIEN=+STUDY,MDIENS=MDIEN_",",MDLPB=0
 S DEVIEN=$P(^MDD(702,STUDY,0),U,11)
 ;
 ; 09/25/15 KAM Remedy Ticket 1095728 IPv6 modifications
 ; Changed next line to use API
 ;S:$$GET1^DIQ(702.09,DEVIEN_",",.14)="127.0.0.1" MDLPB=1
 S:$$CONVERT^XLFIPV($$GET1^DIQ(702.09,DEVIEN_",",.14))=$$CONVERT^XLFIPV("127.0.0.1") MDLPB=1
 ;
 S MDMULT=$$MULT(+MDIEN)
 S MDST=$$GET1^DIQ(702,MDIEN,.09,"I") ; I 'MDMULT&('MDLPB)&("13"[MDST) Q "-1^Study not in proper status"
 I MDMULT&(MDST=1) Q "-1^Study not in proper status"
 I MDMULT&(MDST=3) D STATUS^MDRPCOT(MDIENS,5,"")
 D DELERR(+MDIEN)
 I $$GET1^DIQ(702,MDIEN,.01)="" Q "-1^No Entry in file (#702)."
 D NOW^%DTC S MDDT=%
 S MDMAG("IDFN")=+$$GET1^DIQ(702,MDIEN,.01,"I")
 I 'MDMAG("IDFN") Q "-1^No Patient DFN."
 S MDMAG("PXPKG")=8925
 S MDMAG("PXIEN")=+$$GET1^DIQ(702,MDIEN,.06,"I")
 I 'MDMAG("PXIEN") Q "-1^No TIU IEN"
 I '$O(^MDD(702,MDIEN,.1,0)) D  Q $S(+MDR<0:MDR,1:"3^Transaction Complete")
 .S MDC=$$GET1^DIQ(702,MDIEN,.05,"I")
 .S MDR=$$UPDCONS(MDC,MDMAG("PXIEN"))
 S MDMAG("STSCB")="ISTAT^MDAPI"
 S MDMAG("TRKID")="CP;"_MDIEN_"-"_MDDT
 S MDLOC=$$GET1^DIQ(702,MDIEN,.07,"I"),MDLOC=$P(MDLOC,";",3)
 I 'MDLOC Q "-1^No Hospital Location."
 S MDMAG("ACQS")=$S(+$$GET1^DIQ(44,MDLOC_",",3,"I"):+$$GET1^DIQ(44,MDLOC_",",3,"I"),1:+$G(DUZ(2)))
 S MDMAG("ACQL")=MDLOC
 S MDX=$$GET1^DIQ(702,MDIEN,.04,"I")
 S MDZ=$P(^MDS(702.01,+MDX,0),"^",1)
 S (MDACQ,MDX,MDDEL)="",MDCTR=0
 N MDTOT S MDTOT=$$GET1^DIQ(702,MDIENS,.991)
 S MDL=0 F  S MDL=$O(^MDD(702,MDIEN,.1,MDL)) Q:MDL<1  S MDX=$G(^(MDL,0)) D
 .S:'MDDEL MDDEL=$P(MDX,"^",3)
 .S MDY=$G(^MDD(702,MDIEN,.1,MDL,.1)) Q:MDY=""
 .S:MDACQ="" MDACQ=$P($P(MDY,"\\",2),"\")
 .S:"12"[$P(MDX,"^",9) $P(MDX,"^",9)=""
 .I $P(MDX,"^",9)="" S MDCTR=MDCTR+1,MDARR(MDCTR)=MDY_"^"_MDZ_" image "_MDCTR_" out of "_MDTOT
 .Q
 I '$O(MDARR(0)) Q "-1^No UNC."
 S MDMAG("GDESC")=MDZ_" Result"
 I MDDEL S MDY=$P($G(^MDD(703.1,+MDDEL,0)),"^",3,4),MDMAG("PXDT")=$P(MDY,"^",1),MDY=+$P(MDY,"^",2),MDMAG("ACQD")=$P($G(^MDS(702.09,+MDY,0)),"^"),MDMAG("DFLG")=+$P($G(^MDS(702.09,+MDY,0)),"^",5)
 S:$G(MDMAG("ACQD"))="" MDMAG("ACQD")=MDACQ
 S:'$G(MDMAG("PXDT")) MDMAG("PXDT")=MDDT ; If no date, use NOW in MDDT
 S MDMAG("TRTYPE")="NEW"
 D IMPORT^MAGGSIUI(.MDIMG,.MDARR,.MDMAG)
 I '(+$G(MDIMG(0))) D  Q "-1^"_$P(MDIMG(0),"^",2)
 .D IMGSTAT(+MDIENS,1)
 .F MDAR=0:0 S MDAR=$O(MDIMG(MDAR)) Q:'MDAR  I $G(MDIMG(MDAR))'="" D
 ..S DATA("MESSAGE")=$$TRANS^MDAPI(MDIMG(MDAR)) D ADDMSG^MDRPCOT
 D IMGSTAT(+MDIENS,0)
 Q "1^Images Submitted"
 ;
UPDCONS(MDC,MDDOC) ; [Function] Update Consults Procedure Status
 N MDCRES,MDKK,MDSDY,MDPDEF,MDF,MDH,MDX3,MDX4,MDXC,MDXD S (MDF,MDXD)=0,MDX4=""
 D GETLST^XPAR(.MDH,"SYS","MD GET HIGH VOLUME")
 S MDSDY=$O(^MDD(702,"ACON",MDC,""),-1) Q:'+MDSDY 1
 S MDPDEF=+$P($G(^MDD(702,+MDSDY,0)),"^",4) Q:'+MDPDEF 1
 F MDKK=0:0 S MDKK=$O(MDH(MDKK)) Q:MDKK<1  I $P($G(MDH(MDKK)),"^")=+MDPDEF S MDF=1 Q
 I $P($G(^MDS(702.01,+MDPDEF,0)),U,6)=2 Q 1
 D GETS^DIQ(123,MDC_",","50*","I","MDXC")
 S MDX3="" F  S MDX3=$O(MDXC(123.03,MDX3)) Q:MDX3<1  S MDX4=$G(MDXC(123.03,MDX3,.01,"I")) I MDX4["TIU" S:+MDX4=+$P($G(^MDD(702,+MDSDY,0)),"^",6) MDXD=1 Q
 I +$P($G(^MDS(702.01,+MDPDEF,0)),U,10)!(+MDF) Q:+MDXD 1
 S MDCRES=$$CPDOC^GMRCCP(MDC,MDDOC,2)
 I '(+MDCRES) Q "-1^"_$P(MDCRES,"^",2)
 Q 1
 ;
GETIORD(MDIEN) ; [Function] Return the Instrument order number for this study
 ; Called from instrument interface routines
 Q:'$D(^MDD(702,MDIEN,0))#2 -1  ; No such study
 Q:'$P(^MDD(702,MDIEN,0),U,12) $$NEWIORD(MDIEN)  ; Create a new one
 Q $P(^MDD(702,MDIEN,0),U,12)  ; Return the existing one
 ;
NEWIORD(MDIEN) ; [Function] Generate & return new unique instrument order number
 ; Notice: will overwrite existing order number if it exists
 N MDFDA
 Q:'$D(^MDD(702,MDIEN,0))#2 -1  ; No such study
 L +^MDD(702,"AION"):15 E  Q -1  ; Unable to lock and guarantee uniqueness
 F  D  Q:'$D(^MDD(702,"AION",X))  H 1  ; Loop until unique
 . S X=$$NOW^XLFDT() ; Current DateTime
 . S X=$TR($J(X,14,6),".","") ; Pad with 0's and strip the decimal
 . Q
 I $E($G(^MDS(702.09,DEVIEN,0)),1,4)="Muse" D
 . ; Due to current limitation to the Muse can only except 9
 . ;MD*1.0*78 MUST RETURN EXACTLY 9 DIGITS 24 hours a day
 . ;S X=$E($TR($H,",",""),2,10) ; Using $E($H) only for the MUSE
 . ;MD*1.0*78 Add leading zeros to time to always create 9 digit order number
 . S X=$E($P($H,","),2,5)_$E("00000",1,5-$L($P($H,",",2)))_$P($H,",",2)
 . I '$D(^MDD(702,"AION",X)) Q  ; It is unique and quit
 . N I,FLG ; Not unique
 . S FLG=0
 . F I=1:1 D  Q:FLG
 . . S X=X+1
 . . I '$D(^MDD(702,"AION",X)) S FLG=1
 . . Q
 . Q
 S MDFDA(702,MDIEN_",",.12)=X  ; Build FDA
 D FILE^DIE("","MDFDA")  ; File it
 L -(^MDD(702,"AION"))  ; Unlock it
 ;
 ; MD*1.0*60 - 25 April 2018 - Peter Kuzmak, VistA Imaging
 ; VistA Imaging code to replace the CP Instrument Order Number
 ; with the VistA Imaging consult Accession Number.
 ; 
 ; This greatly improves interoperability between Clinical Procedure
 ; and VistA Imaging CPRS Consult Request Tracking DICOM because
 ; it allows DICOM objects created during a Clinical Procedure
 ; examination to be automatically associated in VistA.
 ;
 N MDS70209,MDFDA,MDGMRCIEN,MDIORD,MDCPDICOM
 S MDS70209=$$GET1^DIQ(702,MDD702,.11,"I") ; get instrument
 S MDCPDICOM=$$GET1^DIQ(702.09,MDS70209,.19,"I") ; get CP - DICOM Interoperability
 I MDCPDICOM D  ; replace CP's accession number with VistA's
 . S MDGMRCIEN=$P(^MDD(702,MDIEN,0),U,5) ; consult number
 . S MDIORD=$$GMRCACN^MAGDFCNV(MDGMRCIEN) ; VI accession number
 . S MDFDA(702,MDIEN_",",.12)=MDIORD  ; Build FDA
 . D FILE^DIE("","MDFDA")  ; File it
 . Q
 ;
 Q $P(^MDD(702,MDIEN,0),U,12)  ; Return it from the file
 ;
GETSTDY(MDION) ; [Function] Return study from instrument order number
 ; Called from instrument interface routines
 Q:'$D(^MDD(702,"AION",MDION)) ""  ; No such order number
 ;
 ; KLM/MD*1.0*60 - 27 June 2018
 ; Return the most recent transaction.  We will look for a pending status on finals,
 ; and complete status on amendments. Failing that, return the most recent no matter
 ; what status as CP will check the transaction status later.
 ; Expected variable X contains the OBR segment
 ; If DEVIEN is not defined, or not using CP-VI accession number, get ION the old way
 I '$G(DEVIEN)!($$GET1^DIQ(702.09,DEVIEN,.19,"I")<1) Q $O(^MDD(702,"AION",MDION,""),-1) ; Return the 702 ien
 ;
 N MDQ,MDIEN,MDTST,MD25,MDX,MDS
 S MD25=$P($G(X),"|",26) ; OBR-25 Result status (CP uses F,C,X only)
 S (MDX,MDS,MDQ)=0
 S MDIEN="" F  Q:MDQ  S MDIEN=$O(^MDD(702,"AION",MDION,MDIEN),-1) Q:MDIEN=""  D
 . S MDX=MDX+1 I MDX=1 S MDS=MDIEN ;save off first one
 . S MDTST=$P($G(^MDD(702,MDIEN,0)),U,9) ; Transaction Status
 . I MDTST=5,MD25="F" S MDQ=MDIEN ; check if status is 'Pending Instrument Data' for Final
 . I MDTST=3,MD25="C" S MDQ=MDIEN ; check if status is 'Complete' for Amendment
 . Q
 I MDQ=0,MDS S MDQ=MDS
 Q $S(MDQ>0:MDQ,1:"")
 ;
MULT(MDIN) ; [Function] Return whether result is multiple or final
 N MDDEF
 S MDDEF=+$$GET1^DIQ(702,MDIN,.04,"I")
 I 'MDDEF Q 0
 Q +$$GET1^DIQ(702.01,MDDEF,.12,"I")
