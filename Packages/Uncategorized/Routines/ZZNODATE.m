ZZNODATE ;ISC1/JF Remove or edit RT Movement History nodes that have no date
 ;;CLASS3 ; 1 APRIL 93
MAIN ;
 ; set counters and root global for deletions
 ;
 S DIK="^RTV(190.3,",(ERASE,GOOD,EDIT)=0
 ;
 ; loop thru the RT Movement History
 ; File and check the necessary data
 ;
 F KOUNT=0:0 S KOUNT=$O(^RTV(190.3,KOUNT)) Q:'KOUNT  D CHKDATA
 ;
 ; print the results
 ;
 W !,"Removed ",ERASE," and updated ",EDIT," entries that"
 W !,"contained no date, ",GOOD," entries did have a date."
 W !,"A total of ",(GOOD+EDIT+ERASE)," entries were searched."
 ;
 ; kill the variables used in the
 ; first portion of the routine
 ;
 K DIK,ERASE,GOOD,EDIT,KOUNT,RECD,TEMP,MOVE,PTR,DA
 ;
 ; call the routine that sets the 3rd piece
 ; of the zero node for the purge routine
 ;
 D GAP^RTPURGE
 ;
 ; explain what happened
 ;
 W !!,"The 3rd piece of the zero node has been"
 W !,"reset as if the file had been purged."
 ;
 ; kill the variables used by
 ; the called routine and quit
 ;
 K I,Z,Z1,Z2,Z3
 Q
CHKDATA ;
 ; set a temporary movement history variable
 ; check the variable for the existance of a date
 ; if a date exists, increment the counter and
 ; return to the loop
 ;
 S TEMP=^RTV(190.3,KOUNT,0)
 I $P(TEMP,"^",6)]"" S GOOD=GOOD+1 Q
 ;
 ; if no date set the record number to the corresponding 
 ; entry in the Records File, make sure it's a numeric
 ; then see if it is valid, delete an invalid movement
 ;
 S RECD=+TEMP
 I $L(RECD)=4!(RECD<1) G DELMOVE
 ;
 ; check to see if there is a current location
 ; for the associated record, delete the movement
 ; history entry if a current location does not exist
 ;
 I '$D(^RT(RECD,"CL")) G DELMOVE
 ;
 ; set a temporary current location variable
 ; set a movement date and movement pointer variable
 ; if there is no date delete the movement history
 ; entry, if no pointer back to movement history
 ; entry reset the pointer
 ;
 S TEMP=^RT(RECD,"CL")
 S MOVE=$P(TEMP,"^",6),PTR=$P(TEMP,"^",2)
 I MOVE="" G DELMOVE
 I PTR="" D SETPTR
 ;
 ; check to see if the pointer is the same
 ; as the movement history number, if it isn't
 ; do a check of the movement history entry
 ; associated with the existing pointer
 ;
 I +PTR'=+KOUNT G CHKPTR
 ;
 ; if validity tests are passed reset the
 ; movement history data node and "C" index
 ; the "B" index should be good as it is
 ; increment the counter and return to loop
 ;
 S ^RTV(190.3,KOUNT,0)=RECD_"^^^^"_$P(TEMP,"^",5,99)
 S ^RTV(190.3,"C",MOVE,KOUNT)="",EDIT=EDIT+1
 Q
SETPTR ; 
 ; set the record file movement pointer
 ; to the movement history file number and
 ; insert it into the current location data
 ; return to the current location data check
 ;
 S PTR=KOUNT
 S ^RT(RECD,"CL")="^"_PTR_$P(TEMP,"^",2,99)
 Q
CHKPTR ;
 ; movement history pointer in the current location
 ; points to newer or other movements, movement
 ; history can not be repaired delete it
 ;
 D DELMOVE
 ;
 ; if this pointer is pointing to 
 ; valid data return to the loop
 ;
 I $D(^RTV(190.3,"C",MOVE,PTR)) Q
 ;
 ; if pointer is not pointing to data
 ; set the required movement history node
 ; for the current location then set the
 ; indexes for that node, adjust the
 ; counters and return to the loop
 ;
 S ^RTV(190.3,PTR,0)=RECD_"^^^^"_$P(TEMP,"^",5,99)
 S ^RTV(190.3,"B",RECD,PTR)=""
 S ^RTV(190.3,"C",MOVE,PTR)=""
 S EDIT=EDIT+1,ERASE=ERASE-1
 Q
DELMOVE ;
 ; bad or unrepairable entry, increment the
 ; counter and set the necessary variables
 ; then delete the data and indexes if any 
 ; return to loop or pointer check
 ;
 S ERASE=ERASE+1,DA=KOUNT
 D ^DIK
 Q
