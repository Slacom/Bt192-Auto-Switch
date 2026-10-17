.class public Lbt192/auto/A2dpRx;
.super Landroid/content/BroadcastReceiver;


# instance fields
.field private final owner:Lbt192/auto/WatchService2;


# direct methods
.method public constructor <init>()V
    .registers 2

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lbt192/auto/A2dpRx;-><init>(Lbt192/auto/WatchService2;)V

    return-void
.end method

.method public constructor <init>(Lbt192/auto/WatchService2;)V
    .registers 2

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    iput-object p1, p0, Lbt192/auto/A2dpRx;->owner:Lbt192/auto/WatchService2;

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 9

    :try_start_0
    iget-object v0, p0, Lbt192/auto/A2dpRx;->owner:Lbt192/auto/WatchService2;

    if-eqz v0, :cond_65

    sget-object v1, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;

    if-ne v0, v1, :cond_65

    if-eqz p2, :cond_65

    const-string v0, "android.bluetooth.a2dp.profile.action.CONNECTION_STATE_CHANGED"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_65

    const-string v0, "android.bluetooth.device.extra.DEVICE"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    instance-of v1, v0, Landroid/bluetooth/BluetoothDevice;

    if-eqz v1, :cond_65

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v2

    const-string v0, "android.bluetooth.profile.extra.STATE"

    const/4 v1, -0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v2, v3}, Lbt192/auto/V3StatusStore;->connectionState(Ljava/lang/String;I)V

    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V

    invoke-static {p1, v2, v3}, Lbt192/auto/CdmTrigger;->signalFor(Landroid/content/Context;Ljava/lang/String;I)V

    invoke-static {p1, v2}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_65

    const-string v0, "android.bluetooth.profile.extra.STATE"

    const/4 v1, -0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    if-ltz v3, :cond_65

    const/4 v0, 0x3

    if-gt v3, v0, :cond_65

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v0, "A2DP MAC="

    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " STATE="

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lbt192/auto/CdmTrigger;->generation()I

    move-result v5

    invoke-static {p1, v4, v5}, Lbt192/auto/Worker;->event(Landroid/content/Context;Ljava/lang/String;I)V
    :try_end_65
    .catchall {:try_start_0 .. :try_end_65} :catchall_66

    :cond_65
    return-void

    :catchall_66
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method
