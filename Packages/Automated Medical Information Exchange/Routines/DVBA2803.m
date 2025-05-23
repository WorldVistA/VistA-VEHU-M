DVBA2803 ;SPH - PATCH DRIVER ; 11/17/05
 ;;2.7;AMIE;**103**;Apr 10, 1995
 ;
 ; Make sure to call each exam name being sent in the patch
 ; This routine will find existing matching entries and will ensure they're disabled.
 ; Call as a pre-init or else it'll disable the exams just loaded.
PRE ;
 N DVBVERSS,DVBVERSN
 S DVBVERSS="103F" ; What the version will be in the incoming file
 S DVBVERSN="103T1" ; What the final version should be named
 W !!!,"**** PRE-PROCESSING ****",!!
 D DISABLE("ACROMEGALY")
 D DISABLE("ARRHYTHMIAS")
 D DISABLE("ARTERIES, VEINS AND MISCELLANEOUS")
 D DISABLE("BRAIN AND SPINAL CORD")
 D DISABLE("COLD INJURY PROTOCOL EXAMINATION")
 D DISABLE("CRANIAL NERVES")
 D DISABLE("CUSHINGS SYNDROME")
 D DISABLE("DENTAL AND ORAL")
 D DISABLE("DIGESTIVE CONDITIONS, MISCELLANEOUS")
 D DISABLE("EATING DISORDERS")
 D DISABLE("EPILEPSY AND NARCOLEPSY")
 D DISABLE("ESOPHAGUS AND HIATAL HERNIA")
 D DISABLE("FIBROMYALGIA")
 D DISABLE("GULF WAR GUIDELINES")
 D DISABLE("GYNECOLOGICAL CONDITIONS AND DISORDERS OF THE BREAST")
 D DISABLE("HIV-RELATED ILLNESS")
 D DISABLE("INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES")
 D DISABLE("INTESTINES (LARGE AND SMALL)")
 D DISABLE("LIVER, GALL BLADDER, AND PANCREAS")
 D DISABLE("LYMPHATIC DISORDERS")
 D DISABLE("MISCELLANEOUS ENDOCRINE DISEASES")
 D DISABLE("MOUTH, LIPS AND TONGUE")
 D DISABLE("PRISONER OF WAR PROTOCOL EXAMINATION")
 D DISABLE("PULMONARY TUBERCULOSIS AND MYCOBACTERIAL DISEASES")
 D DISABLE("RECTUM AND ANUS")
 D DISABLE("RESIDUALS OF AMPUTATIONS")
 D DISABLE("SENSE OF SMELL AND TASTE")
 D DISABLE("SOCIAL WORK AND INDUSTRIAL SURVEY")
 D DISABLE("THYROID AND PARATHYROID DISEASES")
 Q
POST ;
 N DVBVERSS,DVBVERSN
 S DVBVERSS="103F" ; What the version will be in the incoming file
 S DVBVERSN="103T1" ; What the final version should be named
 W !!!,"**** POST-PROCESSING ****",!!
 D POSTP("ACROMEGALY")
 D POSTP("ARRHYTHMIAS")
 D POSTP("ARTERIES, VEINS AND MISCELLANEOUS")
 D POSTP("BRAIN AND SPINAL CORD")
 D POSTP("COLD INJURY PROTOCOL EXAMINATION")
 D POSTP("CRANIAL NERVES")
 D POSTP("CUSHINGS SYNDROME")
 D POSTP("DENTAL AND ORAL")
 D POSTP("DIGESTIVE CONDITIONS, MISCELLANEOUS")
 D POSTP("EATING DISORDERS")
 D POSTP("EPILEPSY AND NARCOLEPSY")
 D POSTP("ESOPHAGUS AND HIATAL HERNIA")
 D POSTP("FIBROMYALGIA")
 D POSTP("GULF WAR GUIDELINES")
 D POSTP("GYNECOLOGICAL CONDITIONS AND DISORDERS OF THE BREAST")
 D POSTP("HIV-RELATED ILLNESS")
 D POSTP("INFECTIOUS, IMMUNE, AND NUTRITIONAL DISABILITIES")
 D POSTP("INTESTINES (LARGE AND SMALL)")
 D POSTP("LIVER, GALL BLADDER, AND PANCREAS")
 D POSTP("LYMPHATIC DISORDERS")
 D POSTP("MISCELLANEOUS ENDOCRINE DISEASES")
 D POSTP("MOUTH, LIPS AND TONGUE")
 D POSTP("PRISONER OF WAR PROTOCOL EXAMINATION")
 D POSTP("PULMONARY TUBERCULOSIS AND MYCOBACTERIAL DISEASES")
 D POSTP("RECTUM AND ANUS")
 D POSTP("RESIDUALS OF AMPUTATIONS")
 D POSTP("SENSE OF SMELL AND TASTE")
 D POSTP("SOCIAL WORK AND INDUSTRIAL SURVEY")
 D POSTP("THYROID AND PARATHYROID DISEASES")
 ;D RBXREF
 Q
