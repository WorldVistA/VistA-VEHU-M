EC725UPD ;ALB/GTS - EC National Procedure Update 9/8/97
 ;;2.0; EVENT CAPTURE ;**6**;8 May 96
 ;
 ;**  This patch is used as a Post-Init in a KIDS build to modify the
 ;**   the EC National Procedure file [^EC(725,]
 ;
EN ;** Add/inactivate/modify EC National Procedures
 ;**  The following code executes if file modifications exist
 ;
 D NAMECHG^EC725CH1 ;** Change name of National Procedures
 D ADDPROC^EC725CH2 ;** Add new National Procedures
 D INACPRC^EC725CHG ;** Inactivate National Procedures
 D CPTCHG^EC725CHG ;** Change CPT codes for National Procedures
 Q
