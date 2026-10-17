.class public Lbt192/auto/CdmTrigger;
.super Ljava/lang/Thread;


# static fields
.field private static active:Lbt192/auto/CdmTrigger;

.field private static volatile epoch:I

.field private static hint:Ljava/lang/String;

.field private static states:Ljava/util/Map;


# instance fields
.field private final ctx:Landroid/content/Context;

.field private final gen:I

.field private pending:Z

.field private final priority:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v0

    invoke-direct {p0, p1, v0}, Lbt192/auto/CdmTrigger;-><init>(Landroid/content/Context;I)V

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;I)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_a

    move-object v0, p1

    :cond_a
    iput-object v0, p0, Lbt192/auto/CdmTrigger;->ctx:Landroid/content/Context;

    iput p2, p0, Lbt192/auto/CdmTrigger;->gen:I

    sget-object v0, Lbt192/auto/CdmTrigger;->hint:Ljava/lang/String;

    iput-object v0, p0, Lbt192/auto/CdmTrigger;->priority:Ljava/lang/String;

    const-string v0, "bt192-v3-serial"

    invoke-virtual {p0, v0}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    return-void
.end method

.method public static error(Ljava/lang/Throwable;)V
    .registers 3

    :try_start_0
    const-string v0, "bt192-fast"

    const-string v1, "v3_013 error"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_7
    .catchall {:try_start_0 .. :try_end_7} :catchall_8

    return-void

    :catchall_8
    move-exception v0

    return-void
.end method

.method public static generation()I
    .registers 1

    sget v0, Lbt192/auto/CdmTrigger;->epoch:I

    return v0
.end method

.method public static invalidate()V
    .registers 3

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget v1, Lbt192/auto/CdmTrigger;->epoch:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lbt192/auto/CdmTrigger;->epoch:I

    const/4 v1, 0x0

    sput-object v1, Lbt192/auto/CdmTrigger;->hint:Ljava/lang/String;

    sput-object v1, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;

    sget-object v2, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    if-eqz v2, :cond_14

    iput-boolean v1, v2, Lbt192/auto/CdmTrigger;->pending:Z
    :try_end_14
    .catchall {:try_start_3 .. :try_end_14} :catchall_16

    :cond_14
    monitor-exit v0

    return-void

    :catchall_16
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private static launch(Landroid/content/Context;I)V
    .registers 5

    :try_start_0
    new-instance v0, Lbt192/auto/CdmTrigger;

    invoke-direct {v0, p0, p1}, Lbt192/auto/CdmTrigger;-><init>(Landroid/content/Context;I)V
    :try_end_5
    .catchall {:try_start_0 .. :try_end_5} :catchall_b

    :try_start_5
    sput-object v0, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    :try_end_a
    .catchall {:try_start_5 .. :try_end_a} :catchall_10

    return-void

    :catchall_b
    move-exception v1

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void

    :catchall_10
    move-exception v1

    sget-object v2, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    if-ne v2, v0, :cond_18

    const/4 v2, 0x0

    sput-object v2, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    :cond_18
    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public static manual(Landroid/content/Context;)Z
    .registers 2

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V

    const/4 v0, 0x0

    return v0
.end method

