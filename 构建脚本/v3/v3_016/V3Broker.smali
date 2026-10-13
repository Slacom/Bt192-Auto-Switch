.class public final Lbt192/auto/V3Broker;
.super Ljava/lang/Object;
.implements Landroid/bluetooth/BluetoothProfile$ServiceListener;

# Process-lifetime public-API owner, strict acquisition budget B=1.
# EVERY shared field below is owned by CdmTrigger.class (not V3Broker.class).
# No reset/close/shutdown API: Activity/service/automation/BT lifecycle is NOT
# the lifetime of this owner. Serial background Workers borrow, never close.
# Client process death releases the client; public API does NOT promise immediate
# removal of already-sent remote oneway requests or service-side callback state.
# state: 0 NEW, 1 REQUESTING, 2 PENDING, 3 READY, 4 PENDING_STALLED,
#        5 DISCONNECTED, 6 UNCERTAIN_STALLED, 7 CONFLICT_STALLED (terminal).
.field private static listener:Lbt192/auto/V3Broker;
.field private static appctx:Landroid/content/Context;
.field private static adapter:Landroid/bluetooth/BluetoothAdapter;
.field private static proxy:Landroid/bluetooth/BluetoothA2dp;
.field private static issued:Z
.field private static state:I
.field private static status:Ljava/lang/String;

.method private constructor <init>()V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

# Isolated allocation: no handler ever reads/compares an uninitialized object.
.method private static makeListener()Lbt192/auto/V3Broker;
    .locals 1
    new-instance v0, Lbt192/auto/V3Broker;
    invoke-direct {v0}, Lbt192/auto/V3Broker;-><init>()V
    return-object v0
.end method

# Caller holds CdmTrigger.class. Consume BEFORE context/adapter/allocation work.
# Failure anywhere here is fail-closed even if getProfileProxy was never reached.
.method private static prepareLocked(Landroid/content/Context;)Z
    .locals 2
    sget-boolean v0, Lbt192/auto/V3Broker;->issued:Z
    if-nez v0, :no
    const/4 v0, 0x1
    sput-boolean v0, Lbt192/auto/V3Broker;->issued:Z
    sput v0, Lbt192/auto/V3Broker;->state:I
    const-string v0, "正在申请系统蓝牙代理，尚未确认结果"
    sput-object v0, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    if-eqz p0, :bad_context
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    if-eqz v0, :bad_context
    instance-of v1, v0, Landroid/app/Activity;
    if-nez v1, :bad_context
    # Never fall back to the caller (which may be an Activity).
    sput-object v0, Lbt192/auto/V3Broker;->appctx:Landroid/content/Context;
    invoke-static {}, Lbt192/auto/V3Broker;->makeListener()Lbt192/auto/V3Broker;
    move-result-object v0
    sput-object v0, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;
    const/4 v0, 0x1
    return v0
    :bad_context
    const/4 v0, 0x6
    sput v0, Lbt192/auto/V3Broker;->state:I
    const-string v0, "无法取得应用级上下文，代理预算已锁定；请真正重启应用并检查无障碍"
    sput-object v0, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    goto :no
    :no
    const/4 v0, 0x0
    return v0
.end method

# Exactly one caller can receive true. Publication is complete before unlock.
.method private static take(Landroid/content/Context;)Z
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-static {p0}, Lbt192/auto/V3Broker;->prepareLocked(Landroid/content/Context;)Z
    move-result v1
    :try_end
    monitor-exit v0
    return v1
    :caught
    move-exception v2
    # No allocation result read, logging, close, retry or throwable cleanup.
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Broker;->issued:Z
    const/4 v1, 0x6
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理初始化失败，预算已锁定；请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    monitor-exit v0
    const/4 v1, 0x0
    return v1
    .catchall {:try_start .. :try_end} :caught
.end method

# Adapter acquisition may initialize framework/Binder state: do it outside the
# monitor, then publish only the returned handle under the shared monitor.
.method private static publishAdapter(Landroid/bluetooth/BluetoothAdapter;)Z
    .locals 2
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sput-object p0, Lbt192/auto/V3Broker;->adapter:Landroid/bluetooth/BluetoothAdapter;
    if-eqz p0, :missing
    const/4 v1, 0x1
    goto :exit
    :missing
    const/4 v1, 0x6
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "未取得系统蓝牙适配器，代理预算已锁定；请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    const/4 v1, 0x0
    :try_end
    :exit
    monitor-exit v0
    return v1
    :caught
    move-exception v1
    const/4 v1, 0x6
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙适配器发布失败，预算已锁定；请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    monitor-exit v0
    const/4 v1, 0x0
    return v1
    .catchall {:try_start .. :try_end} :caught
.end method

