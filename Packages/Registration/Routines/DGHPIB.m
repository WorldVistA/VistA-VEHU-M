DGHPIB ;PKE/ALB - Health Services R&D Caregiver Study Main Routine;
 ;;5.3;Registration;**221**;Aug 13, 1993
 ;
 I $D(DUZ)'=11 DO  Q
 .W !!,"Please set DUZ variables, D ^XUP"
 N XMDUZ,XMSUB,XMY,XMZ,ZTDESC,ZTIO,ZTSK,ZTQUEUED,ZTRTN
 ;
 S DGTATION=+$P($$SITE^VASITE(),U,3)
 I 'DGTATION DO  Q
 . W !!,"Could not find station number from VASITE" Q
 ;
 W !?3,">>> VA Patient Survey <<< ",!
 W !,"    Please queue to run at a non peak time."
 W !,"    This extract will generate 2 mail messages to you"
 W !,"    and to G.DG HPI EXTRACT@ISC-ALBANY.VA.GOV",!
 ;
 S ZTIO="",ZTRTN="START^DGHPIB"
 S ZTDESC="DG*5.3*221 - VA Patient Survey"
 D ^%ZTLOAD,HOME^%ZIS
 I $G(ZTSK) W !?30,"Task Number = ",ZTSK,!
 Q
START I $D(DUZ)'=11 W !!,"Please set DUZ variables, D ^XUP" Q
 ;
 S DGTATION=+$P($$SITE^VASITE(),U,3)
 I '$D(^XTMP("DGHPI","S",DGTATION)) W:'$D(ZTQUEUED) !,"No STATION data" Q
 ;
 S DGSTART=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 K ^XTMP("DGHPI",$J,"DATA")
 K ^XTMP("DGHPI",$J,"ERROR")
 K ^XTMP("DGHPI","S",DGTATION,"DFN")
 ;
 I $D(^XTMP("DGHPI","S",DGTATION,"ERROR","NO DATA REQUESTED")) DO  QUIT
 .;
 . D FMAIL(0)
 . I '$D(ZTQUEUED) W !!?3,">>>... all done"
 ;
 I '$D(ZTQUEUED) DO
 .W !?3,">>> Looking up patients DFNs from SSNs  "
 D GETDFN(DGTATION)
 ;
 I '$D(ZTQUEUED) DO
 .W !!?3,">>> Looking up patients data from DFNs  "
 D DIQLOOK(DGTATION)
 ;
 I '$D(ZTQUEUED) DO
 .W !!?3,">>> Creating Mail message of patients data "
 D SENDATA(DGTATION)
 ;
 I '$D(ZTQUEUED) DO
 .W !!?3,">>> ....all done"
 ;
 ;mail summary
 D FMAIL(1)
 ;
 K DGFIELD,DGN,DGP,DGPECE,DGSTART
 K DGZ,DGFLDS,DGDFN,DGTATION,DGSSN,DGLINE
 Q
