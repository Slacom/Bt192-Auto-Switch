.class public Lbt192/auto/Tick;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field public static current:Lbt192/auto/Tick;


# instance fields
.field private alive:Z

.field private final ctx:Landroid/content/Context;

.field private final h:Landroid/os/Handler;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .registers 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lbt192/auto/Tick;->ctx:Landroid/content/Context;

    iput-object p2, p0, Lbt192/auto/Tick;->h:Landroid/os/Handler;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lbt192/auto/Tick;->alive:Z

    return-void
.end method


# virtual methods
.method public run()V
    .registers 6

    :try_start_0
    sget-object v0, Lbt192/auto/Tick;->current:Lbt192/auto/Tick;

    if-ne v0, p0, :cond_33

    iget-boolean v0, p0, Lbt192/auto/Tick;->alive:Z

    if-eqz v0, :cond_33

    iget-object v0, p0, Lbt192/auto/Tick;->h:Landroid/os/Handler;

    const-wide/32 v1, 0xea60

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v0, p0, Lbt192/auto/Tick;->ctx:Landroid/content/Context;

    const-string v1, "android.permission.BLUETOOTH_CONNECT"

    invoke-virtual {v0, v1}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_33

    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1

    if-eqz v1, :cond_33

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/bluetooth/BluetoothAdapter;->getProfileConnectionState(I)I

    move-result v1

    if-ne v1, v2, :cond_33

    const-string v1, "TICK"

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v2

    invoke-static {v0, v1, v2}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_33
    .catchall {:try_start_0 .. :try_end_33} :catchall_34

    :cond_33
    return-void

    :catchall_34
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public stop()V
    .registers 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lbt192/auto/Tick;->alive:Z

    sget-object v1, Lbt192/auto/Tick;->current:Lbt192/auto/Tick;

    if-ne v1, p0, :cond_9

    sput-object v0, Lbt192/auto/Tick;->current:Lbt192/auto/Tick;

    :cond_9
    :try_start_9
    iget-object v1, p0, Lbt192/auto/Tick;->h:Landroid/os/Handler;

    invoke-virtual {v1, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_e
    .catchall {:try_start_9 .. :try_end_e} :catchall_f

    return-void

    :catchall_f
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method
