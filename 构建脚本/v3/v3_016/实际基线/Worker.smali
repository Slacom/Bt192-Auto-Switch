.class public Lbt192/auto/Worker;
.super Ljava/lang/Thread;


# instance fields
.field private final act:Landroid/content/Context;

.field public appliedAtElapsed:J

.field public appliedAtWall:J

.field private final deadline:J

.field private volatile disconnected:Z

.field private final gen:I

.field public observedAtElapsed:J

.field public observedCodecName:Ljava/lang/String;

.field public observedSampleRateMask:I

.field res:Ljava/lang/String;

.field private sourceCodec:Ljava/lang/Object;

.field private submitted:Z

.field public volatile success:Z

.field private final targetMac:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 7

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    const-wide/16 v3, 0x1f40

    add-long/2addr v1, v3

    invoke-direct {p0, p1, v0, v1, v2}, Lbt192/auto/Worker;-><init>(Landroid/content/Context;IJ)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;IJ)V
    .registers 7

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_a

    move-object v0, p1

    :cond_a
    iput-object v0, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    iput p2, p0, Lbt192/auto/Worker;->gen:I

    iput-wide p3, p0, Lbt192/auto/Worker;->deadline:J

    const/4 v0, 0x0

    iput-object v0, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    const-string v0, "UNKNOWN"

    iput-object v0, p0, Lbt192/auto/Worker;->observedCodecName:Ljava/lang/String;

    const/4 v0, -0x1

    iput v0, p0, Lbt192/auto/Worker;->observedSampleRateMask:I

    const-string v0, "UNKNOWN_NOT_CONFIRMED"

    iput-object v0, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;IJ)V
    .registers 7

    invoke-direct {p0, p1, p3, p4, p5}, Lbt192/auto/Worker;-><init>(Landroid/content/Context;IJ)V

    iput-object p2, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    return-void
.end method

