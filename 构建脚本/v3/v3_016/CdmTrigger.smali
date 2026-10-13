.class public Lbt192/auto/CdmTrigger;
.super Ljava/lang/Thread;

# This class monitor owns coordinator, connection/config epochs and submission.
# Exactly one coordinator thread; each Worker runs synchronously on that owner.
.field private static active:Lbt192/auto/CdmTrigger;
.field private static volatile epoch:I
.field private static states:Ljava/util/Map;
.field private static hint:Ljava/lang/String;
.field private final ctx:Landroid/content/Context;
.field private final gen:I
.field private final priority:Ljava/lang/String;
.field private pending:Z

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I
    move-result v0
    invoke-direct {p0, p1, v0}, Lbt192/auto/CdmTrigger;-><init>(Landroid/content/Context;I)V
    return-void
.end method

.method private constructor <init>(Landroid/content/Context;I)V
    .locals 1
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    if-nez v0, :ctx_ready
    move-object v0, p1
    :ctx_ready
    iput-object v0, p0, Lbt192/auto/CdmTrigger;->ctx:Landroid/content/Context;
    iput p2, p0, Lbt192/auto/CdmTrigger;->gen:I
    sget-object v0, Lbt192/auto/CdmTrigger;->hint:Ljava/lang/String;
    iput-object v0, p0, Lbt192/auto/CdmTrigger;->priority:Ljava/lang/String;
    const-string v0, "bt192-v3-serial"
    invoke-virtual {p0, v0}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V
    return-void
.end method

.method public static generation()I
    .locals 1
    sget v0, Lbt192/auto/CdmTrigger;->epoch:I
    return v0
.end method

.method public static error(Ljava/lang/Throwable;)V
    .locals 2
    :try_start
    const-string v0, "bt192-fast"
    const-string v1, "v3_013 error"
    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end
    return-void
    :caught
    move-exception v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Called under class monitor. Failed launch only rolls back its own owner.
.method private static launch(Landroid/content/Context;I)V
    .locals 3
    :allocation_start
    new-instance v0, Lbt192/auto/CdmTrigger;
    invoke-direct {v0, p0, p1}, Lbt192/auto/CdmTrigger;-><init>(Landroid/content/Context;I)V
    :allocation_end
    # v0 is definitely initialized before entering the publication/start handler.
    :start_begin
    sput-object v0, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    :start_end
    return-void
    :allocation_caught
    move-exception v1
    # Never compare a potentially uninitialized new-instance register here.
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    :start_caught
    move-exception v1
    sget-object v2, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    if-ne v2, v0, :report
    const/4 v2, 0x0
    sput-object v2, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    :report
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:allocation_start .. :allocation_end} :allocation_caught
    .catchall {:start_begin .. :start_end} :start_caught
.end method

.method public static request(Landroid/content/Context;)V
    .locals 4
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Targets;->enabledSet(Landroid/content/Context;)Ljava/util/Set;
    move-result-object v1
    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z
    move-result v1
    if-nez v1, :done
    sget-object v1, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    sget v2, Lbt192/auto/CdmTrigger;->epoch:I
    if-eqz v1, :launch
    iget v3, v1, Lbt192/auto/CdmTrigger;->gen:I
    if-eq v3, v2, :done
    const/4 v3, 0x1
    iput-boolean v3, v1, Lbt192/auto/CdmTrigger;->pending:Z
    goto :done
    :launch
    invoke-static {p0, v2}, Lbt192/auto/CdmTrigger;->launch(Landroid/content/Context;I)V
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Retained ABI for the old non-launcher AutoEntry; it never owns the new UI.
.method public static manual(Landroid/content/Context;)Z
    .locals 1
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    const/4 v0, 0x0
    return v0
.end method

