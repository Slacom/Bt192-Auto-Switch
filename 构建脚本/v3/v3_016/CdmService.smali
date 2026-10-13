.class public Lbt192/auto/CdmService;
.super Landroid/companion/CompanionDeviceService;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/companion/CompanionDeviceService;-><init>()V
    return-void
.end method

.method public onDeviceAppeared(Ljava/lang/String;)V
    .locals 2
    :try_start
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :done
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onDeviceAppeared(Landroid/companion/AssociationInfo;)V
    .locals 2
    :try_start
    const-string v0, "getDeviceMacAddress"
    invoke-static {p1, v0}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p0, v0}, Lbt192/auto/CdmService;->onDeviceAppeared(Ljava/lang/String;)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onDeviceDisappeared(Ljava/lang/String;)V
    .locals 0
    # Companion presence disappearance does not prove A2DP disconnected.
    return-void
.end method

.method public onDeviceDisappeared(Landroid/companion/AssociationInfo;)V
    .locals 0
    return-void
.end method