.method public static observedConnected(Ljava/lang/String;I)Z
    .registers 6

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v1, 0x0

    sget v2, Lbt192/auto/CdmTrigger;->epoch:I

    if-ne p1, v2, :cond_1e

    if-eqz p0, :cond_1e

    sget-object v2, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;

    if-eqz v2, :cond_1e

    invoke-interface {v2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_1e

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_1e

    const/4 v1, 0x1
    :try_end_1e
    .catchall {:try_start_3 .. :try_end_1e} :catchall_20

    :cond_1e
    monitor-exit v0

    return v1

    :catchall_20
    move-exception v2

    const/4 v1, 0x0

    monitor-exit v0

    return v1
.end method

.method public static proxyReady(Landroid/content/Context;)V
    .registers 3

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget v1, Lbt192/auto/CdmTrigger;->epoch:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lbt192/auto/CdmTrigger;->epoch:I

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_c
    .catchall {:try_start_3 .. :try_end_c} :catchall_e

    monitor-exit v0

    return-void

    :catchall_e
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private release()V
    .registers 5

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget-object v1, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    if-ne v1, p0, :cond_19

    const/4 v1, 0x0

    sput-object v1, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    iget-boolean v1, p0, Lbt192/auto/CdmTrigger;->pending:Z

    if-eqz v1, :cond_19

    sget v2, Lbt192/auto/CdmTrigger;->epoch:I

    iget v3, p0, Lbt192/auto/CdmTrigger;->gen:I

    if-eq v2, v3, :cond_19

    iget-object v1, p0, Lbt192/auto/CdmTrigger;->ctx:Landroid/content/Context;

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_19
    .catchall {:try_start_3 .. :try_end_19} :catchall_1b

    :cond_19
    monitor-exit v0

    return-void

    :catchall_1b
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public static request(Landroid/content/Context;)V
    .registers 5

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    invoke-static {p0}, Lbt192/auto/V3Targets;->enabledSet(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1e

    sget-object v1, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    sget v2, Lbt192/auto/CdmTrigger;->epoch:I

    if-eqz v1, :cond_1b

    iget v3, v1, Lbt192/auto/CdmTrigger;->gen:I

    if-eq v3, v2, :cond_1e

    const/4 v3, 0x1

    iput-boolean v3, v1, Lbt192/auto/CdmTrigger;->pending:Z

    goto :goto_1e

    :cond_1b
    invoke-static {p0, v2}, Lbt192/auto/CdmTrigger;->launch(Landroid/content/Context;I)V
    :try_end_1e
    .catchall {:try_start_3 .. :try_end_1e} :catchall_20

    :cond_1e
    :goto_1e
    monitor-exit v0

    return-void

    :catchall_20
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private static shouldRetry(Ljava/lang/String;)Z
    .registers 3

    if-eqz p0, :cond_9

    const-string v0, "RETRY|PROXY_PENDING|UNKNOWN_NOT_CONFIRMED|CURRENT_CODEC_UNKNOWN|CURRENT_CODEC_NOT_READY|CURRENT_CODEC_NOT_CONFIRMED_V5|CURRENT_CODEC_CHANGED_NO_SUBMIT|192_UNSUPPORTED_OR_UNCONFIRMED"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v1

    return v1

    :cond_9
    const/4 v0, 0x0

    return v0
.end method

.method public static signal(Landroid/content/Context;I)V
    .registers 2

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V

    return-void
.end method

.method public static signalFor(Landroid/content/Context;Ljava/lang/String;I)V
    .registers 8

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    if-eqz p1, :cond_65

    invoke-static {p1}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_65

    if-ltz p2, :cond_65

    const/4 v1, 0x3

    if-gt p2, v1, :cond_65

    sget-object v1, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;

    if-nez v1, :cond_1b

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    sput-object v1, Lbt192/auto/CdmTrigger;->states:Ljava/util/Map;

    :cond_1b
    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_29

    const/4 v3, -0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_29
    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-eq v3, p2, :cond_65

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    if-nez p2, :cond_4e

    sget v3, Lbt192/auto/CdmTrigger;->epoch:I

    add-int/lit8 v3, v3, 0x1

    sput v3, Lbt192/auto/CdmTrigger;->epoch:I

    sget-object v4, Lbt192/auto/CdmTrigger;->active:Lbt192/auto/CdmTrigger;

    if-eqz v4, :cond_44

    const/4 v3, 0x1

    iput-boolean v3, v4, Lbt192/auto/CdmTrigger;->pending:Z

    :cond_44
    invoke-static {p1}, Lbt192/auto/V3Submission;->disconnected(Ljava/lang/String;)V

    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V

    goto :goto_65

    :cond_4e
    invoke-interface {v1, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_65

    const/4 v3, 0x2

    if-ne p2, v3, :cond_5c

    sput-object p1, Lbt192/auto/CdmTrigger;->hint:Ljava/lang/String;

    :cond_5c
    sget v3, Lbt192/auto/CdmTrigger;->epoch:I

    add-int/lit8 v3, v3, 0x1

    sput v3, Lbt192/auto/CdmTrigger;->epoch:I

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_65
    .catchall {:try_start_3 .. :try_end_65} :catchall_67

    :cond_65
    :goto_65
    monitor-exit v0

    return-void

    :catchall_67
    move-exception v1

    monitor-exit v0

    invoke-static {v1}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 13

    :try_start_0
    iget-object v1, p0, Lbt192/auto/CdmTrigger;->ctx:Landroid/content/Context;

    iget v3, p0, Lbt192/auto/CdmTrigger;->gen:I

    invoke-static {v1}, Lbt192/auto/V3Targets;->enabledSet(Landroid/content/Context;)Ljava/util/Set;

    move-result-object v6

    new-instance v7, Ljava/util/TreeSet;

    invoke-direct {v7, v6}, Ljava/util/TreeSet;-><init>(Ljava/util/Collection;)V

    new-instance v6, Ljava/util/LinkedHashSet;

    invoke-direct {v6}, Ljava/util/LinkedHashSet;-><init>()V

    iget-object v2, p0, Lbt192/auto/CdmTrigger;->priority:Ljava/lang/String;

    if-eqz v2, :cond_1f

    invoke-virtual {v7, v2}, Ljava/util/TreeSet;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1f

    invoke-virtual {v6, v2}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    :cond_1f
    invoke-virtual {v6, v7}, Ljava/util/LinkedHashSet;->addAll(Ljava/util/Collection;)Z

    invoke-virtual {v6}, Ljava/util/LinkedHashSet;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_26
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v8

    if-ne v3, v8, :cond_79

    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_79

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v1, v2}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_26

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    const-wide/16 v8, 0x1f40

    add-long/2addr v4, v8

    const/4 v7, 0x0

    :goto_46
    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v8

    if-ne v3, v8, :cond_79

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v8

    cmp-long v10, v8, v4

    if-gez v10, :cond_26

    new-instance v0, Lbt192/auto/Worker;

    invoke-direct/range {v0 .. v5}, Lbt192/auto/Worker;-><init>(Landroid/content/Context;Ljava/lang/String;IJ)V

    invoke-virtual {v0}, Lbt192/auto/Worker;->run()V

    iget-object v11, v0, Lbt192/auto/Worker;->res:Ljava/lang/String;

    invoke-static {v1, v2, v3, v0}, Lbt192/auto/V3Runtime;->publishWorker(Landroid/content/Context;Ljava/lang/String;ILbt192/auto/Worker;)V

    iget-boolean v10, v0, Lbt192/auto/Worker;->success:Z

    if-nez v10, :cond_26

    invoke-static {v11}, Lbt192/auto/CdmTrigger;->shouldRetry(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_26

    add-int/lit8 v7, v7, 0x1

    const/4 v8, 0x4

    if-ge v7, v8, :cond_26

    const-wide/16 v8, 0xfa

    add-int/lit8 v10, v7, -0x1

    shl-long/2addr v8, v10

    invoke-static {v8, v9}, Ljava/lang/Thread;->sleep(J)V

    goto :goto_46
    :try_end_79
    .catchall {:try_start_0 .. :try_end_79} :catchall_7d

    :cond_79
    invoke-direct {p0}, Lbt192/auto/CdmTrigger;->release()V

    return-void

    :catchall_7d
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    invoke-direct {p0}, Lbt192/auto/CdmTrigger;->release()V

    return-void
.end method