.method private apply(Landroid/bluetooth/BluetoothA2dp;)Z
    .registers 14

    move-object v0, p1

    invoke-direct {p0, v0}, Lbt192/auto/Worker;->target(Landroid/bluetooth/BluetoothA2dp;)Landroid/bluetooth/BluetoothDevice;

    move-result-object v3

    if-eqz v3, :cond_db

    invoke-direct {p0, v0, v3}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-eqz v2, :cond_eb

    invoke-static {v0, v3}, Lbt192/auto/Worker;->codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;

    move-result-object v8

    if-eqz v8, :cond_de

    invoke-direct {p0, v8}, Lbt192/auto/Worker;->observe(Ljava/lang/Object;)V

    invoke-static {v8}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_e1

    invoke-static {v8}, Lbt192/auto/V3Codec;->ready(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_e4

    invoke-static {v0, v3, v8}, Lbt192/auto/V3Codec;->supports192(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_e7

    const-string v5, "getCodecType"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v11

    const-string v5, "getSampleRate"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    const/16 v6, 0x20

    if-ne v5, v6, :cond_3d

    invoke-direct {p0, v0, v3, v11}, Lbt192/auto/Worker;->confirm(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;I)Z

    move-result v2

    return v2

    :cond_3d
    iput-object v8, p0, Lbt192/auto/Worker;->sourceCodec:Ljava/lang/Object;

    new-instance v1, Landroid/bluetooth/BluetoothCodecConfig$Builder;

    invoke-direct {v1}, Landroid/bluetooth/BluetoothCodecConfig$Builder;-><init>()V

    const-string v5, "getCodecType"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setCodecType(I)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getCodecPriority"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setCodecPriority(I)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const/16 v9, 0x20

    invoke-virtual {v1, v9}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setSampleRate(I)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getBitsPerSample"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setBitsPerSample(I)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getChannelMode"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setChannelMode(I)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getCodecSpecific1"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gl(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v5

    invoke-virtual {v1, v5, v6}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setCodecSpecific1(J)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getCodecSpecific2"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gl(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v5

    invoke-virtual {v1, v5, v6}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setCodecSpecific2(J)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getCodecSpecific3"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gl(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v5

    invoke-virtual {v1, v5, v6}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setCodecSpecific3(J)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    const-string v5, "getCodecSpecific4"

    invoke-static {v8, v5}, Lbt192/auto/Worker;->gl(Ljava/lang/Object;Ljava/lang/String;)J

    move-result-wide v5

    invoke-virtual {v1, v5, v6}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->setCodecSpecific4(J)Landroid/bluetooth/BluetoothCodecConfig$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothCodecConfig$Builder;->build()Landroid/bluetooth/BluetoothCodecConfig;

    move-result-object v1

    invoke-direct {p0, v0, v3, v1}, Lbt192/auto/Worker;->submit(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothCodecConfig;)Z

    move-result v2

    if-eqz v2, :cond_eb

    const-string v2, "SUBMITTED_UNCONFIRMED"

    iput-object v2, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    iget-object v2, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    const-string v4, "APPLY_192"

    iget v5, p0, Lbt192/auto/Worker;->gen:I

    invoke-static {v2, v4, v5}, Lbt192/auto/Worker;->trace(Landroid/content/Context;Ljava/lang/String;I)V

    const/4 v10, 0x0

    :cond_b2
    invoke-direct {p0, v0, v3}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-eqz v2, :cond_eb

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    iget-wide v6, p0, Lbt192/auto/Worker;->deadline:J

    sub-long/2addr v6, v4

    const-wide/16 v4, 0x0

    cmp-long v2, v6, v4

    if-lez v2, :cond_eb

    const-wide/16 v4, 0x96

    cmp-long v2, v4, v6

    if-lez v2, :cond_cc

    move-wide v4, v6

    :cond_cc
    invoke-static {v4, v5}, Ljava/lang/Thread;->sleep(J)V

    invoke-direct {p0, v0, v3, v11}, Lbt192/auto/Worker;->confirm(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;I)Z

    move-result v2

    if-nez v2, :cond_ec

    add-int/lit8 v10, v10, 0x1

    const/4 v2, 0x5

    if-lt v10, v2, :cond_b2

    goto :goto_eb

    :cond_db
    const-string v2, "目标未连接A2DP，等待连接（没有下发）"

    goto :goto_e9

    :cond_de
    const-string v2, "CURRENT_CODEC_UNKNOWN"

    goto :goto_e9

    :cond_e1
    const-string v2, "CURRENT_CODEC_NOT_CONFIRMED_V5"

    goto :goto_e9

    :cond_e4
    const-string v2, "CURRENT_CODEC_NOT_READY"

    goto :goto_e9

    :cond_e7
    const-string v2, "192_UNSUPPORTED_OR_UNCONFIRMED"

    :goto_e9
    iput-object v2, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    :cond_eb
    :goto_eb
    const/4 v2, 0x0

    :cond_ec
    return v2
.end method

.method private static codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;
    .registers 6

    const-class v0, Landroid/bluetooth/BluetoothA2dp;

    const-string v1, "getCodecStatus"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    invoke-static {v0, p0, v1, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1d

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "getCodecConfig"

    invoke-static {v1, v0, v3, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    :cond_1d
    return-object v0
.end method

.method private confirm(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;I)Z
    .registers 11

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    invoke-direct {p0, p1, p2}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    if-eqz v1, :cond_55

    invoke-static {p1, p2}, Lbt192/auto/Worker;->codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_55

    invoke-direct {p0, v2}, Lbt192/auto/Worker;->observe(Ljava/lang/Object;)V

    invoke-static {v2}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_55

    invoke-static {v2}, Lbt192/auto/V3Codec;->ready(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_55

    const-string v3, "getCodecType"

    invoke-static {v2, v3}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    if-ne v1, p3, :cond_55

    const-string v3, "getSampleRate"

    invoke-static {v2, v3}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    const/16 v3, 0x20

    if-ne v1, v3, :cond_55

    invoke-direct {p0, p1, p2}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    if-eqz v1, :cond_55

    iget-object v6, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    invoke-static {v6}, Lbt192/auto/V3Submission;->confirmed(Ljava/lang/String;)V

    iget-boolean v1, p0, Lbt192/auto/Worker;->submitted:Z

    if-eqz v1, :cond_44

    const-string v2, "已切换到 192kHz"

    const-string v3, "CONFIRMED_192"

    goto :goto_48

    :cond_44
    const-string v2, "已是最优 192kHz"

    const-string v3, "ALREADY_192"

    :goto_48
    iput-object v2, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lbt192/auto/Worker;->success:Z

    iget-object v4, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    iget v5, p0, Lbt192/auto/Worker;->gen:I

    invoke-static {v4, v3, v5}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V

    goto :goto_56

    :cond_55
    const/4 v1, 0x0
    :try_end_56
    .catchall {:try_start_3 .. :try_end_56} :catchall_58

    :goto_56
    monitor-exit v0

    return v1

    :catchall_58
    move-exception v6

    monitor-exit v0

    throw v6
.end method

.method public static event(Landroid/content/Context;Ljava/lang/String;I)V
    .registers 7

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "v3_013 t="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, " gen="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "bt192-fast"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_27
    .catchall {:try_start_0 .. :try_end_27} :catchall_28

    return-void

    :catchall_28
    move-exception v0

    return-void
.end method

.method private fresh()Z
    .registers 5

    iget-object v0, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    iget-object v1, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    invoke-static {v0, v1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_22

    iget-boolean v0, p0, Lbt192/auto/Worker;->disconnected:Z

    if-nez v0, :cond_22

    iget v0, p0, Lbt192/auto/Worker;->gen:I

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v1

    if-ne v0, v1, :cond_22

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Lbt192/auto/Worker;->deadline:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_22

    const/4 v0, 0x1

    return v0

    :cond_22
    const/4 v0, 0x0

    return v0
.end method

.method private static gi(Ljava/lang/Object;Ljava/lang/String;)I
    .registers 6

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, p1, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method private static gl(Ljava/lang/Object;Ljava/lang/String;)J
    .registers 6

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, p1, v2}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0
.end method

.method public static logw(Ljava/lang/String;)V
    .registers 3

    sget-object v0, Lbt192/auto/AutoEntry;->ctx:Landroid/content/Context;

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v1

    invoke-static {v0, p0, v1}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V

    return-void
.end method

.method private observe(Ljava/lang/Object;)V
    .registers 6

    invoke-static {p1}, Lbt192/auto/V3Codec;->name(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_8

    const-string v0, "UNKNOWN"

    :cond_8
    const-string v1, "getSampleRate"

    invoke-static {p1, v1}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v1

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    iput-object v0, p0, Lbt192/auto/Worker;->observedCodecName:Ljava/lang/String;

    iput v1, p0, Lbt192/auto/Worker;->observedSampleRateMask:I

    iput-wide v2, p0, Lbt192/auto/Worker;->observedAtElapsed:J

    return-void
.end method

.method private settle()V
    .registers 4

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    invoke-direct {p0}, Lbt192/auto/Worker;->fresh()Z

    move-result v1

    if-nez v1, :cond_10

    const/4 v1, 0x0

    iput-boolean v1, p0, Lbt192/auto/Worker;->success:Z

    const-string v1, "STALE_OR_INELIGIBLE_NOT_CONFIRMED"

    iput-object v1, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;
    :try_end_10
    .catchall {:try_start_3 .. :try_end_10} :catchall_12

    :cond_10
    monitor-exit v0

    return-void

    :catchall_12
    move-exception v2

    const/4 v1, 0x0

    iput-boolean v1, p0, Lbt192/auto/Worker;->success:Z

    const-string v1, "ERROR_NOT_CONFIRMED"

    iput-object v1, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    monitor-exit v0

    invoke-static {v2}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private submit(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothCodecConfig;)Z
    .registers 12

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    iget-boolean v1, p0, Lbt192/auto/Worker;->submitted:Z

    if-nez v1, :cond_83

    invoke-direct {p0, p1, p2}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v1

    if-eqz v1, :cond_83

    iget-object v1, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    iget-object v2, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    invoke-static {v1, v2}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_83

    invoke-static {p1, p2}, Lbt192/auto/Worker;->codec(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_76

    invoke-direct {p0, v1}, Lbt192/auto/Worker;->observe(Ljava/lang/Object;)V

    invoke-static {v1}, Lbt192/auto/V3Codec;->ready(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7c

    iget-object v2, p0, Lbt192/auto/Worker;->sourceCodec:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_79

    invoke-static {v1}, Lbt192/auto/V3Codec;->isV5(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7f

    invoke-static {p1, p2, v1}, Lbt192/auto/V3Codec;->supports192(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7f

    const-string v2, "getSampleRate"

    invoke-static {v1, v2}, Lbt192/auto/Worker;->gi(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v2

    const/16 v3, 0x20

    if-eq v2, v3, :cond_79

    const-class v3, Landroid/bluetooth/BluetoothA2dp;

    const-string v4, "setCodecConfigPreference"

    const/4 v2, 0x2

    new-array v5, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p2, v5, v2

    const/4 v2, 0x1

    aput-object p3, v5, v2

    invoke-direct {p0, p1, p2}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-eqz v2, :cond_83

    iget-object v6, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    invoke-static {v6}, Lbt192/auto/V3Submission;->reserve(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_73

    const/4 v2, 0x1

    iput-boolean v2, p0, Lbt192/auto/Worker;->submitted:Z

    invoke-static {v3, p1, v4, v5}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    iput-wide v6, p0, Lbt192/auto/Worker;->appliedAtWall:J

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    iput-wide v6, p0, Lbt192/auto/Worker;->appliedAtElapsed:J

    const/4 v2, 0x1

    goto :goto_84

    :cond_73
    const-string v2, "该耳机上次192请求尚未确认，暂不重复下发；可连接后回读或主动允许重试"

    goto :goto_81

    :cond_76
    const-string v2, "CURRENT_CODEC_UNKNOWN"

    goto :goto_81

    :cond_79
    const-string v2, "CURRENT_CODEC_CHANGED_NO_SUBMIT"

    goto :goto_81

    :cond_7c
    const-string v2, "CURRENT_CODEC_NOT_READY"

    goto :goto_81

    :cond_7f
    const-string v2, "192_UNSUPPORTED_OR_UNCONFIRMED"

    :goto_81
    iput-object v2, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    :cond_83
    const/4 v2, 0x0
    :try_end_84
    .catchall {:try_start_3 .. :try_end_84} :catchall_86

    :goto_84
    monitor-exit v0

    return v2

    :catchall_86
    move-exception v7

    monitor-exit v0

    throw v7
.end method

.method public static summary(Landroid/content/Context;Ljava/lang/String;)V
    .registers 8

    const/4 v0, 0x0

    :try_start_1
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_1e

    new-instance v2, Ljava/io/File;

    const-string v3, "log.txt"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v0, v3

    const-string v1, "UTF-8"

    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_1e
    .catchall {:try_start_1 .. :try_end_1e} :catchall_1f

    :cond_1e
    goto :goto_20

    :catchall_1f
    move-exception v1

    :goto_20
    if-eqz v0, :cond_27

    :try_start_22
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_25
    .catchall {:try_start_22 .. :try_end_25} :catchall_26

    goto :goto_27

    :catchall_26
    move-exception v0

    :cond_27
    :goto_27
    invoke-static {p0, p1}, Lbt192/auto/Worker;->ui(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method private target(Landroid/bluetooth/BluetoothA2dp;)Landroid/bluetooth/BluetoothDevice;
    .registers 6

    iget-object v3, p0, Lbt192/auto/Worker;->targetMac:Ljava/lang/String;

    if-eqz v3, :cond_30

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothA2dp;->getConnectedDevices()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_30

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_e
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2d

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/bluetooth/BluetoothDevice;

    if-eqz v1, :cond_e

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_e

    invoke-direct {p0, p1, v1}, Lbt192/auto/Worker;->valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z

    move-result v2

    if-eqz v2, :cond_30

    return-object v1

    :cond_2d
    invoke-static {v3}, Lbt192/auto/V3Submission;->disconnected(Ljava/lang/String;)V

    :cond_30
    const/4 v0, 0x0

    return-object v0
.end method

.method public static trace(Landroid/content/Context;Ljava/lang/String;I)V
    .registers 11

    const/4 v0, 0x0

    :try_start_1
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "v3_013 t="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v2, " gen="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "bt192-fast"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p0, :cond_5a

    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_5a

    new-instance v3, Ljava/io/File;

    const-string v4, "fast.log"

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->length()J

    move-result-wide v4

    const-wide/32 v6, 0x40000

    cmp-long v4, v4, v6

    const/4 v5, 0x1

    if-ltz v4, :cond_45

    const/4 v5, 0x0

    :cond_45
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v3, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    move-object v0, v2

    const-string v3, "\n"

    invoke-virtual {v1, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "UTF-8"

    invoke-virtual {v1, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_5a
    .catchall {:try_start_1 .. :try_end_5a} :catchall_5b

    :cond_5a
    goto :goto_5c

    :catchall_5b
    move-exception v1

    :goto_5c
    if-eqz v0, :cond_63

    :try_start_5e
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_61
    .catchall {:try_start_5e .. :try_end_61} :catchall_62

    goto :goto_63

    :catchall_62
    move-exception v0

    :cond_63
    :goto_63
    return-void
.end method

.method public static ui(Landroid/content/Context;Ljava/lang/String;)V
    .registers 5

    :try_start_0
    instance-of v0, p0, Lbt192/auto/AutoEntry;

    if-eqz v0, :cond_15

    new-instance v0, Lbt192/auto/Toaster;

    invoke-direct {v0, p0, p1}, Lbt192/auto/Toaster;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_15
    .catchall {:try_start_0 .. :try_end_15} :catchall_16

    :cond_15
    return-void

    :catchall_16
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private valid(Landroid/bluetooth/BluetoothA2dp;Landroid/bluetooth/BluetoothDevice;)Z
    .registers 5

    invoke-static {p1}, Lbt192/auto/V3Broker;->isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-direct {p0}, Lbt192/auto/Worker;->fresh()Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-virtual {p1, p2}, Landroid/bluetooth/BluetoothA2dp;->getConnectionState(Landroid/bluetooth/BluetoothDevice;)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_18

    invoke-direct {p0}, Lbt192/auto/Worker;->fresh()Z

    move-result v0

    return v0

    :cond_18
    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method public run()V
    .registers 9

    const/4 v0, 0x0

    iput-boolean v0, p0, Lbt192/auto/Worker;->success:Z

    :try_start_3
    iget-object v0, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    const-string v1, "android.permission.BLUETOOTH_CONNECT"

    invoke-virtual {v0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_46

    invoke-direct {p0}, Lbt192/auto/Worker;->fresh()Z

    move-result v1

    if-eqz v1, :cond_52

    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1

    if-eqz v1, :cond_49

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_4c

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/bluetooth/BluetoothAdapter;->getProfileConnectionState(I)I

    move-result v1

    if-ne v1, v2, :cond_4f

    iget-wide v2, p0, Lbt192/auto/Worker;->deadline:J

    invoke-static {v0, v2, v3}, Lbt192/auto/V3Broker;->acquire(Landroid/content/Context;J)Landroid/bluetooth/BluetoothA2dp;

    move-result-object v1

    if-eqz v1, :cond_3f

    invoke-direct {p0}, Lbt192/auto/Worker;->fresh()Z

    move-result v2

    if-eqz v2, :cond_52

    const-string v2, "PROXY_READY_SHARED"

    iget v3, p0, Lbt192/auto/Worker;->gen:I

    invoke-static {v0, v2, v3}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V

    invoke-direct {p0, v1}, Lbt192/auto/Worker;->apply(Landroid/bluetooth/BluetoothA2dp;)Z

    goto :goto_56

    :cond_3f
    invoke-static {}, Lbt192/auto/V3Broker;->reason()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    goto :goto_56

    :cond_46
    const-string v1, "附近设备权限未授权，未请求蓝牙代理"

    goto :goto_54

    :cond_49
    const-string v1, "没有可用蓝牙适配器"

    goto :goto_54

    :cond_4c
    const-string v1, "蓝牙已关闭，等待开启与耳机连接"

    goto :goto_54

    :cond_4f
    const-string v1, "没有有效A2DP连接，等待耳机连接（未申请代理）"

    goto :goto_54

    :cond_52
    const-string v1, "STALE_OR_INELIGIBLE_NOT_CONFIRMED"

    :goto_54
    iput-object v1, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;
    :try_end_56
    .catchall {:try_start_3 .. :try_end_56} :catchall_57

    :goto_56
    goto :goto_62

    :catchall_57
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lbt192/auto/Worker;->success:Z

    const-string v0, "ERROR_NOT_CONFIRMED"

    iput-object v0, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    :goto_62
    invoke-direct {p0}, Lbt192/auto/Worker;->settle()V

    iget-object v0, p0, Lbt192/auto/Worker;->act:Landroid/content/Context;

    iget-object v1, p0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    iget v2, p0, Lbt192/auto/Worker;->gen:I

    invoke-static {v0, v1, v2}, Lbt192/auto/Worker;->trace(Landroid/content/Context;Ljava/lang/String;I)V

    return-void
.end method