.method public static invalidate()V
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget v1, Lbt192/auto/CdmTrigger;->epoch:I
    add-int/lit8 v1, v1, 0x1
    sput v1, Lbt192/auto/CdmTrigger;->epoch:I
    const/4 v1, 0x0
    sput-object v1, Lbt192/auto/CdmTrigger;->hint:Ljava/lang/String;
    sput-object v1, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;
    sget-object v2, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    if-eqz v2, :done
    iput-boolean v1, v2, Lbt192/auto/CdmTrigger;->pending:Z
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Sole caller: current-owner, device-bearing physical A2DP broadcast receiver.
# Observe ALL valid physical states independently of eligibility; only schedule
# nonzero target transitions after its current authorization/configuration gate.
# True0 fences + releases only that MAC, then coalesces work for enabled targets.
.method public static signalFor(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 5
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    if-eqz p1, :done
    invoke-static {p1}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :done
    if-ltz p2, :done
    const/4 v1, 0x3
    if-gt p2, v1, :done
    sget-object v1, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;
    if-nez v1, :states_ready
    new-instance v1, Ljava/util/HashMap;
    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V
    sput-object v1, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;
    :states_ready
    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    if-nez v2, :previous_ready
    # Reserve a map slot BEFORE any disconnect side effect. -1 means no valid
    # observation yet, never a consumed0. Replacing a String-key HashMap entry
    # later does not allocate a new entry under ordinary successfully-linked SDK.
    const/4 v3, -0x1
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :previous_ready
    check-cast v2, Ljava/lang/Integer;
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I
    move-result v3
    if-eq v3, p2, :done
    # Box before mutation/fence/release; allocation failure cannot publish0.
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    if-nez p2, :observe_nonzero
    # No eligibility/Binder lookup between actual0 and its required cleanup.
    sget v3, Lbt192/auto/CdmTrigger;->epoch:I
    add-int/lit8 v3, v3, 0x1
    sput v3, Lbt192/auto/CdmTrigger;->epoch:I
    # Ensure the old serial owner will recheck enabled targets after exiting,
    # even if the first request's enabledSet read transiently fails.
    sget-object v4, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    if-eqz v4, :clear_target
    const/4 v3, 0x1
    iput-boolean v3, v4, Lbt192/auto/CdmTrigger;->pending:Z
    :clear_target
    invoke-static {p1}, Lbt192/auto/V3Submission;->disconnected(Ljava/lang/String;)V
    # Publish0 only AFTER the guarded perMAC cleanup returns. Ledger poison is
    # still sticky if cleanup caught an uncertain mutation; this is not a heal.
    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    goto :done
    :observe_nonzero
    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v4
    if-eqz v4, :done
    const/4 v3, 0x2
    if-ne p2, v3, :no_priority
    sput-object p1, Lbt192/auto/CdmTrigger;->hint:Ljava/lang/String;
    :no_priority
    sget v3, Lbt192/auto/CdmTrigger;->epoch:I
    add-int/lit8 v3, v3, 0x1
    sput v3, Lbt192/auto/CdmTrigger;->epoch:I
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Called once for a broker transition to READY, under the same monitor as its
# state publication. Late readiness must schedule a NEW job even if an old same-
# epoch coordinator has not released yet; it never revives that old logical job.
.method public static proxyReady(Landroid/content/Context;)V
    .locals 2
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget v1, Lbt192/auto/CdmTrigger;->epoch:I
    add-int/lit8 v1, v1, 0x1
    sput v1, Lbt192/auto/CdmTrigger;->epoch:I
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Old ABI no longer accepts an anonymous state as a target identity.
.method public static signal(Landroid/content/Context;I)V
    .locals 0
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    return-void
.end method

.method private release()V
    .locals 4
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget-object v1, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    if-ne v1, p0, :done
    const/4 v1, 0x0
    sput-object v1, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;
    iget-boolean v1, p0, Lbt192/auto/CdmTrigger;->pending:Z
    if-eqz v1, :done
    sget v2, Lbt192/auto/CdmTrigger;->epoch:I
    iget v3, p0, Lbt192/auto/CdmTrigger;->gen:I
    if-eq v2, v3, :done
    iget-object v1, p0, Lbt192/auto/CdmTrigger;->ctx:Landroid/content/Context;
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static shouldRetry(Ljava/lang/String;)Z
    .locals 2
    if-eqz p0, :no
    const-string v0, "RETRY|PROXY_PENDING|UNKNOWN_NOT_CONFIRMED|CURRENT_CODEC_UNKNOWN|CURRENT_CODEC_NOT_READY|CURRENT_CODEC_NOT_CONFIRMED_V5|CURRENT_CODEC_CHANGED_NO_SUBMIT|192_UNSUPPORTED_OR_UNCONFIRMED"
    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z
    move-result v1
    return v1
    :no
    const/4 v0, 0x0
    return v0
.end method

.method public run()V
    .locals 12
    :try_start
    iget-object v1, p0, Lbt192/auto/CdmTrigger;->ctx:Landroid/content/Context;
    iget v3, p0, Lbt192/auto/CdmTrigger;->gen:I
    invoke-static {v1}, Lbt192/auto/V3Targets;->enabledSet(Landroid/content/Context;)Ljava/util/Set;
    move-result-object v6
    new-instance v7, Ljava/util/TreeSet;
    invoke-direct {v7, v6}, Ljava/util/TreeSet;-><init>(Ljava/util/Collection;)V
    new-instance v6, Ljava/util/LinkedHashSet;
    invoke-direct {v6}, Ljava/util/LinkedHashSet;-><init>()V
    iget-object v2, p0, Lbt192/auto/CdmTrigger;->priority:Ljava/lang/String;
    if-eqz v2, :add_rest
    invoke-virtual {v7, v2}, Ljava/util/TreeSet;->contains(Ljava/lang/Object;)Z
    move-result v8
    if-eqz v8, :add_rest
    invoke-virtual {v6, v2}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z
    :add_rest
    invoke-virtual {v6, v7}, Ljava/util/LinkedHashSet;->addAll(Ljava/util/Collection;)Z
    invoke-virtual {v6}, Ljava/util/LinkedHashSet;->iterator()Ljava/util/Iterator;
    move-result-object v6
    :target_loop
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I
    move-result v8
    if-ne v3, v8, :finished
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z
    move-result v8
    if-eqz v8, :finished
    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    invoke-static {v1, v2}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v8
    if-eqz v8, :target_loop
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v4
    const-wide/16 v8, 0x1f40
    add-long/2addr v4, v8
    const/4 v7, 0x0
    :retry
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I
    move-result v8
    if-ne v3, v8, :finished
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v8
    cmp-long v10, v8, v4
    if-gez v10, :target_loop
    new-instance v0, Lbt192/auto/Worker;
    # Contiguous registers: owner, appContext, immutable MAC, epoch, deadline(J).
    invoke-direct/range {v0 .. v5}, Lbt192/auto/Worker;-><init>(Landroid/content/Context;Ljava/lang/String;IJ)V
    invoke-virtual {v0}, Lbt192/auto/Worker;->run()V
    iget-object v11, v0, Lbt192/auto/Worker;->res:Ljava/lang/String;
    invoke-static {v1, v2, v3, v0}, Lbt192/auto/V3Runtime;->publishWorker(Landroid/content/Context;Ljava/lang/String;ILbt192/auto/Worker;)V
    iget-boolean v10, v0, Lbt192/auto/Worker;->success:Z
    if-nez v10, :target_loop
    invoke-static {v11}, Lbt192/auto/CdmTrigger;->shouldRetry(Ljava/lang/String;)Z
    move-result v10
    if-eqz v10, :target_loop
    :retryable
    add-int/lit8 v7, v7, 0x1
    const/4 v8, 0x4
    if-ge v7, v8, :target_loop
    const-wide/16 v8, 0xfa
    add-int/lit8 v10, v7, -0x1
    shl-long/2addr v8, v10
    invoke-static {v8, v9}, Ljava/lang/Thread;->sleep(J)V
    goto :retry
    :try_end
    :finished
    invoke-direct {p0}, Lbt192/auto/CdmTrigger;->release()V
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    invoke-direct {p0}, Lbt192/auto/CdmTrigger;->release()V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method
