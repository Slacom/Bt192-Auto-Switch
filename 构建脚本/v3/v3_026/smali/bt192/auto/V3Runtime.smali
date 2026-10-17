.class public final Lbt192/auto/V3Runtime;
.super Ljava/lang/Object;


# static fields
.field private static results:Ljava/util/Map;


# direct methods
.method public static describe(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .registers 10

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const-string v1, "尚无本进程有效回读；请连接并开启此耳机后刷新"

    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->configured(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_e

    const-string v1, "自动切换已关闭，不对该设备下发"

    goto :goto_58

    :cond_e
    sget-object v2, Lbt192/auto/V3Runtime;->results:Ljava/util/Map;

    if-eqz v2, :cond_58

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_58

    check-cast v2, [Ljava/lang/Object;

    const/4 v3, 0x1

    aget-object v3, v2, v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v4

    if-eq v3, v4, :cond_2c

    const-string v1, "连接或配置已变化，等待新回读（旧结果不算当前成功）"

    goto :goto_58

    :cond_2c
    const/4 v3, 0x2

    aget-object v3, v2, v3

    check-cast v3, Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    sub-long/2addr v5, v3

    const-wide/16 v3, 0x3e8

    div-long/2addr v5, v3

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "最近检查结果（历史观察，"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v4, "秒前）："

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v4, 0x0

    aget-object v2, v2, v4

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_58
    .catchall {:try_start_3 .. :try_end_58} :catchall_5a

    :cond_58
    :goto_58
    monitor-exit v0

    return-object v1

    :catchall_5a
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const-string v1, "状态无法读取；未宣称已切换"

    return-object v1
.end method

.method public static publish(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)V
    .registers 11

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v1

    if-ne p2, v1, :cond_4e

    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4e

    sget-object v1, Lbt192/auto/V3Runtime;->results:Ljava/util/Map;

    if-nez v1, :cond_1a

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    sput-object v1, Lbt192/auto/V3Runtime;->results:Ljava/util/Map;

    :cond_1a
    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p3, v2, v3

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v3, 0x1

    aput-object v4, v2, v3

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const/4 v3, 0x2

    aput-object v4, v2, v3

    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "TARGET="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " RESULT="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1, p2}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V
    :try_end_4e
    .catchall {:try_start_3 .. :try_end_4e} :catchall_50

    :cond_4e
    monitor-exit v0

    return-void

    :catchall_50
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public static publishWorker(Landroid/content/Context;Ljava/lang/String;ILbt192/auto/Worker;)V
    .registers 9

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p3, Lbt192/auto/Worker;->res:Ljava/lang/String;

    invoke-static {v1}, Lbt192/auto/V3Runtime;->reasonLabel(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p3, Lbt192/auto/Worker;->observedAtElapsed:J

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-lez v1, :cond_2e

    const-string v1, "；本轮读取codec="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p3, Lbt192/auto/Worker;->observedCodecName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "，采样率="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p3, Lbt192/auto/Worker;->observedSampleRateMask:I

    invoke-static {v1}, Lbt192/auto/V3Runtime;->rateLabel(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2e
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lbt192/auto/V3Runtime;->publish(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)V

    invoke-static {p0, p1, p2, p3}, Lbt192/auto/V3StatusStore;->recordWorker(Landroid/content/Context;Ljava/lang/String;ILbt192/auto/Worker;)V

    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    :try_end_3b
    .catchall {:try_start_0 .. :try_end_3b} :catchall_3c

    return-void

    :catchall_3c
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private static rateLabel(I)Ljava/lang/String;
    .registers 3

    sparse-switch p0, :sswitch_data_24

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "未知/位掩码="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :sswitch_12
    const-string v0, "44.1kHz"

    return-object v0

    :sswitch_15
    const-string v0, "48kHz"

    return-object v0

    :sswitch_18
    const-string v0, "88.2kHz"

    return-object v0

    :sswitch_1b
    const-string v0, "96kHz"

    return-object v0

    :sswitch_1e
    const-string v0, "176.4kHz"

    return-object v0

    :sswitch_21
    const-string v0, "192kHz"

    return-object v0

    :sswitch_data_24
    .sparse-switch
        0x1 -> :sswitch_12
        0x2 -> :sswitch_15
        0x4 -> :sswitch_18
        0x8 -> :sswitch_1b
        0x10 -> :sswitch_1e
        0x20 -> :sswitch_21
    .end sparse-switch
.end method

.method private static reasonLabel(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    if-eqz p0, :cond_58

    const-string v0, "PROXY_PENDING"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_d

    const-string v0, "系统蓝牙代理尚未回复，为避免悬挂连接暂不增加请求；若长期不恢复，请从应用详情强行停止后重新打开，并核对无障碍绑定"

    return-object v0

    :cond_d
    const-string v0, "CURRENT_CODEC_UNKNOWN"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_18

    const-string v0, "当前编解码信息尚未读取，未下发"

    return-object v0

    :cond_18
    const-string v0, "CURRENT_CODEC_NOT_CONFIRMED_V5"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_23

    const-string v0, "当前编码尚未确认为LHDC V5，未下发"

    return-object v0

    :cond_23
    const-string v0, "192_UNSUPPORTED_OR_UNCONFIRMED"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2e

    const-string v0, "当前远端可选能力未确认192kHz或不支持，未下发"

    return-object v0

    :cond_2e
    const-string v0, "SUBMITTED_UNCONFIRMED"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_39

    const-string v0, "已发送192请求，但尚未回读确认，不能算成功"

    return-object v0

    :cond_39
    const-string v0, "ERROR_NOT_CONFIRMED"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_44

    const-string v0, "系统蓝牙读取或请求异常，未确认成功"

    return-object v0

    :cond_44
    const-string v0, "STALE_OR_INELIGIBLE_NOT_CONFIRMED"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4f

    const-string v0, "连接或开关已变化，旧任务结果无效"

    return-object v0

    :cond_4f
    const-string v0, "UNKNOWN_NOT_CONFIRMED"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_58

    return-object p0

    :cond_58
    const-string v0, "本轮未获得可确认结果，请检查蓝牙和附近设备授权"

    return-object v0
.end method