GETDFN(DGTATION) ;
 ;From strings of SSNs get DFN's from DPT
 ; go down station array
 S DGN=0
 F  S DGN=$O(^XTMP("DGHPI","S",DGTATION,DGN)) Q:'DGN  DO
 .;;piece out ssn
 .F DGP=1:1 S DGSSN=$P(^XTMP("DGHPI","S",DGTATION,DGN),"^",DGP) Q:'DGSSN  DO
 . . S DGDFN=$$DFN(DGSSN)
 . . I DGDFN S ^XTMP("DGHPI","S",DGTATION,"DFN",DGDFN)=DGSSN
 . . E  S ^XTMP("DGHPI",$J,"ERROR","SSN",DGSSN)=DGDFN
 . .;
 . . I (($P($H,",",2))#20) Q
 . . I '$D(ZTQUEUED) W "."
 Q
DIQLOOK(DGTATION) ;
 ;
 ; get array of fields to lookup
 D INIFLDS
 ; for each dfn call gets^diq
 S DGDFN=0
 F  S DGDFN=$O(^XTMP("DGHPI","S",DGTATION,"DFN",DGDFN)) Q:'DGDFN  DO
 . D GETDGIQ(DGDFN)
 .;
 . I (($P($H,",",2))#3) Q
 . I '$D(ZTQUEUED) W "."
 .;
 Q
SENDATA(DGTATION) ;
 ; dgline is the message line
 S DGLINE=0
 S DGDFN=""
 ; (2,dfn, field  set up from fileman data merge, dfn is dfn_"," 
 F  S DGDFN=$O(^XTMP("DGHPI",$J,"DATA",2,DGDFN)) Q:'DGDFN  DO 
 . D SETMAIL(DGTATION,DGDFN)
 .;
 . I (($P($H,",",2))#10) Q
 . I '$D(ZTQUEUED) W " ."
 .;
 ;final mailman set
 Q:'DGLINE
 D SMAIL(DGLINE)
 ;
 Q
SETMAIL(DGTATION,DGDFN) ;
 I DGLINE=0 D INITMAIL(1)
 ;
 S DGLINE=DGLINE+1
 S DGPECE=1
 ;
 ; set first line of each record to station^ssn
 S ^XMB(3.9,XMZ,2,DGLINE,0)=DGTATION_"^"_$P($G(^DPT(+DGDFN,0)),"^",9)_"^"
 S DGLINE=DGLINE+1
 ;
 S DGFIELD=0
 F  S DGFIELD=$O(^XTMP("DGHPI",$J,"DATA",2,DGDFN,DGFIELD)) Q:'DGFIELD  DO
 . ;set mailmsg for 1 dfn
 . I $$LINECALC(DGFIELD,DGLINE)>80 DO
 . . ; make sure end piece has last ^
 . . S $P(^XMB(3.9,XMZ,2,DGLINE,0),"^",DGPECE)=""
 . . S DGLINE=DGLINE+1
 . . S DGPECE=1
 . D SETLINE
 . S DGPECE=DGPECE+1
 ;
 ; make sure end piece has last ^
 S $P(^XMB(3.9,XMZ,2,DGLINE,0),"^",DGPECE)=""
 S DGLINE=DGLINE+1
 ; set record delimiter
 S ^XMB(3.9,XMZ,2,DGLINE,0)=">>>"
 ;
 Q
LINECALC(DGFIELD,DGLINE) ;
 ; return length that would be set
 Q $L($G(^XTMP("DGHPI",$J,"DATA",2,DGDFN,DGFIELD,"E")))+$L($G(^XMB(3.9,XMZ,2,DGLINE,0)))
 ;
 ;
SETLINE ;set mailmsg from xtmp array
 ; $g will preserve piece position if field returned error
 S $P(^XMB(3.9,XMZ,2,DGLINE,0),"^",DGPECE)=$G(^XTMP("DGHPI",$J,"DATA",2,DGDFN,DGFIELD,"E")) Q
 ;
 ;
GETDGIQ(DGDFN) ;
 K DGDATA,DGERR
 ;
 F DGFLDS=1:1:5 DO
 . D GETS^DIQ(2,DGDFN,DGFLDS(DGFLDS),"E","DGDATA","DGERR")
 .;
 .; merge will set ,2,dfn_",",field,"E")=external value
 .;
 . M ^XTMP("DGHPI",$J,"DATA")=DGDATA
 . K DGDATA
 . I $D(DGERR) DO  K DGERR
 . .;if a field has err whatodo
 . .;
 . .; check to see if each field was set in returned array 
 . . F DGP=1:1 S DGFIELD=$P(DGFLDS(DGFLDS),";",DGP) Q:'DGFIELD  DO
 . . .;
 . . .;  indicates fileman returned error
 . . . I '$D(^XTMP("DGHPI",$J,"DATA",2,DGDFN_",",DGFIELD,"E")) DO
 . . . .;
 . . . .; set it to null to keep the piece position in mail
 . . . . S ^XTMP("DGHPI",$J,"DATA",2,DGDFN_",",DGFIELD,"E")=""
 . . . .;
 . . . .;the dgerr array is set by fm in order of missing fields
 . . . . S DGERR=$O(DGERR("DIERR",0)) I 'DGERR K DGERR Q
 . . . . M ^XTMP("DGHPI",$J,"ERROR",DGDFN,DGFIELD)=DGERR("DIERR",DGERR)
 . . . . S ^XTMP("DGHPI",$J,"ERROR",DGDFN,"SSN")=$P($G(^DPT(DGDFN,0)),"^",9)
 . . . .;pop the array
 . . . . K DGERR("DIERR",DGERR)
 . . .;
 ;
 Q
 ;
 Q
INITMAIL(FLAG) ;-- This function will initialize mail variables
 ;
 S XMSUB="DG*5.3*221 "_(+$$SITE^VASITE())_" VA PATIENT SURVEY"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 I $G(FLAG) DO
 . S XMY("G.DG HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 . S XMY("S.DG HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 D GET^XMA2
 Q
SMAIL(DGLINE) ;-- Send Mail Message containing records so far
 ;
 ; INPUT TOTAL- Total Lines in Message
 ;
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_DGLINE_U_DGLINE_U_DT
 D ENT1^XMD
 D KILL^XM
 Q
 ;
FMAIL(DATA) ;- This function will generate a summary mail message.
 ;
 S XMSUB="DG*5.3*221 "_(+$$SITE^VASITE())_" VA Patient Survey Error Summary"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("G.DG HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 S XMY("S.DG HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 ;
 D GET^XMA2
 S ^XMB(3.9,XMZ,2,1,0)="VA Patient Survey completed."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Start Time: "_DGSTART
 S ^XMB(3.9,XMZ,2,4,0)=" Stop Time: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S ^XMB(3.9,XMZ,2,5,0)=""
 ;
 S DGLINE=6
 I 'DATA DO  QUIT
 . S ^XMB(3.9,XMZ,2,DGLINE,0)="No data requested"
 . D SMAIL(DGLINE)
 ;
 S DGZ=$Q(^XTMP("DGHPI",$J,"ERROR"))
 I DGZ]"",DGZ[("""DGHPI"""_","_$J_","_"""ERROR""")
 E  DO  QUIT
 . S ^XMB(3.9,XMZ,2,DGLINE,0)=" Error Summary: No errors Found "
 . D SMAIL(DGLINE)
 ;
 S ^XMB(3.9,XMZ,2,DGLINE,0)=" Error Summary: "
 S DGLINE=DGLINE+1
 S ^XMB(3.9,XMZ,2,DGLINE,0)="""ERR"_$P(DGZ,"ERROR",2)_" = "_@DGZ
 ;
 F  S DGZ=$Q(@DGZ) Q:DGZ']""  Q:DGZ'[("""DGHPI"""_","_$J_","_"""ERROR""")  DO
 . S DGLINE=DGLINE+1
 . S ^XMB(3.9,XMZ,2,DGLINE,0)="""ERR"_$P(DGZ,"ERROR",2)_" = "_@DGZ
 .;
 .;quit if this gets to be too much
 . I DGLINE>500 S DGZ="ZZZEND"
 D SMAIL(DGLINE)
 Q
 ;
DFN(SSN) ;function to lookup DFN from SSN x-ref
 ; input SSN
 ; output DFN or error code
 N DFN
 ; make sure dfn is numeric and not null
 I $O(^DPT("SSN",SSN,0))
 E  Q "No SSN Index for "_SSN
 ;
 I $O(^DPT("SSN",SSN,0))=$O(^DPT("SSN",SSN,""),-1)
 E  Q "Ambiguous SSN cross-ref "_SSN
 ;
 S DFN=$O(^DPT("SSN",SSN,0))
 ;
 I $G(^DPT(DFN,0))]""
 E  Q "No Zero node in DPT for SSN "_SSN
 ;
 I $P($G(^DPT(DFN,0)),"^",9)=SSN
 E  Q "Bad SSN cross-ref "_SSN
 Q DFN
 ;
INIFLDS ; set up array of fields to be used in fm getsdiq call
 S DGFLDS(1)=$P($T(FLDS1),";;",2)
 S DGFLDS(2)=$P($T(FLDS2),";;",2)
 S DGFLDS(3)=$P($T(FLDS3),";;",2)
 S DGFLDS(4)=$P($T(FLDS4),";;",2)
 S DGFLDS(5)=$P($T(FLDS5),";;",2)
 Q
FLDS1 ;;.01;.02;.03;.033;.05;.06;.07;.08;.09;.103;.104;.1041;.105;.111;.1112;.112;.113;.114;.115;.116;.117;.12105;.1211;.12111;.12112;.1212;.1213;.1214;.1215;.1216;.1217;.1218;.1219
FLDS2 ;;.131;.132;.14;.21011;.211;.211011;.212;.2125;.213;.214;.215;.216;.217;.218;.219;.2191;.2192;.21925;.2193;.2194;.2195;.2196;.2197;.2198;.2199
FLDS3 ;;.2401;.2402;.2403;.251;.2514;.2515;.252;.253;.254;.255;.256;.257;.258;.291;.2911;.2912;.2913;.2914;.2915;.2916;.2917;.2918;.2919;.292;.2921;.2922;.2923;.2924;.2925;.2926;.2927;.2928;.2929;.293
FLDS4 ;;.301;.3192;.323;.33011;.3305;.331;.331011;.3311;.3312;.3313;.3314;.3315;.3316;.3317;.3318;.3319;.332;.333;.334;.335;.336;.337;.338;.339;.34011;.3405;.341;.342;.343;.344;.345;.346;.347;.348;.349;.351
FLDS5 ;;.3601;.36205;.3621;.36215;.3622;.36225;.3623;.36235;.3624;.3625;.36255;.3626;.36265;.3627;.36275;.3628;.36285;.3629;.36295;.525;.5291;57.4;148;1901
 Q
