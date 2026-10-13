.class public final Lbt192/auto/V3Targets;
.super Ljava/lang/Object;

# Access ONLY under CdmTrigger.class; never acquire V3Targets.class.
# A failed commit may already have published its new SP memory map.
.field private static blocked:Ljava/util/Set;
# Allocation/ledger failures poison all targets until process restart.
.field private static ledgerBroken:Z

.method private static normalize(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    :try_start
    if-eqz p0, :none
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :none
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Caller owns CdmTrigger.class. Lazy allocation avoids a throwing <clinit>.
.method private static ready()Z
    .locals 2
    sget-boolean v0, Lbt192/auto/V3Targets;->ledgerBroken:Z
    if-nez v0, :no
    :try_start
    sget-object v0, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;
    if-nez v0, :yes
    new-instance v0, Ljava/util/HashSet;
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
    sput-object v0, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;
    :try_end
    :yes
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Targets;->ledgerBroken:Z
    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static block(Ljava/lang/String;)Z
    .locals 2
    :try_start
    invoke-static {}, Lbt192/auto/V3Targets;->ready()Z
    move-result v0
    if-eqz v0, :no
    sget-object v0, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;
    invoke-interface {v0, p0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Targets;->ledgerBroken:Z
    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Copy, never mutate a SharedPreferences-owned Set. No blocked filtering here:
# transactions must preserve other configured (but currently blocked) targets.
.method private static normalizedCopy(Ljava/util/Set;)Ljava/util/HashSet;
    .locals 4
    new-instance v0, Ljava/util/HashSet;
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
    if-eqz p0, :done
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    instance-of v3, v2, Ljava/lang/String;
    if-eqz v3, :loop
    check-cast v2, Ljava/lang/String;
    invoke-static {v2}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :loop
    invoke-virtual {v0, v2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    goto :loop
    :done
    return-object v0
.end method

.method public static enabledSet(Landroid/content/Context;)Ljava/util/Set;
    .locals 5
    # Even the empty result is an independent mutable copy.
    new-instance v1, Ljava/util/HashSet;
    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-static {}, Lbt192/auto/V3Targets;->ready()Z
    move-result v2
    if-eqz v2, :done
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v2
    const-string v3, "enabled_macs"
    const/4 v4, 0x0
    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;
    move-result-object v2
    invoke-static {v2}, Lbt192/auto/V3Targets;->normalizedCopy(Ljava/util/Set;)Ljava/util/HashSet;
    move-result-object v2
    sget-object v3, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;
    invoke-virtual {v2, v3}, Ljava/util/HashSet;->removeAll(Ljava/util/Collection;)Z
    move-object v1, v2
    :try_end
    :done
    monitor-exit v0
    return-object v1
    :caught
    move-exception v2
    # v1 is still the original empty set on every throwing path above.
    monitor-exit v0
    invoke-static {v2}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-object v1
    .catchall {:try_start .. :try_end} :caught
.end method

# Configuration only; deliberately NOT an assertion of CDM authorization.
.method public static configured(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2
    invoke-static {p1}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :no
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Targets;->enabledSet(Landroid/content/Context;)Ljava/util/Set;
    move-result-object v1
    invoke-interface {v1, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
    move-result v0
    :try_end
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Keep legacy real-MAC associations first. On miss/error the API33 helper
# must successfully read this application's actual CDM list; prefs never grant.
.method public static associated(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 4
    :try_start
    invoke-static {p1}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :no
    const-string v1, "companiondevice"
    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/companion/CompanionDeviceManager;
    if-eqz v1, :fallback
    invoke-virtual {v1}, Landroid/companion/CompanionDeviceManager;->getAssociations()Ljava/util/List;
    move-result-object v1
    if-eqz v1, :fallback
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :fallback
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    instance-of v3, v2, Ljava/lang/String;
    if-eqz v3, :loop
    check-cast v2, Ljava/lang/String;
    invoke-static {v2}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :loop
    :try_end
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :fallback
    invoke-static {p0, p1}, Lbt192/auto/V3DirectAssociation;->associated(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v0
    return v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static eligible(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3
    const/4 v1, 0x0
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->configured(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :done
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->associated(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v1
    :try_end
    :done
    monitor-exit v0
    return v1
    :caught
    move-exception v2
    monitor-exit v0
    invoke-static {v2}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const/4 v1, 0x0
    return v1
    .catchall {:try_start .. :try_end} :caught
.end method

# Caller owns CdmTrigger.class; p1 has already been normalized.
.method private static updateLocked(Landroid/content/Context;Ljava/lang/String;Z)Z
    .locals 9
    const/4 v0, 0x0
    const/4 v1, 0x0
    const/4 v8, 0x0
    const-string v4, "enabled_macs"
    :try_start
    invoke-static {}, Lbt192/auto/V3Targets;->ready()Z
    move-result v5
    if-eqz v5, :failed
    if-eqz p2, :authorized
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->associated(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v5
    if-eqz v5, :failed
    :authorized
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    const/4 v6, 0x0
    invoke-interface {v0, v4, v6}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;
    move-result-object v2
    new-instance v3, Ljava/util/HashSet;
    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V
    if-eqz v2, :old_ready
    invoke-virtual {v3, v2}, Ljava/util/HashSet;->addAll(Ljava/util/Collection;)Z
    :old_ready
    move-object v1, v3
    const/4 v8, 0x1
    invoke-static {v1}, Lbt192/auto/V3Targets;->normalizedCopy(Ljava/util/Set;)Ljava/util/HashSet;
    move-result-object v2
    if-eqz p2, :remove
    invoke-virtual {v2, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    goto :changed
    :remove
    invoke-virtual {v2, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z
    :changed
    # Mark before publication; no memory-map true may escape a failed commit.
    invoke-static {p1}, Lbt192/auto/V3Targets;->block(Ljava/lang/String;)Z
    move-result v5
    if-eqz v5, :rollback
    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v3
    invoke-interface {v3, v4, v2}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v5
    if-eqz v5, :rollback
    sget-object v6, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;
    invoke-interface {v6, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :try_end
    const/4 v5, 0x1
    return v5
    :caught
    move-exception v7
    invoke-static {v7}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :rollback
    invoke-static {p1}, Lbt192/auto/V3Targets;->block(Ljava/lang/String;)Z
    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    if-eqz v0, :failed
    # Never restore a partial snapshot if its allocation/copy threw.
    if-eqz v8, :failed
    :rollback_start
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v3
    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :rollback_end
    goto :failed
    :rollback_caught
    move-exception v7
    invoke-static {v7}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :failed
    const/4 v5, 0x0
    return v5
    .catchall {:try_start .. :try_end} :caught
    .catchall {:rollback_start .. :rollback_end} :rollback_caught
.end method

.method public static setEnabled(Landroid/content/Context;Ljava/lang/String;Z)Z
    .locals 5
    invoke-static {p1}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    const/4 v2, 0x0
    if-eqz v1, :invalid
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v3
    if-nez v3, :context_ready
    move-object v3, p0
    :context_ready
    invoke-static {v3, v1, p2}, Lbt192/auto/V3Targets;->updateLocked(Landroid/content/Context;Ljava/lang/String;Z)Z
    move-result v2
    # Existing bounded active/pending trigger, never a thread per target.
    invoke-static {v3}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end
    monitor-exit v0
    return v2
    :caught
    move-exception v4
    # Unexpected wrapper failure must also fail closed and release the monitor.
    :cleanup_start
    invoke-static {v1}, Lbt192/auto/V3Targets;->block(Ljava/lang/String;)Z
    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :cleanup_end
    monitor-exit v0
    invoke-static {v4}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const/4 v2, 0x0
    return v2
    :cleanup_caught
    move-exception v4
    monitor-exit v0
    invoke-static {v4}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :invalid
    const/4 v2, 0x0
    return v2
    .catchall {:try_start .. :try_end} :caught
    .catchall {:cleanup_start .. :cleanup_end} :cleanup_caught
.end method
