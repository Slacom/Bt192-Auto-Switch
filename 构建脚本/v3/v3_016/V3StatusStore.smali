.class public final Lbt192/auto/V3StatusStore;
.super Ljava/lang/Object;

# One immutable-by-ownership list, atomically swapped. Never expose its arrays.
.field private static volatile rows:Ljava/util/List;
.field private static volatile message:Ljava/lang/String;
.field private static volatile historyFailure:Z
.field private static volatile revision:I
.field private static volatile readElapsed:J

.field private static knownAssociated:Ljava/util/Set;
# First confirmed setter success per observed A2DP connection episode.
# Unknown snapshots and UI refresh never reset these ledgers.
.field private static sessionState:Ljava/util/Map;
.field private static sessionRecorded:Ljava/util/Set;
.field private static sessionSince:Ljava/util/Map;

.method public static version()I
    .locals 1
    sget v0, Lbt192/auto/V3StatusStore;->revision:I
    return v0
.end method

# Caller holds Store.class. Pure cache bookkeeping, no Cdm/Binder.
.method private static changedLocked()V
    .locals 1
    sget v0, Lbt192/auto/V3StatusStore;->revision:I
    add-int/lit8 v0, v0, 0x1
    sput v0, Lbt192/auto/V3StatusStore;->revision:I
    return-void
.end method

.method public static devices()Ljava/util/List;
    .locals 1
    invoke-static {}, Lbt192/auto/V3StatusStore;->snapshotRows()Ljava/util/List;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/V3StatusStore;->copy(Ljava/util/List;)Ljava/util/List;
    move-result-object v0
    return-object v0
.end method

