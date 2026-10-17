.class public final Lbt192/auto/V3Targets;
.super Ljava/lang/Object;


# static fields
.field private static blocked:Ljava/util/Set;

.field private static ledgerBroken:Z


# direct methods
.method public static associated(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 6

    :try_start_0
    invoke-static {p1}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3f

    const-string v1, "companiondevice"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/companion/CompanionDeviceManager;

    if-eqz v1, :cond_3a

    invoke-virtual {v1}, Landroid/companion/CompanionDeviceManager;->getAssociations()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3a

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1a
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3a

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Ljava/lang/String;

    if-eqz v3, :cond_1a

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1a
    :try_end_34
    .catchall {:try_start_0 .. :try_end_34} :catchall_36

    const/4 v0, 0x1

    return v0

    :catchall_36
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_3a
    invoke-static {p0, p1}, Lbt192/auto/V3DirectAssociation;->associated(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0

    :cond_3f
    const/4 v0, 0x0

    return v0
.end method

.method private static block(Ljava/lang/String;)Z
    .registers 3

    :try_start_0
    invoke-static {}, Lbt192/auto/V3Targets;->ready()Z

    move-result v0

    if-eqz v0, :cond_14

    sget-object v0, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;

    invoke-interface {v0, p0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :try_end_b
    .catchall {:try_start_0 .. :try_end_b} :catchall_d

    const/4 v0, 0x1

    return v0

    :catchall_d
    move-exception v0

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Targets;->ledgerBroken:Z

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    :cond_14
    const/4 v0, 0x0

    return v0
.end method

.method public static configured(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 4

    invoke-static {p1}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_10

    :try_start_6
    invoke-static {p0}, Lbt192/auto/V3Targets;->enabledSet(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0
    :try_end_e
    .catchall {:try_start_6 .. :try_end_e} :catchall_f

    return v0

    :catchall_f
    move-exception v0

    :cond_10
    const/4 v0, 0x0

    return v0
.end method

.method public static eligible(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 5

    const/4 v1, 0x0

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_4
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->configured(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_e

    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->associated(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1
    :try_end_e
    .catchall {:try_start_4 .. :try_end_e} :catchall_10

    :cond_e
    monitor-exit v0

    return v1

    :catchall_10
    move-exception v2

    monitor-exit v0

    invoke-static {v2}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const/4 v1, 0x0

    return v1
.end method

.method public static enabledSet(Landroid/content/Context;)Ljava/util/Set;
    .registers 6

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_8
    invoke-static {}, Lbt192/auto/V3Targets;->ready()Z

    move-result v2

    if-eqz v2, :cond_23

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
    :try_end_23
    .catchall {:try_start_8 .. :try_end_23} :catchall_25

    :cond_23
    monitor-exit v0

    return-object v1

    :catchall_25
    move-exception v2

    monitor-exit v0

    invoke-static {v2}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-object v1
.end method

.method private static normalize(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    :try_start_0
    if-eqz p0, :cond_14

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_14
    :try_end_12
    .catchall {:try_start_0 .. :try_end_12} :catchall_13

    return-object v0

    :catchall_13
    move-exception v0

    :cond_14
    const/4 v0, 0x0

    return-object v0
.end method

.method private static normalizedCopy(Ljava/util/Set;)Ljava/util/HashSet;
    .registers 5

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    if-eqz p0, :cond_25

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_b
    :goto_b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_25

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Ljava/lang/String;

    if-eqz v3, :cond_b

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_b

    invoke-virtual {v0, v2}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_b

    :cond_25
    return-object v0
.end method

.method private static ready()Z
    .registers 2

    sget-boolean v0, Lbt192/auto/V3Targets;->ledgerBroken:Z

    if-nez v0, :cond_18

    :try_start_4
    sget-object v0, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;

    if-nez v0, :cond_f

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;
    :try_end_f
    .catchall {:try_start_4 .. :try_end_f} :catchall_11

    :cond_f
    const/4 v0, 0x1

    return v0

    :catchall_11
    move-exception v0

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Targets;->ledgerBroken:Z

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    :cond_18
    const/4 v0, 0x0

    return v0
.end method

.method public static setEnabled(Landroid/content/Context;Ljava/lang/String;Z)Z
    .registers 8

    invoke-static {p1}, Lbt192/auto/V3Targets;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_2f

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_a
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    if-nez v3, :cond_11

    move-object v3, p0

    :cond_11
    invoke-static {v3, v1, p2}, Lbt192/auto/V3Targets;->updateLocked(Landroid/content/Context;Ljava/lang/String;Z)Z

    move-result v2

    invoke-static {v3}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_18
    .catchall {:try_start_a .. :try_end_18} :catchall_1a

    monitor-exit v0

    return v2

    :catchall_1a
    move-exception v4

    :try_start_1b
    invoke-static {v1}, Lbt192/auto/V3Targets;->block(Ljava/lang/String;)Z

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_24
    .catchall {:try_start_1b .. :try_end_24} :catchall_2a

    monitor-exit v0

    invoke-static {v4}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const/4 v2, 0x0

    return v2

    :catchall_2a
    move-exception v4

    monitor-exit v0

    invoke-static {v4}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_2f
    const/4 v2, 0x0

    return v2
.end method

.method private static updateLocked(Landroid/content/Context;Ljava/lang/String;Z)Z
    .registers 12

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v8, 0x0

    const-string v4, "enabled_macs"

    :try_start_5
    invoke-static {}, Lbt192/auto/V3Targets;->ready()Z

    move-result v5

    if-eqz v5, :cond_6f

    if-eqz p2, :cond_13

    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->associated(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_6f

    :cond_13
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const/4 v6, 0x0

    invoke-interface {v0, v4, v6}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v2

    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    if-eqz v2, :cond_26

    invoke-virtual {v3, v2}, Ljava/util/HashSet;->addAll(Ljava/util/Collection;)Z

    :cond_26
    move-object v1, v3

    const/4 v8, 0x1

    invoke-static {v1}, Lbt192/auto/V3Targets;->normalizedCopy(Ljava/util/Set;)Ljava/util/HashSet;

    move-result-object v2

    if-eqz p2, :cond_32

    invoke-virtual {v2, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_35

    :cond_32
    invoke-virtual {v2, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    :goto_35
    invoke-static {p1}, Lbt192/auto/V3Targets;->block(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_56

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v4, v2}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v5

    if-eqz v5, :cond_56

    sget-object v6, Lbt192/auto/V3Targets;->blocked:Ljava/util/Set;

    invoke-interface {v6, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :try_end_50
    .catchall {:try_start_5 .. :try_end_50} :catchall_52

    const/4 v5, 0x1

    return v5

    :catchall_52
    move-exception v7

    invoke-static {v7}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_56
    invoke-static {p1}, Lbt192/auto/V3Targets;->block(Ljava/lang/String;)Z

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    if-eqz v0, :cond_6f

    if-eqz v8, :cond_6f

    :try_start_60
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_6a
    .catchall {:try_start_60 .. :try_end_6a} :catchall_6b

    goto :goto_6f

    :catchall_6b
    move-exception v7

    invoke-static {v7}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_6f
    :goto_6f
    const/4 v5, 0x0

    return v5
.end method
