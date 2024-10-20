PSN50P65 ;BIR/LDT - API FOR INFORMATION FROM FILE 50.605;Nov 16, 2018@10:30
 ;;4.0;NATIONAL DRUG FILE;**80,567**;30 Oct 98;Build 4
 ;
IEN(PSNIEN,PSNFT,LIST) ;
 ;PSNIEN - IEN of entry in VA DRUG CLASS file (#50.605).
 ;PSNFT - Free Text name in  VA DRUG CLASS file (#50.605).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece beingreturned.
 ;Returns CODE field (#.01), and CLASSIFICATION field (#1) of  VA DRUG CLASS file (#50.605).
 N DIERR,ZZERR,PSN50P65,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSNIEN)'>0,($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",+$G(PSNIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"" N PSNIEN2 S PSNIEN2=$$FIND1^DIC(50.605,"","B","`"_PSNIEN,,,"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.605,+PSNIEN2,".01;1","IE","PSN50P65") S PSN(1)=0
 .F  S PSN(1)=$O(PSN50P65(50.605,PSN(1))) Q:'PSN(1)  D SETZRO
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP(1) Q
 .D FIND^DIC(50.605,,"@;.01;1","QP",PSNFT,,"B",,,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSN50P65 D GETS^DIQ(50.605,+PSNIEN,".01;1","IE","PSN50P65") S PSN(1)=0
 ..F  S PSN(1)=$O(PSN50P65(50.605,PSN(1))) Q:'PSN(1)  D SETZRO
 K ^TMP("DILIST",$J)
 Q
 ;
ROOT(PSNC) ;
 ;Q  "^PS(50.605, ""C"")" if PSNC is passed in as 1.  If PSNC is null, Q "^PS(50.605,"
 I $G(PSNC)'=1  Q "^PS(50.605,"
 Q "^PS(50.605,""C"")"
 ;
C(PSNIEN,PSNFT,LIST) ;
 ;PSNIEN - IEN of entry in  VA DRUG CLASS file (#50.605).
 ;PSNFT - Free Text name in  VA DRUG CLASS file (#50.605).
 ;LIST - Subscript of ^TMP array in the form ^TMP($J,LIST,Field Number where Field Number is the
 ;       Field Number of the data piece being returned.
 ;Returns CODE field (#.01), CLASSIFICATION field (#1),PARENT CLASS field (#2), and TYPE field (#3)
 ;of  VA DRUG CLASS file (#50.605).
 N DIERR,ZZERR,PSN50P65,PSN
 I $G(LIST)']"" Q
 K ^TMP($J,LIST)
 I +$G(PSNIEN)'>0,($G(PSNFT)']"") S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I $G(PSNIEN)]"",+$G(PSNIEN)'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 I +$G(PSNIEN)>0 N PSNIEN2 S PSNIEN2=$$FIND1^DIC(50.605,"","A","`"_PSNIEN,"C",,"") D
 .I +PSNIEN2'>0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .S ^TMP($J,LIST,0)=1
 .D GETS^DIQ(50.605,+PSNIEN2,".01;1;2;3","IE","PSN50P65") S PSN(1)=0
 .F  S PSN(1)=$O(PSN50P65(50.605,PSN(1))) Q:'PSN(1)  D SETZRO2
 I $G(PSNIEN)="",$G(PSNFT)]"" D
 .I PSNFT["??" D LOOP(2) Q
 .D FIND^DIC(50.605,,"@;.01;1","QP",PSNFT,,"C",,,"")
 .I +$G(^TMP("DILIST",$J,0))=0 S ^TMP($J,LIST,0)=-1_"^"_"NO DATA FOUND" Q
 .I +^TMP("DILIST",$J,0)>0 S ^TMP($J,LIST,0)=+^TMP("DILIST",$J,0) N PSNXX S PSNXX=0 F  S PSNXX=$O(^TMP("DILIST",$J,PSNXX)) Q:'PSNXX  D
 ..S PSNIEN=+^TMP("DILIST",$J,PSNXX,0) K PSN50P65 D GETS^DIQ(50.605,+PSNIEN,".01;1;2;3","IE","PSN50P65") S PSN(1)=0
 ..F  S PSN(1)=$O(PSN50P65(50.605,PSN(1))) Q:'PSN(1)  D SETZRO2
 K ^TMP("DILIST",$J)
 Q
 ;
SETZRO ;
 S ^TMP($J,LIST,+PSN(1),.01)=$G(PSN50P65(50.605,PSN(1),.01,"I"))
 S ^TMP($J,LIST,"B",$G(PSN50P65(50.605,PSN(1),.01,"I")),+PSN(1))=""
 S ^TMP($J,LIST,+PSN(1),1)=$G(PSN50P65(50.605,PSN(1),1,"I"))
 Q
 ;
SETZRO2 ;
 S ^TMP($J,LIST,+PSN(1),.01)=$G(PSN50P65(50.605,PSN(1),.01,"I"))
 S ^TMP($J,LIST,"C",$G(PSN50P65(50.605,PSN(1),.01,"I")),+PSN(1))=""
 S ^TMP($J,LIST,+PSN(1),1)=$G(PSN50P65(50.605,PSN(1),1,"I"))
 S ^TMP($J,LIST,+PSN(1),2)=$S($G(PSN50P65(50.605,PSN(1),2,"I"))="":"",1:PSN50P65(50.605,PSN(1),2,"I")_"^"_PSN50P65(50.605,PSN(1),2,"E"))
 S ^TMP($J,LIST,+PSN(1),3)=$S($G(PSN50P65(50.605,PSN(1),3,"I"))="":"",1:PSN50P65(50.605,PSN(1),3,"I")_"^"_PSN50P65(50.605,PSN(1),3,"E"))
 Q
 ;
LOOP(PSN) ;
 N PSNIEN,CNT S CNT=0
 S PSNIEN=0 F  S PSNIEN=$O(^PS(50.605,PSNIEN)) Q:'PSNIEN  D
 .K PSN50P65 D GETS^DIQ(50.605,+PSNIEN,".01;1;2;3","IE","PSN50P65") S PSN(1)=0 D
 ..F  S PSN(1)=$O(PSN50P65(50.605,PSN(1))) Q:'PSN(1)   D @(PSN) S CNT=CNT+1
 S ^TMP($J,LIST,0)=$S(+CNT>0:CNT,1:"-1^NO DATA FOUND")
 Q
1 ;
 D SETZRO
 Q
 ;
2 ;
 D SETZRO2
 Q
SSET(PSNC,PSNCNT,PSNI,DIR,SUB) ;Pull back a subset of the PHARMACY ORDERABLE ITEM file (#50.7)
 ;
 N PSNJ,X,Y
 F  Q:PSNC'<PSNCNT  S PSNI=$O(^PS(50.605,"B",PSNI),DIR) Q:PSNI=""  S PSNJ=0 F  S PSNJ=$O(^PS(50.605,"B",PSNI,PSNJ)) Q:'PSNJ  D
 . S Y=$G(^PS(50.605,PSNJ,0)) I $P(Y,"^",2)["INACTIVE" Q
 . I $P(Y,"^",3)="",PSNI'="HA000" Q
 . S PSNC=PSNC+1,^TMP(SUB,$J,1,PSNC)=PSNJ_"^"_PSNI_" - "_$P(Y,"^",2)
 Q
