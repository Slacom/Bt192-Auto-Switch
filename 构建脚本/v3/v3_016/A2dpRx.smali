.class public Lbt192/auto/A2dpRx;
.super Landroid/content/BroadcastReceiver;
.field private final owner:Lbt192/auto/WatchService2;

.method public constructor <init>()V
    .locals 1
    const/4 v0, 0x0
    invoke-direct {p0, v0}, Lbt192/auto/A2dpRx;-><init>(Lbt192/auto/WatchService2;)V
    return-void
.end method

.method public constructor <init>(Lbt192/auto/WatchService2;)V
    .locals 0
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    iput-object p1, p0, Lbt192/auto/A2dpRx;->owner:Lbt192/auto/WatchService2;
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    :try_start
    iget-object v0, p0, Lbt192/auto/A2dpRx;->owner:Lbt192/auto/WatchService2;
    if-eqz v0, :done
    sget-object v1, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;
    if-ne v0, v1, :done
    if-eqz p2, :done
    const-string v0, "android.bluetooth.a2dp.profile.action.CONNECTION_STATE_CHANGED"
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :done
    const-string v0, "android.bluetooth.device.extra.DEVICE"
    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;
    move-result-object v0
    instance-of v1, v0, Landroid/bluetooth/BluetoothDevice;
    if-eqz v1, :done
    check-cast v0, Landroid/bluetooth/BluetoothDevice;
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;
    move-result-object v2
    # Session history observes physical events even when auto-switch is disabled.
    const-string v0, "android.bluetooth.profile.extra.STATE"
    const/4 v1, -0x1
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v3
    invoke-static {v2, v3}, Lbt192/auto/V3StatusStore;->connectionState(Ljava/lang/String;I)V
    # A device-bearing connection event may refresh the passive status cache,
    # even for an associated target whose automatic switch is disabled.
    invoke-static {p1}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    # Physical0 cleanup must not depend on current switch eligibility or proxy
    # acquisition. Coordinator deduplicates/fences and releases under one lock.
    invoke-static {p1, v2, v3}, Lbt192/auto/CdmTrigger;->signalFor(Landroid/content/Context;Ljava/lang/String;I)V
    invoke-static {p1, v2}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :done
    const-string v0, "android.bluetooth.profile.extra.STATE"
    const/4 v1, -0x1
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v3
    if-ltz v3, :done
    const/4 v0, 0x3
    if-gt v3, v0, :done
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
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method
