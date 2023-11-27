GMTSDEMC ;SLC/JLC - Sexual Orientation Data ;Jun 07, 2023@11:36
 ;;2.7;Health Summary;**141,144**;Oct 20, 1995;Build 17
 ;                    
 ;                  
SEXOR ; Sexual Orientation
 N I,VAPTYP,VAHOW,VACOM,VADM,VA,VAERR,S1,TMP,GMTSNPG
 D DEM^VADPT
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "The sexual orientation information below shows all active entries listed by the",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "date they were updated.",!!
 W "------------------------------------------------------------------------------",!!
 I '$D(VADM(14,1)) G SEXORN
 F I=1:1:VADM(14,1) D
 . I $P(VADM(14,1,I,1),"^",2)'="A" Q
 . S TMP($P(VADM(14,1,I,3),"^"),I)=""
 I '$D(TMP) G SEXORN
 S S1=""
 F  S S1=$O(TMP(S1)) Q:S1=""  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W S1,":",!
 . S I=0 F  S I=$O(TMP(S1,I)) Q:'I  D
 .. W ?5,$P(VADM(14,1,I),"^"),!
 .. I $P(VADM(14,1,I),U,2)="OTH" W ?8,$G(VADM(14,2)),!
 . W !
 Q
SEXORN ;NO ACTIVE ENTRIES
 W "No active sexual orientation defined."
 Q
PRONOUN ;Pronouns
 N VAPTYP,VAHOW,VACOM,VADM,VA,VAERR,GMTSFIRST,GMTSNUM,GMTSNPG,GMTSTEXT
 D DEM^VADPT
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !,"Pronoun(s): "
 I $D(VADM(14,3))>9 D
 .S GMTSFIRST=1,GMTSNUM=0 F  S GMTSNUM=$O(VADM(14,3,GMTSNUM)) Q:'+GMTSNUM  D
 ..I GMTSFIRST=1 S GMTSFIRST=0
 ..E  D
 ...D CKP^GMTSUP Q:$D(GMTSQIT)
 ...W !
 ...I GMTSNPG W "Pronoun(s): "
 ..Q:$D(GMTSQIT)
 ..W ?10,$P($G(VADM(14,3,GMTSNUM)),U,1)
 .I $G(VADM(14,4))'="" D FORMAT^GMTSU(VADM(14,4),"Pronoun Open Text",1),LINE^GMTSU
 I $D(VADM(14,3))<10 W "<Not Provided>"
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !
 Q
SIGI ;Self-Identified Gender
 N VAPTYP,VAHOW,VACOM,VADM,VA,VAERR,GMTSNPG,GMTSTEXT
 D DEM^VADPT
 D CKP^GMTSUP Q:$D(GMTSQIT)
 S GMTSTEXT=$P($G(VADM(14,5)),U,1)
 I GMTSTEXT="" S GMTSTEXT="<Not Provided>"
 W !,"Gender Identity: ",GMTSTEXT
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !
 Q
