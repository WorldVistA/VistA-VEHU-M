KMPPS44A ;SP/JML - KMP*4*4 POST INSTALL ROUTINE ;11/1/2023
 ;;4.0;CAPACITY MANAGEMENT;**4**;3/1/2018;Build 36
 ;
 ;
GETNODEG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        W ""<H>""_##class(%SYS.System).GetNodeName(1)_""</H>""")
 D MDEF.Implementation.WriteLine("        Return $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
GETCONFIGG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetConfigGEvent"")")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("        D SITE^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        D CPF^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        D MON^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        #dim KMPITER As %Iterator.Array")
 D MDEF.Implementation.WriteLine("        #dim KMPITER2 As %Iterator.Array")
 D MDEF.Implementation.WriteLine("        W ""<H1>Site</H1>""")
 D MDEF.Implementation.WriteLine("        S KMPITER=KMPRET.Site.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KMPKEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        W ""<H1>CPF</H1>""")
 D MDEF.Implementation.WriteLine("        W ""<H2>CPF Startup</H2>""")
 D MDEF.Implementation.WriteLine("        S KMPITER=KMPRET.CPF.Startup.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KMPKEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        W ""<H2>CPF Mirror</H2>""")
 D MDEF.Implementation.WriteLine("        S KMPITER=KMPRET.CPF.MirrorMember.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KMPKEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        W ""<H2>CPF Config</H2>""")
 D MDEF.Implementation.WriteLine("        S KMPITER=KMPRET.CPF.Config.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KMPKEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        W ""<H1>Monitors</H1>""")
 D MDEF.Implementation.WriteLine("        S KMPITER=KMPRET.MonCFG.%GetIterator()")
 D MDEF.Implementation.WriteLine("        while KMPITER.%GetNext(.KMPKEY,.KMPLINE) {")
 D MDEF.Implementation.WriteLine("            W ""<H3>""_KMPLINE.Monitor_""</H3>""")
 D MDEF.Implementation.WriteLine("            S KMPITER2 = KMPLINE.%GetIterator()")
 D MDEF.Implementation.WriteLine("            while KMPITER2.%GetNext(.KMPKEY2, .KMPLINE2) {")
 D MDEF.Implementation.WriteLine("              I KMPKEY2'=""ApiKey"" W KMPKEY2_"": ""_KMPLINE2_""<BR>""")
 D MDEF.Implementation.WriteLine("            }")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetConfigGHandler"")")
 D MDEF.Implementation.WriteLine("        Return $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(kmperr)")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
