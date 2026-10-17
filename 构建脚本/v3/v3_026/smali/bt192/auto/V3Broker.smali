.class public final Lbt192/auto/V3Broker;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/bluetooth/BluetoothProfile$ServiceListener;


# static fields
.field private static adapter:Landroid/bluetooth/BluetoothAdapter;

.field private static appctx:Landroid/content/Context;

.field private static issued:Z

.field private static listener:Lbt192/auto/V3Broker;

.field private static proxy:Landroid/bluetooth/BluetoothA2dp;

.field private static state:I

.field private static status:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static acquire(Landroid/content/Context;J)Landroid/bluetooth/BluetoothA2dp;
    .registers 4

    invoke-static {p0}, Lbt192/auto/V3Broker;->take(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-static {}, Lbt192/auto/V3Broker;->issue()V

    :cond_9
    invoke-static {p1, p2}, Lbt192/auto/V3Broker;->awaitReady(J)Landroid/bluetooth/BluetoothA2dp;

    move-result-object v0

    return-object v0
.end method

.method private static awaitReady(J)Landroid/bluetooth/BluetoothA2dp;
    .registers 10

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    const-wide/16 v3, 0x7d0

    add-long/2addr v1, v3

    cmp-long v5, v1, p0

    if-lez v5, :cond_f

    move-wide v1, p0

    :cond_f
    :goto_f
    sget v5, Lbt192/auto/V3Broker;->state:I

    const/4 v6, 0x3

    if-eq v5, v6, :cond_3d

    if-eqz v5, :cond_3b

    const/4 v6, 0x4

    if-eq v5, v6, :cond_3b

    const/4 v6, 0x7

    if-eq v5, v6, :cond_3b

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    sub-long v3, v1, v3

    const-wide/16 v6, 0x0

    cmp-long v5, v3, v6

    if-lez v5, :cond_2c

    invoke-virtual {v0, v3, v4}, Ljava/lang/Object;->wait(J)V

    goto :goto_f

    :cond_2c
    sget v5, Lbt192/auto/V3Broker;->state:I

    const/4 v6, 0x1

    if-eq v5, v6, :cond_34

    const/4 v6, 0x2

    if-ne v5, v6, :cond_3b

    :cond_34
    const/4 v5, 0x4

    sput v5, Lbt192/auto/V3Broker;->state:I

    const-string v5, "系统蓝牙代理等待回复，未确认结果；若长期不恢复请真正重启应用并检查无障碍"

    sput-object v5, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    :cond_3b
    const/4 v5, 0x0

    goto :goto_3f

    :cond_3d
    sget-object v5, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;
    :try_end_3f
    .catchall {:try_start_3 .. :try_end_3f} :catchall_41

    :goto_3f
    monitor-exit v0

    return-object v5

    :catchall_41
    move-exception v5

    sget v5, Lbt192/auto/V3Broker;->state:I

    const/4 v6, 0x1

    if-eq v5, v6, :cond_4a

    const/4 v6, 0x2

    if-ne v5, v6, :cond_51

    :cond_4a
    const/4 v5, 0x4

    sput v5, Lbt192/auto/V3Broker;->state:I

    const-string v5, "系统蓝牙代理等待中断，未确认结果；预算不恢复，请真正重启应用并检查无障碍"

    sput-object v5, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    :cond_51
    monitor-exit v0

    const/4 v5, 0x0

    return-object v5
.end method

.method public static isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z
    .registers 4

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v1, 0x0

    if-eqz p0, :cond_12

    sget v2, Lbt192/auto/V3Broker;->state:I

    const/4 v1, 0x3

    if-ne v2, v1, :cond_11

    sget-object v2, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;

    if-ne p0, v2, :cond_11

    const/4 v1, 0x1

    goto :goto_12

    :cond_11
    const/4 v1, 0x0
    :try_end_12
    .catchall {:try_start_3 .. :try_end_12} :catchall_14

    :cond_12
    :goto_12
    monitor-exit v0

    return v1

    :catchall_14
    move-exception v1

    monitor-exit v0

    const/4 v1, 0x0

    return v1
.end method

.method private static issue()V
    .registers 5

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget-object v2, Lbt192/auto/V3Broker;->appctx:Landroid/content/Context;

    sget-object v3, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;
    :try_end_7
    .catchall {:try_start_3 .. :try_end_7} :catchall_21

    monitor-exit v0

    :try_start_8
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1
    :try_end_c
    .catchall {:try_start_8 .. :try_end_c} :catchall_1b

    invoke-static {v1}, Lbt192/auto/V3Broker;->publishAdapter(Landroid/bluetooth/BluetoothAdapter;)Z

    move-result v4

    if-eqz v4, :cond_20

    :try_start_12
    const/4 v4, 0x2

    invoke-virtual {v1, v2, v3, v4}, Landroid/bluetooth/BluetoothAdapter;->getProfileProxy(Landroid/content/Context;Landroid/bluetooth/BluetoothProfile$ServiceListener;I)Z

    move-result v4
    :try_end_17
    .catchall {:try_start_12 .. :try_end_17} :catchall_18

    goto :goto_1d

    :catchall_18
    move-exception v0

    const/4 v4, -0x1

    goto :goto_1d

    :catchall_1b
    move-exception v0

    const/4 v4, -0x2

    :goto_1d
    invoke-static {v4}, Lbt192/auto/V3Broker;->returned(I)V

    :cond_20
    return-void

    :catchall_21
    move-exception v4

    const/4 v1, 0x6

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理申请准备失败，预算已锁定；请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    monitor-exit v0

    return-void
.end method

.method private static makeListener()Lbt192/auto/V3Broker;
    .registers 1

    new-instance v0, Lbt192/auto/V3Broker;

    invoke-direct {v0}, Lbt192/auto/V3Broker;-><init>()V

    return-object v0
.end method

.method public static peek()Landroid/bluetooth/BluetoothA2dp;
    .registers 3

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v1, 0x0

    sget v2, Lbt192/auto/V3Broker;->state:I

    const/4 v1, 0x3

    if-ne v2, v1, :cond_c

    sget-object v1, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;

    goto :goto_d

    :cond_c
    const/4 v1, 0x0
    :try_end_d
    .catchall {:try_start_3 .. :try_end_d} :catchall_f

    :goto_d
    monitor-exit v0

    return-object v1

    :catchall_f
    move-exception v2

    monitor-exit v0

    const/4 v1, 0x0

    return-object v1
.end method

.method private static prepareLocked(Landroid/content/Context;)Z
    .registers 3

    sget-boolean v0, Lbt192/auto/V3Broker;->issued:Z

    if-nez v0, :cond_2b

    const/4 v0, 0x1

    sput-boolean v0, Lbt192/auto/V3Broker;->issued:Z

    sput v0, Lbt192/auto/V3Broker;->state:I

    const-string v0, "正在申请系统蓝牙代理，尚未确认结果"

    sput-object v0, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    if-eqz p0, :cond_23

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_23

    instance-of v1, v0, Landroid/app/Activity;

    if-nez v1, :cond_23

    sput-object v0, Lbt192/auto/V3Broker;->appctx:Landroid/content/Context;

    invoke-static {}, Lbt192/auto/V3Broker;->makeListener()Lbt192/auto/V3Broker;

    move-result-object v0

    sput-object v0, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;

    const/4 v0, 0x1

    return v0

    :cond_23
    const/4 v0, 0x6

    sput v0, Lbt192/auto/V3Broker;->state:I

    const-string v0, "无法取得应用级上下文，代理预算已锁定；请真正重启应用并检查无障碍"

    sput-object v0, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    goto :goto_2b

    :cond_2b
    :goto_2b
    const/4 v0, 0x0

    return v0
.end method

.method private static publishAdapter(Landroid/bluetooth/BluetoothAdapter;)Z
    .registers 3

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sput-object p0, Lbt192/auto/V3Broker;->adapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz p0, :cond_9

    const/4 v1, 0x1

    goto :goto_11

    :cond_9
    const/4 v1, 0x6

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "未取得系统蓝牙适配器，代理预算已锁定；请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    const/4 v1, 0x0
    :try_end_11
    .catchall {:try_start_3 .. :try_end_11} :catchall_13

    :goto_11
    monitor-exit v0

    return v1

    :catchall_13
    move-exception v1

    const/4 v1, 0x6

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙适配器发布失败，预算已锁定；请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    monitor-exit v0

    const/4 v1, 0x0

    return v1
.end method

.method public static reason()Ljava/lang/String;
    .registers 2

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    if-nez v1, :cond_9

    const-string v1, "系统蓝牙代理尚未申请"
    :try_end_9
    .catchall {:try_start_3 .. :try_end_9} :catchall_b

    :cond_9
    monitor-exit v0

    return-object v1

    :catchall_b
    move-exception v1

    const-string v1, "系统蓝牙代理状态读取失败；请真正重启应用并检查无障碍"

    monitor-exit v0

    return-object v1
.end method

.method private static returned(I)V
    .registers 4

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget v1, Lbt192/auto/V3Broker;->state:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_27

    if-lez p0, :cond_12

    const/4 v1, 0x2

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理等待回复，未确认结果"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    goto :goto_24

    :cond_12
    const/4 v1, 0x6

    sput v1, Lbt192/auto/V3Broker;->state:I

    if-ltz p0, :cond_1a

    const-string v1, "系统蓝牙代理申请返回false，注册结果不确定；预算不恢复，请真正重启应用并检查无障碍"

    goto :goto_22

    :cond_1a
    const/4 v2, -0x2

    if-eq p0, v2, :cond_20

    const-string v1, "系统蓝牙代理申请发生异常，可能已注册；预算不恢复，请真正重启应用并检查无障碍"

    goto :goto_22

    :cond_20
    const-string v1, "系统蓝牙适配器获取异常，尚未调用代理申请但预算已锁定；请真正重启应用并检查无障碍"

    :goto_22
    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    :goto_24
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end_27
    .catchall {:try_start_3 .. :try_end_27} :catchall_29

    :cond_27
    monitor-exit v0

    return-void

    :catchall_29
    move-exception v1

    monitor-exit v0

    return-void
.end method

.method private static take(Landroid/content/Context;)Z
    .registers 4

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    invoke-static {p0}, Lbt192/auto/V3Broker;->prepareLocked(Landroid/content/Context;)Z

    move-result v1
    :try_end_7
    .catchall {:try_start_3 .. :try_end_7} :catchall_9

    monitor-exit v0

    return v1

    :catchall_9
    move-exception v2

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Broker;->issued:Z

    const/4 v1, 0x6

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理初始化失败，预算已锁定；请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    monitor-exit v0

    const/4 v1, 0x0

    return v1
.end method


# virtual methods
.method public onServiceConnected(ILandroid/bluetooth/BluetoothProfile;)V
    .registers 7

    const-class v0, Lbt192/auto/CdmTrigger;

    const/4 v3, 0x0

    monitor-enter v0

    :try_start_4
    const/4 v1, 0x2

    if-ne p1, v1, :cond_3f

    instance-of v1, p2, Landroid/bluetooth/BluetoothA2dp;

    if-eqz v1, :cond_3f

    sget-boolean v1, Lbt192/auto/V3Broker;->issued:Z

    if-eqz v1, :cond_3f

    sget-object v1, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;

    if-ne p0, v1, :cond_3f

    sget v2, Lbt192/auto/V3Broker;->state:I

    const/4 v1, 0x7

    if-eq v2, v1, :cond_3f

    sget-object v1, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;

    if-eqz v1, :cond_21

    if-ne v1, p2, :cond_35

    const/4 v1, 0x3

    if-eq v2, v1, :cond_3c

    :cond_21
    move-object v1, p2

    check-cast v1, Landroid/bluetooth/BluetoothA2dp;

    sput-object v1, Lbt192/auto/V3Broker;->proxy:Landroid/bluetooth/BluetoothA2dp;

    const/4 v1, 0x3

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理已就绪；耳机连接与任务资格仍需实时检查"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    sget-object v3, Lbt192/auto/V3Broker;->appctx:Landroid/content/Context;

    if-eqz v3, :cond_3c

    invoke-static {v3}, Lbt192/auto/CdmTrigger;->proxyReady(Landroid/content/Context;)V

    goto :goto_3c

    :cond_35
    const/4 v1, 0x7

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理返回不同对象，已安全停用；不再申请，请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    :cond_3c
    :goto_3c
    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end_3f
    .catchall {:try_start_4 .. :try_end_3f} :catchall_46

    :cond_3f
    monitor-exit v0

    if-eqz v3, :cond_45

    invoke-static {v3}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V

    :cond_45
    return-void

    :catchall_46
    move-exception v1

    const/4 v1, 0x7

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理回调处理失败，已安全停用；请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    monitor-exit v0

    return-void
.end method

.method public onServiceDisconnected(I)V
    .registers 5

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v1, 0x2

    if-ne p1, v1, :cond_1d

    sget-boolean v1, Lbt192/auto/V3Broker;->issued:Z

    if-eqz v1, :cond_1d

    sget-object v1, Lbt192/auto/V3Broker;->listener:Lbt192/auto/V3Broker;

    if-ne p0, v1, :cond_1d

    sget v1, Lbt192/auto/V3Broker;->state:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_1d

    const/4 v1, 0x5

    sput v1, Lbt192/auto/V3Broker;->state:I

    const-string v1, "系统蓝牙代理服务断开，等待同会话恢复；不代表耳机断开，不再申请；若长期不恢复请真正重启应用并检查无障碍"

    sput-object v1, Lbt192/auto/V3Broker;->status:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V
    :try_end_1d
    .catchall {:try_start_3 .. :try_end_1d} :catchall_1f

    :cond_1d
    monitor-exit v0

    return-void

    :catchall_1f
    move-exception v1

    monitor-exit v0

    return-void
.end method
