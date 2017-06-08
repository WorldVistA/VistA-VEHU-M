ADXTAFL ;523/KC transfer follow-up file to files 160,160.5 ;4-AUG-1992
 ;;1.1;;
 ; Add entries from MRS Follow-up file to "Subsequent Treatment"
 ; multiple (file 165.5), and "Follow-Up" multiple (file 160).
 ;
 N ADXT,ADXTDA,ADXTERR,ADXTFILE,ADXTLBL,ADXTRN,ADXTX1,DIC,Y
 ;
 U IO(0)
 W !,"Transferring from MRS Follow-up file to VA files 160 and 165.5"
 S (ADXTRN)=0,ADXTLBL="FL"
 F  S ADXTRN=$O(^TMP("ADXT","FL",ADXTRN)) Q:'+ADXTRN  D
 .S ADXTERR=0 D FL^ADXTCHK I ADXTERR W !?10,"Did not process MRS follow-up record stored at ^TMP(""ADXT"",""FL"",",ADXTRN,").",!! D VERERR^ADXTCERR Q
 .S ADXTX1=$G(^TMP("ADXT","FL",ADXTRN))
 .D EN^ADXTAFL1 ; store MRS variables in ADXT local array
 .I $E(ADXTRN,$L(ADXTRN))="0" U IO(0) W "."
 .D PRIMARY ; add fields to primary file and subfiles
 .D PATIENT ; add fields to patient file and subfiles
 .Q
EXIT ;
 K ADXT,ADXTDA,ADXTERR,ADXTFILE,ADXTLBL,ADXTRN,ADXTX1,DIC,Y
 Q
PRIMARY ;
 S ADXTFILE="Processing MRS follow-up. Error: unable to match DTOP/PID/SEQ # to file 165.5 entry."
 K ADXTDA S ADXTDA=$$GTOPP^ADXTUT(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 I ADXTDA<1 D ERROR Q
 D EN^ADXTAFL2 ; subsequent treatments multiple
 D EN^ADXTAFL4 ; add 70,71,71.1,71.2,71.3 to file 165.5, and also
 ;               calls ADXTAFL6 for subsequent recurrence multiple
 D EN^ADXTAFL5 ; add tumor status multiple
 Q
PATIENT ;
 S ADXTFILE="Processing MRS follow-up. Error: PID not matched to a patient entry in file 160."
 S ADXTDA=$$GTPP^ADXTUT(ADXT("PID"))
 I ADXTDA<1 D ERROR Q
 D EN^ADXTAFL3 ; follow-up multiple
 D EN^ADXTAFL7 ; follow-up attempts multiple
 D EN^ADXTAFL8 ; follow-up contact multiple
 Q
ERROR ;
 D ADDERR^ADXTCERR U IO(0) Q
