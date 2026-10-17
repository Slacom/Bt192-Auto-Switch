.class public final Lbt192/auto/V3Reflow;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final owner:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lbt192/auto/V3Setup;)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lbt192/auto/V3Reflow;->owner:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method public static handler()Landroid/os/Handler;
    .registers 2

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-object v0
.end method

.method public static task(Lbt192/auto/V3Setup;)Ljava/lang/Runnable;
    .registers 2

    new-instance v0, Lbt192/auto/V3Reflow;

    invoke-direct {v0, p0}, Lbt192/auto/V3Reflow;-><init>(Lbt192/auto/V3Setup;)V

    return-object v0
.end method


# virtual methods
.method public run()V
    .registers 2

    :try_start_0
    iget-object v0, p0, Lbt192/auto/V3Reflow;->owner:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lbt192/auto/V3Setup;

    if-eqz v0, :cond_d

    invoke-virtual {v0}, Lbt192/auto/V3Setup;->performReflow()V
    :try_end_d
    .catchall {:try_start_0 .. :try_end_d} :catchall_e

    :cond_d
    return-void

    :catchall_e
    move-exception v0

    return-void
.end method
