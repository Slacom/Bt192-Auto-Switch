.class public final Lbt192/auto/V3Association;
.super Landroid/companion/CompanionDeviceManager$Callback;
.implements Ljava/lang/Runnable;

.field private final owner:Ljava/lang/ref/WeakReference;
.field private final token:I

.method public constructor <init>(Lbt192/auto/V3Setup;I)V
    .locals 1
    invoke-direct {p0}, Landroid/companion/CompanionDeviceManager$Callback;-><init>()V
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lbt192/auto/V3Association;->owner:Ljava/lang/ref/WeakReference;
    iput p2, p0, Lbt192/auto/V3Association;->token:I
    return-void
.end method

.method private owner()Lbt192/auto/V3Setup;
    .locals 2
    iget-object v0, p0, Lbt192/auto/V3Association;->owner:Ljava/lang/ref/WeakReference;
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Lbt192/auto/V3Setup;
    if-eqz v0, :none
    iget v1, p0, Lbt192/auto/V3Association;->token:I
    invoke-virtual {v0, v1}, Lbt192/auto/V3Setup;->associationCurrent(I)Z
    move-result v1
    if-eqz v1, :none
    return-object v0
    :none
    const/4 v0, 0x0
    return-object v0
.end method

.method public onDeviceFound(Landroid/content/IntentSender;)V
    .locals 2
    :try_start
    invoke-direct {p0}, Lbt192/auto/V3Association;->owner()Lbt192/auto/V3Setup;
    move-result-object v0
    if-eqz v0, :done
    iget v1, p0, Lbt192/auto/V3Association;->token:I
    invoke-virtual {v0, p1, v1}, Lbt192/auto/V3Setup;->showAssociation(Landroid/content/IntentSender;I)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onAssociationPending(Landroid/content/IntentSender;)V
    .locals 0
    invoke-virtual {p0, p1}, Lbt192/auto/V3Association;->onDeviceFound(Landroid/content/IntentSender;)V
    return-void
.end method

.method public onAssociationCreated(Landroid/companion/AssociationInfo;)V
    .locals 3
    :try_start
    invoke-direct {p0}, Lbt192/auto/V3Association;->owner()Lbt192/auto/V3Setup;
    move-result-object v0
    if-eqz v0, :done
    if-eqz p1, :missing_mac
    # isSelfManaged() is a public SDK method only on API35+.
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v2, 0x23
    if-lt v1, v2, :normal_mac
    invoke-virtual {p1}, Landroid/companion/AssociationInfo;->isSelfManaged()Z
    move-result v1
    if-eqz v1, :normal_mac
    iget v2, p0, Lbt192/auto/V3Association;->token:I
    invoke-virtual {v0, p1, v2}, Lbt192/auto/V3Setup;->selfAssociationCreated(Landroid/companion/AssociationInfo;I)V
    goto :done
    :normal_mac
    const-string v1, "getDeviceMacAddress"
    invoke-static {p1, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    if-eqz v1, :missing_mac
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v1
    iget v2, p0, Lbt192/auto/V3Association;->token:I
    invoke-virtual {v0, v1, v2}, Lbt192/auto/V3Setup;->associationCreated(Ljava/lang/String;I)V
    goto :done
    :missing_mac
    const-string v1, "系统关联结果未包含蓝牙地址；未开启自动切换"
    iget v2, p0, Lbt192/auto/V3Association;->token:I
    invoke-virtual {v0, v1, v2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const-string v0, "关联结果读取失败；未开启自动切换"
    invoke-virtual {p0, v0}, Lbt192/auto/V3Association;->onFailure(Ljava/lang/CharSequence;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onFailure(Ljava/lang/CharSequence;)V
    .locals 3
    :try_start
    invoke-direct {p0}, Lbt192/auto/V3Association;->owner()Lbt192/auto/V3Setup;
    move-result-object v0
    if-eqz v0, :done
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "关联未完成："
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    iget v2, p0, Lbt192/auto/V3Association;->token:I
    invoke-virtual {v0, v1, v2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public run()V
    .locals 1
    const-string v0, "关联等待超时，请重新发起；未开启自动切换"
    invoke-virtual {p0, v0}, Lbt192/auto/V3Association;->onFailure(Ljava/lang/CharSequence;)V
    return-void
.end method

.method public onFailure(ILjava/lang/CharSequence;)V
    .locals 0
    invoke-virtual {p0, p2}, Lbt192/auto/V3Association;->onFailure(Ljava/lang/CharSequence;)V
    return-void
.end method
