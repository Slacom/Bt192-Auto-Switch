.class public final Lbt192/auto/V3Association;
.super Landroid/companion/CompanionDeviceManager$Callback;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final owner:Ljava/lang/ref/WeakReference;

.field private final token:I


# direct methods
.method public constructor <init>(Lbt192/auto/V3Setup;I)V
    .registers 4

    invoke-direct {p0}, Landroid/companion/CompanionDeviceManager$Callback;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lbt192/auto/V3Association;->owner:Ljava/lang/ref/WeakReference;

    iput p2, p0, Lbt192/auto/V3Association;->token:I

    return-void
.end method

.method private owner()Lbt192/auto/V3Setup;
    .registers 3

    iget-object v0, p0, Lbt192/auto/V3Association;->owner:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lbt192/auto/V3Setup;

    if-eqz v0, :cond_13

    iget v1, p0, Lbt192/auto/V3Association;->token:I

    invoke-virtual {v0, v1}, Lbt192/auto/V3Setup;->associationCurrent(I)Z

    move-result v1

    if-eqz v1, :cond_13

    return-object v0

    :cond_13
    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method public onAssociationCreated(Landroid/companion/AssociationInfo;)V
    .registers 5

    :try_start_0
    invoke-direct {p0}, Lbt192/auto/V3Association;->owner()Lbt192/auto/V3Setup;

    move-result-object v0

    if-eqz v0, :cond_33

    if-eqz p1, :cond_2c

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x23

    if-lt v1, v2, :cond_1a

    invoke-virtual {p1}, Landroid/companion/AssociationInfo;->isSelfManaged()Z

    move-result v1

    if-eqz v1, :cond_1a

    iget v2, p0, Lbt192/auto/V3Association;->token:I

    invoke-virtual {v0, p1, v2}, Lbt192/auto/V3Setup;->selfAssociationCreated(Landroid/companion/AssociationInfo;I)V

    goto :goto_33

    :cond_1a
    const-string v1, "getDeviceMacAddress"

    invoke-static {p1, v1}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_2c

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lbt192/auto/V3Association;->token:I

    invoke-virtual {v0, v1, v2}, Lbt192/auto/V3Setup;->associationCreated(Ljava/lang/String;I)V

    goto :goto_33

    :cond_2c
    const-string v1, "系统关联结果未包含蓝牙地址；未开启自动切换"

    iget v2, p0, Lbt192/auto/V3Association;->token:I

    invoke-virtual {v0, v1, v2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    :try_end_33
    .catchall {:try_start_0 .. :try_end_33} :catchall_34

    :cond_33
    :goto_33
    return-void

    :catchall_34
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const-string v0, "关联结果读取失败；未开启自动切换"

    invoke-virtual {p0, v0}, Lbt192/auto/V3Association;->onFailure(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onAssociationPending(Landroid/content/IntentSender;)V
    .registers 2

    invoke-virtual {p0, p1}, Lbt192/auto/V3Association;->onDeviceFound(Landroid/content/IntentSender;)V

    return-void
.end method

.method public onDeviceFound(Landroid/content/IntentSender;)V
    .registers 4

    :try_start_0
    invoke-direct {p0}, Lbt192/auto/V3Association;->owner()Lbt192/auto/V3Setup;

    move-result-object v0

    if-eqz v0, :cond_b

    iget v1, p0, Lbt192/auto/V3Association;->token:I

    invoke-virtual {v0, p1, v1}, Lbt192/auto/V3Setup;->showAssociation(Landroid/content/IntentSender;I)V
    :try_end_b
    .catchall {:try_start_0 .. :try_end_b} :catchall_c

    :cond_b
    return-void

    :catchall_c
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public onFailure(ILjava/lang/CharSequence;)V
    .registers 3

    invoke-virtual {p0, p2}, Lbt192/auto/V3Association;->onFailure(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public onFailure(Ljava/lang/CharSequence;)V
    .registers 5

    :try_start_0
    invoke-direct {p0}, Lbt192/auto/V3Association;->owner()Lbt192/auto/V3Setup;

    move-result-object v0

    if-eqz v0, :cond_19

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "关联未完成："

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lbt192/auto/V3Association;->token:I

    invoke-virtual {v0, v1, v2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    :try_end_19
    .catchall {:try_start_0 .. :try_end_19} :catchall_1a

    :cond_19
    return-void

    :catchall_1a
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public run()V
    .registers 2

    const-string v0, "关联等待超时，请重新发起；未开启自动切换"

    invoke-virtual {p0, v0}, Lbt192/auto/V3Association;->onFailure(Ljava/lang/CharSequence;)V

    return-void
.end method
