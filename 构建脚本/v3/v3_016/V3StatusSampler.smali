.class public final Lbt192/auto/V3StatusSampler;
.super Ljava/lang/Thread;

# Exactly one physical thread per process. Idle wait has NO periodic Binder work.
# Queue lock is Sampler.class: never call Cdm/Binder/Store while holding it.
# Caller may hold Cdm; the reverse order is forbidden. Context is app-only.
.field private static owner:Lbt192/auto/V3StatusSampler;
.field private static pending:Z
.field private static history:Ljava/util/Map;
.field private final ctx:Landroid/content/Context;
.field private epoch:I
.field private permission:Z
.field private assoc:Ljava/util/Set;
.field private bonded:Ljava/util/Map;
.field private connected:Ljava/util/Map;
.field private proxy:Landroid/bluetooth/BluetoothA2dp;
.field private prefs:Landroid/content/SharedPreferences;

.method private constructor <init>(Landroid/content/Context;)V
    .locals 1
    const-string v0, "v3-status-read-only"
    invoke-direct {p0, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V
    iput-object p1, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;
    return-void
.end method

# Isolate NEW: its handler must never compare an uninitialized object.
.method private static make(Landroid/content/Context;)Lbt192/auto/V3StatusSampler;
    .locals 1
    new-instance v0, Lbt192/auto/V3StatusSampler;
    invoke-direct {v0, p0}, Lbt192/auto/V3StatusSampler;-><init>(Landroid/content/Context;)V
    return-object v0
.end method

.method public static request(Landroid/content/Context;)V
    .locals 3
    :context_start
    if-eqz p0, :return
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v1
    if-eqz v1, :return
    instance-of v2, v1, Landroid/app/Activity;
    if-nez v2, :return
    :context_end
    const-class v0, Lbt192/auto/V3StatusSampler;
    monitor-enter v0
    :queue_start
    const/4 v2, 0x1
    sput-boolean v2, Lbt192/auto/V3StatusSampler;->pending:Z
    sget-object v2, Lbt192/auto/V3StatusSampler;->owner:Lbt192/auto/V3StatusSampler;
    if-nez v2, :wake
    # Construction failure leaves owner null; the next request can retry.
    invoke-static {v1}, Lbt192/auto/V3StatusSampler;->make(Landroid/content/Context;)Lbt192/auto/V3StatusSampler;
    move-result-object v2
    sput-object v2, Lbt192/auto/V3StatusSampler;->owner:Lbt192/auto/V3StatusSampler;
    :start_begin
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V
    :start_end
    :wake
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :queue_end
    monitor-exit v0
    :return
    return-void
    :start_caught
    move-exception v1
    # Thread.start could throw after native start. Only provably NEW releases
    # ownership; never free a running owner and create a second physical thread.
    :state_start
    invoke-virtual {v2}, Ljava/lang/Thread;->getState()Ljava/lang/Thread$State;
    move-result-object v1
    :state_end
    sget-object v2, Ljava/lang/Thread$State;->NEW:Ljava/lang/Thread$State;
    if-ne v1, v2, :failed_exit
    const/4 v1, 0x0
    sput-object v1, Lbt192/auto/V3StatusSampler;->owner:Lbt192/auto/V3StatusSampler;
    :failed_exit
    monitor-exit v0
    const/4 v1, 0x1
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    return-void
    :queue_caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x1
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    return-void
    :context_caught
    move-exception v0
    return-void
    .catchall {:state_start .. :state_end} :queue_caught
    .catchall {:context_start .. :context_end} :context_caught
    .catchall {:queue_start .. :start_begin} :queue_caught
    .catchall {:start_begin .. :start_end} :start_caught
    .catchall {:start_end .. :queue_end} :queue_caught
.end method

.method public static enqueue(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Long;)V
    .locals 3
    const-class v0, Lbt192/auto/V3StatusSampler;
    monitor-enter v0
    :try_start
    sget-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;
    if-nez v1, :ready
    new-instance v1, Ljava/util/HashMap;
    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V
    sput-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;
    :ready
    invoke-interface {v1, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end
    monitor-exit v0
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x1
    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# One bounded coalescing pending bit, not a per-event job/thread queue.
.method private static awaitWork()Ljava/util/Map;
    .locals 3
    const-class v0, Lbt192/auto/V3StatusSampler;
    monitor-enter v0
    :try_start
    :wait
    sget-boolean v1, Lbt192/auto/V3StatusSampler;->pending:Z
    if-nez v1, :take
    invoke-virtual {v0}, Ljava/lang/Object;->wait()V
    goto :wait
    :take
    const/4 v1, 0x0
    sput-boolean v1, Lbt192/auto/V3StatusSampler;->pending:Z
    sget-object v2, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;
    sput-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;
    if-nez v2, :taken
    new-instance v2, Ljava/util/HashMap;
    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V
    :taken
    :try_end
    monitor-exit v0
    return-object v2
    :caught
    move-exception v1
    monitor-exit v0
    const/4 v1, 0x0
    return-object v1
    .catchall {:try_start .. :try_end} :caught
.end method

.method public run()V
    .locals 2
    :loop
    invoke-static {}, Lbt192/auto/V3StatusSampler;->awaitWork()Ljava/util/Map;
    move-result-object v0
    if-eqz v0, :loop
    :cycle_start
    invoke-direct {p0, v0}, Lbt192/auto/V3StatusSampler;->saveHistory(Ljava/util/Map;)V
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->sample()V
    :cycle_end
    goto :loop
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :fallback_start
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->failed()V
    :fallback_end
    goto :loop
    :fallback_caught
    move-exception v0
    goto :loop
    .catchall {:cycle_start .. :cycle_end} :caught
    .catchall {:fallback_start .. :fallback_end} :fallback_caught
.end method

.method private historyPrefs()Landroid/content/SharedPreferences;
    .locals 3
    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;
    const-string v1, "v3_status_history"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    iput-object v0, p0, Lbt192/auto/V3StatusSampler;->prefs:Landroid/content/SharedPreferences;
    return-object v0
.end method

# Independent accepted history survives later epoch changes. No current-rate claim.
# commit is on this background thread, outside both shared monitors.
.method private saveHistory(Ljava/util/Map;)V
    .locals 7
    if-eqz p1, :done
    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z
    move-result v0
    if-nez v0, :done
    :try_start
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->historyPrefs()Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;
    move-result-object v1
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :commit
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/util/Map$Entry;
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Ljava/lang/String;
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/Long;
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J
    move-result-wide v4
    invoke-interface {v0, v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;
    goto :loop
    :commit
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v0
    if-eqz v0, :failed
    const/4 v0, 0x0
    invoke-static {v0}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    :failed
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->retryHistory(Ljava/util/Map;)V
    const/4 v0, 0x1
    invoke-static {v0}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Keep failed accepted writes for the next EXPLICIT request, never auto-spin.
# Concurrent newly accepted timestamps win over an older failed batch per MAC.
.method private static retryHistory(Ljava/util/Map;)V
    .locals 6
    const-class v0, Lbt192/auto/V3StatusSampler;
    monitor-enter v0
    :try_start
    sget-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;
    if-nez v1, :ready
    new-instance v1, Ljava/util/HashMap;
    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V
    sput-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;
    :ready
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;
    move-result-object v2
    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v2
    :loop
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :done
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Ljava/util/Map$Entry;
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;
    move-result-object v4
    invoke-interface {v1, v4}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z
    move-result v5
    if-nez v5, :loop
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;
    move-result-object v3
    invoke-interface {v1, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    goto :loop
    :try_end
    :done
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static allowed(Landroid/content/Context;)Z
    .locals 1
    :try_start
    const-string v0, "android.permission.BLUETOOTH_CONNECT"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :no
    :try_end
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static associations(Landroid/content/Context;)Ljava/util/Set;
    .locals 1
    :try_start
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->macs(Landroid/content/Context;)Ljava/util/Set;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Complete list reads only: null/malformed/address failures do NOT prove absence.
.method private static deviceMap(Ljava/util/Collection;)Ljava/util/Map;
    .locals 5
    if-eqz p0, :none
    new-instance v0, Ljava/util/LinkedHashMap;
    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V
    invoke-interface {p0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/bluetooth/BluetoothDevice;
    if-eqz v2, :none
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;
    move-result-object v3
    if-eqz v3, :none
    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v3, v4}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v4
    if-eqz v4, :none
    invoke-interface {v0, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    goto :loop
    :done
    return-object v0
    :none
    const/4 v0, 0x0
    return-object v0
.end method

.method private static bondedDevices()Ljava/util/Map;
    .locals 1
    :try_start
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;
    move-result-object v0
    if-eqz v0, :none
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBondedDevices()Ljava/util/Set;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->deviceMap(Ljava/util/Collection;)Ljava/util/Map;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static connectedDevices(Landroid/bluetooth/BluetoothA2dp;)Ljava/util/Map;
    .locals 1
    if-eqz p0, :none
    :try_start
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothA2dp;->getConnectedDevices()Ljava/util/List;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->deviceMap(Ljava/util/Collection;)Ljava/util/Map;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Background only. UI controls need actual A2DP state before ANY enabled target.
# Borrow/initialize the SAME process-lifetime Broker (B=1); no second owner,
# physical connect, codec mutation, resetting or scheduling an automation job.
.method private static snapshotProxy(Landroid/content/Context;)Landroid/bluetooth/BluetoothA2dp;
    .locals 4
    invoke-static {}, Lbt192/auto/V3Broker;->peek()Landroid/bluetooth/BluetoothA2dp;
    move-result-object v0
    if-nez v0, :done
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v0
    const-wide/16 v2, 0x7d0
    add-long/2addr v0, v2
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Broker;->acquire(Landroid/content/Context;J)Landroid/bluetooth/BluetoothA2dp;
    move-result-object v0
    :done
    return-object v0
.end method

# Cached public metadata only: 1 audio sink/type, 0 known other, -1 unreadable.
# UUID is the A2DP Audio Sink SERVICE, not a negotiated codec/name heuristic.
# No fetchUuidsWithSdp, scanner, getProfileProxy or setter here.
.method private static music(Landroid/bluetooth/BluetoothDevice;)I
    .locals 5
    if-eqz p0, :unknown
    :uuid_start
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothDevice;->getUuids()[Landroid/os/ParcelUuid;
    move-result-object v0
    if-eqz v0, :uuid_end
    const/4 v1, 0x0
    :uuid_loop
    array-length v2, v0
    if-ge v1, v2, :uuid_end
    aget-object v2, v0, v1
    if-eqz v2, :uuid_next
    invoke-virtual {v2}, Landroid/os/ParcelUuid;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v3, "0000110b-0000-1000-8000-00805f9b34fb"
    invoke-virtual {v3, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z
    move-result v2
    if-nez v2, :yes
    :uuid_next
    add-int/lit8 v1, v1, 0x1
    goto :uuid_loop
    :uuid_end
    goto :class_start
    :uuid_caught
    move-exception v4
    :class_start
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothDevice;->getBluetoothClass()Landroid/bluetooth/BluetoothClass;
    move-result-object v0
    if-eqz v0, :class_end
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothClass;->getDeviceClass()I
    move-result v0
    const/16 v1, 0x404
    if-eq v0, v1, :yes
    const/16 v1, 0x414
    if-eq v0, v1, :yes
    const/16 v1, 0x418
    if-eq v0, v1, :yes
    const/16 v1, 0x41c
    if-eq v0, v1, :yes
    const/16 v1, 0x420
    if-eq v0, v1, :yes
    const/16 v1, 0x428
    if-eq v0, v1, :yes
    const/16 v1, 0x43c
    if-eq v0, v1, :yes
    # Only explicit non-playback classes are negative. Generic/unrecognized
    # CoD (including 0x400 and Uncategorized major 0x1f00) is UNKNOWN, not NO.
    # Preserve a previously positive music identity without admitting new unknowns.
    and-int/lit16 v1, v0, 0x1f00
    const/16 v2, 0x100
    if-eq v1, v2, :known_no
    const/16 v2, 0x200
    if-eq v1, v2, :known_no
    const/16 v2, 0x500
    if-eq v1, v2, :known_no
    const/16 v2, 0x600
    if-eq v1, v2, :known_no
    const/16 v2, 0x700
    if-eq v1, v2, :known_no
    const/16 v2, 0x800
    if-eq v1, v2, :known_no
    const/16 v2, 0x900
    if-eq v1, v2, :known_no
    # A/V recording or display-only types are not generic playback evidence.
    const/16 v1, 0x40c
    if-eq v0, v1, :known_no
    const/16 v1, 0x42c
    if-eq v0, v1, :known_no
    const/16 v1, 0x430
    if-eq v0, v1, :known_no
    const/16 v1, 0x434
    if-eq v0, v1, :known_no
    const/16 v1, 0x438
    if-eq v0, v1, :known_no
    goto :class_end
    :known_no
    const/4 v0, 0x0
    return v0
    :class_end
    goto :unknown
    :class_caught
    move-exception v4
    :unknown
    const/4 v0, -0x1
    return v0
    :yes
    const/4 v0, 0x1
    return v0
    .catchall {:uuid_start .. :uuid_end} :uuid_caught
    .catchall {:class_start .. :class_end} :class_caught
.end method

# Previous rows in THIS014 process have already passed this filter. Preserve
# their identity on unreadable metadata, not their connection/codec/authority.
# A current real A2DP connection is the strongest positive audio evidence.
.method private includeMusic(Ljava/lang/String;[Ljava/lang/String;)Z
    .locals 3
    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    if-eqz v0, :metadata
    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :yes
    :metadata
    const/4 v1, 0x0
    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    if-eqz v0, :classify
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/bluetooth/BluetoothDevice;
    :classify
    invoke-static {v1}, Lbt192/auto/V3StatusSampler;->music(Landroid/bluetooth/BluetoothDevice;)I
    move-result v2
    if-gtz v2, :yes
    if-eqz v2, :no
    if-eqz p2, :no
    :yes
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

.method private sample()V
    .locals 9
    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I
    move-result v1
    iput v1, p0, Lbt192/auto/V3StatusSampler;->epoch:I
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->associations(Landroid/content/Context;)Ljava/util/Set;
    move-result-object v1
    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->allowed(Landroid/content/Context;)Z
    move-result v1
    iput-boolean v1, p0, Lbt192/auto/V3StatusSampler;->permission:Z
    const/4 v2, 0x0
    iput-object v2, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    iput-object v2, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    iput-object v2, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;
    if-eqz v1, :build
    invoke-static {}, Lbt192/auto/V3StatusSampler;->bondedDevices()Ljava/util/Map;
    move-result-object v1
    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    # Connection controls bootstrap via the SAME B=1 broker on this background
    # thread. This acquires a read handle, never connects a device or sets codec.
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->snapshotProxy(Landroid/content/Context;)Landroid/bluetooth/BluetoothA2dp;
    move-result-object v1
    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;
    invoke-static {v1}, Lbt192/auto/V3StatusSampler;->connectedDevices(Landroid/bluetooth/BluetoothA2dp;)Ljava/util/Map;
    move-result-object v1
    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    :build
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->historyPrefs()Landroid/content/SharedPreferences;
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v1
    new-instance v2, Ljava/util/LinkedHashMap;
    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :old_loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :union
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, [Ljava/lang/String;
    const/4 v4, 0x0
    aget-object v4, v3, v4
    invoke-interface {v2, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    goto :old_loop
    :union
    new-instance v3, Ljava/util/TreeSet;
    invoke-direct {v3}, Ljava/util/TreeSet;-><init>()V
    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;
    if-eqz v4, :preserve
    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z
    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    if-nez v4, :add_maps
    :preserve
    # Names/MACs may survive unknown list read, never old codec/rate/authority.
    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;
    move-result-object v4
    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z
    :add_maps
    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    if-eqz v4, :add_connected
    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;
    move-result-object v4
    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z
    :add_connected
    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    if-eqz v4, :rows
    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;
    move-result-object v4
    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z
    :rows
    new-instance v4, Ljava/util/ArrayList;
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v3
    :row_loop
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z
    move-result v5
    if-eqz v5, :publish
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v5
    check-cast v5, Ljava/lang/String;
    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v6
    check-cast v6, [Ljava/lang/String;
    invoke-direct {p0, v5, v6}, Lbt192/auto/V3StatusSampler;->includeMusic(Ljava/lang/String;[Ljava/lang/String;)Z
    move-result v7
    if-eqz v7, :row_loop
    invoke-direct {p0, v5, v6}, Lbt192/auto/V3StatusSampler;->row(Ljava/lang/String;[Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v5
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    goto :row_loop
    :publish
    invoke-direct {p0, v4}, Lbt192/auto/V3StatusSampler;->publish(Ljava/util/List;)V
    return-void
.end method

.method private row(Ljava/lang/String;[Ljava/lang/String;)[Ljava/lang/String;
    .locals 8
    const/16 v0, 0x8
    new-array v0, v0, [Ljava/lang/String;
    const/4 v1, 0x0
    aput-object p1, v0, v1
    const/4 v1, 0x1
    aput-object p1, v0, v1
    if-eqz p2, :assoc
    aget-object v2, p2, v1
    aput-object v2, v0, v1
    :assoc
    const-string v2, "?"
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;
    if-eqz v3, :assoc_done
    invoke-interface {v3, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
    move-result v3
    const-string v2, "0"
    if-eqz v3, :assoc_done
    const-string v2, "1"
    :assoc_done
    const/4 v1, 0x2
    aput-object v2, v0, v1
    const-string v2, "?"
    const/4 v1, 0x3
    aput-object v2, v0, v1
    const-string v2, "UNKNOWN"
    const/4 v1, 0x4
    aput-object v2, v0, v1
    const-string v2, "—"
    const/4 v1, 0x5
    aput-object v2, v0, v1
    const/4 v1, 0x6
    aput-object v2, v0, v1
    const/4 v1, 0x7
    aput-object v2, v0, v1
    :history_start
    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->prefs:Landroid/content/SharedPreferences;
    const-wide/16 v3, 0x0
    invoke-interface {v2, p1, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J
    move-result-wide v3
    invoke-static {v3, v4}, Lbt192/auto/V3StatusStore;->time(J)Ljava/lang/String;
    move-result-object v2
    aput-object v2, v0, v1
    :history_end
    goto :name
    :history_caught
    move-exception v2
    const-string v2, "历史读取失败"
    aput-object v2, v0, v1
    :name
    const/4 v2, 0x0
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    if-eqz v3, :connected_name
    invoke-interface {v3, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/bluetooth/BluetoothDevice;
    :connected_name
    if-nez v2, :read_name
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    if-eqz v3, :connection
    invoke-interface {v3, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/bluetooth/BluetoothDevice;
    :read_name
    if-eqz v2, :connection
    :name_start
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :name_end
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z
    move-result v3
    if-nez v3, :name_end
    const/4 v1, 0x1
    aput-object v2, v0, v1
    :name_end
    goto :connection
    :name_caught
    move-exception v2
    :connection
    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    if-eqz v2, :done
    const/4 v1, 0x3
    const-string v3, "0"
    aput-object v3, v0, v1
    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/bluetooth/BluetoothDevice;
    if-eqz v2, :done
    const-string v3, "1"
    aput-object v3, v0, v1
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;
    invoke-static {v3, v2, v0}, Lbt192/auto/V3StatusSampler;->codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;[Ljava/lang/String;)V
    :done
    return-object v0
    .catchall {:history_start .. :history_end} :history_caught
    .catchall {:name_start .. :name_end} :name_caught
.end method

# Same hidden getter helper as Worker. It grants NO platform permission.
# Fill only after ALL getters succeed; no cached 192 fallback on exception/null.
.method private static codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;[Ljava/lang/String;)V
    .locals 7
    :try_start
    invoke-static {p0, p1}, Lbt192/auto/V3Codec;->status(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done
    const-string v1, "getCodecConfig"
    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done
    invoke-static {v0}, Lbt192/auto/V3Codec;->name(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :done
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    move-result v2
    if-nez v2, :done
    const-string v2, "getSampleRate"
    invoke-static {v0, v2}, Lbt192/auto/V3Codec;->integer(Ljava/lang/Object;Ljava/lang/String;)I
    move-result v2
    invoke-static {v2}, Lbt192/auto/V3StatusSampler;->rate(I)Ljava/lang/String;
    move-result-object v2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v3
    invoke-static {v3, v4}, Lbt192/auto/V3StatusStore;->time(J)Ljava/lang/String;
    move-result-object v3
    const-string v4, "（历史读取）"
    invoke-virtual {v3, v4}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    const/4 v4, 0x4
    aput-object v1, p2, v4
    const/4 v4, 0x5
    aput-object v2, p2, v4
    const/4 v4, 0x6
    aput-object v3, p2, v4
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static rate(I)Ljava/lang/String;
    .locals 1
    sparse-switch p0, :rates
    const-string v0, "未知采样率"
    return-object v0
    :r44
    const-string v0, "44.1kHz"
    return-object v0
    :r48
    const-string v0, "48kHz"
    return-object v0
    :r88
    const-string v0, "88.2kHz"
    return-object v0
    :r96
    const-string v0, "96kHz"
    return-object v0
    :r176
    const-string v0, "176.4kHz"
    return-object v0
    :r192
    const-string v0, "192kHz"
    return-object v0
    :rates
    .sparse-switch
        0x1 -> :r44
        0x2 -> :r48
        0x4 -> :r88
        0x8 -> :r96
        0x10 -> :r176
        0x20 -> :r192
    .end sparse-switch
.end method

# Final permission read OUTSIDE Cdm lock; epoch/proxy checks and atomic store
# swap INSIDE. Observer never grants authorization or alters Submission ledger.
.method private publish(Ljava/util/List;)V
    .locals 6
    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->allowed(Landroid/content/Context;)Z
    move-result v1
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    iget v2, p0, Lbt192/auto/V3StatusSampler;->epoch:I
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I
    move-result v3
    if-ne v2, v3, :stale
    iget-boolean v2, p0, Lbt192/auto/V3StatusSampler;->permission:Z
    if-ne v1, v2, :stale
    if-eqz v1, :no_permission
    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;
    if-eqz v2, :no_proxy
    invoke-static {v2}, Lbt192/auto/V3Broker;->isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z
    move-result v3
    if-eqz v3, :stale
    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;
    if-eqz v2, :read_failed
    const-string v2, ""
    goto :store
    :no_permission
    const-string v2, "附近设备未授权。"
    goto :unknown_store
    :no_proxy
    const-string v2, "连接状态暂未就绪。"
    goto :unknown_store
    :read_failed
    const-string v2, "连接状态暂不可确认。"
    goto :unknown_store
    :stale
    const-string v2, "设备状态已变化，请刷新。"
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->unknown(Ljava/util/List;)V
    # An old association list is never an authorization claim after epoch change.
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v3
    :stale_loop
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z
    move-result v4
    if-eqz v4, :store
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v4
    check-cast v4, [Ljava/lang/String;
    const/4 v5, 0x2
    const-string v1, "?"
    aput-object v1, v4, v5
    goto :stale_loop
    :unknown_store
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->unknown(Ljava/util/List;)V
    :store
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;
    if-nez v3, :bonded_notice
    const-string v3, "关联状态暂不可确认。"
    invoke-virtual {v2, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    :bonded_notice
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;
    if-nez v3, :save
    const-string v3, "配对状态暂不可确认。"
    invoke-virtual {v2, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    :save
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->codecUnknown(Ljava/util/List;)Z
    move-result v3
    if-eqz v3, :replace
    const-string v3, "采样率暂不可读取。"
    invoke-virtual {v2, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    :replace
    invoke-static {p1, v2}, Lbt192/auto/V3StatusStore;->replace(Ljava/util/List;Ljava/lang/String;)V
    :try_end
    monitor-exit v0
    return-void
    :caught
    move-exception v1
    monitor-exit v0
    throw v1
    .catchall {:try_start .. :try_end} :caught
.end method

.method private static codecUnknown(Ljava/util/List;)Z
    .locals 5
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :no
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [Ljava/lang/String;
    const/4 v2, 0x3
    aget-object v2, v1, v2
    const-string v3, "1"
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :loop
    const/4 v2, 0x4
    aget-object v1, v1, v2
    const-string v3, "UNKNOWN"
    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :loop
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

.method private static unknown(Ljava/util/List;)V
    .locals 4
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :done
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [Ljava/lang/String;
    const/4 v2, 0x3
    const-string v3, "?"
    aput-object v3, v1, v2
    const/4 v2, 0x4
    const-string v3, "UNKNOWN"
    aput-object v3, v1, v2
    const-string v3, "—"
    const/4 v2, 0x5
    aput-object v3, v1, v2
    const/4 v2, 0x6
    aput-object v3, v1, v2
    goto :loop
    :done
    return-void
.end method

.method private failed()V
    .locals 5
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->unknown(Ljava/util/List;)V
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :save
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, [Ljava/lang/String;
    const/4 v3, 0x2
    const-string v4, "?"
    aput-object v4, v2, v3
    goto :loop
    :save
    const-string v1, "设备状态读取失败。"
    invoke-static {v0, v1}, Lbt192/auto/V3StatusStore;->replace(Ljava/util/List;Ljava/lang/String;)V
    return-void
.end method
