DGYCLD ;ALB/MTC - Lodger Clean-up routine for DG*5.2*19 ; 11/3/92
 ;;5.2;REGISTRATION;**19**;JUL 29,1992
 ;
 W !,">>> Cleaning up the ^DGPM(""LD"" and ^DGPM(""ARM"" cross references."
 D LOOP
 Q
 ;
LOOP ;-- loop thru DGPM("LD", save DFN, DA of entry then 
 ;   reset by calling RESET^DGPMDDLD.
 N I,J,DFN,DA
 ;
 ;-- find lodgers, save DA and DFN
 S I="" F  S I=$O(^DGPM("LD",I)) Q:I=""  D
 . S J=0 F  S J=$O(^DGPM("LD",I,J)) Q:'J  D
 .. S ^TMP("LDCLN",$J,$P($G(^DGPM(J,0)),U,3),J)=""
 .. K ^DGPM("LD",I,J)
 ;
 ;-- clean-up
 S DFN=0 F  S DFN=$O(^TMP("LDCLN",$J,DFN)) Q:'DFN  D
 . S DA=0 F  S DA=$O(^TMP("LDCLN",$J,DFN,DA)) Q:'DA  D RESET^DGPMDDLD
 K ^TMP("LDCLN",$J)
 ;
