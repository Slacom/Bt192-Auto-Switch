.class public final Lbt192/auto/V3ListTouch;
.super Ljava/lang/Object;
.implements Landroid/view/View$OnTouchListener;

# Attach only to the inner ScrollView; never to the outer page/root.
# Release parent interception on UP/CANCEL; do not consume events or clicks.
.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 4
    :try_start
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I
    move-result v0
    if-eqz v0, :down
    const/4 v1, 0x1               # ACTION_UP
    if-eq v0, v1, :release
    const/4 v1, 0x3               # ACTION_CANCEL
    if-eq v0, v1, :release
    goto :try_end
    :down
    const/4 v1, 0x1
    goto :notify
    :release
    const/4 v1, 0x0
    :notify
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;
    move-result-object v2
    if-eqz v2, :try_end
    invoke-interface {v2, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V
    :try_end
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :degraded
    :degraded
    move-exception v3
    const/4 v0, 0x0
    return v0
.end method
