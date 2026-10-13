.class public final Lbt192/auto/V3DeviceScroll;
.super Landroid/widget/ScrollView;
.implements Ljava/lang/Runnable;
# UI-only; mode0 normal,1 armed,2 reorder,3 rail,4 cancelled-until-UP.
.field private mode:I
.field private touching:Z
.field private candidate:Landroid/view/View;
.field private original:Ljava/util/List;
.field private downX:F
.field private downY:F
.field private lastY:F
.field private thumbGrab:F
.field private slop:I
.field private rail:I
.field private fadeAt:J
.field private paint:Landroid/graphics/Paint;

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V
    const/16 v0, 0x14
    invoke-static {p1, v0}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v0
    iput v0, p0, Lbt192/auto/V3DeviceScroll;->rail:I
    const/4 v1, 0x0
    invoke-virtual {p0, v1, v1, v0, v1}, Landroid/view/View;->setPadding(IIII)V
    invoke-virtual {p0, v1}, Landroid/view/View;->setVerticalScrollBarEnabled(Z)V
    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;
    move-result-object v0
    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I
    move-result v0
    iput v0, p0, Lbt192/auto/V3DeviceScroll;->slop:I
    new-instance v0, Landroid/graphics/Paint;
    const/4 v1, 0x1
    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V
    const v1, 0xff9ca3af
    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V
    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->paint:Landroid/graphics/Paint;
    return-void
.end method

.method private rowsView()Landroid/widget/LinearLayout;
    .locals 2
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I
    move-result v0
    if-eqz v0, :none
    const/4 v0, 0x0
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v0
    instance-of v1, v0, Landroid/widget/LinearLayout;
    if-eqz v1, :none
    check-cast v0, Landroid/widget/LinearLayout;
    return-object v0
    :none
    const/4 v0, 0x0
    return-object v0
.end method

