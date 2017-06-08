DSICXPR0 ;DSS/SGM - RPCs/APIs FOR PARAMETERS ;01/09/2005 07:59
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 N I,X D HOME^%ZIS W @IOF
 F I=1:1 S X=$T(T+I) Q:X=""  W !,"   "_$P(X,";",3,99)
 Q
 ;
T ;
 ;;            COMMON TERMINOLOGY FOR ALL RPC ENTRY POINTS
 ;;=====================================================================
 ;;
 ;;There are GET type APIs and EDIT type APIS
 ;;  GET type - these only retrieve data and do not change any values
 ;; EDIT type - these may add/edit/delete values
 ;;
 ;;DESCRIPTION OF XPAR PARAMETERS
 ;;------------------------------
 ;;
 ;;Note: if an input parameter is listed as optional or required, then
 ;;      you need to look at the individual line tags to see which is it
 ;;
 ;;PARAMETER NAME - required
 ;; .01 field external value or IEN from file 8989.51 always required
 ;;---------------------------------------------------------------------
 ;;
 ;;ENTITY - optional or required
 ;;1. A person, place, or thing with has a configurable attribute.
 ;;
 ;;2. Only allowable entries are from 8989.518
 ;;
 ;;3. Default for GETs is ALL - default for EDITS is USR
 ;;
 ;;4. Allowable format for entity:
 ;;   a. Internal Fileman variable pointer syntax [nnn;;GLO(123,]
 ;;   b. 3 character abbreviations that can be used
 ;;      Defaults for some 3 char entities
 ;;           USR => DUZ
 ;;           DIV => DUZ(2)
 ;;           SYS => system domain
 ;;           PKG => package derived from the parameter name
 ;;
 ;;      2) Syntax => prefix.entryname   where entryname can be
 ;;         a) the external name for that entity
 ;;         b) "`"_<the internal entry number> for that entity
 ;;
 ;;      3) A list of entities delimited by '^'.  This list is processed
 ;;         in left to right order with the first existing instance
 ;;         being returned
 ;;
 ;;      4) 'ALL' - This uses the entity precedence defined by the
 ;;         PARAMETER DEFINITION file.
 ;;
 ;;5. See XPAR documentation for detailed explanation
 ;;
 ;;6. EXAMPLES:  USR.`1234  LOC.PULMONARY CLINIC  34;;DIC(4,  LOC.`57
 ;;---------------------------------------------------------------------
 ;;
 ;;INSTANCE - optional or required
 ;;1. An unique value assigned to entity/param combo
 ;;
 ;;2. XPAR ensures uniqueness in PARAMETER file (#8989.5) for an
 ;;   entity/param/instance combination only (does not include value)
 ;;
 ;;3. Optional for all single value parameters - default to 1
 ;;
 ;;4. Optional for ADD to a multiple instance parameter.  In this case,
 ;;   it is assumed that INSTANCE is numeric and will calculate the next
 ;;   INSTANCE value
 ;;---------------------------------------------------------------------
 ;;
 ;;VALUE
 ;;  A value for a specific entity/parameter/instance combination may or
 ;;  may not be required - see individual line tags
 ;;---------------------------------------------------------------------
 ;;
 ;;                     FORMAT OF INPUT PARAMETERS
 ;;=====================================================================
 ;;DATA - required - p1~p2~p3~p4~p5~p6
 ;; p1 - opt     - Entity
 ;; p2 - req     - Parameter
 ;; p3 - opt/req - Instance
 ;; p4 - opt/req - Value
 ;;                1. required for most calls
 ;;                2. optional for get type calls
 ;;                3. not used in delete call
 ;; p5 - opt/req - New Instance Value - only required for REPL call
 ;; p6 - opt     - GET1 format
 ;;                1. Only used in GET1 call
 ;;                2. Default to Q
 ;;                3. For GET and GETALL - ignore, always default to B
 ;;
 ;;FUN - opt     - default 0
 ;;                if +$G(FUN) then external function call vs RPC call
 ;;
 ;;Return value:
 ;;  RET - if successful, return 1
 ;;        if unsuccessful return -1^error message
 ;;        Some XPAR calls return 0 if the there were no problems but
 ;;        the lookup failed.
 ;;
 ;;                       DOCUMENTATION NOTES
 ;;=====================================================================
 ;;For GET type calls
 ;;---------------------------------------------------------------------
 ;; iI := internal instance     eI := external instance
 ;; iV := internal value        eV := external value
 ;;
 ;;Adding a new PARAMETER
 ;;---------------------------------------------------------------------
 ;;Only uniqueness of an entity/param/instance combination is ensured.
 ;;For multiple instance parameters, you could have several
 ;;entity/param/instance combos with the same value.  This may or may
 ;;not be acceptable for your particular usage.
 ;;
 ;;PASSING INTERNAL VALUES
 ;;---------------------------------------------------------------------
 ;;When setting up the DATA input parameter you must append the "`"
 ;;character to p1,p3,p4,p5 if you are passing an IEN.  This is only
 ;;relevant if that component is defined to be a type that has an
 ;;internal value which is different than the external value, e.g.,
 ;;Fileman pointer, set of codes, etc.
