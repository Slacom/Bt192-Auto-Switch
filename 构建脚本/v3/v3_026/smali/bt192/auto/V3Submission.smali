.class public final Lbt192/auto/V3Submission;
.super Ljava/lang/Object;


# static fields
.field private static pending:Ljava/util/Set;

.field private static poisoned:Z


# direct methods
.method public static confirmed(Ljava/lang/String;)V
    .registers 4

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    if-nez v1, :cond_a

    invoke-static {p0}, Lbt192/auto/V3Submission;->releaseLocked(Ljava/lang/String;)V
    :try_end_a
    .catchall {:try_start_3 .. :try_end_a} :catchall_c

    :cond_a
    :goto_a
    monitor-exit v0

    return-void

    :catchall_c
    move-exception v2

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    goto :goto_a
.end method

.method public static disconnected(Ljava/lang/String;)V
    .registers 4

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    if-nez v1, :cond_a

    invoke-static {p0}, Lbt192/auto/V3Submission;->releaseLocked(Ljava/lang/String;)V
    :try_end_a
    .catchall {:try_start_3 .. :try_end_a} :catchall_c

    :cond_a
    :goto_a
    monitor-exit v0

    return-void

    :catchall_c
    move-exception v2

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    goto :goto_a
.end method

.method private static normalize(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    if-eqz p0, :cond_13

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_13

    return-object v0

    :cond_13
    const/4 v0, 0x0

    return-object v0
.end method

.method public static pending(Ljava/lang/String;)Z
    .registers 5

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v2, 0x1

    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    if-nez v1, :cond_18

    const/4 v2, 0x0

    invoke-static {p0}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_18

    invoke-static {}, Lbt192/auto/V3Submission;->ready()V

    sget-object v3, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;

    invoke-interface {v3, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2
    :try_end_18
    .catchall {:try_start_3 .. :try_end_18} :catchall_1a

    :cond_18
    :goto_18
    monitor-exit v0

    return v2

    :catchall_1a
    move-exception v3

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    const/4 v2, 0x1

    goto :goto_18
.end method

.method private static ready()V
    .registers 1

    sget-object v0, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;

    if-nez v0, :cond_b

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;

    :cond_b
    return-void
.end method

.method private static releaseLocked(Ljava/lang/String;)V
    .registers 3

    invoke-static {p0}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_e

    invoke-static {}, Lbt192/auto/V3Submission;->ready()V

    sget-object v1, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    :cond_e
    return-void
.end method

.method public static reserve(Ljava/lang/String;)Z
    .registers 5

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v2, 0x0

    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    if-nez v1, :cond_17

    invoke-static {p0}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_17

    invoke-static {}, Lbt192/auto/V3Submission;->ready()V

    sget-object v3, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;

    invoke-interface {v3, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v2
    :try_end_17
    .catchall {:try_start_3 .. :try_end_17} :catchall_19

    :cond_17
    :goto_17
    monitor-exit v0

    return v2

    :catchall_19
    move-exception v3

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    const/4 v2, 0x0

    goto :goto_17
.end method

.method public static retry(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 6

    const-class v0, Lbt192/auto/CdmTrigger;

    monitor-enter v0

    :try_start_3
    const/4 v2, 0x0

    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    if-nez v1, :cond_23

    invoke-static {p1}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_23

    invoke-static {p0, v1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_23

    invoke-static {}, Lbt192/auto/V3Submission;->ready()V

    sget-object v3, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;

    invoke-interface {v3, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V

    const/4 v2, 0x1
    :try_end_23
    .catchall {:try_start_3 .. :try_end_23} :catchall_25

    :cond_23
    :goto_23
    monitor-exit v0

    return v2

    :catchall_25
    move-exception v3

    const/4 v1, 0x1

    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z

    const/4 v2, 0x0

    goto :goto_23
.end method
