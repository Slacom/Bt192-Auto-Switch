.class public final Lbt192/auto/V3StatusSampler;
.super Ljava/lang/Thread;


# static fields
.field private static history:Ljava/util/Map;

.field private static owner:Lbt192/auto/V3StatusSampler;

.field private static pending:Z


# instance fields
.field private assoc:Ljava/util/Set;

.field private bonded:Ljava/util/Map;

.field private connected:Ljava/util/Map;

.field private final ctx:Landroid/content/Context;

.field private epoch:I

.field private permission:Z

.field private prefs:Landroid/content/SharedPreferences;

.field private proxy:Landroid/bluetooth/BluetoothA2dp;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .registers 3

    const-string v0, "v3-status-read-only"

    invoke-direct {p0, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;

    return-void
.end method

.method private static allowed(Landroid/content/Context;)Z
    .registers 2

    :try_start_0
    const-string v0, "android.permission.BLUETOOTH_CONNECT"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_b
    :try_end_8
    .catchall {:try_start_0 .. :try_end_8} :catchall_a

    const/4 v0, 0x1

    return v0

    :catchall_a
    move-exception v0

    :cond_b
    const/4 v0, 0x0

    return v0
.end method

.method private static associations(Landroid/content/Context;)Ljava/util/Set;
    .registers 2

    :try_start_0
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->macs(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v0
    :try_end_4
    .catchall {:try_start_0 .. :try_end_4} :catchall_5

    return-object v0

    :catchall_5
    move-exception v0

    const/4 v0, 0x0

    return-object v0
.end method

.method private static awaitWork()Ljava/util/Map;
    .registers 3

    const-class v0, Lbt192/auto/V3StatusSampler;

    monitor-enter v0

    :goto_3
    :try_start_3
    sget-boolean v1, Lbt192/auto/V3StatusSampler;->pending:Z

    if-nez v1, :cond_b

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V

    goto :goto_3

    :cond_b
    const/4 v1, 0x0

    sput-boolean v1, Lbt192/auto/V3StatusSampler;->pending:Z

    sget-object v2, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;

    sput-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;

    if-nez v2, :cond_19

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V
    :try_end_19
    .catchall {:try_start_3 .. :try_end_19} :catchall_1b

    :cond_19
    monitor-exit v0

    return-object v2

    :catchall_1b
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x0

    return-object v1
.end method

.method private static bondedDevices()Ljava/util/Map;
    .registers 1

    :try_start_0
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_10

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBondedDevices()Ljava/util/Set;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->deviceMap(Ljava/util/Collection;)Ljava/util/Map;

    move-result-object v0
    :try_end_e
    .catchall {:try_start_0 .. :try_end_e} :catchall_f

    return-object v0

    :catchall_f
    move-exception v0

    :cond_10
    const/4 v0, 0x0

    return-object v0
.end method

.method private static codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;[Ljava/lang/String;)V
    .registers 10

    :try_start_0
    invoke-static {p0, p1}, Lbt192/auto/V3Codec;->status(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3b

    const-string v1, "getCodecConfig"

    invoke-static {v0, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3b

    invoke-static {v0}, Lbt192/auto/V3Codec;->name(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3b

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_3b

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
    :try_end_3b
    .catchall {:try_start_0 .. :try_end_3b} :catchall_3c

    :cond_3b
    return-void

    :catchall_3c
    move-exception v0

    return-void
.end method

.method private static codecUnknown(Ljava/util/List;)Z
    .registers 6

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_4
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_28

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    const/4 v2, 0x3

    aget-object v2, v1, v2

    const-string v3, "1"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    const/4 v2, 0x4

    aget-object v1, v1, v2

    const-string v3, "UNKNOWN"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    const/4 v0, 0x1

    return v0

    :cond_28
    const/4 v0, 0x0

    return v0
.end method

.method private static connectedDevices(Landroid/bluetooth/BluetoothA2dp;)Ljava/util/Map;
    .registers 2

    if-eqz p0, :cond_c

    :try_start_2
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothA2dp;->getConnectedDevices()Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->deviceMap(Ljava/util/Collection;)Ljava/util/Map;

    move-result-object v0
    :try_end_a
    .catchall {:try_start_2 .. :try_end_a} :catchall_b

    return-object v0

    :catchall_b
    move-exception v0

    :cond_c
    const/4 v0, 0x0

    return-object v0
.end method

.method private static deviceMap(Ljava/util/Collection;)Ljava/util/Map;
    .registers 6

    if-eqz p0, :cond_30

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    invoke-interface {p0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothDevice;

    if-eqz v2, :cond_30

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_30

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_30

    invoke-interface {v0, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_b

    :cond_2f
    return-object v0

    :cond_30
    const/4 v0, 0x0

    return-object v0
.end method

.method public static enqueue(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Long;)V
    .registers 6

    const-class v0, Lbt192/auto/V3StatusSampler;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;

    if-nez v1, :cond_e

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    sput-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;

    :cond_e
    invoke-interface {v1, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_11
    .catchall {:try_start_3 .. :try_end_11} :catchall_16

    monitor-exit v0

    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V

    return-void

    :catchall_16
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x1

    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    return-void
.end method

.method private failed()V
    .registers 6

    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->unknown(Ljava/util/List;)V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1d

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    const/4 v3, 0x2

    const-string v4, "?"

    aput-object v4, v2, v3

    goto :goto_b

    :cond_1d
    const-string v1, "设备状态读取失败。"

    invoke-static {v0, v1}, Lbt192/auto/V3StatusStore;->replace(Ljava/util/List;Ljava/lang/String;)V

    return-void
.end method

.method private historyPrefs()Landroid/content/SharedPreferences;
    .registers 4

    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;

    const-string v1, "v3_status_history"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lbt192/auto/V3StatusSampler;->prefs:Landroid/content/SharedPreferences;

    return-object v0
.end method

.method private includeMusic(Ljava/lang/String;[Ljava/lang/String;)Z
    .registers 6

    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;

    if-eqz v0, :cond_a

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1f

    :cond_a
    const/4 v1, 0x0

    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;

    if-eqz v0, :cond_15

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/bluetooth/BluetoothDevice;

    :cond_15
    invoke-static {v1}, Lbt192/auto/V3StatusSampler;->music(Landroid/bluetooth/BluetoothDevice;)I

    move-result v2

    if-gtz v2, :cond_1f

    if-eqz v2, :cond_21

    if-eqz p2, :cond_21

    :cond_1f
    const/4 v0, 0x1

    return v0

    :cond_21
    const/4 v0, 0x0

    return v0
.end method

.method private static make(Landroid/content/Context;)Lbt192/auto/V3StatusSampler;
    .registers 2

    new-instance v0, Lbt192/auto/V3StatusSampler;

    invoke-direct {v0, p0}, Lbt192/auto/V3StatusSampler;-><init>(Landroid/content/Context;)V

    return-object v0
.end method

.method private static music(Landroid/bluetooth/BluetoothDevice;)I
    .registers 6

    if-eqz p0, :cond_7e

    :try_start_2
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothDevice;->getUuids()[Landroid/os/ParcelUuid;

    move-result-object v0

    if-eqz v0, :cond_1f

    const/4 v1, 0x0

    :goto_9
    array-length v2, v0

    if-ge v1, v2, :cond_1f

    aget-object v2, v0, v1

    if-eqz v2, :cond_1c

    invoke-virtual {v2}, Landroid/os/ParcelUuid;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "0000110b-0000-1000-8000-00805f9b34fb"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_80

    :cond_1c
    add-int/lit8 v1, v1, 0x1

    goto :goto_9
    :try_end_1f
    .catchall {:try_start_2 .. :try_end_1f} :catchall_20

    :cond_1f
    goto :goto_21

    :catchall_20
    move-exception v4

    :goto_21
    :try_start_21
    invoke-virtual {p0}, Landroid/bluetooth/BluetoothDevice;->getBluetoothClass()Landroid/bluetooth/BluetoothClass;

    move-result-object v0

    if-eqz v0, :cond_7c

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothClass;->getDeviceClass()I

    move-result v0

    const/16 v1, 0x404

    if-eq v0, v1, :cond_80

    const/16 v1, 0x414

    if-eq v0, v1, :cond_80

    const/16 v1, 0x418

    if-eq v0, v1, :cond_80

    const/16 v1, 0x41c

    if-eq v0, v1, :cond_80

    const/16 v1, 0x420

    if-eq v0, v1, :cond_80

    const/16 v1, 0x428

    if-eq v0, v1, :cond_80

    const/16 v1, 0x43c

    if-eq v0, v1, :cond_80

    and-int/lit16 v1, v0, 0x1f00

    const/16 v2, 0x100

    if-eq v1, v2, :cond_7a

    const/16 v2, 0x200

    if-eq v1, v2, :cond_7a

    const/16 v2, 0x500

    if-eq v1, v2, :cond_7a

    const/16 v2, 0x600

    if-eq v1, v2, :cond_7a

    const/16 v2, 0x700

    if-eq v1, v2, :cond_7a

    const/16 v2, 0x800

    if-eq v1, v2, :cond_7a

    const/16 v2, 0x900

    if-eq v1, v2, :cond_7a

    const/16 v1, 0x40c

    if-eq v0, v1, :cond_7a

    const/16 v1, 0x42c

    if-eq v0, v1, :cond_7a

    const/16 v1, 0x430

    if-eq v0, v1, :cond_7a

    const/16 v1, 0x434

    if-eq v0, v1, :cond_7a

    const/16 v1, 0x438

    if-eq v0, v1, :cond_7a

    goto :goto_7c

    :cond_7a
    const/4 v0, 0x0

    return v0
    :try_end_7c
    .catchall {:try_start_21 .. :try_end_7c} :catchall_7d

    :cond_7c
    :goto_7c
    goto :goto_7e

    :catchall_7d
    move-exception v4

    :cond_7e
    :goto_7e
    const/4 v0, -0x1

    return v0

    :cond_80
    const/4 v0, 0x1

    return v0
.end method

.method private publish(Ljava/util/List;)V
    .registers 8

    iget-object v0, p0, Lbt192/auto/V3StatusSampler;->ctx:Landroid/content/Context;

    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->allowed(Landroid/content/Context;)Z

    move-result v1

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_9
    iget v2, p0, Lbt192/auto/V3StatusSampler;->epoch:I

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v3

    if-ne v2, v3, :cond_31

    iget-boolean v2, p0, Lbt192/auto/V3StatusSampler;->permission:Z

    if-ne v1, v2, :cond_31

    if-eqz v1, :cond_28

    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;

    if-eqz v2, :cond_2b

    invoke-static {v2}, Lbt192/auto/V3Broker;->isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z

    move-result v3

    if-eqz v3, :cond_31

    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;

    if-eqz v2, :cond_2e

    const-string v2, ""

    goto :goto_4f

    :cond_28
    const-string v2, "附近设备未授权。"

    goto :goto_4c

    :cond_2b
    const-string v2, "连接状态暂未就绪。"

    goto :goto_4c

    :cond_2e
    const-string v2, "连接状态暂不可确认。"

    goto :goto_4c

    :cond_31
    const-string v2, "设备状态已变化，请刷新。"

    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->unknown(Ljava/util/List;)V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3a
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4f

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [Ljava/lang/String;

    const/4 v5, 0x2

    const-string v1, "?"

    aput-object v1, v4, v5

    goto :goto_3a

    :goto_4c
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->unknown(Ljava/util/List;)V

    :cond_4f
    :goto_4f
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;

    if-nez v3, :cond_59

    const-string v3, "关联状态暂不可确认。"

    invoke-virtual {v2, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_59
    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;

    if-nez v3, :cond_63

    const-string v3, "配对状态暂不可确认。"

    invoke-virtual {v2, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_63
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->codecUnknown(Ljava/util/List;)Z

    move-result v3

    if-eqz v3, :cond_6f

    const-string v3, "采样率暂不可读取。"

    invoke-virtual {v2, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_6f
    invoke-static {p1, v2}, Lbt192/auto/V3StatusStore;->replace(Ljava/util/List;Ljava/lang/String;)V
    :try_end_72
    .catchall {:try_start_9 .. :try_end_72} :catchall_74

    monitor-exit v0

    return-void

    :catchall_74
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static rate(I)Ljava/lang/String;
    .registers 2

    sparse-switch p0, :sswitch_data_18

    const-string v0, "未知采样率"

    return-object v0

    :sswitch_6
    const-string v0, "44.1kHz"

    return-object v0

    :sswitch_9
    const-string v0, "48kHz"

    return-object v0

    :sswitch_c
    const-string v0, "88.2kHz"

    return-object v0

    :sswitch_f
    const-string v0, "96kHz"

    return-object v0

    :sswitch_12
    const-string v0, "176.4kHz"

    return-object v0

    :sswitch_15
    const-string v0, "192kHz"

    return-object v0

    :sswitch_data_18
    .sparse-switch
        0x1 -> :sswitch_6
        0x2 -> :sswitch_9
        0x4 -> :sswitch_c
        0x8 -> :sswitch_f
        0x10 -> :sswitch_12
        0x20 -> :sswitch_15
    .end sparse-switch
.end method

.method public static request(Landroid/content/Context;)V
    .registers 4

    :try_start_0
    if-eqz p0, :cond_23

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    if-eqz v1, :cond_23

    instance-of v2, v1, Landroid/app/Activity;

    if-nez v2, :cond_23
    :try_end_c
    .catchall {:try_start_0 .. :try_end_c} :catchall_3d

    const-class v0, Lbt192/auto/V3StatusSampler;

    monitor-enter v0

    :try_start_f
    const/4 v2, 0x1

    sput-boolean v2, Lbt192/auto/V3StatusSampler;->pending:Z

    sget-object v2, Lbt192/auto/V3StatusSampler;->owner:Lbt192/auto/V3StatusSampler;

    if-nez v2, :cond_1f

    invoke-static {v1}, Lbt192/auto/V3StatusSampler;->make(Landroid/content/Context;)Lbt192/auto/V3StatusSampler;

    move-result-object v2

    sput-object v2, Lbt192/auto/V3StatusSampler;->owner:Lbt192/auto/V3StatusSampler;
    :try_end_1c
    .catchall {:try_start_f .. :try_end_1c} :catchall_36

    :try_start_1c
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V
    :try_end_1f
    .catchall {:try_start_1c .. :try_end_1f} :catchall_24

    :cond_1f
    :try_start_1f
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end_22
    .catchall {:try_start_1f .. :try_end_22} :catchall_36

    monitor-exit v0

    :cond_23
    return-void

    :catchall_24
    move-exception v1

    :try_start_25
    invoke-virtual {v2}, Ljava/lang/Thread;->getState()Ljava/lang/Thread$State;

    move-result-object v1
    :try_end_29
    .catchall {:try_start_25 .. :try_end_29} :catchall_36

    sget-object v2, Ljava/lang/Thread$State;->NEW:Ljava/lang/Thread$State;

    if-ne v1, v2, :cond_30

    const/4 v1, 0x0

    sput-object v1, Lbt192/auto/V3StatusSampler;->owner:Lbt192/auto/V3StatusSampler;

    :cond_30
    monitor-exit v0

    const/4 v1, 0x1

    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    return-void

    :catchall_36
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x1

    invoke-static {v1}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    return-void

    :catchall_3d
    move-exception v0

    return-void
.end method

.method private static retryHistory(Ljava/util/Map;)V
    .registers 7

    const-class v0, Lbt192/auto/V3StatusSampler;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;

    if-nez v1, :cond_e

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    sput-object v1, Lbt192/auto/V3StatusSampler;->history:Ljava/util/Map;

    :cond_e
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_16
    :goto_16
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_34

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_16

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v1, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_16
    :try_end_34
    .catchall {:try_start_3 .. :try_end_34} :catchall_36

    :cond_34
    monitor-exit v0

    return-void

    :catchall_36
    move-exception v1

    monitor-exit v0

    return-void
.end method

.method private row(Ljava/lang/String;[Ljava/lang/String;)[Ljava/lang/String;
    .registers 11

    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    const/4 v1, 0x1

    aput-object p1, v0, v1

    if-eqz p2, :cond_10

    aget-object v2, p2, v1

    aput-object v2, v0, v1

    :cond_10
    const-string v2, "?"

    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;

    if-eqz v3, :cond_20

    invoke-interface {v3, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    const-string v2, "0"

    if-eqz v3, :cond_20

    const-string v2, "1"

    :cond_20
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

    :try_start_38
    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->prefs:Landroid/content/SharedPreferences;

    const-wide/16 v3, 0x0

    invoke-interface {v2, p1, v3, v4}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v3

    invoke-static {v3, v4}, Lbt192/auto/V3StatusStore;->time(J)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1
    :try_end_46
    .catchall {:try_start_38 .. :try_end_46} :catchall_47

    goto :goto_4c

    :catchall_47
    move-exception v2

    const-string v2, "历史读取失败"

    aput-object v2, v0, v1

    :goto_4c
    const/4 v2, 0x0

    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;

    if-eqz v3, :cond_57

    invoke-interface {v3, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothDevice;

    :cond_57
    if-nez v2, :cond_63

    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;

    if-eqz v3, :cond_76

    invoke-interface {v3, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothDevice;

    :cond_63
    if-eqz v2, :cond_76

    :try_start_65
    invoke-virtual {v2}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_74

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_74

    const/4 v1, 0x1

    aput-object v2, v0, v1
    :try_end_74
    .catchall {:try_start_65 .. :try_end_74} :catchall_75

    :cond_74
    goto :goto_76

    :catchall_75
    move-exception v2

    :cond_76
    :goto_76
    iget-object v2, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;

    if-eqz v2, :cond_90

    const/4 v1, 0x3

    const-string v3, "0"

    aput-object v3, v0, v1

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/bluetooth/BluetoothDevice;

    if-eqz v2, :cond_90

    const-string v3, "1"

    aput-object v3, v0, v1

    iget-object v3, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;

    invoke-static {v3, v2, v0}, Lbt192/auto/V3StatusSampler;->codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;[Ljava/lang/String;)V

    :cond_90
    return-object v0
.end method

.method private sample()V
    .registers 10

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

    if-eqz v1, :cond_2f

    invoke-static {}, Lbt192/auto/V3StatusSampler;->bondedDevices()Ljava/util/Map;

    move-result-object v1

    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;

    invoke-static {v0}, Lbt192/auto/V3StatusSampler;->snapshotProxy(Landroid/content/Context;)Landroid/bluetooth/BluetoothA2dp;

    move-result-object v1

    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->proxy:Landroid/bluetooth/BluetoothA2dp;

    invoke-static {v1}, Lbt192/auto/V3StatusSampler;->connectedDevices(Landroid/bluetooth/BluetoothA2dp;)Ljava/util/Map;

    move-result-object v1

    iput-object v1, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;

    :cond_2f
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->historyPrefs()Landroid/content/SharedPreferences;

    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;

    move-result-object v1

    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_3f
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_52

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Ljava/lang/String;

    const/4 v4, 0x0

    aget-object v4, v3, v4

    invoke-interface {v2, v4, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3f

    :cond_52
    new-instance v3, Ljava/util/TreeSet;

    invoke-direct {v3}, Ljava/util/TreeSet;-><init>()V

    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->assoc:Ljava/util/Set;

    if-eqz v4, :cond_62

    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;

    if-nez v4, :cond_69

    :cond_62
    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    :cond_69
    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->bonded:Ljava/util/Map;

    if-eqz v4, :cond_74

    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    :cond_74
    iget-object v4, p0, Lbt192/auto/V3StatusSampler;->connected:Ljava/util/Map;

    if-eqz v4, :cond_7f

    invoke-interface {v4}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    :cond_7f
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_88
    :goto_88
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_a8

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [Ljava/lang/String;

    invoke-direct {p0, v5, v6}, Lbt192/auto/V3StatusSampler;->includeMusic(Ljava/lang/String;[Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_88

    invoke-direct {p0, v5, v6}, Lbt192/auto/V3StatusSampler;->row(Ljava/lang/String;[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_88

    :cond_a8
    invoke-direct {p0, v4}, Lbt192/auto/V3StatusSampler;->publish(Ljava/util/List;)V

    return-void
.end method

.method private saveHistory(Ljava/util/Map;)V
    .registers 9

    if-eqz p1, :cond_42

    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_42

    :try_start_8
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->historyPrefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_18
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_38

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

    goto :goto_18

    :cond_38
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v0

    if-eqz v0, :cond_44

    const/4 v0, 0x0

    invoke-static {v0}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V
    :try_end_42
    .catchall {:try_start_8 .. :try_end_42} :catchall_43

    :cond_42
    return-void

    :catchall_43
    move-exception v0

    :cond_44
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->retryHistory(Ljava/util/Map;)V

    const/4 v0, 0x1

    invoke-static {v0}, Lbt192/auto/V3StatusStore;->historyFailed(Z)V

    return-void
.end method

.method private static snapshotProxy(Landroid/content/Context;)Landroid/bluetooth/BluetoothA2dp;
    .registers 5

    invoke-static {}, Lbt192/auto/V3Broker;->peek()Landroid/bluetooth/BluetoothA2dp;

    move-result-object v0

    if-nez v0, :cond_11

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    const-wide/16 v2, 0x7d0

    add-long/2addr v0, v2

    invoke-static {p0, v0, v1}, Lbt192/auto/V3Broker;->acquire(Landroid/content/Context;J)Landroid/bluetooth/BluetoothA2dp;

    move-result-object v0

    :cond_11
    return-object v0
.end method

.method private static unknown(Ljava/util/List;)V
    .registers 5

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_4
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_23

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

    goto :goto_4

    :cond_23
    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    :cond_0
    :goto_0
    invoke-static {}, Lbt192/auto/V3StatusSampler;->awaitWork()Ljava/util/Map;

    move-result-object v0

    if-eqz v0, :cond_0

    :try_start_6
    invoke-direct {p0, v0}, Lbt192/auto/V3StatusSampler;->saveHistory(Ljava/util/Map;)V

    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->sample()V
    :try_end_c
    .catchall {:try_start_6 .. :try_end_c} :catchall_d

    goto :goto_0

    :catchall_d
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :try_start_11
    invoke-direct {p0}, Lbt192/auto/V3StatusSampler;->failed()V
    :try_end_14
    .catchall {:try_start_11 .. :try_end_14} :catchall_15

    goto :goto_0

    :catchall_15
    move-exception v0

    goto :goto_0
.end method
