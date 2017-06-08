ADXTPCO5 ;523/KC update last tumor status from tumor stat mult.;2/19/93
 ;;1.0;;
 ;
 I $G(DUZ(0))'="@" D  Q
 .W !,"Not set up as a programmer... quitting..."
 W !!,"Resetting LAST TUMOR STATUS (#95) field for all entries in 165.5..."
 N ADXTCNT,ADXTCNTC,ADXTDA,ADXTPP,ADXTDOD,ADXTLSTS,ADXTLAST,ADXTSBDA,ADXTDAT
 S ADXTDA=0,ADXTCNT=0,ADXTCNTC=0
 F  S ADXTDA=$O(^ONCO(165.5,ADXTDA)) Q:'+ADXTDA  D
 .Q:'$D(^DIZ(523701.6,"B",ADXTDA))  ; quit if not from conversion
 .S ADXTCNT=ADXTCNT+1 I '(ADXTCNT#10) W "." ; progress update
 .D GETPP I '+ADXTPP D  Q  ;get onco patient pointer
 ..W !,"## Warning, entry ",ADXTDA," in PRIMARY file has no pointer to ONCO Patient file!!!" Q
 .D GETDOD ;get date of death (if any)
 .D GETLSTS ;get last tumor status from tumor status multiple (#73)
 .Q:'+ADXTLSTS
 .D GETLAST ;get last tumor status (#95)
 .;
 .;if different, report and update
 .I ((ADXTLAST'=ADXTLSTS)&(+ADXTLSTS)) D  Q
 ..S ADXTCNTC=ADXTCNTC+1
 ..W !,"Changing Last tumor status, entry ",ADXTDA," from ",ADXTLAST," to ",ADXTLSTS,"."
 ..K DIE,DR,DA S DIE="^ONCO(165.5,",DA=ADXTDA,DR="95///"_ADXTLSTS D ^DIE
 ..Q
EXIT ;
 W !,ADXTCNTC," tumors had last tumor status (#95) field changed."
 K ADXTCNT,ADXTCNTC,ADXTDA,ADXTPP,ADXTDOD,ADXTLSTS,ADXTLAST,ADXTSBDA,ADXTDAT
 Q
GETLSTS ;get last tumor status from tumor status multiple
 S ADXTDAT=0,ADXTLSTS=""
 I '+ADXTDOD D  ;if patient not dead, get most recent tumor stat date
 .S ADXTDAT=$O(^ONCO(165.5,ADXTDA,"TS","AA",ADXTDAT))
 Q:'+ADXTDAT
 I +ADXTDOD D  ; if patient dead, check if tumor stat date > d.o.d.
 .F  S ADXTDAT=$O(^ONCO(165.5,ADXTDA,"TS","AA",ADXTDAT)) Q:((9999999-ADXTDAT)'>ADXTDOD)!('+ADXTDAT)  D
 ..W !,"## tumor status for tumor ",ADXTDA," date ",(9999999-ADXTDAT)," past patient's date of death."
 Q:'+ADXTDAT  S ADXTSBDA=0
 S ADXTSBDA=$O(^ONCO(165.5,ADXTDA,"TS","AA",ADXTDAT,ADXTSBDA))
 Q:'+ADXTSBDA
 S ADXTLSTS=+$P($G(^ONCO(165.5,ADXTDA,"TS",ADXTSBDA,0)),"^",2)
 I (ADXTLSTS'=1)&(ADXTLSTS'=2)&(ADXTLSTS'=9) S ADXTLSTS=""
 Q
GETLAST ;get last tumor status
 S ADXTLAST=$P($G(^ONCO(165.5,ADXTDA,7)),"^",6) Q
GETPP ;get pointer to patient file
 S ADXTPP=$P($G(^ONCO(165.5,ADXTDA,0)),"^",2) Q
GETDOD ;get date of death from 160
 S ADXTDOD=+$P($G(^ONCO(160,ADXTPP,1)),"^",8) Q