POSTP(NM) ;
 ; Rename XXXXXXX~imported version to XXXXXXX~new version
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 N DVBABCN2,DVBABIE2,DVBABS2
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)=DVBVERSS  D
 ..;Check and be sure the new version isn't in the file yet
 ..S DVBABCN2=0,DVBABIE2=0,DVBACH=0
 ..F  S DVBABIE2=$O(^DVB(396.18,DVBABIE2)) Q:'DVBABIE2  D
 ...S DVBABS2=$P($G(^DVB(396.18,DVBABIE2,0)),"^",1)
 ...I $P(DVBABS2,"~",1)=NM  I $P(DVBABS2,"~",2)=DVBVERSN  S DVBACH=1
 ..;If new version is found, delete the import version and don't import
 ..I DVBACH=1  D
 ...W "FOUND EXISTING "_NM_".  NO MODIFICATIONS MADE.",!
 ...K ^DVB(396.18,DVBABIEN)
 ..;If existing version isn't found, go ahead and rename imported entry to new version name
 ..I DVBACH=0  D
 ...S $P(^DVB(396.18,DVBABIEN,0),"^",1)=NM_"~"_DVBVERSN
 ...W "ACTIVATED: "_$P($G(^DVB(396.18,DVBABIEN,0)),"^",1),!
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
RBXREF ;
 ; Rebuild cross-references
 ; XRef: B
 W !!,"CLEANING UP FILES AND REBUILDING 2 CROSS-REFERENCES.",!,"THIS MAY TAKE A FEW MINUTES.",!
 W !!,"REBUILDING 'B' XREF, CAPRI TEMPLATE DEFINITIONS FILE",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("B")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^B"
 . S DA(1)=REGIEN  D ENALL^DIK
 ; 
 ; XRef: AV
 W !!,"REBUILDING 'AV' XREF, CAPRI TEMPLATE DEFINITIONS FILE",!
 N DA,DIK,REGIEN,ROOT
 S ROOT=$$ROOT^DILFD(396.18,,1)  K @ROOT@("AV")
 S REGIEN=0
 F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 . S DIK=$$ROOT^DILFD(396.18,","_REGIEN_","),DIK(1)=".01^AV"
 . S DA(1)=REGIEN  D ENALL^DIK
 K DA,DIK,REGIEN,ROOT
 ;
 ; XRef: C, in 2507 EXAM FILE
 ;W !!,"REBUILDING 'C' XREF, 2507 EXAM FILE",!
 ;N DA,DIK,REGIEN,ROOT
 ;S ROOT=$$ROOT^DILFD(396.4,,1)  K @ROOT@("C")
 ;S REGIEN=0
 ;F  S REGIEN=$O(@ROOT@(REGIEN))  Q:'REGIEN  D
 ;. S DIK=$$ROOT^DILFD(396.4,","_REGIEN_","),DIK(1)=".02^C"
 ;. S DA(1)=REGIEN  D ENALL^DIK
 ;K DA,DIK,REGIEN,ROOT
 ;Q 
DISABLE(NM) ;
 ; First look for matches and turn off the "selectable by user field"
 ; This will keep the entry from showing in the list
 ; Next, look at disabled date.  If there's no date, set it to today.
 ; File is 396.18.  Field 3 is de-activation date.  Field 7 is selectable by user (0=no)
 N DVBABCNT,DVBABIEN,DVBABST,DVBACH
 S DVBABCNT=0,DVBABIEN=0
 F  S DVBABIEN=$O(^DVB(396.18,DVBABIEN)) Q:'DVBABIEN  D
 .S DVBABST=$P($G(^DVB(396.18,DVBABIEN,0)),"^",1)
 .I $P(DVBABST,"~",1)=NM  I $P(DVBABST,"~",2)'=DVBVERSN  D
 ..S DVBACH=0
 ..I $P(^DVB(396.18,DVBABIEN,6),"^",1)'="0"  S $P(^DVB(396.18,DVBABIEN,6),"^",1)="0",DVBACH=1
 ..I $P(^DVB(396.18,DVBABIEN,2),"^",2)=""  S $P(^DVB(396.18,DVBABIEN,2),"^",2)=DT,DVBACH=1  ; This is deactivation date 
 ..I DVBACH=1  W "MODIFIED: "_DVBABST,!
 K DVBABCNT,DVBABIEN,DVBABST,DVBACH
 Q
