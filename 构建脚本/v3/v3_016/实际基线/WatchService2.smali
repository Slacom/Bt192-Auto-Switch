.class public Lbt192/auto/WatchService2;
.super Landroid/accessibilityservice/AccessibilityService;


# static fields
.field public static current:Lbt192/auto/WatchService2;


# instance fields
.field private h:Landroid/os/Handler;

.field private registered:Z

.field private rx:Lbt192/auto/A2dpRx;

.field private tick:Lbt192/auto/Tick;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/accessibilityservice/AccessibilityService;-><init>()V

    return-void
.end method

.method private dispose()V
    .registers 3

    :try_start_0
    invoke-direct {p0}, Lbt192/auto/WatchService2;->stop()V

    sget-object v0, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;

    if-ne v0, p0, :cond_12

    const/4 v0, 0x0

    sput-object v0, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    :try_end_12
    .catchall {:try_start_0 .. :try_end_12} :catchall_13

    :cond_12
    return-void

    :catchall_13
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private register()V
    .registers 7

    :try_start_0
    move-object v0, p0

    new-instance v1, Lbt192/auto/A2dpRx;

    invoke-direct {v1, p0}, Lbt192/auto/A2dpRx;-><init>(Lbt192/auto/WatchService2;)V

    iput-object v1, p0, Lbt192/auto/WatchService2;->rx:Lbt192/auto/A2dpRx;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.bluetooth.a2dp.profile.action.CONNECTION_STATE_CHANGED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    const-string v3, "android.permission.BLUETOOTH_CONNECT"

    const/4 v4, 0x0

    const/4 v5, 0x2

    invoke-virtual/range {v0 .. v5}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;I)Landroid/content/Intent;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lbt192/auto/WatchService2;->registered:Z
    :try_end_19
    .catchall {:try_start_0 .. :try_end_19} :catchall_1a

    return-void

    :catchall_1a
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method private stop()V
    .registers 3

    :try_start_0
    iget-object v0, p0, Lbt192/auto/WatchService2;->tick:Lbt192/auto/Tick;

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Lbt192/auto/Tick;->stop()V

    const/4 v0, 0x0

    iput-object v0, p0, Lbt192/auto/WatchService2;->tick:Lbt192/auto/Tick;
    :try_end_a
    .catchall {:try_start_0 .. :try_end_a} :catchall_b

    :cond_a
    goto :goto_f

    :catchall_b
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :goto_f
    :try_start_f
    iget-boolean v0, p0, Lbt192/auto/WatchService2;->registered:Z

    if-eqz v0, :cond_20

    const/4 v0, 0x0

    iput-boolean v0, p0, Lbt192/auto/WatchService2;->registered:Z

    iget-object v0, p0, Lbt192/auto/WatchService2;->rx:Lbt192/auto/A2dpRx;

    invoke-virtual {p0, v0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_1b
    .catchall {:try_start_f .. :try_end_1b} :catchall_1c

    goto :goto_20

    :catchall_1c
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_20
    :goto_20
    return-void
.end method


# virtual methods
.method public onAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .registers 2

    return-void
.end method

.method public onDestroy()V
    .registers 2

    invoke-direct {p0}, Lbt192/auto/WatchService2;->dispose()V

    :try_start_3
    invoke-super {p0}, Landroid/accessibilityservice/AccessibilityService;->onDestroy()V
    :try_end_6
    .catchall {:try_start_3 .. :try_end_6} :catchall_7

    return-void

    :catchall_7
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public onInterrupt()V
    .registers 1

    return-void
.end method

.method protected onServiceConnected()V
    .registers 6

    :try_start_0
    invoke-super {p0}, Landroid/accessibilityservice/AccessibilityService;->onServiceConnected()V

    sget-object v0, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;

    if-eqz v0, :cond_c

    if-eq v0, p0, :cond_c

    invoke-direct {v0}, Lbt192/auto/WatchService2;->stop()V

    :cond_c
    invoke-direct {p0}, Lbt192/auto/WatchService2;->stop()V

    sput-object p0, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lbt192/auto/AutoEntry;->ctx:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V

    invoke-direct {p0}, Lbt192/auto/WatchService2;->register()V

    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lbt192/auto/WatchService2;->h:Landroid/os/Handler;

    new-instance v2, Lbt192/auto/Tick;

    invoke-direct {v2, v0, v1}, Lbt192/auto/Tick;-><init>(Landroid/content/Context;Landroid/os/Handler;)V

    iput-object v2, p0, Lbt192/auto/WatchService2;->tick:Lbt192/auto/Tick;

    sput-object v2, Lbt192/auto/Tick;->current:Lbt192/auto/Tick;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    const-string v1, "SERVICE_READY"

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v2

    invoke-static {v0, v1, v2}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V
    :try_end_3e
    .catchall {:try_start_0 .. :try_end_3e} :catchall_3f

    return-void

    :catchall_3f
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public onUnbind(Landroid/content/Intent;)Z
    .registers 3

    invoke-direct {p0}, Lbt192/auto/WatchService2;->dispose()V

    :try_start_3
    invoke-super {p0, p1}, Landroid/accessibilityservice/AccessibilityService;->onUnbind(Landroid/content/Intent;)Z

    move-result v0
    :try_end_7
    .catchall {:try_start_3 .. :try_end_7} :catchall_8

    return v0

    :catchall_8
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const/4 v0, 0x0

    return v0
.end method
