ABC ;TSISC/ABC - KIDS utilities ;07/17/96  14:12
 ;;8.0;KERNEL;**21,28,39**;Jul 10, 1995
LOOP ;
 S NAOU=0 
 F  S NAOU=$O(^PSD(58.8,NAOU)) Q:+NAOU'>0  D DRUG 
 W !,"DONE" Q 
DRUG ; 
 S DRUG=0 
 F  S DRUG=$O(^PSD(58.8,NAOU,1,DRUG)) Q:+DRUG'>0  D 
 . I $D(^PSD(58.8,NAOU,1,DRUG,3)),'$D(^(0)) D
 .. W !,"NAOU: ",NAOU,"  DRUG: ",DRUG 
 Q         
