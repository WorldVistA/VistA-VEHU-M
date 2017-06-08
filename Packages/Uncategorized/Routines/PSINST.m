PSINST ;GRK/BHM; OUTPATIENT PHARMACY INSTALLATION DRIVER ; 13 APR 85  4:44 PM
 ;5.0 ; 04/16/85
 S PSMESS=$P($T(PSMESS),";",2,99)
CHNG53 I $D(^PSF("PREVER")) X ^PSF("PREVER") I Y(1)<4.02 D ^PSOFIX53 G OUT53
 I $D(^DIC(53,0)),'$D(^PS(53,0)) D ^PSOFIX53
OUT53 ;
CNVT5 I '$D(^PSF("PREVER")),$D(^PSRX) D ^PSO5CNVT G OUT5
 I $D(^PSF("PREVER")) X ^PSF("PREVER") I Y(1)<5.0 D ^PSO5CNVT
OUT5 ;
PSMESS ;F J=1:1:300 S A=$P($T(@PSML+J),";",2,99) Q:A="<"  X ("W ! "_$S($E(A,1)=">":$E(A,2,999),1:"W """_A_""""))
 S PSASK=$P($T(PSASK),";",2,99)
PSASK ;W !!?5,"Press RETURN to continue or '^' to exit: " R X:$S($D(DTIME):DTIME,1:99999) W !
 S PSML="INTRO" X PSMESS
 I $D(^PSF("PREVER")) X ^PSF("PREVER") I Y(1)>$P($T(PSINST+1),";",2) W !!,"You are attempting to install a version which is earlier than your",!,"current version, ",Y(1),", which should not be done." Q
 I $D(^PSRX) W ! S PSML="NOMERGE" X PSMESS,PSASK Q:X="^"
 G:'$D(^PS(50.5)) SKIPCL S PSML="NEWFORM" X PSMESS
CLASK R !!,"Replace classification file: N//",X Q:X="^"  S:X="" X="N" G:"YN"'[$E(X,1) CLASK
 I $E(X,1)="Y",$D(^DD("VERSION")),^DD("VERSION")<16.34 W !!,"YOU MUST HAVE AT LEAST VERSION 16.34 OF THE FILE MANAGER",!,"BEFORE THE REPLACEMENT CAN TAKE PLACE.",*7 Q
 I $E(X,1)="Y" K ^PS(50.5),^DIC(50.5),^DIC("B","FORMULARY",50.5) W !,"The old classification file has been deleted.",*7
TIME ;
 W !! S PSML="TIMETXT" X PSMESS I '$D(^PSF) S PSML="CONV" X PSMESS
 X PSASK
SKIPCL W !! D ^PSINIT Q
INTRO ; Introduction message and version display
 ;           VETERANS ADMINISTRATION OUTPATIENT PHARMACY
 ;
 ;>W ?15,"VERSION - ",$P($T(PSINST+1),";",2,99)
 ;<
NOMERGE ;Guidance on merging data
 ;After the pharmacy has been initially installed, it is usually not
 ;necessary or desirable to merge data, sent by the pharmacy INITs,
 ;with existing files.  Typically files will have been modified to
 ;meet the needs of your medical center and merging the data may
 ;recreate file entries that were removed deliberately during start-up.
 ;Unless the documentation states otherwise, the INITs simply provide
 ;'seed' data that is modified before going into production - typically
 ;a one-time procedure.  You will be asked if data should be merged later in
 ;in this process.
 ;<
NEWFORM ; Notify user of new formulary
 ;Previous releases of pharmacy established the file of AHFS classifications
 ;without some of the latest sub-divisions as outlined in the 1984 manual.
 ;This release contains a newly updated classification file that includes
 ;these new numbers as well as title corrections.  If you so choose, your
 ;present classification file can be erased and replaced with this new
 ;file.  The classification file is number 50.5 and is named FORMULARY.
 ;<
TIMETXT ;
 ;HOW MUCH TIME WILL THIS TAKE???
 ;
 ;1) The PSINITS will take approximately 15 minutes.
 ;
 ;2) Updating the expiration dates will take approximately 1 hour for each
 ;   90,000 prescriptions.  <== NECESSARY FOR VER 4.01
 ;
 ;3) Updating prescription costs, an option during installation, will also
 ;   take approximately 1 hour or each 90,000 prescriptions.
 ;
 ;<
CONV ;
 ;4) The conversion program will take approximately 1 hour for
 ;   each 90,000 prescriptions.  <== NECESSARY FOR VER 4.01
 ;<