.method private outer(Z)V
    .locals 1
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;
    move-result-object v0
    if-eqz v0, :done
    invoke-interface {v0, p1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V
    :done
    return-void
.end method

.method public busy()Z
    .locals 6
    iget-boolean v0, p0, Lbt192/auto/V3DeviceScroll;->touching:Z
    if-nez v0, :yes
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J
    move-result-wide v0
    iget-wide v2, p0, Lbt192/auto/V3DeviceScroll;->fadeAt:J
    sub-long/2addr v0, v2
    const-wide/16 v2, 0x258
    cmp-long v4, v0, v2
    if-ltz v4, :yes
    const/4 v0, 0x0
    return v0
    :yes
    const/4 v0, 0x1
    return v0
.end method

.method private showRail()V
    .locals 2
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J
    move-result-wide v0
    iput-wide v0, p0, Lbt192/auto/V3DeviceScroll;->fadeAt:J
    invoke-virtual {p0}, Landroid/view/View;->invalidate()V
    return-void
.end method

.method protected onScrollChanged(IIII)V
    .locals 0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ScrollView;->onScrollChanged(IIII)V
    if-eq p2, p4, :done
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->showRail()V
    :done
    return-void
.end method

.method private range()I
    .locals 3
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;
    move-result-object v0
    if-eqz v0, :zero
    invoke-virtual {v0}, Landroid/view/View;->getHeight()I
    move-result v0
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I
    move-result v1
    sub-int/2addr v0, v1
    const/4 v2, 0x0
    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I
    move-result v0
    return v0
    :zero
    const/4 v0, 0x0
    return v0
.end method

.method private thumbHeight()I
    .locals 5
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I
    move-result v0
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I
    move-result v1
    add-int/2addr v1, v0
    if-lez v1, :zero
    int-to-float v2, v0
    mul-float/2addr v2, v2
    int-to-float v3, v1
    div-float/2addr v2, v3
    float-to-int v2, v2
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;
    move-result-object v3
    const/16 v4, 0x12
    invoke-static {v3, v4}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v3
    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I
    move-result v2
    invoke-static {v2, v0}, Ljava/lang/Math;->min(II)I
    move-result v2
    return v2
    :zero
    const/4 v0, 0x0
    return v0
.end method

# Grabbing an existing thumb keeps its offset (no initial jump); rail tap centers.
.method private thumbStart(F)V
    .locals 7
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->thumbHeight()I
    move-result v0
    int-to-float v0, v0
    const/high16 v1, 0x40000000
    div-float v1, v0, v1
    iput v1, p0, Lbt192/auto/V3DeviceScroll;->thumbGrab:F
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I
    move-result v1
    if-lez v1, :done
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I
    move-result v2
    int-to-float v2, v2
    sub-float/2addr v2, v0
    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I
    move-result v3
    int-to-float v3, v3
    mul-float/2addr v2, v3
    int-to-float v1, v1
    div-float/2addr v2, v1
    cmpg-float v1, p1, v2
    if-ltz v1, :done
    add-float v3, v2, v0
    cmpl-float v1, p1, v3
    if-gtz v1, :done
    sub-float v1, p1, v2
    iput v1, p0, Lbt192/auto/V3DeviceScroll;->thumbGrab:F
    :done
    return-void
.end method

.method private thumbMove(F)V
    .locals 7
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I
    move-result v0
    if-lez v0, :done
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->thumbHeight()I
    move-result v1
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I
    move-result v2
    sub-int/2addr v2, v1
    if-lez v2, :done
    iget v1, p0, Lbt192/auto/V3DeviceScroll;->thumbGrab:F
    sub-float v1, p1, v1
    int-to-float v2, v2
    div-float/2addr v1, v2
    const/4 v3, 0x0
    invoke-static {v1, v3}, Ljava/lang/Math;->max(FF)F
    move-result v1
    const/high16 v3, 0x3f800000
    invoke-static {v1, v3}, Ljava/lang/Math;->min(FF)F
    move-result v1
    int-to-float v0, v0
    mul-float/2addr v1, v0
    float-to-int v1, v1
    const/4 v0, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/widget/ScrollView;->scrollTo(II)V
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->showRail()V
    :done
    return-void
.end method

# Rows are vertical, visible, unweighted and have zero external margins.
# V3Setup's gaps/dividers belong INSIDE each measured row, not between children.
# Current child order + measured sizes is authoritative during requestLayout;
# never combine a new index with a View's previous traversal getTop/getBottom.
.method private findRow(F)Landroid/view/View;
    .locals 8
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;
    move-result-object v0
    if-eqz v0, :none
    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I
    move-result v1
    int-to-float v1, v1
    add-float/2addr v1, p1
    invoke-virtual {v0}, Landroid/view/View;->getPaddingTop()I
    move-result v6
    const/4 v2, 0x0
    :loop
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I
    move-result v3
    if-ge v2, v3, :none
    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v3
    invoke-virtual {v3}, Landroid/view/View;->getMeasuredHeight()I
    move-result v4
    if-lez v4, :none
    add-int v5, v6, v4
    int-to-float v7, v6
    cmpg-float v7, v1, v7
    if-ltz v7, :next
    int-to-float v7, v5
    cmpl-float v7, v1, v7
    if-gtz v7, :next
    invoke-virtual {v3}, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v4
    instance-of v7, v4, Ljava/lang/String;
    if-eqz v7, :next
    check-cast v4, Ljava/lang/String;
    const-string v7, "order:"
    invoke-virtual {v4, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v7
    if-nez v7, :found
    :next
    move v6, v5
    add-int/lit8 v2, v2, 0x1
    goto :loop
    :found
    return-object v3
    :none
    const/4 v0, 0x0
    return-object v0
.end method

.method private logicalTop(Landroid/widget/LinearLayout;I)I
    .locals 4
    invoke-virtual {p1}, Landroid/view/View;->getPaddingTop()I
    move-result v0
    const/4 v1, 0x0
    :loop
    if-ge v1, p2, :done
    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v2
    invoke-virtual {v2}, Landroid/view/View;->getMeasuredHeight()I
    move-result v2
    if-lez v2, :unknown
    add-int/2addr v0, v2
    add-int/lit8 v1, v1, 0x1
    goto :loop
    :done
    return v0
    :unknown
    const/4 v0, -0x1
    return v0
.end method

.method private dragMove(F)V
    .locals 8
    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    if-eqz v0, :done
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;
    move-result-object v1
    if-eqz v1, :done
    invoke-direct {p0, p1}, Lbt192/auto/V3DeviceScroll;->findRow(F)Landroid/view/View;
    move-result-object v2
    if-eqz v2, :done
    if-eq v0, v2, :done
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I
    move-result v3
    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I
    move-result v4
    if-ltz v3, :done
    if-ltz v4, :done
    invoke-direct {p0, v1, v3}, Lbt192/auto/V3DeviceScroll;->logicalTop(Landroid/widget/LinearLayout;I)I
    move-result v5
    if-ltz v5, :done
    invoke-virtual {v2}, Landroid/view/View;->getMeasuredHeight()I
    move-result v6
    if-lez v6, :done
    div-int/lit8 v6, v6, 0x2
    add-int/2addr v5, v6
    int-to-float v5, v5
    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I
    move-result v6
    int-to-float v6, v6
    add-float v6, v6, p1
    if-le v3, v4, :up
    cmpg-float v5, v6, v5
    if-ltz v5, :done
    goto :move
    :up
    cmpl-float v5, v6, v5
    if-gtz v5, :done
    :move
    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V
    invoke-virtual {v1, v0, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;I)V
    :done
    return-void
.end method

.method public run()V
    .locals 10
    :try_start
    iget v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    const/4 v1, 0x1
    if-ne v0, v1, :edge
    iget-boolean v0, p0, Lbt192/auto/V3DeviceScroll;->touching:Z
    if-eqz v0, :done
    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    if-eqz v0, :done
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;
    move-result-object v0
    if-eqz v0, :done
    invoke-static {v0}, Lbt192/auto/V3DeviceOrder;->capture(Landroid/widget/LinearLayout;)Ljava/util/List;
    move-result-object v0
    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->original:Ljava/util/List;
    # Cancel child stream BEFORE owning drag: releasing never emits a click.
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J
    move-result-wide v0
    move-wide v2, v0
    const/4 v4, 0x3
    iget v5, p0, Lbt192/auto/V3DeviceScroll;->downX:F
    iget v6, p0, Lbt192/auto/V3DeviceScroll;->downY:F
    const/4 v7, 0x0
    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;
    move-result-object v0
    invoke-super {p0, v0}, Landroid/widget/ScrollView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    invoke-virtual {v0}, Landroid/view/MotionEvent;->recycle()V
    const/4 v0, 0x2
    iput v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    const v1, 0xffedf3ff
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V
    const/high16 v1, 0x41000000
    invoke-virtual {v0, v1}, Landroid/view/View;->setTranslationZ(F)V
    const/4 v0, 0x0
    invoke-virtual {p0, v0}, Landroid/view/View;->performHapticFeedback(I)Z
    const/4 v0, 0x1
    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->outer(Z)V
    :edge
    iget v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    const/4 v1, 0x2
    if-ne v0, v1, :done
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;
    move-result-object v0
    const/16 v1, 0x20
    invoke-static {v0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    const/4 v2, 0x4
    invoke-static {v0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    iget v3, p0, Lbt192/auto/V3DeviceScroll;->lastY:F
    int-to-float v4, v1
    cmpg-float v4, v3, v4
    if-ltz v4, :scroll_up
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I
    move-result v4
    sub-int/2addr v4, v1
    int-to-float v4, v4
    cmpl-float v4, v3, v4
    if-gtz v4, :scroll_down
    goto :drag
    :scroll_up
    neg-int v2, v2
    :scroll_down
    const/4 v0, 0x0
    invoke-virtual {p0, v0, v2}, Landroid/widget/ScrollView;->scrollBy(II)V
    :drag
    invoke-direct {p0, v3}, Lbt192/auto/V3DeviceScroll;->dragMove(F)V
    const-wide/16 v0, 0x10
    invoke-virtual {p0, p0, v0, v1}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private finish(Z)V
    .locals 6
    invoke-virtual {p0, p0}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z
    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    if-eqz v0, :restore
    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Landroid/view/View;->setTranslationZ(F)V
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V
    :restore
    iget-object v1, p0, Lbt192/auto/V3DeviceScroll;->original:Ljava/util/List;
    if-eqz v1, :clear
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;
    move-result-object v2
    if-eqz v2, :clear
    if-eqz p1, :rollback
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;
    move-result-object v3
    invoke-static {v3, v2}, Lbt192/auto/V3DeviceOrder;->save(Landroid/content/Context;Landroid/widget/LinearLayout;)Z
    move-result v4
    if-nez v4, :clear
    const-string v4, "顺序未保存，已恢复原顺序"
    const/4 v5, 0x0
    invoke-static {v3, v4, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v3
    invoke-virtual {v3}, Landroid/widget/Toast;->show()V
    :rollback
    invoke-static {v2, v1}, Lbt192/auto/V3DeviceOrder;->restore(Landroid/widget/LinearLayout;Ljava/util/List;)V
    :clear
    const/4 v0, 0x0
    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->original:Ljava/util/List;
    iput v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    iput-boolean v0, p0, Lbt192/auto/V3DeviceScroll;->touching:Z
    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->outer(Z)V
    return-void
.end method

.method public cancelGesture()V
    .locals 1
    const/4 v0, 0x0
    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->finish(Z)V
    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 0
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    invoke-super {p0}, Landroid/widget/ScrollView;->onDetachedFromWindow()V
    return-void
.end method

.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 12
    :try_start
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I
    move-result v0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F
    move-result v1
    iput v1, p0, Lbt192/auto/V3DeviceScroll;->lastY:F
    if-eqz v0, :down
    const/4 v2, 0x1
    if-eq v0, v2, :up
    const/4 v2, 0x3
    if-eq v0, v2, :cancel
    const/4 v2, 0x5
    if-eq v0, v2, :multi
    iget v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    const/4 v3, 0x4
    if-eq v2, v3, :consume
    const/4 v3, 0x2
    if-eq v2, v3, :drag
    const/4 v3, 0x3
    if-eq v2, v3, :thumb
    const/4 v3, 0x1
    if-ne v2, v3, :dispatch
    iget v2, p0, Lbt192/auto/V3DeviceScroll;->downY:F
    sub-float v2, v1, v2
    invoke-static {v2}, Ljava/lang/Math;->abs(F)F
    move-result v2
    iget v3, p0, Lbt192/auto/V3DeviceScroll;->slop:I
    int-to-float v3, v3
    cmpl-float v2, v2, v3
    if-gtz v2, :disarm
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F
    move-result v2
    iget v3, p0, Lbt192/auto/V3DeviceScroll;->downX:F
    sub-float/2addr v2, v3
    invoke-static {v2}, Ljava/lang/Math;->abs(F)F
    move-result v2
    iget v3, p0, Lbt192/auto/V3DeviceScroll;->slop:I
    int-to-float v3, v3
    cmpl-float v2, v2, v3
    if-lez v2, :dispatch
    :disarm
    invoke-virtual {p0, p0}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z
    const/4 v2, 0x0
    iput-object v2, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    iput v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    goto :dispatch
    :drag
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->dragMove(F)V
    goto :consume
    :thumb
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->thumbMove(F)V
    goto :consume
    :down
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    const/4 v2, 0x1
    iput-boolean v2, p0, Lbt192/auto/V3DeviceScroll;->touching:Z
    invoke-direct {p0, v2}, Lbt192/auto/V3DeviceScroll;->outer(Z)V
    iput v1, p0, Lbt192/auto/V3DeviceScroll;->downY:F
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F
    move-result v2
    iput v2, p0, Lbt192/auto/V3DeviceScroll;->downX:F
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I
    move-result v3
    iget v4, p0, Lbt192/auto/V3DeviceScroll;->rail:I
    sub-int/2addr v3, v4
    int-to-float v4, v3
    cmpl-float v4, v2, v4
    if-ltz v4, :arm
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I
    move-result v4
    if-lez v4, :dispatch
    const/4 v4, 0x3
    iput v4, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->thumbStart(F)V
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->thumbMove(F)V
    goto :consume
    :arm
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;
    move-result-object v4
    const/16 v5, 0x38
    invoke-static {v4, v5}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v5
    int-to-float v5, v5
    cmpg-float v5, v2, v5
    if-ltz v5, :dispatch
    const/16 v5, 0x64
    invoke-static {v4, v5}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v5
    sub-int/2addr v3, v5
    int-to-float v3, v3
    cmpl-float v3, v2, v3
    if-gtz v3, :dispatch
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->findRow(F)Landroid/view/View;
    move-result-object v2
    if-eqz v2, :dispatch
    iput-object v2, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;
    const/4 v2, 0x1
    iput v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I
    move-result v2
    int-to-long v2, v2
    invoke-virtual {p0, p0, v2, v3}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :dispatch
    :up
    iget v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    const/4 v3, 0x2
    if-ne v2, v3, :terminal
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->dragMove(F)V
    const/4 v0, 0x1
    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->finish(Z)V
    goto :consume
    :cancel
    iget v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    :terminal
    const/4 v3, 0x3
    if-ne v2, v3, :terminal_ready
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->showRail()V
    :terminal_ready
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    const/4 v3, 0x2
    if-ge v2, v3, :consume
    goto :dispatch
    :multi
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    const/4 v2, 0x4
    iput v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    const/4 v2, 0x1
    iput-boolean v2, p0, Lbt192/auto/V3DeviceScroll;->touching:Z
    invoke-direct {p0, v2}, Lbt192/auto/V3DeviceScroll;->outer(Z)V
    invoke-static {p1}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    move-result-object v2
    const/4 v3, 0x3
    invoke-virtual {v2, v3}, Landroid/view/MotionEvent;->setAction(I)V
    invoke-super {p0, v2}, Landroid/widget/ScrollView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    invoke-virtual {v2}, Landroid/view/MotionEvent;->recycle()V
    goto :consume
    :dispatch
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    move-result v0
    :try_end
    return v0
    :consume
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    const/4 v0, 0x1
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method private railAlpha()I
    .locals 7
    iget v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I
    const/4 v1, 0x3
    if-eq v0, v1, :full
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J
    move-result-wide v0
    iget-wide v2, p0, Lbt192/auto/V3DeviceScroll;->fadeAt:J
    sub-long/2addr v0, v2
    const-wide/16 v2, 0x28a
    cmp-long v4, v0, v2
    if-gez v4, :hidden
    const-wide/16 v2, 0xfa
    cmp-long v4, v0, v2
    if-lez v4, :full
    const-wide/16 v2, 0x28a
    sub-long v0, v2, v0
    long-to-int v0, v0
    mul-int/lit16 v0, v0, 0xff
    div-int/lit16 v0, v0, 0x190
    return v0
    :full
    const/16 v0, 0xff
    return v0
    :hidden
    const/4 v0, 0x0
    return v0
.end method

.method protected dispatchDraw(Landroid/graphics/Canvas;)V
    .locals 12
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->dispatchDraw(Landroid/graphics/Canvas;)V
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I
    move-result v7
    if-lez v7, :done
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->railAlpha()I
    move-result v6
    if-lez v6, :done
    iget-object v5, p0, Lbt192/auto/V3DeviceScroll;->paint:Landroid/graphics/Paint;
    invoke-virtual {v5, v6}, Landroid/graphics/Paint;->setAlpha(I)V
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I
    move-result v0
    int-to-float v3, v0
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;
    move-result-object v0
    const/4 v1, 0x3
    invoke-static {v0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    int-to-float v1, v1
    sub-float/2addr v3, v1
    sub-float v1, v3, v1
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->thumbHeight()I
    move-result v6
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I
    move-result v0
    sub-int/2addr v0, v6
    int-to-float v2, v0
    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I
    move-result v0
    int-to-float v0, v0
    mul-float/2addr v2, v0
    int-to-float v7, v7
    div-float/2addr v2, v7
    add-float/2addr v2, v0
    int-to-float v6, v6
    add-float v4, v2, v6
    move-object v0, p1
    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V
    invoke-virtual {p0}, Landroid/view/View;->postInvalidateOnAnimation()V
    :done
    return-void
.end method
