.class public final Lbt192/auto/V3Codec;
.super Ljava/lang/Object;


# direct methods
.method public static call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .registers 5

    if-eqz p0, :cond_e

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, p1, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :cond_e
    const/4 v0, 0x0

    return-object v0
.end method

.method public static integer(Ljava/lang/Object;Ljava/lang/String;)I
    .registers 3

    invoke-static {p0, p1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public static isV5(Ljava/lang/Object;)Z
    .registers 5

    invoke-static {p0}, Lbt192/auto/V3Codec;->name(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2c

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "[\\s_-]+"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "LHDCV5"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2e

    const-string v1, "LHDCV5.0"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2e

    const-string v1, "LHDC5.0"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2e

    :cond_2c
    const/4 v0, 0x0

    return v0

    :cond_2e
    const/4 v0, 0x1

    return v0
.end method

.method public static name(Ljava/lang/Object;)Ljava/lang/String;
    .registers 7

    if-eqz p0, :cond_2d

    :try_start_2
    const-string v0, "getCodecName"

    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_a
    .catchall {:try_start_2 .. :try_end_a} :catchall_d

    if-eqz v0, :cond_e

    return-object v0

    :catchall_d
    move-exception v0

    :cond_e
    :try_start_e
    const-string v1, "getCodecType"

    invoke-static {p0, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    const/4 v4, 0x0

    const-string v5, "getCodecName"

    invoke-static {v2, v4, v5, v3}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_2b
    .catchall {:try_start_e .. :try_end_2b} :catchall_2c

    return-object v0

    :catchall_2c
    move-exception v0

    :cond_2d
    const/4 v0, 0x0

    return-object v0
.end method

.method private static oneValue(II)Z
    .registers 4

    if-lez p0, :cond_e

    and-int v0, p0, p1

    if-ne v0, p0, :cond_e

    add-int/lit8 v1, p0, -0x1

    and-int v0, p0, v1

    if-nez v0, :cond_e

    const/4 v0, 0x1

    return v0

    :cond_e
    const/4 v0, 0x0

    return v0
.end method

.method public static ready(Ljava/lang/Object;)Z
    .registers 4

    :try_start_0
    if-eqz p0, :cond_2d

    const-string v0, "getSampleRate"

    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    const/16 v1, 0x3f

    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->oneValue(II)Z

    move-result v2

    if-eqz v2, :cond_2d

    const-string v0, "getBitsPerSample"

    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x7

    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->oneValue(II)Z

    move-result v2

    if-eqz v2, :cond_2d

    const-string v0, "getChannelMode"

    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x3

    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->oneValue(II)Z

    move-result v2

    if-eqz v2, :cond_2d

    const/4 v0, 0x1
    :try_end_2b
    .catchall {:try_start_0 .. :try_end_2b} :catchall_2c

    return v0

    :catchall_2c
    move-exception v0

    :cond_2d
    const/4 v0, 0x0

    return v0
.end method

.method public static status(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;
    .registers 6

    const-class v0, Landroid/bluetooth/BluetoothA2dp;

    const-string v1, "getCodecStatus"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    invoke-static {v0, p0, v1, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static supports192(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;Ljava/lang/Object;)Z
    .registers 11

    :try_start_0
    invoke-static {p2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6e

    invoke-static {p0, p1}, Lbt192/auto/V3Codec;->status(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_6e

    const-string v1, "getCodecConfig"

    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6e

    const-string v1, "getCodecType"

    invoke-static {p2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v3

    invoke-static {v2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    if-ne v3, v4, :cond_6e

    const-string v1, "getCodecsSelectableCapabilities"

    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_6e

    instance-of v1, v0, [Ljava/lang/Object;

    if-eqz v1, :cond_36

    check-cast v0, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    :cond_36
    instance-of v1, v0, Ljava/lang/Iterable;

    if-eqz v1, :cond_6e

    check-cast v0, Ljava/lang/Iterable;

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_40
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6e

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_40

    invoke-static {v2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_40

    const-string v1, "getCodecType"

    invoke-static {v2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    if-ne v3, v4, :cond_40

    const-string v1, "getSampleRate"

    invoke-static {v2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v4

    sget v5, Landroid/bluetooth/BluetoothCodecConfig;->SAMPLE_RATE_192000:I

    if-eqz v5, :cond_6e

    and-int v6, v4, v5

    if-ne v6, v5, :cond_40

    const/4 v0, 0x1
    :try_end_69
    .catchall {:try_start_0 .. :try_end_69} :catchall_6a

    return v0

    :catchall_6a
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_6e
    const/4 v0, 0x0

    return v0
.end method