GETHTTPG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetHttpMetricsGEvent"")")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("        D SITE^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        W ""<H1>Site</H1>""")
 D MDEF.Implementation.WriteLine("        S KMPITER = KMPRET.Site.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        S KMPMCHK=%request.Get(""MONTYPE"")")
 D MDEF.Implementation.WriteLine("        I KMPMCHK="""" S KMPMCHK=""ALL""")
 D MDEF.Implementation.WriteLine("        S KMPDATE=%request.Get(""DATE"")")
 D MDEF.Implementation.WriteLine("        I KMPDATE'="""" S KMPDCHK=""3""_KMPDATE")
 D MDEF.Implementation.WriteLine("        E  S KMPDCHK=""ALL""")
 D MDEF.Implementation.WriteLine("        S KMPSUB=""KMP""")
 D MDEF.Implementation.WriteLine("        F  S KMPSUB=$O(^XTMP(KMPSUB)) Q:$E(KMPSUB,1,3)'=""KMP""  D")
 D MDEF.Implementation.WriteLine("        .S KMPDAY=$P(KMPSUB,"" "",2)")
 D MDEF.Implementation.WriteLine("        .Q:(KMPDCHK'=KMPDAY)&&(KMPDCHK'=""ALL"")")
 D MDEF.Implementation.WriteLine("        .W ""<H2>""_$P(^XTMP(KMPSUB,0),""^"",3)_""</H2>""")
 D MDEF.Implementation.WriteLine("        .S KMPMTYP=0")
 D MDEF.Implementation.WriteLine("        .F  S KMPMTYP=$O(^XTMP(KMPSUB,KMPMTYP)) Q:KMPMTYP=""""  D")
 D MDEF.Implementation.WriteLine("        ..Q:(KMPMTYP'[KMPMCHK)&&(KMPMCHK'=""ALL"")")
 D MDEF.Implementation.WriteLine("        ..S KMPNODE=""""")
 D MDEF.Implementation.WriteLine("        ..F  S KMPNODE=$O(^XTMP(KMPSUB,KMPMTYP,""HTTP"",KMPNODE)) Q:KMPNODE=""""  D")
 D MDEF.Implementation.WriteLine("        ...W ""<H3>""_KMPMTYP_"" : ""_KMPNODE_""</H3>""")
 D MDEF.Implementation.WriteLine("        ...S KMPT=""""")
 D MDEF.Implementation.WriteLine("        ...F  S KMPT=$O(^XTMP(KMPSUB,KMPMTYP,""HTTP"",KMPNODE,KMPT)) Q:KMPT=""""  D")
 D MDEF.Implementation.WriteLine("        ....S KMPTIME=$ZT(KMPT)")
 D MDEF.Implementation.WriteLine("        ....S KMPDATA=^XTMP(KMPSUB,KMPMTYP,""HTTP"",KMPNODE,KMPT)")
 D MDEF.Implementation.WriteLine("        ....W ""<pre>""_KMPMTYP_"" - ""_KMPTIME_"" - ""_KMPDATA_""</pre>""")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetHttpMetricsGHandler"")")
 D MDEF.Implementation.WriteLine("        Return $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
KILLDATAG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetKillDataGEvent"")")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("        D SITE^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        W ""<H1>Site</H1>""")
 D MDEF.Implementation.WriteLine("        S KMPITER = KMPRET.Site.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        S KMPMCHK=%request.Get(""MONTYPE"")")
 D MDEF.Implementation.WriteLine("        S KMPMCHK=$REPLACE(KMPMCHK,"""""""","""")")
 D MDEF.Implementation.WriteLine("        I KMPMCHK="""" S KMPMCHK=""VBEM:VCSM:VETM:VHLM:VMCM:VSTM:VTCM""")
 D MDEF.Implementation.WriteLine("        S KMPL=$L(KMPMCHK,"":"")")
 D MDEF.Implementation.WriteLine("        F KMPI=1:1:KMPL D")
 D MDEF.Implementation.WriteLine("        .S KMPMTYP=$P(KMPMCHK,"":"",KMPI)")
 D MDEF.Implementation.WriteLine("        .K ^KMPTMP(""KMPV"",KMPMTYP)")
 D MDEF.Implementation.WriteLine("        .W ""<BR>Data deleted: "",KMPMTYP")
 D MDEF.Implementation.WriteLine("        .D STOPMON^KMPVCBG(KMPMTYP,1,0)")
 D MDEF.Implementation.WriteLine("        .W ""<BR>Monitor stopped: "",KMPMTYP")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetKillDataGHandler"")")
 D MDEF.Implementation.WriteLine("        Return $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
STARTMONG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetStartMonitorGEvent"")")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("        D SITE^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        W ""<H1>Site</H1>""")
 D MDEF.Implementation.WriteLine("        S KMPITER = KMPRET.Site.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        S KMPMCHK=%request.Get(""MONTYPE"")")
 D MDEF.Implementation.WriteLine("        I KMPMCHK=""ALL"" S KMPMCHK=""VBEM:VCSM:VETM:VHLM:VMCM:VSTM:VTCM""")
 D MDEF.Implementation.WriteLine("        F KMPI=1:1:$L(KMPMCHK,"":"") D")
 D MDEF.Implementation.WriteLine("        .S KMPQUIT=0")
 D MDEF.Implementation.WriteLine("        .S KMPVMKEY=$P(KMPMCHK,"":"",KMPI)")
 D MDEF.Implementation.WriteLine("        .W ""<H3>""_KMPVMKEY_""</H3>""")
 D MDEF.Implementation.WriteLine("        .I '$D(^KMPV(8969,""B"",KMPVMKEY)) D")
 D MDEF.Implementation.WriteLine("        ..W ""&nbsp;&nbsp;&nbsp;&nbsp;""_KMPVMKEY_"" not a valid monitor""")
 D MDEF.Implementation.WriteLine("        ..S KMPQUIT=1")
 D MDEF.Implementation.WriteLine("        .S KMPVROUT=$$GETVAL^KMPVCCFG(KMPVMKEY,""CACHE DAILY TASK"",8969)")
 D MDEF.Implementation.WriteLine("        .I KMPVROUT="""" D")
 D MDEF.Implementation.WriteLine("        ..W ""&nbsp;&nbsp;&nbsp;&nbsp;""_KMPVMKEY_"" has no run routine""")
 D MDEF.Implementation.WriteLine("        ..S KMPQUIT=1")
 D MDEF.Implementation.WriteLine("        .I $$ROUTCHK^KMPVCBG(KMPVROUT)=1 D")
 D MDEF.Implementation.WriteLine("        ..W ""&nbsp;&nbsp;&nbsp;&nbsp;""_KMPVMKEY_"" already running""")
 D MDEF.Implementation.WriteLine("        ..S KMPQUIT=1")
 D MDEF.Implementation.WriteLine("        .I KMPQUIT=0 D")
 D MDEF.Implementation.WriteLine("        ..D STARTMON^KMPVCBG(KMPVMKEY,1,1)")
 D MDEF.Implementation.WriteLine("        ..S KMPVTASK=""RUN^""_KMPVROUT J @KMPVTASK")
 D MDEF.Implementation.WriteLine("        ..W !,""&nbsp;&nbsp;&nbsp;&nbsp;""_KMPVMKEY_"" Started""")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetStartMonitorGHandler"")")
 D MDEF.Implementation.WriteLine("        RETURN $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
GETRETRYDATAG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetRetryDataGEvent"")")
 D MDEF.Implementation.WriteLine("        S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("        D SITE^KMPUTLW(KMPRET)")
 D MDEF.Implementation.WriteLine("        W ""<H1>Site</H1>""")
 D MDEF.Implementation.WriteLine("        S KMPITER = KMPRET.Site.%GetIterator()")
 D MDEF.Implementation.WriteLine("        WHILE KMPITER.%GetNext(.KEY,.KMPVALUE) {")
 D MDEF.Implementation.WriteLine("          W KEY_"": ""_KMPVALUE_""<BR>""")
 D MDEF.Implementation.WriteLine("        }")
 D MDEF.Implementation.WriteLine("        S KMPMCHK=%request.Get(""MONTYPE"")")
 D MDEF.Implementation.WriteLine("        I KMPMCHK=""ALL"" S KMPMCHK=""VBEM:VCSM:VETM:VHLM:VMCM:VSTM:VTCM""")
 D MDEF.Implementation.WriteLine("        F KMPI=1:1:$L(KMPMCHK,"":"") D")
 D MDEF.Implementation.WriteLine("        .S KMPVMKEY=$P(KMPMCHK,"":"",KMPI)")
 D MDEF.Implementation.WriteLine("        .W ""<H3>Monitor:""_KMPVMKEY_""</H3>""")
 D MDEF.Implementation.WriteLine("        .S KMPVNODE=""""")
 D MDEF.Implementation.WriteLine("        .F  S KMPVNODE=$O(^KMPTMP(""KMPV"",KMPVMKEY,""RETRY"",KMPVNODE)) Q:KMPVNODE=""""  D")
 D MDEF.Implementation.WriteLine("        ..S KMPDAY=""""")
 D MDEF.Implementation.WriteLine("        ..F  S KMPDAY=$O(^KMPTMP(""KMPV"",KMPVMKEY,""RETRY"",KMPVNODE,KMPDAY)) Q:KMPDAY=""""  D")
 D MDEF.Implementation.WriteLine("        ...S HOROLOG=""""")
 D MDEF.Implementation.WriteLine("        ...F  S HOROLOG=$O(^KMPTMP(""KMPV"",KMPVMKEY,""RETRY"",KMPVNODE,KMPDAY,HOROLOG)) Q:HOROLOG=""""  D")
 D MDEF.Implementation.WriteLine("        ....S KMPJDAY=$ZD(KMPDAY)")
 D MDEF.Implementation.WriteLine("        ....S KMPJTIME=$ZT($P(HOROLOG,"","",2))")
 D MDEF.Implementation.WriteLine("        ....S KMPDATA=KMPVMKEY_""^""_KMPVNODE_""^""_KMPJDAY_""^""_KMPJTIME")
 D MDEF.Implementation.WriteLine("        ....W ""<BR>Data:""_KMPDATA")
 D MDEF.Implementation.WriteLine("        D RU^%ZOSVKR(""KMP GetRetryDataGHandler"")")
 D MDEF.Implementation.WriteLine("        RETURN $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 Q
