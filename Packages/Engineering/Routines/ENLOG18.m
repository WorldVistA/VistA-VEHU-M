ENLOG18 ;(WASH ISC)/DH-LOG1 => AEMS-MERS Help Text ;2-11-92
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
MSG W !!,"Many sites leave a gap between existing EQUIPMENT ENTRY numbers and new",!,"records added from LOG1.  This makes it easy to distinguish LOG1 records"
 W !,"from those acquired in other ways."
 W !!,"You may wish to use the next even thousand as your starting value."
 W !!,"For example, if your Equipment File now goes up to ENTRY NUMBER 18257 then",!,"you may wish to use 19000 as your LOG1 starting point.",!!
 Q
 ;
MSG1 W !!,"If you wish, you can add the content of the LOG1 SPEX field(s) into",!,"your AEMS/MERS COMMENTS.  Doing so will not disturb any information"
 W !,"presently found in this COMMENTS field."
 W !!,"The principal disadvantage to moving LOG1 SPEX into AEMS/MERS is that it",!,"will consume some disk space.  You will probably find that the SPEX portion"
 W !,"of the 'average' LOG1 equipment record will consume between 100 and 200",!,"bytes."
 W !!,"Note that the LOG1 SPEX will always be written into any AEMS/MERS records",!,"that are automatically created during this conversion."
 R !!,"Press <RETURN> to continue...",X:DTIME
 Q
 ;ENLOG18
