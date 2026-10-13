.class public Lbt192/auto/CdmCb;
.super Landroid/companion/CompanionDeviceManager$Callback;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field act:Lbt192/auto/AutoEntry;


# direct methods
.method public constructor <init>(Lbt192/auto/AutoEntry;)V
    .registers 2

    invoke-direct {p0}, Landroid/companion/CompanionDeviceManager$Callback;-><init>()V

    iput-object p1, p0, Lbt192/auto/CdmCb;->act:Lbt192/auto/AutoEntry;

    return-void
.end method


# virtual methods
.method public onAssociationCreated(Landroid/companion/AssociationInfo;)V
    .registers 6

    :try_start_0
    const-string v0, "CDM association created"

    invoke-static {v0}, Lbt192/auto/Worker;->logw(Ljava/lang/String;)V

    iget-object v0, p0, Lbt192/auto/CdmCb;->act:Lbt192/auto/AutoEntry;

    const-string v1, "已关联耳机，正在切换..."

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    const-wide/16 v2, 0x5dc

    invoke-virtual {v1, p0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
    :try_end_20
    .catchall {:try_start_0 .. :try_end_20} :catchall_21

    return-void

    :catchall_21
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public onFailure(Ljava/lang/CharSequence;)V
    .registers 5

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "CDM onFailure: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/Worker;->logw(Ljava/lang/String;)V

    iget-object v0, p0, Lbt192/auto/CdmCb;->act:Lbt192/auto/AutoEntry;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "关联失败: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    invoke-virtual {v0}, Lbt192/auto/AutoEntry;->finish()V

    return-void
    :try_end_37
    .catchall {:try_start_0 .. :try_end_37} :catchall_38

    return-void

    :catchall_38
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public run()V
    .registers 2

    :try_start_0
    iget-object v0, p0, Lbt192/auto/CdmCb;->act:Lbt192/auto/AutoEntry;

    invoke-virtual {v0}, Lbt192/auto/AutoEntry;->startWorker()V

    return-void
    :try_end_6
    .catchall {:try_start_0 .. :try_end_6} :catchall_7

    return-void

    :catchall_7
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method
