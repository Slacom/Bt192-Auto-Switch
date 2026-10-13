.class public final Lbt192/auto/V3DevicePrefs;
.super Ljava/lang/Object;

# UI-only store/lock. Never touch the runtime/settings/association lock graph.
# Overrides retain the PRE-click display after Android publishes a failed commit
# into SharedPreferences memory. They are cleared only after a successful retry.
.field private static failed:Ljava/util/HashMap;
.field private static poisoned:Z

.method private static key(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    :try_start
    if-eqz p0, :invalid
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v0
    # Pure address syntax validation: no adapter, permissions or Binder call.
    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :invalid
    const-string v1, "device_icon:"
    invoke-virtual {v1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    :try_end
    return-object v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v2
    :invalid
    const/4 v0, 0x0
    return-object v0
.end method

.method private static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 3
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    if-nez v0, :ready
    move-object v0, p0
    :ready
    const-string v1, "v3_ui_prefs"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    return-object v0
.end method

.method private static legal(I)I
    .locals 1
    const/16 v0, 0x9
    if-eq p0, v0, :tws
    const/4 v0, 0x0
    :tws
    return v0
.end method

# Lazy allocation avoids a throwing class initializer disabling the public API.
# Pre-arm BEFORE edit/commit so allocation failure cannot publish a new choice.
.method private static hold(Ljava/lang/String;I)Z
    .locals 3
    :try_start
    sget-object v0, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;
    if-nez v0, :ready
    new-instance v0, Ljava/util/HashMap;
    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V
    sput-object v0, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;
    :ready
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v1
    invoke-virtual {v0, p0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const/4 v0, 0x1
    :try_end
    return v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v2
    const/4 v0, 0x1
    sput-boolean v0, Lbt192/auto/V3DevicePrefs;->poisoned:Z
    const/4 v0, 0x0
    return v0
.end method

# Managed DEX declared-synchronized is metadata, not a substitute for a monitor.
# Only this UI class is locked; no runtime/Cdm/Worker locks or callbacks.
.method public static kind(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3
    :enter_start
    const-class v0, Lbt192/auto/V3DevicePrefs;
    monitor-enter v0
    :enter_end
    :work_start
    invoke-static {p0, p1}, Lbt192/auto/V3DevicePrefs;->kindLocked(Landroid/content/Context;Ljava/lang/String;)I
    move-result v1
    :work_end
    monitor-exit v0
    return v1
    .catchall {:enter_start .. :enter_end} :unlocked_failure
    .catchall {:work_start .. :work_end} :locked_failure
    :locked_failure
    move-exception v2
    monitor-exit v0
    goto :default
    :unlocked_failure
    move-exception v2
    # const-class/monitor-enter failed: never read v0 or attempt to release.
    :default
    const/4 v1, 0x0
    return v1
.end method

.method private static kindLocked(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3
    :try_start
    sget-boolean v0, Lbt192/auto/V3DevicePrefs;->poisoned:Z
    if-nez v0, :default
    invoke-static {p1}, Lbt192/auto/V3DevicePrefs;->key(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :default
    sget-object v1, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;
    if-eqz v1, :read
    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v1
    if-eqz v1, :read
    check-cast v1, Ljava/lang/Integer;
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    move-result v0
    goto :legal
    :read
    invoke-static {p0}, Lbt192/auto/V3DevicePrefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v1
    const/4 v2, 0x0
    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    move-result v0
    :legal
    invoke-static {v0}, Lbt192/auto/V3DevicePrefs;->legal(I)I
    move-result v0
    :try_end
    return v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v2
    :default
    const/4 v0, 0x0
    return v0
.end method

.method public static save(Landroid/content/Context;Ljava/lang/String;I)Z
    .locals 3
    :enter_start
    const-class v0, Lbt192/auto/V3DevicePrefs;
    monitor-enter v0
    :enter_end
    :work_start
    invoke-static {p0, p1, p2}, Lbt192/auto/V3DevicePrefs;->saveLocked(Landroid/content/Context;Ljava/lang/String;I)Z
    move-result v1
    :work_end
    monitor-exit v0
    return v1
    .catchall {:enter_start .. :enter_end} :unlocked_failure
    .catchall {:work_start .. :work_end} :locked_failure
    :locked_failure
    move-exception v2
    monitor-exit v0
    goto :default
    :unlocked_failure
    move-exception v2
    :default
    const/4 v1, 0x0
    return v1
.end method

.method private static saveLocked(Landroid/content/Context;Ljava/lang/String;I)Z
    .locals 8
    # Every handler-visible reference/value is initialized before the try.
    const/4 v0, 0x0                 # key
    const/4 v1, 0x0                 # prefs
    const/4 v2, 0x0                 # previous displayed kind
    const/4 v3, 0x0                 # editor
    :try_start
    sget-boolean v4, Lbt192/auto/V3DevicePrefs;->poisoned:Z
    if-nez v4, :failed
    const/16 v4, 0x9
    if-eq p2, v4, :valid_kind
    if-nez p2, :failed
    :valid_kind
    invoke-static {p1}, Lbt192/auto/V3DevicePrefs;->key(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :failed
    invoke-static {p0}, Lbt192/auto/V3DevicePrefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v1
    sget-object v4, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;
    if-eqz v4, :read_old
    invoke-virtual {v4, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v4
    if-eqz v4, :read_old
    check-cast v4, Ljava/lang/Integer;
    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I
    move-result v2
    goto :old_ready
    :read_old
    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    move-result v2
    invoke-static {v2}, Lbt192/auto/V3DevicePrefs;->legal(I)I
    move-result v2
    :old_ready
    invoke-static {v0, v2}, Lbt192/auto/V3DevicePrefs;->hold(Ljava/lang/String;I)Z
    move-result v4
    if-eqz v4, :failed
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v3
    invoke-interface {v3, v0, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v4
    if-eqz v4, :rollback
    sget-object v5, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;
    invoke-virtual {v5, v0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    const/4 v4, 0x1
    :try_end
    return v4
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v7
    # A preparation/getInt poison cannot be reported as a saved choice.
    if-eqz v3, :failed
    :rollback
    # Retain/re-arm the old display even if removal threw after a disk success.
    invoke-static {v0, v2}, Lbt192/auto/V3DevicePrefs;->hold(Ljava/lang/String;I)Z
    :rollback_start
    # Fresh editor: the failed editor itself may be unusable.
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v6
    invoke-interface {v6, v0, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :rollback_end
    goto :failed
    .catchall {:rollback_start .. :rollback_end} :rollback_caught
    :rollback_caught
    move-exception v7
    :failed
    const/4 v4, 0x0
    return v4
.end method
