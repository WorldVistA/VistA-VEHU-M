PSO7P731 ;DAL/JCH - Post Install routine for patch PSO*7*731 ;08/24/2023
 ;;7.0;OUTPATIENT PHARMACY;**731**;DEC 1997;Build 18
 ;
 ; Reference to ^VA(200,IEN,"PS" in ICR #10060
 Q
 ;
POST ; Post Install queued entry point
 D QUE
 Q
 ;
START ; Begin post-install processing
 ; Remove orphaned DEAs
 N PSOXNODE
 S PSOXNODE="PSO*7.0*731 POST INSTALL"
 D ORPHANDEA
 D TMPMSG(PSOXNODE)
 Q
 ;
ORPHANDEA ; Clean up orphaned DEA# field (53.2) in NEW PERSON file (#200)
 N DEA532,DEA5321,PRIEN,PSOFDA,PSOPRGDT,PSOXHDR,PSODTM
 S PSODTM=$$NOW^XLFDT()
 S PSOXHDR=$$FMADD^XLFDT($$DT^XLFDT(),90)_"^"_$$DT^XLFDT()_"^Delete orphan DEA numbers from DEA# field (#53.2) in NEW PERSON file (#200)"
 S ^XTMP(PSOXNODE,0)=$G(PSOXHDR)
 ;
 ; Remove Orphan DEA# field (#53.2) values when no NEW DEA #'s multiple (#53.21) values exist for Provider
 ; Find all DEA number in DEA# field (#53.2)
 S DEA532="" F  S DEA532=$O(^VA(200,"PS1",DEA532)) Q:DEA532=""  D
 . ; Find providers associated with DEA# - quit if no NEW DEA #'s were ever filed for the provider
 . S PRIEN=0 F  S PRIEN=$O(^VA(200,"PS1",DEA532,PRIEN)) Q:'PRIEN  D
 . . Q:'$D(^VA(200,PRIEN,"PS4",0))!$O(^VA(200,PRIEN,"PS4",0))
 . . K PSOFDA,PSOERR
 . . S PSOFDA(200,PRIEN_",",53.2)="@"
 . . D FILE^DIE("","PSOFDA","PSOERR")
 . . S ^XTMP(PSOXNODE,"DEA",$G(DEA532),"DELETED",+$G(PRIEN))=PSODTM
 . . S PSOERR=$G(PSOERR("DIERR",1,"TEXT",1)) I $L(PSOERR) S ^XTMP(PSOXNODE,"DEA",$G(DEA532),"ERROR",+$G(PRIEN))=""
 . . Q
 . Q
 Q
 ;
TMPMSG(PSOXNODE)  ; Send MailMan LOG REPORT
 Q:$G(PSOXNODE)=""
 N PSODASH,PSOXMAIL,PSODEA,PSOPRIEN,PSOCNT,PSODEAR,PSOPAD,NPIEN,XMDUZ,XMSUB
 S $P(PSODASH,"-",80)="",$P(PSOPAD," ",80)=" "
 S PSOXMAIL="PSO_ORPHAN_DEA_CLEANUP"
 S XMDUZ=.5
 ;
 S XMSUB="Orphan DEA Cleanup Complete "_$$FMTE^XLFDT(DT,"5DZ"),XMDUZ=.5
 K XMY S NPIEN=0 F  S NPIEN=$O(^XUSEC("PSDMGR",NPIEN)) Q:'+NPIEN  S XMY(NPIEN)=""
 ;
 S PSOCNT=3  ; Start DEA array starts at 4, first 3 lines for header
 S PSODEA="" F  S PSODEA=$O(^XTMP(PSOXNODE,"DEA",PSODEA)) Q:PSODEA=""  D
 . S PSOPRIEN=0 F  S PSOPRIEN=$O(^XTMP(PSOXNODE,"DEA",PSODEA,"DELETED",PSOPRIEN)) Q:'PSOPRIEN  D
 . . ; Pull Date/Time back out, in case run more than once at different times
 . . S PSODTM=$G(^XTMP(PSOXNODE,"DEA",PSODEA,"DELETED",PSOPRIEN)) S:'$L(PSODTM) PSODTM="*Missing*"
 . . S PSOCNT=PSOCNT+1
 . . S PSODEAR(PSOCNT,0)="  Provider IEN:"_PSOPRIEN
 . . S PSODEAR(PSOCNT,0)=PSODEAR(PSOCNT,0)_$E(PSOPAD,1,31-$L(PSODEAR(PSOCNT,0)))_" DEA: "_PSODEA_"   Removed: "_$P($$FMTE^XLFDT(PSODTM,"2Z"),":",1,2)
 S PSOCNT=PSOCNT-3
 ;
 S ^XTMP(PSOXMAIL,$J,1,0)=" Orphan DEA Cleanup Complete"
 S ^XTMP(PSOXMAIL,$J,2,0)=" "_PSOCNT_" orphaned DEA number"_$S(PSOCNT=1:" was ",1:"s were ")_"removed from the NEW PERSON (#200) file"
 S ^XTMP(PSOXMAIL,$J,3,0)=""
 M ^XTMP(PSOXMAIL,$J)=PSODEAR
 ;
 S XMY(DUZ)="" N DIFROM S XMTEXT="^XTMP("""_PSOXMAIL_""","_$J_"," D ^XMD K DIFROM
 K PSOTEXT,XMTEXT
 K ^XTMP(PSOXMAIL,$J)
 Q
 ;
QUE ; Que post install
 N PSOJOB,PSOPATCH,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE
 S PSOPATCH="PSO*7.0*731"
 S ZTDTH=$$FMTH^XLFDT($$NOW^XLFDT())
 S PSOJOB=$J
 ;
 S ZTRTN="START^PSO7P731",ZTIO=""
 S (ZTDESC)="Background job for "_PSOJOB
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . N POSTEXT
 . S POSTEXT(1)="A MailMan message will be sent to the installer and"
 . S POSTEXT(2)="PSDRPH key holders upon Post Install Completion"
 . S POSTEXT(3)="*** Task #"_ZTSK_" Queued! ***"
 . D MES^XPDUTL(.POSTEXT)
 . S ZTSAVE("ZTSK")=""
 ;
 Q
