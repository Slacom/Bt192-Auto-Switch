.class public Lbt192/auto/CdmService;
.super Landroid/companion/CompanionDeviceService;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/companion/CompanionDeviceService;-><init>()V

    return-void
.end method


# virtual methods
.method public onDeviceAppeared(Landroid/companion/AssociationInfo;)V
    .registers 4

    :try_start_0
    const-string v0, "getDeviceMacAddress"

    invoke-static {p1, v0}, Lbt192/auto/V3Codec;->call(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_f

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lbt192/auto/CdmService;->onDeviceAppeared(Ljava/lang/String;)V
    :try_end_f
    .catchall {:try_start_0 .. :try_end_f} :catchall_10

    :cond_f
    return-void

    :catchall_10
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public onDeviceAppeared(Ljava/lang/String;)V
    .registers 4

    :try_start_0
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_d

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end_d
    .catchall {:try_start_0 .. :try_end_d} :catchall_e

    :cond_d
    return-void

    :catchall_e
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method

.method public onDeviceDisappeared(Landroid/companion/AssociationInfo;)V
    .registers 2

    return-void
.end method

.method public onDeviceDisappeared(Ljava/lang/String;)V
    .registers 2

    return-void
.end method
