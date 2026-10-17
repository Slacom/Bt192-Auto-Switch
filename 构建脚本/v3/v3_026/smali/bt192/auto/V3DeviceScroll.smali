.class public final Lbt192/auto/V3DeviceScroll;
.super Landroid/widget/ScrollView;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private candidate:Landroid/view/View;

.field private downX:F

.field private downY:F

.field private fadeAt:J

.field private grabOffset:F

.field private lastY:F

.field private mode:I

.field private original:Ljava/util/List;

.field private paint:Landroid/graphics/Paint;

.field private rail:I

.field private slop:I

.field private thumbGrab:F

.field private touching:Z

.field private visual:Lbt192/auto/V3DragVisual;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 5

    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    const/16 v0, 0x14

    invoke-static {p1}, Lbt192/auto/V3Setup;->isNarrowPortrait(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_d

    const/16 v0, 0xc

    :cond_d
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

    const v1, -0x635c51

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->paint:Landroid/graphics/Paint;

    return-void
.end method

.method private dragMove(F)V
    .registers 10

    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;

    if-eqz v0, :cond_82

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v1

    if-eqz v1, :cond_82

    iget-object v7, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    if-eqz v7, :cond_11

    invoke-virtual {v7, p1}, Lbt192/auto/V3DragVisual;->point(F)V

    :cond_11
    iget v7, p0, Lbt192/auto/V3DeviceScroll;->grabOffset:F

    sub-float/2addr p1, v7

    invoke-virtual {v0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v7

    if-lez v7, :cond_82

    div-int/lit8 v7, v7, 0x2

    int-to-float v7, v7

    add-float/2addr p1, v7

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    invoke-direct {p0, v1, v2}, Lbt192/auto/V3DeviceScroll;->logicalTop(Landroid/widget/LinearLayout;I)I

    move-result v3

    if-lez v3, :cond_82

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {v1}, Landroid/view/View;->getPaddingTop()I

    move-result v2

    int-to-float v2, v2

    sub-float/2addr v2, v4

    int-to-float v3, v3

    sub-float/2addr v3, v4

    invoke-static {p1, v2}, Ljava/lang/Math;->max(FF)F

    move-result p1

    invoke-static {p1, v3}, Ljava/lang/Math;->min(FF)F

    move-result p1

    invoke-direct {p0, p1}, Lbt192/auto/V3DeviceScroll;->findRow(F)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_82

    if-eq v0, v2, :cond_82

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I

    move-result v3

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I

    move-result v4

    if-ltz v3, :cond_82

    if-ltz v4, :cond_82

    invoke-direct {p0, v1, v3}, Lbt192/auto/V3DeviceScroll;->logicalTop(Landroid/widget/LinearLayout;I)I

    move-result v5

    if-ltz v5, :cond_82

    invoke-virtual {v2}, Landroid/view/View;->getMeasuredHeight()I

    move-result v6

    if-lez v6, :cond_82

    div-int/lit8 v6, v6, 0x2

    add-int/2addr v5, v6

    int-to-float v5, v5

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v6

    int-to-float v6, v6

    add-float v6, v6, p1

    if-le v3, v4, :cond_71

    cmpg-float v5, v6, v5

    if-ltz v5, :cond_82

    goto :goto_75

    :cond_71
    cmpl-float v5, v6, v5

    if-gtz v5, :cond_82

    :goto_75
    iget-object v7, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    if-eqz v7, :cond_7c

    invoke-virtual {v7}, Lbt192/auto/V3DragVisual;->capture()V

    :cond_7c
    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    invoke-virtual {v1, v0, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;I)V

    :cond_82
    return-void
.end method

.method private dragRowAt(FF)Landroid/view/View;
    .registers 13

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_70

    invoke-direct {p0, p2}, Lbt192/auto/V3DeviceScroll;->findRow(F)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_70

    instance-of v2, v1, Landroid/widget/LinearLayout;

    if-eqz v2, :cond_70

    check-cast v1, Landroid/widget/LinearLayout;

    const-string v3, "drag_name"

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    if-eqz v3, :cond_70

    invoke-virtual {v3}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    instance-of v4, v2, Landroid/widget/LinearLayout;

    if-eqz v4, :cond_70

    check-cast v2, Landroid/widget/LinearLayout;

    invoke-virtual {v3}, Landroid/view/View;->getWidth()I

    move-result v4

    if-lez v4, :cond_70

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v4

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v5

    add-int/2addr v4, v5

    invoke-virtual {v2}, Landroid/view/View;->getLeft()I

    move-result v5

    add-int/2addr v4, v5

    invoke-virtual {v3}, Landroid/view/View;->getLeft()I

    move-result v5

    add-int/2addr v5, v4

    int-to-float v5, v5

    cmpg-float v5, p1, v5

    if-ltz v5, :cond_70

    invoke-virtual {v3}, Landroid/view/View;->getRight()I

    move-result v5

    add-int/2addr v5, v4

    int-to-float v5, v5

    cmpl-float v5, p1, v5

    if-gez v5, :cond_70

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I

    move-result v3

    invoke-direct {p0, v0, v3}, Lbt192/auto/V3DeviceScroll;->logicalTop(Landroid/widget/LinearLayout;I)I

    move-result v3

    if-ltz v3, :cond_70

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v4

    sub-int/2addr v4, v3

    int-to-float v4, v4

    add-float/2addr v4, p2

    invoke-virtual {v2}, Landroid/view/View;->getTop()I

    move-result v5

    int-to-float v5, v5

    cmpg-float v5, v4, v5

    if-ltz v5, :cond_70

    invoke-virtual {v2}, Landroid/view/View;->getBottom()I

    move-result v5

    int-to-float v5, v5

    cmpl-float v5, v4, v5

    if-gez v5, :cond_70

    return-object v1

    :cond_70
    const/4 v0, 0x0

    return-object v0
.end method

.method private findRow(F)Landroid/view/View;
    .registers 10

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_44

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v1

    int-to-float v1, v1

    add-float/2addr v1, p1

    invoke-virtual {v0}, Landroid/view/View;->getPaddingTop()I

    move-result v6

    const/4 v2, 0x0

    :goto_11
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-ge v2, v3, :cond_44

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getMeasuredHeight()I

    move-result v4

    if-lez v4, :cond_44

    add-int v5, v6, v4

    int-to-float v7, v6

    cmpg-float v7, v1, v7

    if-ltz v7, :cond_3f

    int-to-float v7, v5

    cmpl-float v7, v1, v7

    if-gtz v7, :cond_3f

    invoke-virtual {v3}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v4

    instance-of v7, v4, Ljava/lang/String;

    if-eqz v7, :cond_3f

    check-cast v4, Ljava/lang/String;

    const-string v7, "order:"

    invoke-virtual {v4, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_43

    :cond_3f
    move v6, v5

    add-int/lit8 v2, v2, 0x1

    goto :goto_11

    :cond_43
    return-object v3

    :cond_44
    const/4 v0, 0x0

    return-object v0
.end method

.method private finish(Z)V
    .registers 9

    invoke-virtual {p0, p0}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    const/4 v6, 0x0

    iget-object v1, p0, Lbt192/auto/V3DeviceScroll;->original:Ljava/util/List;

    if-eqz v1, :cond_2f

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v2

    if-eqz v2, :cond_2f

    if-eqz p1, :cond_2c

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v2}, Lbt192/auto/V3DeviceOrder;->save(Landroid/content/Context;Landroid/widget/LinearLayout;)Z

    move-result v4

    if-eqz v4, :cond_1c

    const/4 v6, 0x1

    goto :goto_2f

    :cond_1c
    invoke-static {v2, v1}, Lbt192/auto/V3DeviceOrder;->restore(Landroid/widget/LinearLayout;Ljava/util/List;)V

    :try_start_1f
    const-string v4, "顺序未保存，已恢复原顺序"

    const/4 v5, 0x0

    invoke-static {v3, v4, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/Toast;->show()V
    :try_end_29
    .catchall {:try_start_1f .. :try_end_29} :catchall_2a

    goto :goto_2f

    :catchall_2a
    move-exception v4

    goto :goto_2f

    :cond_2c
    invoke-static {v2, v1}, Lbt192/auto/V3DeviceOrder;->restore(Landroid/widget/LinearLayout;Ljava/util/List;)V

    :cond_2f
    :goto_2f
    const/4 v0, 0x0

    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;

    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->original:Ljava/util/List;

    iput v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    iput-boolean v0, p0, Lbt192/auto/V3DeviceScroll;->touching:Z

    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->outer(Z)V

    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    if-eqz v0, :cond_48

    if-eqz v6, :cond_45

    invoke-virtual {v0}, Lbt192/auto/V3DragVisual;->drop()V

    goto :goto_48

    :cond_45
    invoke-virtual {v0}, Lbt192/auto/V3DragVisual;->cleanup()V

    :cond_48
    :goto_48
    return-void
.end method

.method private logicalTop(Landroid/widget/LinearLayout;I)I
    .registers 7

    invoke-virtual {p1}, Landroid/view/View;->getPaddingTop()I

    move-result v0

    const/4 v1, 0x0

    :goto_5
    if-ge v1, p2, :cond_15

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getMeasuredHeight()I

    move-result v2

    if-lez v2, :cond_16

    add-int/2addr v0, v2

    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    :cond_15
    return v0

    :cond_16
    const/4 v0, -0x1

    return v0
.end method

.method private outer(Z)V
    .registers 3

    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_9

    invoke-interface {v0, p1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_9
    return-void
.end method

.method private railAlpha()I
    .registers 8

    iget v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_22

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lbt192/auto/V3DeviceScroll;->fadeAt:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x28a

    cmp-long v4, v0, v2

    if-gez v4, :cond_25

    const-wide/16 v2, 0xfa

    cmp-long v4, v0, v2

    if-lez v4, :cond_22

    const-wide/16 v2, 0x28a

    sub-long v0, v2, v0

    long-to-int v0, v0

    mul-int/lit16 v0, v0, 0xff

    div-int/lit16 v0, v0, 0x190

    return v0

    :cond_22
    const/16 v0, 0xff

    return v0

    :cond_25
    const/4 v0, 0x0

    return v0
.end method

.method private range()I
    .registers 4

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_15

    invoke-virtual {v0}, Landroid/view/View;->getHeight()I

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v1

    sub-int/2addr v0, v1

    const/4 v2, 0x0

    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0

    :cond_15
    const/4 v0, 0x0

    return v0
.end method

.method private rowsView()Landroid/widget/LinearLayout;
    .registers 3

    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-eqz v0, :cond_12

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Landroid/widget/LinearLayout;

    if-eqz v1, :cond_12

    check-cast v0, Landroid/widget/LinearLayout;

    return-object v0

    :cond_12
    const/4 v0, 0x0

    return-object v0
.end method

.method private showRail()V
    .registers 3

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lbt192/auto/V3DeviceScroll;->fadeAt:J

    invoke-virtual {p0}, Landroid/view/View;->invalidate()V

    return-void
.end method

.method private thumbHeight()I
    .registers 6

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v0

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I

    move-result v1

    add-int/2addr v1, v0

    if-lez v1, :cond_23

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

    :cond_23
    const/4 v0, 0x0

    return v0
.end method

.method private thumbMove(F)V
    .registers 9

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I

    move-result v0

    if-lez v0, :cond_2c

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->thumbHeight()I

    move-result v1

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v2

    sub-int/2addr v2, v1

    if-lez v2, :cond_2c

    iget v1, p0, Lbt192/auto/V3DeviceScroll;->thumbGrab:F

    sub-float v1, p1, v1

    int-to-float v2, v2

    div-float/2addr v1, v2

    const/4 v3, 0x0

    invoke-static {v1, v3}, Ljava/lang/Math;->max(FF)F

    move-result v1

    const/high16 v3, 0x3f800000  # 1.0f

    invoke-static {v1, v3}, Ljava/lang/Math;->min(FF)F

    move-result v1

    int-to-float v0, v0

    mul-float/2addr v1, v0

    float-to-int v1, v1

    const/4 v0, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/widget/ScrollView;->scrollTo(II)V

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->showRail()V

    :cond_2c
    return-void
.end method

.method private thumbStart(F)V
    .registers 9

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->thumbHeight()I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x40000000  # 2.0f

    div-float v1, v0, v1

    iput v1, p0, Lbt192/auto/V3DeviceScroll;->thumbGrab:F

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I

    move-result v1

    if-lez v1, :cond_2d

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

    if-ltz v1, :cond_2d

    add-float v3, v2, v0

    cmpl-float v1, p1, v3

    if-gtz v1, :cond_2d

    sub-float v1, p1, v2

    iput v1, p0, Lbt192/auto/V3DeviceScroll;->thumbGrab:F

    :cond_2d
    return-void
.end method


# virtual methods
.method public busy()Z
    .registers 7

    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    if-nez v0, :cond_17

    iget-boolean v0, p0, Lbt192/auto/V3DeviceScroll;->touching:Z

    if-nez v0, :cond_17

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lbt192/auto/V3DeviceScroll;->fadeAt:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x258

    cmp-long v4, v0, v2

    if-ltz v4, :cond_17

    const/4 v0, 0x0

    return v0

    :cond_17
    const/4 v0, 0x1

    return v0
.end method

.method public cancelGesture()V
    .registers 2

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->finish(Z)V

    return-void
.end method

.method protected dispatchDraw(Landroid/graphics/Canvas;)V
    .registers 14

    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v8

    :try_start_4
    const/4 v0, 0x0

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v1

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v2

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v3

    add-int/2addr v3, v1

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->clipRect(IIII)Z

    invoke-super {p0, p1}, Landroid/widget/ScrollView;->dispatchDraw(Landroid/graphics/Canvas;)V
    :try_end_18
    .catchall {:try_start_4 .. :try_end_18} :catchall_1c

    invoke-virtual {p1, v8}, Landroid/graphics/Canvas;->restoreToCount(I)V

    goto :goto_21

    :catchall_1c
    move-exception v9

    invoke-virtual {p1, v8}, Landroid/graphics/Canvas;->restoreToCount(I)V

    throw v9

    :goto_21
    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I

    move-result v7

    if-lez v7, :cond_61

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->railAlpha()I

    move-result v6

    if-lez v6, :cond_61

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

    :cond_61
    return-void
.end method

.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 14

    :try_start_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    iput v1, p0, Lbt192/auto/V3DeviceScroll;->lastY:F

    if-eqz v0, :cond_57

    const/4 v2, 0x1

    if-eq v0, v2, :cond_98

    const/4 v2, 0x3

    if-eq v0, v2, :cond_a5

    const/4 v2, 0x5

    if-eq v0, v2, :cond_b4

    iget v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    const/4 v3, 0x4

    if-eq v2, v3, :cond_d4

    const/4 v3, 0x2

    if-eq v2, v3, :cond_4e

    const/4 v3, 0x3

    if-eq v2, v3, :cond_53

    const/4 v3, 0x1

    if-ne v2, v3, :cond_cf

    iget v2, p0, Lbt192/auto/V3DeviceScroll;->downY:F

    sub-float v2, v1, v2

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    iget v3, p0, Lbt192/auto/V3DeviceScroll;->slop:I

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-gtz v2, :cond_44

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    iget v3, p0, Lbt192/auto/V3DeviceScroll;->downX:F

    sub-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    iget v3, p0, Lbt192/auto/V3DeviceScroll;->slop:I

    int-to-float v3, v3

    cmpl-float v2, v2, v3

    if-lez v2, :cond_cf

    :cond_44
    invoke-virtual {p0, p0}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    const/4 v2, 0x0

    iput-object v2, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;

    iput v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    goto/16 :goto_cf

    :cond_4e
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->dragMove(F)V

    goto/16 :goto_d4

    :cond_53
    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->thumbMove(F)V

    goto :goto_d4

    :cond_57
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

    if-ltz v4, :cond_84

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->range()I

    move-result v4

    if-lez v4, :cond_cf

    const/4 v4, 0x3

    iput v4, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->thumbStart(F)V

    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->thumbMove(F)V

    goto :goto_d4

    :cond_84
    invoke-direct {p0, v2, v1}, Lbt192/auto/V3DeviceScroll;->dragRowAt(FF)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_cf

    iput-object v2, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;

    const/4 v2, 0x1

    iput v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v2

    int-to-long v2, v2

    invoke-virtual {p0, p0, v2, v3}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_cf

    :cond_98
    iget v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_a7

    invoke-direct {p0, v1}, Lbt192/auto/V3DeviceScroll;->dragMove(F)V

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->finish(Z)V

    goto :goto_d4

    :cond_a5
    iget v2, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    :cond_a7
    const/4 v3, 0x3

    if-ne v2, v3, :cond_ad

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->showRail()V

    :cond_ad
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    const/4 v3, 0x2

    if-ge v2, v3, :cond_d4

    goto :goto_cf

    :cond_b4
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

    goto :goto_d4

    :cond_cf
    :goto_cf
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0
    :try_end_d3
    .catchall {:try_start_0 .. :try_end_d3} :catchall_d6

    return v0

    :cond_d4
    :goto_d4
    const/4 v0, 0x1

    return v0

    :catchall_d6
    move-exception v0

    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    const/4 v0, 0x1

    return v0
.end method

.method protected onDetachedFromWindow()V
    .registers 1

    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    invoke-super {p0}, Landroid/widget/ScrollView;->onDetachedFromWindow()V

    return-void
.end method

.method protected onScrollChanged(IIII)V
    .registers 5

    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ScrollView;->onScrollChanged(IIII)V

    if-eq p2, p4, :cond_8

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->showRail()V

    :cond_8
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .registers 5

    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ScrollView;->onSizeChanged(IIII)V

    if-lez p3, :cond_e

    if-lez p4, :cond_e

    if-ne p1, p3, :cond_b

    if-eq p2, p4, :cond_e

    :cond_b
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    :cond_e
    return-void
.end method

.method public run()V
    .registers 11

    :try_start_0
    iget v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_67

    iget-boolean v0, p0, Lbt192/auto/V3DeviceScroll;->touching:Z

    if-eqz v0, :cond_9a

    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;

    if-eqz v0, :cond_9a

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_9a

    invoke-static {v0}, Lbt192/auto/V3DeviceOrder;->capture(Landroid/widget/LinearLayout;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->original:Ljava/util/List;

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

    invoke-direct {p0}, Lbt192/auto/V3DeviceScroll;->rowsView()Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lbt192/auto/V3DeviceScroll;->candidate:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I

    move-result v4

    invoke-direct {p0, v2, v4}, Lbt192/auto/V3DeviceScroll;->logicalTop(Landroid/widget/LinearLayout;I)I

    move-result v4

    if-ltz v4, :cond_5b

    int-to-float v4, v4

    invoke-virtual {p0}, Landroid/view/View;->getScrollY()I

    move-result v5

    int-to-float v5, v5

    iget v6, p0, Lbt192/auto/V3DeviceScroll;->downY:F

    add-float/2addr v5, v6

    sub-float/2addr v5, v4

    iput v5, p0, Lbt192/auto/V3DeviceScroll;->grabOffset:F

    iget v4, p0, Lbt192/auto/V3DeviceScroll;->lastY:F

    new-instance v0, Lbt192/auto/V3DragVisual;

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lbt192/auto/V3DragVisual;-><init>(Lbt192/auto/V3DeviceScroll;Landroid/widget/LinearLayout;Landroid/view/View;FF)V

    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    invoke-virtual {v0}, Lbt192/auto/V3DragVisual;->begin()V

    goto :goto_5f

    :cond_5b
    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    return-void

    :goto_5f
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/View;->performHapticFeedback(I)Z

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lbt192/auto/V3DeviceScroll;->outer(Z)V

    :cond_67
    iget v0, p0, Lbt192/auto/V3DeviceScroll;->mode:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_9a

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

    if-ltz v4, :cond_8d

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v4

    sub-int/2addr v4, v1

    int-to-float v4, v4

    cmpl-float v4, v3, v4

    if-gtz v4, :cond_8e

    goto :goto_92

    :cond_8d
    neg-int v2, v2

    :cond_8e
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v2}, Landroid/widget/ScrollView;->scrollBy(II)V

    :goto_92
    invoke-direct {p0, v3}, Lbt192/auto/V3DeviceScroll;->dragMove(F)V

    const-wide/16 v0, 0x10

    invoke-virtual {p0, p0, v0, v1}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_9a
    .catchall {:try_start_0 .. :try_end_9a} :catchall_9b

    :cond_9a
    return-void

    :catchall_9b
    move-exception v0

    invoke-virtual {p0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    return-void
.end method

.method public visualCurrent(Lbt192/auto/V3DragVisual;)Z
    .registers 3

    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    if-ne v0, p1, :cond_6

    const/4 v0, 0x1

    return v0

    :cond_6
    const/4 v0, 0x0

    return v0
.end method

.method public visualEnded(Lbt192/auto/V3DragVisual;)V
    .registers 3

    iget-object v0, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    if-ne v0, p1, :cond_7

    const/4 v0, 0x0

    iput-object v0, p0, Lbt192/auto/V3DeviceScroll;->visual:Lbt192/auto/V3DragVisual;

    :cond_7
    return-void
.end method
