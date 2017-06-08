ZZRPC   ;BIZ/PB - Utility to pull RPC Options and RPC Information
        ;;1.0;Nov 30, 2012
GETOPT  ;get a list of type B options
        K ^TMP("RPC")
        W !,"IEN,Option Name,Total RPC's Registered"
        S XX=0 F  S XX=$O(^DIC(19,XX)) Q:XX'>0  I $P(^DIC(19,XX,0),"^",4)="B" D
        .K RPCCNT S CNT=$G(CNT)+1
        .I $D(^DIC(19,XX,"RPC",0)) S RPCCNT=$P(^DIC(19,XX,"RPC",0),"^",3)
        .I $G(RPCCNT)>0 W !,XX,",",$P($G(^DIC(19,XX,0)),"^"),",",$G(RPCCNT)
        .S ^TMP("RPC",$J,CNT)=XX_U_$P($G(^DIC(19,XX,0)),"^")_U_$G(RPCCNT)
        K XX
        Q
GETRPC  ;Get a list of RPC calls for an Option
        K ^TMP("RPCDESC")
        R !,"ENTER OPTION IEN: ",IEN:DTIME
        S OPTNAME=$P(^DIC(19,IEN,0),"^")
        W !!,$G(OPTNAME),!!,"IEN,RPC NAME,LINETAG^ROUTINE,DESCRIPTION,INPUT,OUTPUT"
        Q:'$D(^DIC(19,IEN,"RPC",0))
        S XX=0 F  S XX=$O(^DIC(19,IEN,"RPC",XX)) Q:XX'>0  D
        .S RPC=$P(^DIC(19,IEN,"RPC",XX,0),"^"),CNT=$G(CNT)+1
        .Q:$G(RPC)'>0
        .S RPCNAME=$P($G(^XWB(8994,RPC,0)),"^"),TAG=$P($G(^XWB(8994,RPC,0)),"^",2),ROUTINE=$P($G(^XWB(8994,RPC,0)),"^",3)
        .S DESC=""
        .I $D(^XWB(8994,RPC,1,0)) D
        ..S YY=0 F  S YY=$O(^XWB(8994,RPC,1,YY)) Q:YY'>0  S DESC=$G(DESC)_" "_$G(^XWB(8994,RPC,1,YY,0))
        .S INPUT=""
        .I $D(^XWB(8994,RPC,2,0))  D
        ..S ZZ=0 F  S ZZ=$O(^XWB(8994,RPC,2,ZZ)) Q:ZZ'>0  S INPUT=$G(INPUT)_"^"_$P(^XWB(8994,RPC,2,ZZ,0),"^",1)
        .S OUTPUT=""
        .I $D(^XWB(8994,RPC,3,0)) D
        ..S TT=0 F  S TT=$O(^XWB(8994,RPC,3,TT)) Q:TT'>0  S OUTPUT=$G(OUTPUT)_"^"_$G(^XWB(8994,RPC,3,TT,0))
        .S OUTPUT=$TR(OUTPUT,",","")
        .W !,$G(RPCNAME),",",$G(TAG)_"^"_$G(ROUTINE),",",$TR($G(DESC),","," "),",",$G(INPUT),",",$G(OUTPUT)
        .S ^TMP("RPCDESC",CNT)=$G(RPC)_","_$G(RPCNAME)_","_$G(TAG)_"^"_$G(ROUTINE)_","_$TR($G(DESC),","," ")_","_"INPUT "_$G(INPUT)_","_"OUTPUT "_$G(OUTPUT)
        .K RPCNAME,TAG,ROUTINE,DESC,INPUT,OUTPUT
        K XX,IEN,CNT
        ;;$$GTF^%ZISH(global_ref,inc_subscr,path,filename)
        S PATH="C:\TEMP\",FILENAME=$TR(OPTNAME," ","_")_".CSV"
        S Y=$$GTF^%ZISH($NA(^TMP("RPCDESC",1)),2,PATH,FILENAME)
        W:Y=1 !,"SUCCESS"
        W:Y'=1 !,"FAILED TO CREATE FILE"
        
        K OPTNAME
        Q
