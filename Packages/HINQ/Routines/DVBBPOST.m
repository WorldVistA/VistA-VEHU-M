DVBBPOST ;ALB/JLU;post init to re index ARQ;9/2/93
 ;;v2.5;AMIE;**4**;09/02/93
EN ;reindex the ARQ cross reference.
 W !!!!," Starting to re-index the ""ARQ"" cross reference in the 2507 Exam file"
 S DIK="^DVB(396.4,",DIK(1)=".03^ARQ"
 D ENALL^DIK
 W !!," Re-indexing has finished!!!!"
 K DIK
 Q
