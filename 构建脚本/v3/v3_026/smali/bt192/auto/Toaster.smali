.class public Lbt192/auto/Toaster;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final act:Landroid/content/Context;

.field private final msg:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lbt192/auto/Toaster;->act:Landroid/content/Context;

    iput-object p2, p0, Lbt192/auto/Toaster;->msg:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public run()V
    .registers 4

    :try_start_0
    iget-object v0, p0, Lbt192/auto/Toaster;->act:Landroid/content/Context;

    instance-of v1, v0, Lbt192/auto/AutoEntry;

    if-eqz v1, :cond_2a

    check-cast v0, Lbt192/auto/AutoEntry;

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v1

    if-nez v1, :cond_2a

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_2a

    iget-boolean v2, v0, Lbt192/auto/AutoEntry;->uiDone:Z

    if-nez v2, :cond_2a

    iget-object v1, p0, Lbt192/auto/Toaster;->msg:Ljava/lang/String;

    if-eqz v1, :cond_24

    const-string v2, "NEED_CDM"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_27

    :cond_24
    const/4 v2, 0x1

    iput-boolean v2, v0, Lbt192/auto/AutoEntry;->uiDone:Z

    :cond_27
    invoke-virtual {v0, v1}, Lbt192/auto/AutoEntry;->handleResult(Ljava/lang/String;)V
    :try_end_2a
    .catchall {:try_start_0 .. :try_end_2a} :catchall_2b

    :cond_2a
    return-void

    :catchall_2b
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    return-void
.end method
