.class public final Lbt192/auto/V3DevicePrefs;
.super Ljava/lang/Object;


# static fields
.field private static failed:Ljava/util/HashMap;

.field private static poisoned:Z


# direct methods
.method private static hold(Ljava/lang/String;I)Z
    .registers 5

    :try_start_0
    sget-object v0, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;

    if-nez v0, :cond_b

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;

    :cond_b
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x1
    :try_end_13
    .catchall {:try_start_0 .. :try_end_13} :catchall_14

    return v0

    :catchall_14
    move-exception v2

    const/4 v0, 0x1

    sput-boolean v0, Lbt192/auto/V3DevicePrefs;->poisoned:Z

    const/4 v0, 0x0

    return v0
.end method

.method private static key(Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    :try_start_0
    if-eqz p0, :cond_1a

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1a

    const-string v1, "device_icon:"

    invoke-virtual {v1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_18
    .catchall {:try_start_0 .. :try_end_18} :catchall_19

    return-object v0

    :catchall_19
    move-exception v2

    :cond_1a
    const/4 v0, 0x0

    return-object v0
.end method

.method public static kind(Landroid/content/Context;Ljava/lang/String;)I
    .registers 5

    :try_start_0
    const-class v0, Lbt192/auto/V3DevicePrefs;

    monitor-enter v0
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_c

    :try_start_3
    invoke-static {p0, p1}, Lbt192/auto/V3DevicePrefs;->kindLocked(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1
    :try_end_7
    .catchall {:try_start_3 .. :try_end_7} :catchall_9

    monitor-exit v0

    return v1

    :catchall_9
    move-exception v2

    monitor-exit v0

    goto :goto_d

    :catchall_c
    move-exception v2

    :goto_d
    const/4 v1, 0x0

    return v1
.end method

.method private static kindLocked(Landroid/content/Context;Ljava/lang/String;)I
    .registers 5

    :try_start_0
    sget-boolean v0, Lbt192/auto/V3DevicePrefs;->poisoned:Z

    if-nez v0, :cond_2a

    invoke-static {p1}, Lbt192/auto/V3DevicePrefs;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2a

    sget-object v1, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;

    if-eqz v1, :cond_1b

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_1b

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_24

    :cond_1b
    invoke-static {p0}, Lbt192/auto/V3DevicePrefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    :goto_24
    invoke-static {v0}, Lbt192/auto/V3DevicePrefs;->legal(I)I

    move-result v0
    :try_end_28
    .catchall {:try_start_0 .. :try_end_28} :catchall_29

    return v0

    :catchall_29
    move-exception v2

    :cond_2a
    const/4 v0, 0x0

    return v0
.end method

.method private static legal(I)I
    .registers 2

    const/16 v0, 0x9

    if-eq p0, v0, :cond_5

    const/4 v0, 0x0

    :cond_5
    return v0
.end method

.method private static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_7

    move-object v0, p0

    :cond_7
    const-string v1, "v3_ui_prefs"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method public static save(Landroid/content/Context;Ljava/lang/String;I)Z
    .registers 6

    :try_start_0
    const-class v0, Lbt192/auto/V3DevicePrefs;

    monitor-enter v0
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_c

    :try_start_3
    invoke-static {p0, p1, p2}, Lbt192/auto/V3DevicePrefs;->saveLocked(Landroid/content/Context;Ljava/lang/String;I)Z

    move-result v1
    :try_end_7
    .catchall {:try_start_3 .. :try_end_7} :catchall_9

    monitor-exit v0

    return v1

    :catchall_9
    move-exception v2

    monitor-exit v0

    goto :goto_d

    :catchall_c
    move-exception v2

    :goto_d
    const/4 v1, 0x0

    return v1
.end method

.method private static saveLocked(Landroid/content/Context;Ljava/lang/String;I)Z
    .registers 11

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :try_start_4
    sget-boolean v4, Lbt192/auto/V3DevicePrefs;->poisoned:Z

    if-nez v4, :cond_5d

    const/16 v4, 0x9

    if-eq p2, v4, :cond_e

    if-nez p2, :cond_5d

    :cond_e
    invoke-static {p1}, Lbt192/auto/V3DevicePrefs;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5d

    invoke-static {p0}, Lbt192/auto/V3DevicePrefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    sget-object v4, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;

    if-eqz v4, :cond_29

    invoke-virtual {v4, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :cond_29

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_31

    :cond_29
    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    invoke-static {v2}, Lbt192/auto/V3DevicePrefs;->legal(I)I

    move-result v2

    :goto_31
    invoke-static {v0, v2}, Lbt192/auto/V3DevicePrefs;->hold(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_5d

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3, v0, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v4

    if-eqz v4, :cond_4e

    sget-object v5, Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;

    invoke-virtual {v5, v0}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v4, 0x1
    :try_end_4a
    .catchall {:try_start_4 .. :try_end_4a} :catchall_4b

    return v4

    :catchall_4b
    move-exception v7

    if-eqz v3, :cond_5d

    :cond_4e
    invoke-static {v0, v2}, Lbt192/auto/V3DevicePrefs;->hold(Ljava/lang/String;I)Z

    :try_start_51
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-interface {v6, v0, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_5b
    .catchall {:try_start_51 .. :try_end_5b} :catchall_5c

    goto :goto_5d

    :catchall_5c
    move-exception v7

    :cond_5d
    :goto_5d
    const/4 v4, 0x0

    return v4
.end method
