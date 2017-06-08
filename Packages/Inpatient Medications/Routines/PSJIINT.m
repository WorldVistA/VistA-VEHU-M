PSJIINT ;BIR/CML3-INIT ROUTINE ;12/27/93 / 15:56:54
 ;;4.5; Inpatient Medications ;;7 Oct 94
 ;
FD ; file delete
 S XQABT3=$H
 W !!,"Deleting the PICK LIST file data dictionary..." S DIU=53.5,DIU(0)="" D EN^DIU2
 Q
