PRCO175 ;WISC/REW-IFCAP post init for patch 175 ; 7/1/99 2:44pm
 ;;5.0;IFCAP;**175**;4/21/95
 ;
 ; This post init routine will place, in file 443.75, the DUZ
 ; of the person who 'created' the PHA, RFQ or TXT.  File 443.75
 ; keeps track of those transactions going to Austin and of ACT or
 ; REJ transactions returning from Austin.  Additionally File 443.75
 ; keeps track of POA transactions returning from vendors.  File
 ; 443.75 needs to 'populate' the SENDER field (#5.5) and set up
 ; cross-references that use the SENDER field.  This post init will
 ; do both of these things.
 ;--------------------------------------------------------------------
START ; Search through file 443.75 -- get the 'IEN' for file 442 or 444.
 ; Go to the file and get the 'DUZ' from the file entry.  Add
 ; it to field 5.5.  Continue until out of records in file 443.75.
 ;
 N DA,DIE,DR,I,J,J1,J2,SENDER
 S DIE="^PRC(443.75,"
 S I=0
 F  S I=$O(^PRC(443.75,I)) Q:'I  D
 .  S J=$G(^PRC(443.75,I,0))
 .  I $P(J,U,8)>0 S SENDER=$P($G(^PRC(442,$P(J,U,8),1)),U,10) D:SENDER>0 SAVE Q
 .  I $P(J,U,9)>0 S SENDER=$P($G(^PRC(444,$P(J,U,9),0)),U,4) D:SENDER>0 SAVE Q
 .  D  ;
 .  .  S MSG="*** Internal Entry Number "_I
 .  .  S MSG=MSG_" is missing both a P.O. & RFQ number***"
 .  .  D MES^XPDUTL(MSG)
 .  .  Q
 .  Q
 ;
 ; --------------- Finished fetching 'SENDER' data. ---------------
 ;
 ; Setup 'C' and 'D' cross references.
 D UPDATE
 D MES^XPDUTL("*** Processing Completed. All Done! ***")
 ; 
 QUIT
 ;
 ;--------------------------------------------------------------------
SAVE ; Found the 'DUZ' for the file 443.75 record.  Now enter it into
 ; field 5.5 using FileMan.  This should set all x-refs for the
 ; field.
 ;
 S DA=I
 S DR="5.5////^S X=SENDER"
 D ^DIE
 Q
 ;--------------------------------------------------------------------
UPDATE ; Now lets update the "C" cross-reference in file 443.75.  This x-ref
 ; lists all the users that have entries in the file.  The number that
 ; shows up after the name of the user is the internal record number
 ; of the record entered in the "C" x-ref.  Any user can have more
 ; than one record in the file.  Only the first record for that user
 ; goes into the "C" x-ref.
 ; 
 ; 'D' cross references will be created for all 443.75 entries that
 ;  do not have one.  This cross reference will be used by the purge
 ;  process in determining which entries are to be deleted.  If an
 ;  entry is greater that 60 days old, then it will be purged.
 ;  
 ;  After the patch is loaded, a 'D' cross references will be created
 ;  for any transactions that occur.  This subroutine will create a
 ;  'D' cross reference for all transactions that occured before the
 ;  patch was installed.
 ;
 ;  The purge routine will not be sent with this patch. More analysis
 ;  is needed.  However, it has been determined that the 'D' cross
 ;  reference is to be put in place with this version of PRC*5.0*175.
 ;--------------------------------------------------------------------
 D MES^XPDUTL("*** Updating 'C' and 'D' cross references ***")
 ;
 D NOW^%DTC S TODAY=%
 ;
 N SENDER,IEN,TDATE,DATA
 S IEN=0
 F  S IEN=$O(^PRC(443.75,IEN)) Q:'IEN  D  ;Get IEN
 .  S DATA=$G(^PRC(443.75,IEN,0))         ;Get data string
 .  Q:DATA=""
 .  S TDATE=$P(DATA,U,7)                  ;Get transaction date
 .  ;
 .  ; Transaction date is missing set one up
 .  I TDATE="" S TDATE=TODAY,DA=IEN,DR="6////^S X=TDATE" DO ^DIE
 .  ;
 .  ; Setup D cross reference if there isn't one
 .  I '$D(^PRC(443.75,"D",TDATE,IEN)) S ^PRC(443.75,"D",TDATE,IEN)=""
 .  ;
 .  ; Setup C cross reference
 .  S SENDER=$P(DATA,U,11)
 .  Q:'SENDER
 .  Q:$D(^PRC(443.75,"C",SENDER))
 .  S ^PRC(443.75,"C",SENDER,IEN)=""
 .  Q
 ;
 QUIT