.method private static snapshotRows()Ljava/util/List;
    .locals 3
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    sget-object v1, Lbt192/auto/V3StatusStore;->rows:Ljava/util/List;
    :try_end
    monitor-exit v0
    return-object v1
    :caught
    move-exception v2
    monitor-exit v0
    throw v2
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static copy(Ljava/util/List;)Ljava/util/List;
    .locals 4
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    if-eqz p0, :done
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, [Ljava/lang/String;
    invoke-virtual {v2}, [Ljava/lang/String;->clone()Ljava/lang/Object;
    move-result-object v3
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    goto :loop
    :done
    return-object v0
.end method

.method public static associatedRows()Ljava/util/List;
    .locals 5
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v0
    new-instance v1, Ljava/util/ArrayList;
    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, [Ljava/lang/String;
    const/4 v3, 0x2
    aget-object v3, v2, v3
    const-string v4, "1"
    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, :include
    const/4 v3, 0x2
    aget-object v3, v2, v3
    const-string v4, "?"
    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :loop
    const/4 v3, 0x0
    aget-object v3, v2, v3
    invoke-static {v3}, Lbt192/auto/V3StatusStore;->wasAssociated(Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, :loop
    :include
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    goto :loop
    :done
    return-object v1
.end method

.method public static notice()Ljava/lang/String;
    .locals 3
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    invoke-static {}, Lbt192/auto/V3StatusStore;->noticeLocked()Ljava/lang/String;
    move-result-object v1
    :try_end
    monitor-exit v0
    return-object v1
    :caught
    move-exception v2
    monitor-exit v0
    const-string v1, "缓存状态读取失败，不能宣称实时"
    return-object v1
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static noticeLocked()Ljava/lang/String;
    .locals 3
    const-string v0, "最近读取结果，非持续实时监测。"
    sget-object v1, Lbt192/auto/V3StatusStore;->message:Ljava/lang/String;
    if-nez v1, :ready
    const-string v1, "尚未读取设备状态。"
    :ready
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    sget-boolean v1, Lbt192/auto/V3StatusStore;->historyFailure:Z
    if-eqz v1, :done
    const-string v1, "成功切换时间尚未保存。"
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    :done
    return-object v0
.end method

.method public static historyFailed(Z)V
    .locals 2
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    sput-boolean p0, Lbt192/auto/V3StatusStore;->historyFailure:Z
    invoke-static {}, Lbt192/auto/V3StatusStore;->changedLocked()V
    :try_end
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static replace(Ljava/util/List;Ljava/lang/String;)V
    .locals 5
    # Prepare a privately-owned complete snapshot before lock/publication.
    invoke-static {p0}, Lbt192/auto/V3StatusStore;->copy(Ljava/util/List;)Ljava/util/List;
    move-result-object v1
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;
    move-result-object v1
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->rememberLocked(Ljava/util/List;)V
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v2
    sput-object v1, Lbt192/auto/V3StatusStore;->rows:Ljava/util/List;
    sput-object p1, Lbt192/auto/V3StatusStore;->message:Ljava/lang/String;
    sput-wide v2, Lbt192/auto/V3StatusStore;->readElapsed:J
    invoke-static {}, Lbt192/auto/V3StatusStore;->changedLocked()V
    :try_end
    monitor-exit v0
    return-void
    :caught
    move-exception v4
    monitor-exit v0
    throw v4
    .catchall {:try_start .. :try_end} :caught
.end method

# Remember provenance ONLY for display. flag '?' remains unknown and never
# grants enablement/authorization. A fresh explicit '0' forgets old association.
.method private static rememberLocked(Ljava/util/List;)V
    .locals 6
    sget-object v0, Lbt192/auto/V3StatusStore;->knownAssociated:Ljava/util/Set;
    if-nez v0, :ready
    new-instance v0, Ljava/util/HashSet;
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
    sput-object v0, Lbt192/auto/V3StatusStore;->knownAssociated:Ljava/util/Set;
    :ready
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, [Ljava/lang/String;
    const/4 v3, 0x0
    aget-object v3, v2, v3
    const/4 v4, 0x2
    aget-object v2, v2, v4
    const-string v4, "1"
    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :no
    invoke-interface {v0, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    goto :loop
    :no
    const-string v4, "0"
    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :loop
    invoke-interface {v0, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    goto :loop
    :done
    return-void
.end method

.method private static wasAssociated(Ljava/lang/String;)Z
    .locals 3
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    const/4 v1, 0x0
    sget-object v2, Lbt192/auto/V3StatusStore;->knownAssociated:Ljava/util/Set;
    if-eqz v2, :done
    invoke-interface {v2, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
    move-result v1
    :try_end
    :done
    monitor-exit v0
    return v1
    :caught
    move-exception v2
    monitor-exit v0
    const/4 v1, 0x0
    return v1
    .catchall {:try_start .. :try_end} :caught
.end method

# Background publishWorker calls this AFTER Runtime.publish has released Cdm.
# Qualify real permission/association outside monitors, then gate epoch/config
# atomically. No commit here; accepted wall history survives later epoch changes.
.method public static recordWorker(Landroid/content/Context;Ljava/lang/String;ILbt192/auto/Worker;)V
    .locals 5
    iget-boolean v0, p3, Lbt192/auto/Worker;->success:Z
    if-eqz v0, :early_return
    iget-object v0, p3, Lbt192/auto/Worker;->res:Ljava/lang/String;
    const-string v1, "已切换到 192kHz"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-nez v0, :qualify
    :early_return
    return-void
    :qualify
    invoke-static {p0, p1}, Lbt192/auto/V3StatusStore;->historyEligible(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v0
    if-nez v0, :lock
    return-void
    :lock
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I
    move-result v1
    if-ne v1, p2, :done
    iget-boolean v1, p3, Lbt192/auto/Worker;->success:Z
    if-eqz v1, :done
    iget-object v1, p3, Lbt192/auto/Worker;->res:Ljava/lang/String;
    const-string v2, "已切换到 192kHz"
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :done
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->configured(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :done
    iget-wide v1, p3, Lbt192/auto/Worker;->appliedAtWall:J
    const-wide/16 v3, 0x0
    cmp-long v3, v1, v3
    if-lez v3, :done
    iget-wide v3, p3, Lbt192/auto/Worker;->appliedAtElapsed:J
    const-wide/16 v1, 0x0
    cmp-long v3, v3, v1
    if-lez v3, :done
    iget-wide v1, p3, Lbt192/auto/Worker;->appliedAtElapsed:J
    invoke-static {p1, v1, v2}, Lbt192/auto/V3StatusStore;->acceptFirst(Ljava/lang/String;J)Z
    move-result v1
    if-eqz v1, :done
    iget-wide v1, p3, Lbt192/auto/Worker;->appliedAtWall:J
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;
    move-result-object v1
    invoke-static {p0, p1, v1}, Lbt192/auto/V3StatusSampler;->enqueue(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Long;)V
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x1
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static historyEligible(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 2
    :try_start
    const-string v0, "android.permission.BLUETOOTH_CONNECT"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :no
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->macs(Landroid/content/Context;)Ljava/util/Set;
    move-result-object v0
    if-eqz v0, :no
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
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

# User wall clock label, explicitly not monotonic timing. Dates prevent yesterday
# and previous boots being mistaken for today's reading.
# Caller holds Store.class; memory bookkeeping only, no preferences/Binder.
.method private static ensureSessionLocked()V
    .locals 1
    sget-object v0, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;
    if-nez v0, :state_ready
    new-instance v0, Ljava/util/HashMap;
    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V
    sput-object v0, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;
    :state_ready
    sget-object v0, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;
    if-nez v0, :since_ready
    new-instance v0, Ljava/util/HashMap;
    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V
    sput-object v0, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;
    :since_ready
    sget-object v0, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;
    if-nez v0, :done
    new-instance v0, Ljava/util/HashSet;
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
    sput-object v0, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;
    :done
    return-void
.end method

# Only actual A2DP STATE_CONNECTED/STATE_DISCONNECTED broadcasts call this.
# A missing proxy, unknown sample, pause, UI refresh and duplicate CONNECTED do not reset.
.method public static connectionState(Ljava/lang/String;I)V
    .locals 5
    if-eqz p0, :return
    const/4 v0, 0x2
    if-eq p1, v0, :valid
    if-nez p1, :return
    :valid
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    invoke-static {}, Lbt192/auto/V3StatusStore;->ensureSessionLocked()V
    sget-object v1, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;
    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    if-eqz p1, :reset
    if-eqz v2, :reset
    check-cast v2, Ljava/lang/Integer;
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I
    move-result v2
    if-eq v2, p1, :store
    :reset
    sget-object v2, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;
    invoke-interface {v2, p0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v3
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;
    move-result-object v2
    sget-object v3, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;
    invoke-interface {v3, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :store
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    invoke-interface {v1, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end
    monitor-exit v0
    :return
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x1
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Called only after existing real-success, epoch, authorization and positive-time gates.
# A confirmed success can establish an initially unknown connected episode.
.method private static acceptFirst(Ljava/lang/String;J)Z
    .locals 7
    const-class v0, Lbt192/auto/V3StatusStore;
    monitor-enter v0
    :try_start
    const/4 v4, 0x0
    invoke-static {}, Lbt192/auto/V3StatusStore;->ensureSessionLocked()V
    sget-object v1, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;
    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    if-eqz v2, :connected
    check-cast v2, Ljava/lang/Integer;
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I
    move-result v2
    if-eqz v2, :done
    :connected
    sget-object v3, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;
    invoke-interface {v3, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    if-eqz v2, :boundary_ready
    check-cast v2, Ljava/lang/Long;
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J
    move-result-wide v5
    cmp-long v2, p1, v5
    if-ltz v2, :done
    :boundary_ready
    sget-object v3, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;
    invoke-interface {v3, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :done
    const/4 v2, 0x2
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    invoke-interface {v1, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    invoke-interface {v3, p0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    move-result v4
    :try_end
    :done
    monitor-exit v0
    return v4
    :caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x1
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    const/4 v4, 0x0
    return v4
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static time(J)Ljava/lang/String;
    .locals 4
    const-wide/16 v0, 0x0
    cmp-long v0, p0, v0
    if-lez v0, :none
    new-instance v0, Ljava/text/SimpleDateFormat;
    const-string v1, "yyyy-MM-dd HH:mm:ss"
    sget-object v2, Ljava/util/Locale;->CHINA:Ljava/util/Locale;
    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V
    new-instance v1, Ljava/util/Date;
    invoke-direct {v1, p0, p1}, Ljava/util/Date;-><init>(J)V
    invoke-virtual {v0, v1}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;
    move-result-object v0
    return-object v0
    :none
    const-string v0, "—"
    return-object v0
.end method
