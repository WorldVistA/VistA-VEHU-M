MAGRDEL2 ;WISC/RED Add data to 2005.15 Teleconsult File [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
ADD(MAGRET,MAGARR1) ; Call UPDATE^DIE to Add a File 2005.15 entry
 ;
 ; MAGARR1 is an array of fields and their entries
 ;  i.e. MAGARR1(1)=".5^38"   field .5   data is 38
 ;
 ; If Long Description is included in fields, we create a new
 ;  array to hold the text, and pass that to UPDATE^DIE
 ;
 ; If this entry is an object group
 ;  i.e. MAGARR1(n)="2005.04^344"    
 ;   (the field 2005.04 is the OBJECT GROUP MULTIPLE)
 ; 
 ;
 ; MAGRET - Ret variable (Single Variable)
 ;   If successful   MAGRET = IEN^FILE NAME (with full path)
 ;        IEN is Internal Entry Number of ^MAG(2005
 ;        CALLING ROUTINE is responsible for RENAMING THE IMAGE FILE
 ;        TO THE NEW FILE NAME.
 ;
 ;   If UNsuccessful MAGRET = 0^Error desc
 ; 
 ;----------------------------------------------------------------
 ;
 S X="ERR^MAGRDEL2",@^%ZOSF("TRAP")
 ;TESTING
 K ^MAGGXXX("RED1") M ^MAGGXXX("RED1")=MAGARR1
 K ^MAGGXXX("MAGRD1")
 ;
 S DIQUIET=1 D DT^DICRW
 N MAGGXE,MAGGFDA,MAGGIEN,MAGGDRV,MAGGR,MAGGRC,MAGGDA,MAGGFNM,I,J
 N MAGGWP,MAGGWPC,MAGGFLD,MAGGDAT,MAGERR,MAGGEXT
 ;
 S MAGRET="",MAGERR="",MAGGR=0,MAGGRC=1,MAGGWPC=0
 ;
 I ($D(MAGARR1)<10) S MAGRET="0^No input data, NO entry made" Q
 ;
 S Z="" F  S Z=$O(MAGARR1(Z)) Q:Z=""  D  I $L(MAGERR) Q
 . S MAGGFLD=$P(MAGARR1(Z),U,1),MAGGDAT=$P(MAGARR1(Z),U,2)
 . I MAGGFLD=""!(MAGGDAT="") Q
 . ; if this is a image group entry.
 . I MAGGFLD=2005.159 D  Q
 . . S MAGGDAT=+MAGGDAT
 . . S MAGGR=1,MAGGR(+MAGGDAT)=""
 . . S MAGGRC=MAGGRC+1
 . . I '$D(^MAG(2005,+MAGGDAT,0)) S MAGERR="0^Image Group "_MAGGDAT_" doesn't exist"
 . . S MAGGFDA(2005.159,"+"_MAGGRC_",+1,",.01)=+MAGGDAT
 . ;
 . ; if we are getting a WP for Findings, set array to pass.
 . I MAGGFLD=10 D  ; this is a line of the WP Long Desc field.
 . . S MAGGWPC=MAGGWPC+1,MAGGWP(MAGGWPC)=MAGGDAT
 . ; 
 . ; if a BAD field number
 . I '$D(^DD(2005.15,MAGGFLD)) D  Q
 . . S MAGERR="0^Field Number "_MAGGFLD_" doesn't exist"
 . ;
 . ; if a Date field, we'll convert it here.
 . I ($P(^DD(2005.15,MAGGFLD,0),U,2)["D") D  Q:$L(MAGERR)
 . . S %DT="T",X=MAGGDAT D ^%DT
 . . I Y=-1 S MAGERR="0^Invalid Date. Field "_MAGGFLD Q
 . . S MAGGDAT=Y
 . ; 
 . ;  if a pointer field, we'll assure the pointer to entry exists.
 . I ($P(^DD(2005.15,MAGGFLD,0),U,2)["P") D  Q:$L(MAGERR)
 . . S MAGGDAT=+MAGGDAT
 . . S ZZ=+$E($P(^DD(2005.15,MAGGFLD,0),U,2),2,999)
 . . S X="^"_$P(^DD(2005.15,MAGGFLD,0),U,3)_+MAGGDAT_",0)"
 . . S ^MAGGXXX("RED1","POINTER")=X
 . . I '$D(@X) S MAGERR="0^Pointed to entry "_+MAGGDAT_" in "_$O(^DD(ZZ,0,"NM",""))_" doesn't exist" Q
 . ; should test for SET
 . ; made it here, so set the Node for the UPDATE^DIC Call.
 . S MAGGFDA(2005.15,"+1,",MAGGFLD)=MAGGDAT
 ; 
 ; if there was an Error in data we'll quit now.
 I $L(MAGERR) S MAGRET=MAGERR Q
 ;
 ;  some possible problems, we'll check for now.
 I '$D(MAGGFDA(2005.15,"+1,")) S MAGRET="0^No data to file ?" Q
 ;
 ;  We're making Object Type and either Patient, or short Desc Required.
 ;I '$D(MAGGFDA(2005.15,"+1,",3)) S MAGRET="0^Need an Object Type " Q
 ;I '$D(MAGGFDA(2005.15,"+1,",5)),'$D(MAGGFDA(2005.15,"+1,",10)) D  Q
 ;. S MAGRET="0^Need Patient or Short Desc. NO ENTRY CREATED"
 ;
 ; If a Name (.01) wasn't sent, we'll make one
 ; We know that either Patient or Short Desc, and Object Type exist
 I '$D(MAGGFDA(2005.15,"+1,",.01)) D  Q
 . S MAGRET="0^Need Patient Name. NO ENTRY CREATED"
 ;S MAGGFDA(2005.15,"+1,",.01)=$$MAKENAME()
 ;
 ; If a long description was sent.
 I $D(MAGGWP) S MAGGFDA(2005.15,"+1,",10)="MAGGWP"
 ;
 M ^MAGGXXX("MAGGFDA")=MAGGFDA ; TESTING
 ;
 ; Now call Fileman to file the data.
 ;   we know that MAGGIEN WILL contain the internal number.
 D UPDATE^DIE("","MAGGFDA","MAGGIEN","MAGGXE")
 I '$G(MAGGIEN(1)) D  D CLEAN^DILF S MAGRET=MAGERR Q
 . S MAGERR="0^ERROR Creating new Teleconsult File Entry "
 . I $D(DIERR) D RTRNERR(.MAGERR)
 ;
 S MAGGDA=MAGGIEN(1)
 K MAGGFDA
 ;
 ; IF a group, Modify GROUP PARENT in each Group Object and QUIT
 ;   we'll do this by hand, Else it'll take forever.
 ;   we Return the IEN with NO Filename. Groups don't get Filename
 ;;no groups here; I MAGGR S MAGRET=MAGGDA_U,Z="" D  Q
 ;;. F  S Z=$O(MAGGR(Z)) Q:Z=""  S $P(^MAG(2005.15,Z,0),U,10)=MAGGDA
 ; 
 ; Queue it to be copied to Jukebox.
 ;S X=$$JUKEBOX^MAGBAPI(MAGGDA)
 ;  We return the IEN ^ DRIVE:DIR ^ FILE.EXT
 ;   i.e  487^C:\IMAGE\^DC000487.TIF
 ;  The calling routine is responsible for renaming/naming the file
 ;   to the returned DRIVE:\DIR\FILENAME.EXT
 ;  
 S MAGRET=MAGGDA ;_U_MAGGDRV_U_MAGGFNM
 D CLEAN^DILF
 Q
 ;
RTRNERR(ETXT) ;
 ; There was error from UPDATE^DIE quit with error text
 S ETXT="0^ERROR  "_MAGGXE("DIERR",1,"TEXT",1)_"X="_$G(X)_" Z="_$G(Z)_"end" ;FROM UPDATE^DIE"
 Q
ERR ;
 S MAGRET="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
MAKENAME() ; MAGGFDA exists so get info from that.
 ; We'll make NAME (.01)  with PATIENT NAME   SSN  
 ; DOCUMENT Imaging was making name of 
 ; $E(PATENT NAME,1,10)' '$E(DESC CATEG,1,9)' 'MM/DD/YY   (DOC DATE)
 N Z,ZN,ZS,ZD
 I $D(MAGGFDA(2005,"+1,",10)) S ZD=$E(MAGGFDA(2005,"+1,",10),1,30)
 I $D(MAGGFDA(2005,"+1,",5)) D
 . S X=MAGGFDA(2005,"+1,",5)
 . S ZN=$P(^DPT(X,0),U),ZS=$P(^DPT(X,0),U,9)
 ;
 ; If not Document Image Make .01 quit
 I '$D(MAGGFDA(2005,"+1,",100)) D  Q Z
 . I $D(ZN) S Z=$E(ZN,1,18)_"   "_ZS Q
 . S Z=ZD
 ;
 S ZT=$E($P(^MAG(2005.81,MAGGFDA(2005,"+1,",100),0),U),1,8)
 I $D(ZN) S Z=$E(ZN,1,10)_" "_ZT_" "_ZS Q Z
 S Z=$E(ZD,1,18)_"  "_ZT Q Z
 ;
 Q "Image entry No Patient,No Desc"
