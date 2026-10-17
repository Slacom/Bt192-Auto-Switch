.class public final Lbt192/auto/V3StatusStore;
.super Ljava/lang/Object;


# static fields
.field private static volatile historyFailure:Z

.field private static knownAssociated:Ljava/util/Set;

.field private static volatile message:Ljava/lang/String;

.field private static volatile readElapsed:J

.field private static volatile revision:I

.field private static volatile rows:Ljava/util/List;

.field private static sessionRecorded:Ljava/util/Set;

.field private static sessionSince:Ljava/util/Map;

.field private static sessionState:Ljava/util/Map;


# direct methods
.method private static acceptFirst(Ljava/lang/String;J)Z
    .registers 10

    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_3
    const/4 v4, 0x0

    invoke-static {}, Lbt192/auto/V3StatusStore;->ensureSessionLocked()V

    sget-object v1, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;

    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_17

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-eqz v2, :cond_3d

    :cond_17
    sget-object v3, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;

    invoke-interface {v3, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_29

    check-cast v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    cmp-long v2, p1, v5

    if-ltz v2, :cond_3d

    :cond_29
    sget-object v3, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;

    invoke-interface {v3, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_3d

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-interface {v3, p0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v4
    :try_end_3d
    .catchall {:try_start_3 .. :try_end_3d} :catchall_3f

    :cond_3d
    monitor-exit v0

    return v4

    :catchall_3f
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x1

    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    const/4 v4, 0x0

    return v4
.end method

.method public static associatedRows()Ljava/util/List;
    .registers 5

    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;

    move-result-object v0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_d
    :goto_d
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3c

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    const/4 v3, 0x2

    aget-object v3, v2, v3

    const-string v4, "1"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_38

    const/4 v3, 0x2

    aget-object v3, v2, v3

    const-string v4, "?"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_d

    const/4 v3, 0x0

    aget-object v3, v2, v3

    invoke-static {v3}, Lbt192/auto/V3StatusStore;->wasAssociated(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_d

    :cond_38
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_d

    :cond_3c
    return-object v1
.end method

.method private static changedLocked()V
    .registers 1

    sget v0, Lbt192/auto/V3StatusStore;->revision:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lbt192/auto/V3StatusStore;->revision:I

    return-void
.end method

.method public static connectionState(Ljava/lang/String;I)V
    .registers 7

    if-eqz p0, :cond_39

    const/4 v0, 0x2

    if-eq p1, v0, :cond_7

    if-nez p1, :cond_39

    :cond_7
    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_a
    invoke-static {}, Lbt192/auto/V3StatusStore;->ensureSessionLocked()V

    sget-object v1, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;

    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-eqz p1, :cond_1f

    if-eqz v2, :cond_1f

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-eq v2, p1, :cond_31

    :cond_1f
    sget-object v2, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;

    invoke-interface {v2, p0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    sget-object v3, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;

    invoke-interface {v3, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_31
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_38
    .catchall {:try_start_a .. :try_end_38} :catchall_3a

    monitor-exit v0

    :cond_39
    return-void

    :catchall_3a
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x1

    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    return-void
.end method

.method private static copy(Ljava/util/List;)Ljava/util/List;
    .registers 5

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    if-eqz p0, :cond_1f

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    invoke-virtual {v2}, [Ljava/lang/String;->clone()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_b

    :cond_1f
    return-object v0
.end method

.method public static devices()Ljava/util/List;
    .registers 1

    invoke-static {}, Lbt192/auto/V3StatusStore;->snapshotRows()Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/V3StatusStore;->copy(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method private static ensureSessionLocked()V
    .registers 1

    sget-object v0, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;

    if-nez v0, :cond_b

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lbt192/auto/V3StatusStore;->sessionState:Ljava/util/Map;

    :cond_b
    sget-object v0, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;

    if-nez v0, :cond_16

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lbt192/auto/V3StatusStore;->sessionSince:Ljava/util/Map;

    :cond_16
    sget-object v0, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;

    if-nez v0, :cond_21

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lbt192/auto/V3StatusStore;->sessionRecorded:Ljava/util/Set;

    :cond_21
    return-void
.end method

.method private static historyEligible(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 4

    :try_start_0
    const-string v0, "android.permission.BLUETOOTH_CONNECT"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_14

    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->macs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v0

    if-eqz v0, :cond_14

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0
    :try_end_12
    .catchall {:try_start_0 .. :try_end_12} :catchall_13

    return v0

    :catchall_13
    move-exception v0

    :cond_14
    const/4 v0, 0x0

    return v0
.end method

.method public static historyFailed(Z)V
    .registers 3

    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_3
    sput-boolean p0, Lbt192/auto/V3StatusStore;->historyFailure:Z

    invoke-static {}, Lbt192/auto/V3StatusStore;->changedLocked()V
    :try_end_8
    .catchall {:try_start_3 .. :try_end_8} :catchall_a

    monitor-exit v0

    return-void

    :catchall_a
    move-exception v1

    monitor-exit v0

    return-void
.end method

.method public static notice()Ljava/lang/String;
    .registers 3

    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_3
    invoke-static {}, Lbt192/auto/V3StatusStore;->noticeLocked()Ljava/lang/String;

    move-result-object v1
    :try_end_7
    .catchall {:try_start_3 .. :try_end_7} :catchall_9

    monitor-exit v0

    return-object v1

    :catchall_9
    move-exception v2

    monitor-exit v0

    const-string v1, "缓存状态读取失败，不能宣称实时"

    return-object v1
.end method

.method private static noticeLocked()Ljava/lang/String;
    .registers 3

    const-string v0, "最近读取结果，非持续实时监测。"

    sget-object v1, Lbt192/auto/V3StatusStore;->message:Ljava/lang/String;

    if-nez v1, :cond_8

    const-string v1, "尚未读取设备状态。"

    :cond_8
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-boolean v1, Lbt192/auto/V3StatusStore;->historyFailure:Z

    if-eqz v1, :cond_16

    const-string v1, "成功切换时间尚未保存。"

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_16
    return-object v0
.end method

.method public static recordWorker(Landroid/content/Context;Ljava/lang/String;ILbt192/auto/Worker;)V
    .registers 9

    iget-boolean v0, p3, Lbt192/auto/Worker;->success:Z

    if-eqz v0, :cond_e

    iget-object v0, p3, Lbt192/auto/Worker;->res:Ljava/lang/String;

    const-string v1, "已切换到 192kHz"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_f

    :cond_e
    return-void

    :cond_f
    invoke-static {p0, p1}, Lbt192/auto/V3StatusStore;->historyEligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_16

    return-void

    :cond_16
    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_19
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v1

    if-ne v1, p2, :cond_54

    iget-boolean v1, p3, Lbt192/auto/Worker;->success:Z

    if-eqz v1, :cond_54

    iget-object v1, p3, Lbt192/auto/Worker;->res:Ljava/lang/String;

    const-string v2, "已切换到 192kHz"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_54

    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->configured(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_54

    iget-wide v1, p3, Lbt192/auto/Worker;->appliedAtWall:J

    const-wide/16 v3, 0x0

    cmp-long v3, v1, v3

    if-lez v3, :cond_54

    iget-wide v3, p3, Lbt192/auto/Worker;->appliedAtElapsed:J

    const-wide/16 v1, 0x0

    cmp-long v3, v3, v1

    if-lez v3, :cond_54

    iget-wide v1, p3, Lbt192/auto/Worker;->appliedAtElapsed:J

    invoke-static {p1, v1, v2}, Lbt192/auto/V3StatusStore;->acceptFirst(Ljava/lang/String;J)Z

    move-result v1

    if-eqz v1, :cond_54

    iget-wide v1, p3, Lbt192/auto/Worker;->appliedAtWall:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {p0, p1, v1}, Lbt192/auto/V3StatusSampler;->enqueue(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Long;)V
    :try_end_54
    .catchall {:try_start_19 .. :try_end_54} :catchall_56

    :cond_54
    monitor-exit v0

    return-void

    :catchall_56
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x1

    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    return-void
.end method

.method private static rememberLocked(Ljava/util/List;)V
    .registers 7

    sget-object v0, Lbt192/auto/V3StatusStore;->knownAssociated:Ljava/util/Set;

    if-nez v0, :cond_b

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lbt192/auto/V3StatusStore;->knownAssociated:Ljava/util/Set;

    :cond_b
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_f
    :goto_f
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_39

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

    if-eqz v5, :cond_2d

    invoke-interface {v0, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_f

    :cond_2d
    const-string v4, "0"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_f

    invoke-interface {v0, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_f

    :cond_39
    return-void
.end method

.method public static replace(Ljava/util/List;Ljava/lang/String;)V
    .registers 7

    invoke-static {p0}, Lbt192/auto/V3StatusStore;->copy(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_b
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->rememberLocked(Ljava/util/List;)V

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    sput-object v1, Lbt192/auto/V3StatusStore;->rows:Ljava/util/List;

    sput-object p1, Lbt192/auto/V3StatusStore;->message:Ljava/lang/String;

    sput-wide v2, Lbt192/auto/V3StatusStore;->readElapsed:J

    invoke-static {}, Lbt192/auto/V3StatusStore;->changedLocked()V
    :try_end_1b
    .catchall {:try_start_b .. :try_end_1b} :catchall_1d

    monitor-exit v0

    return-void

    :catchall_1d
    move-exception v4

    monitor-exit v0

    throw v4
.end method

.method private static snapshotRows()Ljava/util/List;
    .registers 3

    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lbt192/auto/V3StatusStore;->rows:Ljava/util/List;
    :try_end_5
    .catchall {:try_start_3 .. :try_end_5} :catchall_7

    monitor-exit v0

    return-object v1

    :catchall_7
    move-exception v2

    monitor-exit v0

    throw v2
.end method

.method public static time(J)Ljava/lang/String;
    .registers 6

    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-lez v0, :cond_19

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    sget-object v2, Ljava/util/Locale;->CHINA:Ljava/util/Locale;

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1, p0, p1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v1}, Ljava/text/DateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_19
    const-string v0, "—"

    return-object v0
.end method

.method public static version()I
    .registers 1

    sget v0, Lbt192/auto/V3StatusStore;->revision:I

    return v0
.end method

.method private static wasAssociated(Ljava/lang/String;)Z
    .registers 4

    const-class v0, Lbt192/auto/V3StatusStore;

    monitor-enter v0

    :try_start_3
    const/4 v1, 0x0

    sget-object v2, Lbt192/auto/V3StatusStore;->knownAssociated:Ljava/util/Set;

    if-eqz v2, :cond_c

    invoke-interface {v2, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1
    :try_end_c
    .catchall {:try_start_3 .. :try_end_c} :catchall_e

    :cond_c
    monitor-exit v0

    return v1

    :catchall_e
    move-exception v2

    monitor-exit v0

    const/4 v1, 0x0

    return v1
.end method
