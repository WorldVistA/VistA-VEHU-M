DGZPMDX ;ALB/MLI - Diagnosis routine for DGPM problems ; 10/2/95 [10/3/95 9:33am]
 ;;version 1.0
 ;
 ; This routine will loop through entries in the PATIENT MOVEMENT file
 ; and verify cross-references exist.  It will also loop through all of
 ; the cross-references to ensure that corresponding data exists.
 ; Lastly, it will check for current inpatients and ensure they PATIENT
 ; file x-refs are properly set and loop through the PATIENT file x-refs
 ; to ensure they have corresponding supporting data in ^DGPM.
 ;
EN ; queues process to run
 ;
 S ZTRTN="DQ^DGZPMDX",ZTDESC="Diagnostic for pt. movement data/x-refs"
 S ZTIO="" D ^%ZTLOAD
 I $D(ZTSK) W !,"ZTSK = ",ZTSK
 K ZTDESC,ZTIO,ZTRTN,ZTSK
 Q
 ;
 ;
DQ ; begin processing
 ;
 S (DGZCOUNT,DGZERR)=0
 S DGZSTART=$$NOW^XLFDT()
 S DGZERR=$$DGPMENT()
 S DGZERR=$$DGPMXREF()
 I 'DGZERR D  ; if no DGPM problems found
 . D DPTENT
 . D DPTXREF
 D MAIL
 K ^TMP("DGZPMDX",$J)
 K DGZCOUNT,DGZERR,DGZSTART
 Q
 ;
 ;
