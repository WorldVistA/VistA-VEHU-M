DVB428PT ;ALB/SEK POST-INSTALL FOR PATCH DVB*4*28 ; 9/24/96
 ;;V4.0;HINQ;**28**;03/25/92
 ;
 ;This routine will be run as a post-installation for patch DVB*4*28.
 ;This routine will add new disability codes to and modify existing
 ;names in the DISABILITY CONDITION file (#31).
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DVBLINE","EN^DVB428PT",1)
 Q
 ;
EN ;begin processing
 ;
 N DVBLINE
 ;
 D BMES^XPDUTL("  >> *** Updating DISABILITY CONDITION file (#31)")
 D MES^XPDUTL("  ")
 ;
 ;get value from checkpoints, previous run
 S DVBLINE=+$$PARCP^XPDUTL("DVBLINE")
 ;
DVBNEW ;add new codes or modify name
 ;
 F DVBI=DVBLINE:1 S DVBJ=$P($T(NEWCODE+DVBI),";;",2) Q:DVBJ["$EXIT"  D
 .S DVBCODE=+DVBJ,DVBNAME=$E($P(DVBJ,"^",2),1,45),DVBLINE=DVBI
 .;
 .;add new code
 .I '$D(^DIC(31,"C",DVBCODE)) D  G UPDATECH
 ..K DD,DO
 ..S DIC="^DIC(31,",DIC(0)="L",DIC("DR")="2////"_DVBCODE
 ..S X=DVBNAME,DLAYGO=31
 ..D FILE^DICN
 ..D MES^XPDUTL("  >> adding  "_DVBCODE_"  "_X)
 ..K DLAYGO,DIC,X
 ..Q
 .;
 .;modify name
 .S DVBIEN=+$O(^DIC(31,"C",DVBCODE,0))
 .S DVBREC=$G(^DIC(31,DVBIEN,0)) I DVBREC']"" D  G UPDATECH
 ..D MES^XPDUTL("  >>>> error "_DVBCODE_" in C x-reference and not in file 31")
 ..Q
 .S DVBOLDN=$P(DVBREC,"^") I DVBOLDN=DVBNAME G UPDATECH
 .S DA=DVBIEN,DIE="^DIC(31,",DR=".01////"_DVBNAME D ^DIE
 .K DR,DA,DIE
 .D MES^XPDUTL("   >> changing name of "_DVBCODE_" from "_DVBOLDN)
 .D MES^XPDUTL("                            to   "_DVBNAME)
 .;
UPDATECH .;update checkpoint
 .S %=$$UPCP^XPDUTL("DVBLINE",DVBLINE)
 .Q
 K DVBCODE,DVBI,DVBIEN,DVBJ,DVBNAME,DVBOLDN,DVBREC
 Q
 ;
NEWCODE ; codes to be addded
 ;;5025^FIBROMYALGIA
 ;;6319^LYME DISEASE
 ;;6320^PARASITIC DISEASES OTHERWISE NOT SPECIFIED
 ;;6502^SEPTUM, NASAL, DEVIATION OF
 ;;6518^LARYNGECTOMY
 ;;6519^APHONIA
 ;;6520^LARYNX, STENOSIS OF
 ;;6521^PHARYNX, INJURIES TO
 ;;6522^ALLERGIC OR VASOMOTOR RHINITIS
 ;;6523^BACTERIAL RHINITIS
 ;;6524^GRANULOMATOUS RHINITIS
 ;;6604^CHRONIC OBSTRUCTIVE PULMONARY DISEASE
 ;;6817^PULMONARY VASCULAR DISEASE
 ;;6819^NEOPLASMS, MALIGNANT, RESPIRATORY SYSTEM
 ;;6820^NEOPLASMS, BENIGN, RESPIRATORY SYSTEM
 ;;6822^ACTINOMYCOSIS
 ;;6823^NOCARDIOSIS
 ;;6824^CHRONIC LUNG ABSCESS
 ;;6825^DIFFUSE INTERSTITIAL FIBROSIS
 ;;6826^DESQUAMATIVE INTERSTITIAL PNEUMONITIS
 ;;6827^PULMONARY ALVEOLAR PROTEINOSIS
 ;;6828^EOSINOPHILIC GRANULOMA OF LUNG
 ;;6829^DRUG-INDUCED PNEUMONITIS/FIBROSIS
 ;;6830^RADIATION-INDUCED PNEUMONITIS/FIBROSIS
 ;;6831^HYPERSENSITIVITY PNEUMONITIS
 ;;6832^PNEUMOCONIOSIS
 ;;6833^ASBESTOSIS
 ;;6834^HISTOPLASMOSIS OF LUNG
 ;;6835^COCCIDIOIDOMYCOSIS
 ;;6836^BLASTOMYCOSIS
 ;;6837^CRYPTOCOCCOSIS
 ;;6838^ASPERGILLOSIS
 ;;6839^MUCORMYCOSIS
 ;;6840^DIAPHRAGM PARALYSIS OR PARESIS
 ;;6841^SPINAL CORD INJURY/RESPIRATORY INSUFFICIENCY
 ;;6842^KYPHOSCOLIOSIS
 ;;6843^TRAUMATIC CHEST WALL DEFECT
 ;;6844^POST-SURGICAL/RESPIRATORY SYSTEM
 ;;6845^CHRONIC PLEURAL EFFUSION OR FIBROSIS
 ;;6846^SARCOIDOSIS
 ;;6847^SLEEP APNEA SYNDROMES
 ;;7916^HYPERPITUITARISM
 ;;7917^HYPERALDOSTERONISM
 ;;7918^PHEOCHROMOCYTOMA
 ;;7919^C-CELL HYPERPLASIA OF THE THYROID
 ;;6504^NOSE,LOSS OF PART OF,OR SCARS
 ;;6510^SINUSITIS,PANSINUSITIS,CHRONIC
 ;;6511^SINUSITIS,ETHMOID,CHRONIC
 ;;6512^SINUSITIS,FRONTAL,CHRONIC
 ;;6513^SINUSITIS,MAXILLARY,CHRONIC
 ;;6514^SINUSITIS,SPHENOID,CHRONIC
 ;;6515^LARYNGITIS,TUBERCULOUS,ACTIVE OR INACTIVE
 ;;6516^LARYNGITIS,CHRONIC
 ;;6600^BRONCHITIS,CHRONIC
 ;;6602^ASTHMA,BRONCHIAL
 ;;6603^EMPHYSEMA,PULMONARY
 ;;6701^TUBERCULOSIS,PULM.,CHRONIC,FAR ADV,ACTIVE
 ;;6702^TUBERCULOSIS,PULM.,CHRONIC,MOD.ADV,ACTIVE
 ;;6703^TUBERCULOSIS,PULM.,CHRONIC,MINIMAL,ACTIVE
 ;;6704^TUBERCULOSIS,PULM.,CHRONIC,ACT.,ADV UNSP
 ;;6721^TUBERCULOSIS,PULM.,CHRONIC,FAR ADV,INACTIVE
 ;;6722^TUBERCULOSIS,PULM.,CHRONIC,MOD.ADV,INACTIVE
 ;;6723^TUBERCULOSIS,PULM.,CHRONIC,MINIMAL,INACTIVE
 ;;6724^TUBERCULOSIS,PULM.,CHRONIC,INACT.,ADV UNSP
 ;;6730^TUBERCULOSIS,PULMONARY,CHRONIC,ACTIVE
 ;;6731^TUBERCULOSIS,PULMONARY,CHRONIC,INACTIVE
 ;;6732^PLEURISY,TUBERCULOUS,ACTIVE OR INACTIVE
 ;;$EXIT
 Q