GETALL  ;D GETOPT
        Q:'$D(^TMP("RPC",$J))
        S CNT=1
        S I=0 F  S I=$O(^TMP("RPC",$J,I)) Q:I'>0  D
        .S IEN=$P(^TMP("RPC",$J,I),"^"),OPTNAME=$P(^TMP("RPC",$J,I),"^",2)
        .W !,IEN,?10,OPTNAME
        .;S OPTNAME=$P(^DIC(19,IEN,0),"^")
        .W !!,$G(OPTNAME),!!,"IEN,RPC NAME,LINETAG^ROUTINE,DESCRIPTION,INPUT,OUTPUT"
        .Q:'$D(^DIC(19,IEN,"RPC",0))
        .S XX=0 F  S XX=$O(^DIC(19,IEN,"RPC",XX)) Q:XX'>0  D
        ..S RPC=$P(^DIC(19,IEN,"RPC",XX,0),"^")  ;,CNT=$G(CNT)+1
        ..Q:$G(RPC)'>0
        ..S RPCNAME=$P($G(^XWB(8994,RPC,0)),"^"),TAG=$P($G(^XWB(8994,RPC,0)),"^",2),ROUTINE=$P($G(^XWB(8994,RPC,0)),"^",3)
        ..S DESC=""
        ..I $D(^XWB(8994,RPC,1,0)) D
        ...S YY=0 F  S YY=$O(^XWB(8994,RPC,1,YY)) Q:YY'>0  S DESC=$G(DESC)_" "_$G(^XWB(8994,RPC,1,YY,0))
        ..S INPUT=""
        ..I $D(^XWB(8994,RPC,2,0))  D
        ...S ZZ=0 F  S ZZ=$O(^XWB(8994,RPC,2,ZZ)) Q:ZZ'>0  S INPUT=$G(INPUT)_"^"_$P(^XWB(8994,RPC,2,ZZ,0),"^",1)
        ..S OUTPUT=""
        ..I $D(^XWB(8994,RPC,3,0)) D
        ...S TT=0 F  S TT=$O(^XWB(8994,RPC,3,TT)) Q:TT'>0  S OUTPUT=$G(OUTPUT)_"^"_$G(^XWB(8994,RPC,3,TT,0))
        ..S OUTPUT=$TR(OUTPUT,",","")
        ..W !,$G(RPCNAME),",",$G(TAG)_"^"_$G(ROUTINE),",",$TR($G(DESC),","," "),",",$G(INPUT),",",$G(OUTPUT)
        ..S ^TMP("RPCDESC",CNT)=$G(RPC)_","_$G(RPCNAME)_","_$G(TAG)_"^"_$G(ROUTINE)_","_$TR($G(DESC),","," ")_","_"INPUT "_$G(INPUT)_","_"OUTPUT "_$G(OUTPUT),CNT=$G(CNT)+1
        ..K RPCNAME,TAG,ROUTINE,DESC,INPUT,OUTPUT
        K XX,IEN,CNT
        S XCNT=1 K ^TMP("RPCDESCA")
        S ZZ=0 F  S ZZ=$O(^TMP("RPCDESC",ZZ)) Q:ZZ'>0  S ^TMP("RPCDESCA",XCNT)=$G(^TMP("RPCDESC",ZZ)),XCNT=$G(XCNT)+1
        ;;$$GTF^%ZISH(global_ref,inc_subscr,path,filename)
        S PATH="C:\TEMP\",FILENAME="PHIL CPRS_ALL_RPC.CSV"  ;FILENAME=$TR(OPTNAME," ","_")_".CSV"
        S Y=$$GTF^%ZISH($NA(^TMP("RPCDESCA",1)),2,PATH,FILENAME)
        W:Y=1 !,"SUCCESS"
        W:Y'=1 !,"FAILED TO CREATE FILE"
        K OPTNAME
        Q
