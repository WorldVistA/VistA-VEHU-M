EVETRPT ;SLC/GPM - ; 11/25/02 2:46pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ;Report: MY HEALTHEVET DAILY DOWNLOAD ACTIVITY FOR XX/XX/XXXX
 ;
DTLPAT ; Detail by Patient
 N FLDS,BY
 S BY=".02,.03"
 S FLDS="[EVET DOWNLOAD DETAIL]"
 D PRINT
 Q
 ;
DTLDATE ; Detail by Date
 N FLDS,BY
 S BY=".03,.02"
 S FLDS="[EVET DOWNLOAD DETAIL]"
 D PRINT
 Q
 ;
SUMPAT ; Summary by Patient
 N FLDS,BY
 S BY=".02,.03"
 S FLDS="[EVET DOWNLOAD SUMMARY]"
 D PRINT
 Q
 ;
SUMDATE ; Summary by Date
 N FLDS,BY
 S BY=".03,.02"
 S FLDS="[EVET DOWNLOAD SUMMARY]"
 D PRINT
 Q
 ;
PRINT ;  Print Report
 N PFX,L,DIC,DIOBEG,DIOEND
 D DT^DICRW            ; Set up FM required variables.
 S L=0                 ; No SORT prompt.
 S DIC="^EVET(2276.1,"
 D EN1^DIP
 Q
 ;