DGPMENT() ; checks each entry to verify the x-refs are set appropriately
 ;
 N DA,CA,DATE,DFN,ERR,ID,NODE,TT,I,J,K,L
 S ERR=0
 F DA=0:0 S DA=$O(^DGPM(DA)) Q:'DA  D
 . I '$D(ZTQUEUED),'(DA#1000) W "."
 . S NODE=$G(^DGPM(DA,0)),DFN=+$P(NODE,"^",3),CA=+$P(NODE,"^",14),TT=$P(NODE,"^",2)
 . I TT=4!(TT=5) Q  ; don't check lodgers
 . S DATE=+NODE+($P(NODE,"^",22)/10000000),ID=9999999.9999999-DATE
 . I '$P(NODE,"^",4) S ERR=1 D LINE("Incomplete 0 node for entry "_DA) Q
 . I '$D(^DGPM("B",+NODE,DA)) S ERR=$$ERR("B",DA)
 . I '$D(^DGPM("C",DFN,DA)) S ERR=$$ERR("C",DA)
 . I '$D(^DGPM("CA",CA,DA)) S ERR=$$ERR("CA",DA)
 . I $P(NODE,"^",2)=6 D
 . . Q:'$P(NODE,"^",9)  ; no treating specialty defined
 . . I '$D(^DGPM("ATS",DFN,CA,ID,+$P(NODE,"^",9),DA)) S ERR=$$ERR("ATS",DA)
 . I $P(NODE,"^",2)'=6 D
 . . I '$D(^DGPM("APRD",DFN,DATE,DA)) S ERR=$$ERR("APRD",DA)
 . . I '$D(^DGPM("APID",DFN,ID,DA)) S ERR=$$ERR("APID",DA)
 . . I '$D(^DGPM("APMV",DFN,CA,ID,DA)) S ERR=$$ERR("APMV",DA)
 . . I '$D(^DGPM("APCA",DFN,CA,DATE,DA)) S ERR=$$ERR("APCA",DA)
 . I '$D(^DGPM("ATID"_TT,DFN,ID,DA)) S ERR=$$ERR("ATID"_TT,DA)
 . I '$D(^DGPM("ATT"_TT,DATE,DA)) S ERR=$$ERR("ATT"_TT,DA)
 . I '$D(^DGPM("APTT"_TT,DFN,DATE,DA)) S ERR=$$ERR("APTT"_TT,DA)
 . I '$D(^DGPM("AMV"_TT,DATE,DFN,DA)) S ERR=$$ERR("AMV"_TT,DA)
 Q ERR
 ;
 ;
DGPMXREF() ; loops through DGPM x-refs to see if corresponding data exists
 ;
 N CA,DA,DATE,DFN,ERR,ID,NODE,TT,I,J,K,L
 S ERR=0
 F I=0:0 S I=$O(^DGPM("B",I)) Q:'I  F DA=0:0 S DA=$O(^DGPM("B",I,DA)) Q:'DA  I +$G(^DGPM(DA,0))'=I S ERR=$$XREFERR("B",I,DA)
 F I=0:0 S I=$O(^DGPM("C",I)) Q:'I  F DA=0:0 S DA=$O(^DGPM("C",I,DA)) Q:'DA  I +$P($G(^DGPM(DA,0)),"^",3)'=I S ERR=$$XREFERR("C",I,DA)
 F I=0:0 S I=$O(^DGPM("CA",I)) Q:'I  F DA=0:0 S DA=$O(^DGPM("CA",I,DA)) Q:'DA  I +$P($G(^DGPM(DA,0)),"^",14)'=I S ERR=$$XREFERR("CA",I,DA)
 F I=1,2,3,6 F J=0:0 S J=$O(^DGPM("ATID"_I,J)) Q:'J  F K=0:0 S K=$O(^DGPM("ATID"_I,J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("ATID"_I,J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I DFN'=J!(I'=TT)!(K'=ID) S ERR=$$XREFERR("ATID"_I,J,DA)
 F I=1,2,3,6 F J=0:0 S J=$O(^DGPM("APTT"_I,J)) Q:'J  F K=0:0 S K=$O(^DGPM("APTT"_I,J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("APTT"_I,J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I DFN'=J!(I'=TT)!(K'=DATE) S ERR=$$XREFERR("APTT"_I,J,DA)
 F J=0:0 S J=$O(^DGPM("APID",J)) Q:'J  F K=0:0 S K=$O(^DGPM("APID",J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("APID",J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I DFN'=J!(K'=ID) S ERR=$$XREFERR("ATID"_I,J,DA)
 F J=0:0 S J=$O(^DGPM("APRD",J)) Q:'J  F K=0:0 S K=$O(^DGPM("APRD",J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("APRD",J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I DFN'=J!(K'=DATE) S ERR=$$XREFERR("APRD"_I,J,DA)
 F I=1,2,3,6 F J=0:0 S J=$O(^DGPM("AMV"_I,J)) Q:'J  F K=0:0 S K=$O(^DGPM("AMV"_I,J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("AMV"_I,J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I DATE'=J!(I'=TT)!(K'=DFN) S ERR=$$XREFERR("AMV"_I,J,DA)
 F I=1,2,3,6 F J=0:0 S J=$O(^DGPM("ATT"_I,J)) Q:'J  F DA=0:0 S DA=$O(^DGPM("ATT"_I,J,DA)) Q:'DA  D
 . D VAR(DA)
 . I DATE'=J!(I'=TT) S ERR=$$XREFERR("ATT"_I,J,DA)
 F I=0:0 S I=$O(^DGPM("APCA",I)) Q:'I   F J=0:0 S J=$O(^DGPM("APCA",I,J)) Q:'J  F K=0:0 S K=$O(^DGPM("APCA",I,J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("APCA",I,J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I I'=DFN!(J'=CA)!(K'=DATE) S ERR=$$XREFERR("APCA",I,DA)
 F I=0:0 S I=$O(^DGPM("APMV",I)) Q:'I   F J=0:0 S J=$O(^DGPM("APMV",I,J)) Q:'J  F K=0:0 S K=$O(^DGPM("APMV",I,J,K)) Q:'K  F DA=0:0 S DA=$O(^DGPM("APMV",I,J,K,DA)) Q:'DA  D
 . D VAR(DA)
 . I I'=DFN!(J'=CA)!(K'=ID) S ERR=$$XREFERR("APMV",I,DA)
 F I=0:0 S I=$O(^DGPM("ATS",I)) Q:'I  F J=0:0 S J=$O(^DGPM("ATS",I,J)) Q:'J  F K=0:0 S K=$O(^DGPM("ATS",I,J,K)) Q:'K  F L=0:0 S L=$O(^DGPM("ATS",I,J,K,L)) Q:'L  F DA=0:0 S DA=$O(^DGPM("ATS",I,J,K,L,DA)) Q:'DA  D
 . D VAR(DA)
 . I I'=DFN!(J'=CA)!(K'=ID)!(L'=$P(NODE,"^",9)) S ERR=$$XREFERR("ATS",I,DA)
 Q ERR
 ;
 ;
VAR(DA) ; set up variables based on 0 node
 S NODE=$G(^DGPM(DA,0))
 S DATE=+NODE+($P(NODE,"^",22)/10000000),ID=9999999.9999999-DATE
 S DFN=$P(NODE,"^",3),TT=$P(NODE,"^",2),CA=$P(NODE,"^",14)
 Q
 ;
 ;
DPTENT ; loops through to see if x-refs are set for current inpts
 Q
 ;
 ;
DPTXREF ; loops through DPT inpatient x-refs and checks for validity
 Q
 ;
 ;
ERR(XREF,DA) ; sets error code for data w/ no cross-references
 D LINE("Entry "_DA_" has no "_XREF_" x-ref.")
 Q 1
 ;
 ;
XREFERR(XREF,SUB,DA) ; sets error code for x-ref w/no data
 D LINE("X-ref "_XREF_" has no corresponding data: Subscript 1: "_SUB_"  DA:"_DA)
 I '$D(ZTQUEUED),'(DA#1000) W "."
 Q 1
 ;
 ;
LINE(TEXT) ; puts text into array to send message
 S DGZCOUNT=DGZCOUNT+1
 S ^TMP("DGZPMDX",$J,DGZCOUNT)=TEXT
 Q
MAIL ; generate an e-mail bulletin when done
 S ^TMP("DGZPMDX",$J,.01)="The DGPM diagnostic has run to completion at "_$P($$SITE^VASITE(),"^",2)_"."
 S ^TMP("DGZPMDX",$J,.02)="    Start Time:         "_DGZSTART
 S ^TMP("DGZPMDX",$J,.03)="    End Time:           "_$$NOW^XLFDT(),^(.04)=" "
 S XMSUB="DGPM diagnostic is Complete",XMN=0
 S XMTEXT="^TMP(""DGZPMDX"",$J,"
 S XMDUZ=.5,XMY(DUZ)="",XMY("INSLEY,MARCIA@ISC-ALBANY.VA.GOV")=""
 D ^XMD
 K XMDUZ,XMN,XMSUB,XMTEXT,XMY
 Q
