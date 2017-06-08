A1B8PL ;PICK LIST CLEAN-UP ROUTINE; ALBANY ISC; VFR; 5/13/92
 ;;VERSION 1
 ;   This routine cleans-up the pick list data nodes that ecisted from a
 ;test version of Unit Dose, and those negative pick lists created before
 ;PSJ*3.2*19.  This is specific for Manchester and will kill off the pick
 ;lists that are older than 1/29/92, or another specified date.
 ;
START ;
 S PKLST=""
 F I=0:0 S PKLST=$O(^PS(53.5,PKLST)) Q:PKLST=""  D LIST
 Q
LIST ;
 I '$D(^PS(53.5,PKLST,0)) Q
 S RECORD=^PS(53.5,PKLST,0)
 I $P(^PS(53.5,PKLST,0),U,2)'="" S LSTDT=$P(RECORD,U,2) 
 I LSTDT'="" S XDATE=$E(LSTDT,4,5)_"/"_$E(LSTDT,6,7)_"/"_$E(LSTDT,2,3)
 Q:LSTDT>"2891104.00"
 W !,(^PS(53.5,PKLST,0))_"...PICK LIST # = "_PKLST
 Q
EXIT ;
 K I,LSTDT,PKLST,XDATE,RECORD
 Q