# Called once, only by the successful take() caller, WITHOUT the class monitor.
.method private static issue()V
    .locals 5
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :snapshot_start
    sget-object v2, Lbt192/auto/V3Broker;->appctx:Landroid/content/Context;
    sget-object v3, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;
    :snapshot_end
    monitor-exit v0
    :adapter_start
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;
    move-result-object v1
    :adapter_end
    invoke-static {v1}, Lbt192/auto/V3Broker;->publishAdapter(Landroid/bluetooth/BluetoothAdapter;)Z
    move-result v4
    if-eqz v4, :return
    :call_start
    const/4 v4, 0x2
    invoke-virtual {v1, v2, v3, v4}, Landroid/bluetooth/BluetoothAdapter;->getProfileProxy(Landroid/content/Context;Landroid/bluetooth/BluetoothProfile$ServiceListener;I)Z
    move-result v4
    :call_end
    goto :finish
    :call_caught
    move-exception v0
    const/4 v4, -0x1
    goto :finish
    :adapter_caught
    move-exception v0
    const/4 v4, -0x2
    :finish
    invoke-static {v4}, Lbt192/auto/V3Broker;->returned(I)V
    :return
    return-void
    :snapshot_caught
    move-exception v4
    const/4 v1, 0x6
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理申请准备失败，预算已锁定；请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    monitor-exit v0
    return-void
    .catchall {:snapshot_start .. :snapshot_end} :snapshot_caught
    .catchall {:adapter_start .. :adapter_end} :adapter_caught
    .catchall {:call_start .. :call_end} :call_caught
.end method

# true is NOT a callback guarantee. false/throw may already have published.
# Only REQUESTING can be changed: early READY or READY->DISCONNECTED wins.
.method private static returned(I)V
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget v1, Lbt192/auto/V3Broker;->state:I
    const/4 v2, 0x1
    if-ne v1, v2, :done
    if-lez p0, :uncertain
    const/4 v1, 0x2
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理等待回复，未确认结果"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    goto :notify
    :uncertain
    const/4 v1, 0x6
    sput v1, Lbt192/auto/V3Broker;->state:I
    if-ltz p0, :threw
    const-string v1, "系统蓝牙代理申请返回false，注册结果不确定；预算不恢复，请真正重启应用并检查无障碍"
    goto :set_status
    :threw
    const/4 v2, -0x2
    if-eq p0, v2, :adapter_failed
    const-string v1, "系统蓝牙代理申请发生异常，可能已注册；预算不恢复，请真正重启应用并检查无障碍"
    goto :set_status
    :adapter_failed
    const-string v1, "系统蓝牙适配器获取异常，尚未调用代理申请但预算已锁定；请真正重启应用并检查无障碍"
    :set_status
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    :notify
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    # Keep ownership and budget; no risky cleanup in an error handler.
    monitor-exit v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# ONLY background serial Worker callers. Never call from Activity/main thread.
# Binder call itself is synchronous public API and has no caller-controlled
# timeout; the 2s/job deadline bound applies to the subsequent monitor wait.
.method public static acquire(Landroid/content/Context;J)Landroid/bluetooth/BluetoothA2dp;
    .locals 1
    invoke-static {p0}, Lbt192/auto/V3Broker;->take(Landroid/content/Context;)Z
    move-result v0
    if-eqz v0, :await
    invoke-static {}, Lbt192/auto/V3Broker;->issue()V
    :await
    invoke-static {p1, p2}, Lbt192/auto/V3Broker;->awaitReady(J)Landroid/bluetooth/BluetoothA2dp;
    move-result-object v0
    return-object v0
.end method

# wait(J) releases the SAME monitor used by callbacks and Worker.valid/submit.
# Spurious wakeups do not extend the absolute end time. STALLED/CONFLICT return
# immediately; DISCONNECTED waits for this SAME wrapper/session, never re-get.
.method private static awaitReady(J)Landroid/bluetooth/BluetoothA2dp;
    .locals 8
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v1
    const-wide/16 v3, 0x7d0
    add-long/2addr v1, v3
    cmp-long v5, v1, p0
    if-lez v5, :loop
    move-wide v1, p0
    :loop
    sget v5, Lbt192/auto/V3Broker;->state:I
    const/4 v6, 0x3
    if-eq v5, v6, :ready
    if-eqz v5, :none
    const/4 v6, 0x4
    if-eq v5, v6, :none
    const/4 v6, 0x7
    if-eq v5, v6, :none
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v3
    sub-long v3, v1, v3
    const-wide/16 v6, 0x0
    cmp-long v5, v3, v6
    if-lez v5, :timeout
    invoke-virtual {v0, v3, v4}, Ljava/lang/Object;->wait(J)V
    goto :loop
    :timeout
    sget v5, Lbt192/auto/V3Broker;->state:I
    const/4 v6, 0x1
    if-eq v5, v6, :stall
    const/4 v6, 0x2
    if-ne v5, v6, :none
    :stall
    const/4 v5, 0x4
    sput v5, Lbt192/auto/V3Broker;->state:I
    const-string v5, "系统蓝牙代理等待回复，未确认结果；若长期不恢复请真正重启应用并检查无障碍"
    sput-object v5, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    :none
    const/4 v5, 0x0
    goto :exit
    :ready
    sget-object v5, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;
    :try_end
    :exit
    monitor-exit v0
    return-object v5
    :caught
    move-exception v5
    # wait reacquires the monitor before throwing; retain the physical session.
    sget v5, Lbt192/auto/V3Broker;->state:I
    const/4 v6, 0x1
    if-eq v5, v6, :interrupted_stall
    const/4 v6, 0x2
    if-ne v5, v6, :caught_exit
    :interrupted_stall
    const/4 v5, 0x4
    sput v5, Lbt192/auto/V3Broker;->state:I
    const-string v5, "系统蓝牙代理等待中断，未确认结果；预算不恢复，请真正重启应用并检查无障碍"
    sput-object v5, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    :caught_exit
    monitor-exit v0
    const/4 v5, 0x0
    return-object v5
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    const/4 v1, 0x0
    if-eqz p0, :done
    sget v2, Lbt192/auto/V3Broker;->state:I
    const/4 v1, 0x3
    if-ne v2, v1, :no
    sget-object v2, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;
    if-ne p0, v2, :no
    const/4 v1, 0x1
    goto :done
    :no
    const/4 v1, 0x0
    :try_end
    :done
    monitor-exit v0
    return v1
    :caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x0
    return v1
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static reason()Ljava/lang/String;
    .locals 2
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    if-nez v1, :done
    const-string v1, "系统蓝牙代理尚未申请"
    :try_end
    :done
    monitor-exit v0
    return-object v1
    :caught
    move-exception v1
    const-string v1, "系统蓝牙代理状态读取失败；请真正重启应用并检查无障碍"
    monitor-exit v0
    return-object v1
    .catchall {:try_start .. :try_end} :caught
