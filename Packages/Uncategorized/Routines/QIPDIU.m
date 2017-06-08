QIPDIU ;WASH CIOFO/ERC-Delete files from inactive QUIC package ;6/15/99
 ;;4.1;QUALITY IMPROVEMENT CHECKLIST;**1**;OCT 16,1995
 ;
 ;Routine will run as a pre-install that will delete files
 ;#735-QUIC QUESTION, #735.1-QUIC SURVEY DATE, #736-QUIC SORT
 ;DATA, #738-QUALITY IMPROVEMENT CHECKLIST and #738.1-QUIC EXTRACT.
 ;Data and data dictionaries will be deleted.
 ;
 N DIU
 S DIU(0)="DT"
 F DIU="^QIP(735,","^QIP(735.1,","^QIP(736,","^QIP(738,","^QIP(738.1," D
 . D EN^DIU2
 Q
