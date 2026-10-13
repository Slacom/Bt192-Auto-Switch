.class public final Lbt192/auto/V3Codec;
.super Ljava/lang/Object;

# Strict codec self-description and selectable remote capability checks.
# Negotiated current values must be known single values, not NONE/capability masks.
.method private static oneValue(II)Z
    .locals 2
    if-lez p0, :no
    and-int v0, p0, p1
    if-ne v0, p0, :no
    add-int/lit8 v1, p0, -0x1
    and-int v0, p0, v1
    if-nez v0, :no
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

# Local getters only: no profile request, setter, clock, defaults or persistence.
.method public static ready(Ljava/lang/Object;)Z
    .locals 3
    :try_start
    if-eqz p0, :no
    const-string v0, "getSampleRate"
    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v0
    const/16 v1, 0x3f
    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->oneValue(II)Z
    move-result v2
    if-eqz v2, :no
    const-string v0, "getBitsPerSample"
    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v0
    const/4 v1, 0x7
    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->oneValue(II)Z
    move-result v2
    if-eqz v2, :no
    const-string v0, "getChannelMode"
    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v0
    const/4 v1, 0x3
    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->oneValue(II)Z
    move-result v2
    if-eqz v2, :no
    const/4 v0, 0x1
    :try_end
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method
# No fallback to numeric ROM codec IDs, device names or local-only capabilities.
.method public static call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .locals 3
    if-eqz p0, :none
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;
    move-result-object v0
    const/4 v1, 0x0
    new-array v2, v1, [Ljava/lang/Object;
    invoke-static {v0, p0, p1, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v0
    return-object v0
    :none
    const/4 v0, 0x0
    return-object v0
.end method

.method public static integer(Ljava/lang/Object;Ljava/lang/String;)I
    .locals 1
    invoke-static {p0, p1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Ljava/lang/Integer;
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    move-result v0
    return v0
.end method

.method public static name(Ljava/lang/Object;)Ljava/lang/String;
    .locals 6
    if-eqz p0, :none
    :instance_start
    const-string v0, "getCodecName"
    invoke-static {p0, v0}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Ljava/lang/String;
    :instance_end
    if-eqz v0, :static_fallback
    return-object v0
    :instance_caught
    move-exception v0
    :static_fallback
    # Some ROMs expose only framework static getCodecName(int). Ask the
    # framework for its OWN canonical name; numeric IDs are NEVER assumed V5.
    :static_start
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
    :static_end
    return-object v0
    :static_caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:instance_start .. :instance_end} :instance_caught
    .catchall {:static_start .. :static_end} :static_caught
.end method

.method public static isV5(Ljava/lang/Object;)Z
    .locals 4
    invoke-static {p0}, Lbt192/auto/V3Codec;->name(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :no
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
    if-nez v2, :yes
    const-string v1, "LHDCV5.0"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :yes
    const-string v1, "LHDC5.0"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :yes
    :no
    const/4 v0, 0x0
    return v0
    :yes
    const/4 v0, 0x1
    return v0
.end method

.method public static status(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;
    .locals 4
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

# Input is the current configuration read by Worker. Revalidate type and name
# against a single newer status, then inspect selectable (not local) capabilities.
.method public static supports192(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;Ljava/lang/Object;)Z
    .locals 8
    :try_start
    invoke-static {p2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :no
    invoke-static {p0, p1}, Lbt192/auto/V3Codec;->status(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :no
    const-string v1, "getCodecConfig"
    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v2
    invoke-static {v2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :no
    const-string v1, "getCodecType"
    invoke-static {p2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v3
    invoke-static {v2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v4
    if-ne v3, v4, :no
    const-string v1, "getCodecsSelectableCapabilities"
    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :no
    instance-of v1, v0, [Ljava/lang/Object;
    if-eqz v1, :iterable
    check-cast v0, [Ljava/lang/Object;
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    :iterable
    instance-of v1, v0, Ljava/lang/Iterable;
    if-eqz v1, :no
    check-cast v0, Ljava/lang/Iterable;
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :no
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    if-eqz v2, :loop
    invoke-static {v2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :loop
    const-string v1, "getCodecType"
    invoke-static {v2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v4
    if-ne v3, v4, :loop
    const-string v1, "getSampleRate"
    invoke-static {v2, v1}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v4
    sget v5, Landroid/bluetooth/BluetoothCodecConfig;->SAMPLE_RATE_192000:I
    if-eqz v5, :no
    and-int v6, v4, v5
    if-ne v6, v5, :loop
    const/4 v0, 0x1
    :try_end
    return v0
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method
