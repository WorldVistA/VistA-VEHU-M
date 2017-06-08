ZZTSET7 ;ciofo-scramble data in the patient file ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 ; concept/code taken from original routine ZDWGTDEM (author unknown)
 ;
 ; abort if this routine wasn't called from the main menu routine (that's where"
 ; we check to make sure we're running in the correct UCI/namespace)...
 I '$D(ZZROUTIN) D  Q
 .W $C(7)
 .W !!,"Sorry, you can't run this routine directly...you must choose it from the"
 .W !,"menu in the routine ^ZZTSETM."
 ;
 W @IOF
 W !!,"Part 7.  Scramble Data in the Patient File."
 W !!,"In this part, certain data elements in the Patient file will be changed so that"
 W !,"patients' right to privacy is protected while you still have a usable patient"
 W !,"database for demonstration and training purposes."
 W !!,"Primarily, the patients' names and social security numbers will be changed."
 W !,"Also, information about street addresses, telephone numbers and the names of"
 W !,"next of kin will be altered."
 W !!,"Note that this process could take quite some time to complete -- total elapsed"
 W !,"time will be dependent upon the number of records in your Patient file and other"
 W !,"hardware-related issues."
 S DIR(0)="YA"
 S DIR("A")="Okay to continue? "
 S DIR("B")="NO"
 W !
 D ^DIR K DIR
 I Y'=1!($D(DIRUT)) K DIROUT,DIRUT,X,Y Q
 N ZZROUTIN
 ;
 ; set up variables and call utilities to set up the TMP global we'll need...
 ; NLN = number of last name nodes in ^TMP($J,"LNAME",...)
 ; NFN = number of female first names in ^TMP($J,"FENAME",...)
 ; NMN = number of male first names in ^TMP($J,"FNAME",...)
 ; NSSN = the starting number for social security numbers
 W !!,"First, setting up some temporary files and variables I'll need..."
 S NLN=93
 S NFN=23
 S NMN=38
 S NSSN=111110000
 ;
 K ^TMP($J)
 F ZZX=1:1:6 D
 .S ZZROUTIN="^ZZTSETU"_ZZX
 .D @ZZROUTIN
 .W "."
 ;
 ; get total number of records we'll be working on...
 S (ZZRECS,ZZDFN)=0
 F  S ZZDFN=$O(^DPT(ZZDFN)) Q:'ZZDFN  S ZZRECS=ZZRECS+1
 S ZZCOUNT=ZZRECS
 ;
 W @IOF
 W !!,"Scrambling data in the Patient file..."
 W !!
 S DX=$X,DY=$Y
 S ZZCLRLIN="$C(13)"
 ;
 ; launch the procedure...
 S ZZDFN=0
 F  S ZZDFN=$O(^DPT(ZZDFN)) Q:'ZZDFN  D
 .S DA=ZZDFN
 .S ZZCOUNT=ZZCOUNT-1
 .X IOXY
 .W @ZZCLRLIN,"TOTAL RECORDS:",$J(ZZRECS,10),"  RECORDS REMAINING:",$J(ZZCOUNT,10),!
 .I '$D(^DPT(DA,0))#2 S ZZRECS=ZZRECS-1 K ^DPT(DA) Q
 .;
 .; call the scrambler for name and address data...
 .;D EN^ZDWNWDEM
 .D ^ZZTSET7A
 .;
 .; perform the changes...
 .D ^ZZTSET7B
 .D ^ZZTSET7C
 .D ^ZZTSET7D
 ;
 ; finish...
 K DA,DIC,DIE,DR,DX,DY,I,J,K,L,ST
 K FNAME,LNAME,MI,NCITY,NCOUNTY,NFN,NNAME,NMN,NPHONE,NSSN,NSTATE,NZIP
 K ZZCLRLIN,ZZCOUNT,ZZDA,ZZDFN,ZZRECS,ZZX
 K ^TMP($J)
 W $C(7)
 W !!,"Part 7 complete."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,DIRUT,X,Y
 Q
