ADXTADI ;523/KC transfer diagnosis file to file 165.5 ;4-AUG-1992
 ;;1.1;;
 ;
 N ADXTFILE,ADXTLBL,ADXTERR,ADXTRN,ADXTX1,ADXTX2,ADXTDA,DIC,X,Y,ADXTTMP
 U IO(0)
 ;
 ; Adds .01 field to file 165.5; then call routine to add rest of fields
 ;
 W !,"Starting transfer from MRS Diagnosis file to Oncology Primary (165.5) file"
 W !,", and Oncology Patient (160) file, at ",$$TIME^ADXTUT(),".",!
 ;
 S (ADXTRN)=0,ADXTLBL="DI"
 F  S ADXTRN=$O(^TMP("ADXT","DI",ADXTRN)) Q:'+ADXTRN  D
 .I $E(ADXTRN,$L(ADXTRN))="0" U IO(0) W "."
 .S ADXTERR=0 D DI^ADXTCHK I ADXTERR W !?10,"Did not process MRS diagnosis record stored at ^TMP(""ADXT"",""DI"",",ADXTRN,").",!! D VERERR^ADXTCERR Q
 .S ADXTX1=$G(^TMP("ADXT","DI",ADXTRN,1)),ADXTX2=$G(^TMP("ADXT","DI",ADXTRN,2))
 .D EN^ADXTADI1 ; store MRS variables in ADXT local array
 .;
 .S ADXTFILE="Oncology Primary file (165.5). "
 .I ADXT("PID")="" S ADXTFILE=ADXTFILE_" Error was: PID null." D ERROR Q
 .I ADXT("DSQ")="" S ADXTFILE=ADXTFILE_" Error was: DSQ null." D ERROR Q
 .S X=$$GTPP^ADXTUT(ADXT("PID")) ; get pointer value for patient name
 .I +X<1 S ADXTFILE=ADXTFILE_" Error was: PID not found." D ERROR Q
 .S X=$$GTSP^ADXTUT(ADXT("DTOP")) ; get pointer value for .01 field
 .I +X<1 S ADXTFILE=ADXTFILE_" Error was: Site Grp not matched." D ERROR Q
 .;
 .;check if same primary already converted
 .S ADXTDA=+$$GTOPP^ADXTUT(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 .I +ADXTDA D  Q
 ..S ADXTFILE=ADXTFILE_" Error: Attempted to add an already-converted primary."
 ..D ERROR Q
 .;
 .;check if same primary exists (not from conversion)
 .S ADXTDA=+$$GTOPPOLD^ADXTUT2(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 .I +ADXTDA D  Q
 ..S ADXTFILE=ADXTFILE_" Error: Attempted to add a primary that already exists."
 ..D ERROR Q
NEW .;
 .I '+ADXTDA D
 ..K D0,DD
 ..K DIC S DIC="^ONCO(165.5,",DIC(0)="L" D FILE^DICN
 ..I (+Y<1) S ADXTFILE=ADXTFILE_" Error: FILE^DICN could not add DTOP." D ERROR Q
 ..K ADXTDA S ADXTDA=$P(Y,"^")
 ..;stuff DIE of 523000,523000.1 here!!
 ..K DIC,DIE,DA,DR S DA=ADXTDA,DIE="^ONCO(165.5,"
 ..S DR="523000///"_ADXT("PID")_ADXT("DTOP")_ADXT("DSQ")_";523000.1///N"
 ..D ^DIE
 ..S ^ONCO(165.5,ADXTDA,7)="^" ;create 7th node so always is defined
MATCHED .;
 .D EN^ADXTADI2 ;add rest of fields to file 165.5.
 .D EN^ADXTADI5 ; add tumor status based on DPRE if patient deceased
 .D EN^ADXTADI4 ; add cause of death field to patients's 160 entry
 .U IO W " ...done adding MRS recno ",ADXTRN,"."
 ;
EXIT ;
 U IO(0) W !,"Done processing the MRS Diagnosis file at "
 W $$TIME^ADXTUT(),"."
 K ADXTFILE,ADXTLBL,ADXTERR,ADXTRN,ADXTX1,ADXTX2,ADXTDA,DIC,X,Y,ADXTTMP
 K ADXT
 Q
ERROR ;
 D ADDERR^ADXTCERR U IO(0) Q
