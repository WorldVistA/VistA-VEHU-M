ISIIMP ;ISI GROUP/MLS -- VistA DATA LOADER 1.0 ;6/26/12
 ;;1.0;;;Jun 26,2012;Build 30
 ;
 ; VistA Data Loader 1.0
 ;
 ; Copyright (C) 2012 Johns Hopkins University
 ;
 ; VistA Data Loader is provided by the Johns Hopkins University School of
 ; Nursing, and funded by the Department of Health and Human Services, Office
 ; of the National Coordinator for Health Information Technology under Award
 ; Number #1U24OC000013-01.
 ;
 ; All portions of this release that are modified from the original Freedom 
 ; of Information Act release provided by the Department of Veterans Affairs 
 ; is subject to the terms of the GNU Affero General Public License as published
 ; by the Free Software Foundation, either version 3 of the License, or any 
 ; later version.
 ;
 ; This program is distributed in the hope that it will be useful, but WITHOUT
 ; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 ; FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
 ; details.
 ;
 ; You should have received a copy of the GNU Affero General Public License 
 ; along with this program.  If not, see http://www.gnu.org/licenses/.
 ;
 ;
 ; DECLARATIONS
 ; -------------------------------
 ; This software package is NOT for use in any production or clinical setting.
 ; The software has not been designed, coded, or tested for use in any clinical
 ; or production setting.
 ;
 ; This should be considered a work in progress.  If folks are interested in 
 ; collaborating on a 2.0 version of the utility set should please contact 
 ; Mike Stark (starklogic@gmail.com) or ISI GROUP, LLC, Bethesda, MD.
 ;
 ;
 ; CREDITS
 ; ------------
 ; Some of the utilities used inside this package were first used inside the
 ; "CAMP MASTER" VistA training system used at the VA's VEHU conference 
 ; (available through FOIA). These are not "production" utilities and are 
 ; not properly attributed to their authors.  Most of them were coded by 
 ; by folks in their spare time out of generosity and dedication to the 
 ; VA's mission.  
 ; 
 ; Where it is not possible to properly give credit, I apologize.  Below is a
 ; list of routines borrowed from and their author initials.  I'm listing them
 ; here for proper credit --  all mistakes & bugs are my own (see DECLARATIONS
 ; AND CAVEATS above).
 ;
 ; LAB utility (LRZORD,LRZORD1,LRZOE,LRZOE2,LRZVER*): DALOI/CJS, NTEO/JFR
 ; VITAL utility (ZGMRVPOP):                          SLC/DAN
 ; PATIENT utility (ZVHDPT):                          DALOI/RM
 ; PROBLEM utility (ZVHGMPL):                         NTEO/JFR
 ; APPOINTMENTS utility (ZVHZSDM):                    SLC/DAN
 ;
 ;
 ; GENERAL OPERATION
 ; -----------------
 ; 1) Receive input list, MISC, from RPC ^ISIIMPR*.
 ; 2) Convert list, MISC, to usable array, ISIMISC, in utility ^ISIIMPU*.
 ; 3) Perform validation on array, ISIMISC, in ^ISIIMPU*.
 ; 4) Perform import via API in ^ISIIMP##.
 ;
 ;
 ; NAMESPACING  -- FUNCTION
 ; ------------------------
 ; ISIIMP*      -- All DATA Loader routines
 ; ISIIMPR*     -- RPC entry points
 ; ISIIMPU*     -- Utilities (merge, validation, etc.)
 ; ISIIMP##     -- API entry, create, and rpc handlers
 ; ISIIMPER     -- Error processing
 ; ISIIMPL*     -- Lab import spill over routines
 ;
 ;
 ; API ENTRY POINT ------  DESCRIPTION
 ; -------------------------------------------
 ; IMPORTPT^ISIIMP03 -----  Patient import API
 ; APPT^ISIIMP05     -----  Appointment Import API
 ; CREATE^ISIIMP07   -----  Problem Import API
 ; IMPORTVT^ISIIMP09 -----  Vitals Import API
 ; IMPRTALG^ISIIMP11 -----  Allergy Import API
 ; IMPRTLAB^ISIIMP13 -----  LABS Import API
 ; IMPRTNOT^ISIIMP15 -----  Notes Import API
 ; MEDS^ISIIMP17     -----  Med Import API
 ; CONS^ISIIMP19     -----  Consults Import API
 ; RADO^ISIIMP21     -----  RAD ORDERS Import API
 ; ENTRY^ISIIMPUA    -----  File fetch for external select lists
 ; ICD9^ISIIMPUA     -----  Fetches ICD description
 ;
 ;
 ; REMOTE PROCEDURE      ENTRY POINT         DESCRIPTION
 ; -----------------------------------------------------------------------
 ; ISI IMPORT ALLERGY    ALGMAKE^ISIIMPR2    Load allergy entries
 ; ISI IMPORT APPT       APPMAKE^ISIIMPR1    Load appt and encounters
 ; ISI IMPORT CONSULT    CONMAKE^ISIIMPR2    Creates and sign consults
 ; ISI IMPORT ICDFIND    ICD9GET^ISIIMPR2    Fetches ICD9 Descriptions
 ; ISI IMPORT LAB        LABMAKE^ISIIMPR2    Creates Lab tests
 ; ISI IMPORT MED        MEDMAKE^ISIIMPR2    Creates Medication orders
 ; ISI IMPORT NOTE       NOTEMAKE^ISIIMPR2   Creates TIU/Progress note entries
 ; ISI IMPORT PAT        PNTIMPORT^ISIIMPR1  Creates patient records
 ; ISI IMPORT PROB       PROBMAKE^ISIIMPR1   Creates Problem entries
 ; ISI IMPORT RAD ORDER  RADOMAKE^ISIIMPR1   Creates Radiology order entries
 ; ISI IMPORT TABLEFETCH TABLEGET^ISIIMPR2   Exports select tables 
 ;
 ;
 ; Validation entry  -- Description
 ; -----------------------------------
 ; VALIDATE^ISIIMPU1 -- Patient import validation
 ; VALAPT^ISIIMPU2   -- Appointment import validation
 ; VALPROB^ISIIMPU4  -- Problem import validation
 ; VALVITAL^ISIIMPU5 -- Vitals import validation
 ; VALALG^ISIIMPU6   -- Allergy import validation
 ; VALLAB^ISIIMPU7   -- Labs import validation
 ; VALNOTE^ISIIMPU8  -- Notes import validation
 ; VALMEDS^ISIIMPU9 -- Meds import validation
 ; VALCONS^ISIIMPUB -- Consult import validation
 ; VALRADO^ISIIMPUC -- Rad Orders Import validation
 ;
 ;
 ; Lab import spill over routines
 ; ------------------------------
 ; ISIIMPL1
 ; ISIIMPL2
 ; ISIIMPL3
 ; ISIIMPL4
 ;
 ;
 ; ISI PT IMPORT TEMPLATE (#9001)
 ; ------------------------------
 ; 9001,.01      NAME                          0;1 FREE TEXT (Required)
 ; 9001,1        TYPE                          0;2 POINTER TO TYPE OF PATIENT FILE (#391)
 ; 9001,2        NAME MASK                     0;3 FREE TEXT
 ; 9001,4        SSN MASK                      0;5 NUMBER
 ; 9001,5        SEX                           0;6 SET
 ; 9001,6        EARLIEST DATE OF BIRTH        0;7 DATE
 ; 9001,7        LATEST DATE OF BIRTH          0;8 DATE
 ; 9001,8        MARITAL STATUS                0;9 POINTER TO MARITAL STATUS FILE (#11)
 ; 9001,9        ZIP+4 MASK                    0;10 NUMBER
 ; 9001,10       PHONE NUMBER [RESIDENCE] MASK 0;11 NUMBER
 ; 9001,11       CITY                          0;12 FREE TEXT
 ; 9001,12       STATE                         0;13 POINTER TO STATE FILE (#5)
 ; 9001,13       VETERAN                       0;14 SET
 ; 9001,14       DFN_NAME                      0;4 SET
 ; 9001,15       EMPLOYMENT STATUS             0;15 SET
 ;
 Q
