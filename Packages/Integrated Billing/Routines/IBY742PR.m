IBY742PR ;EDE/JRA - Pre-Installation for IB patch 727 ; 10/12/17 2:12 pm
 ;;2.0;INTEGRATED BILLING;**742**;21-MAR-94;Build 36
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN ; entry point
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x or FILE=8 indicating file 350.8 (IB ERROR)
 ; Y=ien to file
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
 Q OK
 ;
 ;Delete edited entries to insure clean install of new entries
 ;Delete obsolete entries.
DELOF   ; Delete included OF entries
 NEW FILE,DIK,LN,TAG,TAGLN,DATA,PCE,DA,Y
 F FILE=5:1:8 S DIK=$S(FILE=8:"^IBE(350.",1:"^IBA(364.")_FILE_"," D
 . F TAG="ENT"_FILE,"DEL"_FILE D
 .. F LN=2:1 S TAGLN=TAG_"+"_LN,DATA=$P($T(@TAGLN),";;",2) Q:DATA=""  D
 ... F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  D
 .... I FILE=8,$D(^IBE(350.8,DA,0)) D ^DIK
 .... Q:FILE=8
 .... I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 Q
 ;
 ; Example for ENT5, ENT6, ENT7, ENT8, DEL5, DEL6, DEL7, and DEL8:
 ;;^195^254^259^269^324^325^
 ; Note:  Must have beginning and ending up-carat
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 O.F. entries added:
 ;
 ;  
ENT5 ;O.F. entries in file 364.5 to be added
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 O.F. entries added:
 ;
 ;
ENT6 ;O.F. entries in file 364.6 to be added
 ;
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 O.F. entries added:
 ;
 ;
ENT7 ; O.F. entries in file 364.7 to be added
 ;
 ;;^216^161^162^163^472^194^1015^
 ;
 ; 216   GEN-1
 ; 161   GEN-2
 ; 162   GEN-3
 ; 163   GEN-4
 ; 472   GEN-5
 ; 194   GEN-6
 ; 1015  GEN-7
 ;
 ;-----------------------------------------------------------------------
 ; 350.8 O.F. entries added:
 ;
 ;
ENT8 ;O.F. entries in file 350.8 to be added
 ;
 ;;
 ;
 ;
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries deleted:
 ;
DEL5    ; remove O.F. entries in file 364.5 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries deleted:
 ;
DEL6    ; remove O.F. entries in file 364.6 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries deleted:
 ;
 ;
DEL7    ; remove O.F. entries in file 364.7 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 350.8 Entries deleted:
 ;
 ;
DEL8    ; remove entries from 350.8 (IB ERROR)
 ;
 ;;
 ;