.end method

# Callbacks only publish availability and request a fresh coordinator generation.
# READY + wake are atomic under the same lock; duplicates do not wake.
# Never invoke a setter/Worker/hidden API/close/re-get or infer earphone disconnect.
.method public onServiceConnected(ILandroid/bluetooth/BluetoothProfile;)V
    .locals 4
    const-class v0, Lbt192/auto/CdmTrigger;
    const/4 v3, 0x0
    monitor-enter v0
    :try_start
    const/4 v1, 0x2
    if-ne p1, v1, :done
    instance-of v1, p2, Landroid/bluetooth/BluetoothA2dp;
    if-eqz v1, :done
    sget-boolean v1, Lbt192/auto/V3Broker;->issued:Z
    if-eqz v1, :done
    sget-object v1, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;
    if-ne p0, v1, :done
    sget v2, Lbt192/auto/V3Broker;->state:I
    const/4 v1, 0x7
    if-eq v2, v1, :done
    sget-object v1, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;
    if-eqz v1, :accept
    if-ne v1, p2, :conflict
    const/4 v1, 0x3
    if-eq v2, v1, :notify
    :accept
    # Copy, not p0/p2 overwrite. Only a checked, initialized A2dp is retained.
    move-object v1, p2
    check-cast v1, Landroid/bluetooth/BluetoothA2dp;
    sput-object v1, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;
    const/4 v1, 0x3
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理已就绪；耳机连接与任务资格仍需实时检查"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    sget-object v3, Lbt192/auto/V3Broker;->appctx:Landroid/content/Context;
    if-eqz v3, :notify
    invoke-static {v3}, Lbt192/auto/CdmTrigger;->proxyReady(Landroid/content/Context;)V
    goto :notify
    :conflict
    const/4 v1, 0x7
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理返回不同对象，已安全停用；不再申请，请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    :notify
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end
    :done
    monitor-exit v0
    # Outside the broker/configuration lock. Does not acquire another proxy.
    if-eqz v3, :status_done
    invoke-static {v3}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    :status_done
    return-void
    :caught
    move-exception v1
    # Fail-closed; no potentially throwing cleanup/status formatting.
    const/4 v1, 0x7
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理回调处理失败，已安全停用；请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    monitor-exit v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onServiceDisconnected(I)V
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    const/4 v1, 0x2
    if-ne p1, v1, :done
    sget-boolean v1, Lbt192/auto/V3Broker;->issued:Z
    if-eqz v1, :done
    sget-object v1, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;
    if-ne p0, v1, :done
    sget v1, Lbt192/auto/V3Broker;->state:I
    const/4 v2, 0x3
    if-ne v1, v2, :done
    const/4 v1, 0x5
    sput v1, Lbt192/auto/V3Broker;->state:I
    const-string v1, "系统蓝牙代理服务断开，等待同会话恢复；不代表耳机断开，不再申请；若长期不恢复请真正重启应用并检查无障碍"
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    # Do not release budget or discard the registered wrapper.
    monitor-exit v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Read-only borrow. Never acquire/retry/close/notify/request from status refresh.
.method public static peek()Landroid/bluetooth/BluetoothA2dp;
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start_peek
    const/4 v1, 0x0
    sget v2, Lbt192/auto/V3Broker;->state:I
    const/4 v1, 0x3
    if-ne v2, v1, :peek_none
    sget-object v1, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;
    goto :peek_exit
    :peek_none
    const/4 v1, 0x0
    :try_end_peek
    :peek_exit
    monitor-exit v0
    return-object v1
    :peek_caught
    move-exception v2
    monitor-exit v0
    const/4 v1, 0x0
    return-object v1
    .catchall {:try_start_peek .. :try_end_peek} :peek_caught
.end method
