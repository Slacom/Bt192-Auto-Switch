.class public final Lbt192/auto/V3Prefs;
.super Ljava/lang/Object;

.field private static uncertainMask:I

# Failure ledger prevents a failed/throwing disk commit from being mistaken for
# durable confirmation merely because Android already changed its memory map.
.method private static bit(Ljava/lang/String;)I
    .locals 2
    const-string v0, "battery_ack"
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :auto
    const/4 v0, 0x1
    return v0
    :auto
    const-string v0, "autostart_ack"
    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :none
    const/4 v0, 0x2
    return v0
    :none
    const/4 v0, 0x0
    return v0
.end method

.method public static declared-synchronized uncertain(Ljava/lang/String;)Z
    .locals 2
    invoke-static {p0}, Lbt192/auto/V3Prefs;->bit(Ljava/lang/String;)I
    move-result v0
    sget v1, Lbt192/auto/V3Prefs;->uncertainMask:I
    and-int/2addr v0, v1
    if-eqz v0, :no
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

.method private static mark(Ljava/lang/String;Z)V
    .locals 2
    invoke-static {p0}, Lbt192/auto/V3Prefs;->bit(Ljava/lang/String;)I
    move-result v0
    sget v1, Lbt192/auto/V3Prefs;->uncertainMask:I
    if-eqz p1, :clear
    or-int/2addr v1, v0
    goto :store
    :clear
    not-int v0, v0
    and-int/2addr v1, v0
    :store
    sput v1, Lbt192/auto/V3Prefs;->uncertainMask:I
    return-void
.end method

# Private flags are user acknowledgements, NOT permission grants or ROM assertions.
.method public static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 3
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    if-nez v0, :context_ready
    move-object v0, p0
    :context_ready
    const-string v1, "v3_settings"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    return-object v0
.end method

.method public static declared-synchronized acknowledged(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2
    invoke-static {p1}, Lbt192/auto/V3Prefs;->uncertain(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :try_start
    const/4 v0, 0x0
    return v0
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    const/4 v1, 0x0
    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v0
    :try_end
    return v0
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static declared-synchronized acknowledge(Landroid/content/Context;Ljava/lang/String;Z)Z
    .locals 4
    const/4 v2, 0x0
    const/4 v1, 0x0
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v1
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    invoke-interface {v2, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v0
    if-eqz v0, :rollback
    const/4 v3, 0x0
    invoke-static {p1, v3}, Lbt192/auto/V3Prefs;->mark(Ljava/lang/String;Z)V
    :try_end
    return v0
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :rollback
    const/4 v3, 0x1
    invoke-static {p1, v3}, Lbt192/auto/V3Prefs;->mark(Ljava/lang/String;Z)V
    # Android commits update the memory map even when disk write fails.
    # Restore the old value before refreshing; disk rollback is best effort.
    if-eqz v2, :failed
    :rollback_start
    invoke-interface {v2, p1, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :rollback_end
    goto :failed
    :rollback_caught
    move-exception v3
    invoke-static {v3}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :failed
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
    .catchall {:rollback_start .. :rollback_end} :rollback_caught
.end method

.method public static declared-synchronized resetAcknowledgements(Landroid/content/Context;)Z
    .locals 7
    const/4 v0, 0x0
    const/4 v1, 0x0
    const/4 v2, 0x0
    const-string v3, "battery_ack"
    const-string v4, "autostart_ack"
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v5
    const/4 v6, 0x0
    invoke-interface {v5, v3, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v1
    invoke-interface {v5, v4, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v2
    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0, v3, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0, v4, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v5
    if-eqz v5, :rollback
    const/4 v6, 0x0
    sput v6, Lbt192/auto/V3Prefs;->uncertainMask:I
    :try_end
    return v5
    :caught
    move-exception v5
    invoke-static {v5}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :rollback
    const/4 v6, 0x3
    sput v6, Lbt192/auto/V3Prefs;->uncertainMask:I
    if-eqz v0, :failed
    :rollback_start
    invoke-interface {v0, v3, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0, v4, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :rollback_end
    goto :failed
    :rollback_caught
    move-exception v5
    invoke-static {v5}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :failed
    const/4 v5, 0x0
    return v5
    .catchall {:try_start .. :try_end} :caught
    .catchall {:rollback_start .. :rollback_end} :rollback_caught
.end method

# A durable, positive request code, not a masked per-Activity counter. Plain
# Activity (min33) accepts full positive int codes; do not truncate to 14 bits.
# Recreated Activities/processes reserve a NEW code before any chooser launch.
.method public static declared-synchronized reserveAssociationToken(Landroid/content/Context;)I
    .locals 5
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "association_token_seq"
    const/4 v2, 0x0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    move-result v2
    if-ltz v2, :failed
    const v3, 0x7ffffffe
    if-ge v2, v3, :failed
    add-int/lit8 v2, v2, 0x1
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v3
    if-eqz v3, :failed
    :try_end
    return v2
    :caught
    move-exception v4
    invoke-static {v4}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :failed
    # No chooser is launched after false/exception; gaps are safe, reuse is not.
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method
