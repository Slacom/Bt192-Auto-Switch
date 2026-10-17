.class public final Lbt192/auto/V3DragVisual;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/ViewTreeObserver$OnPreDrawListener;


# instance fields
.field private active:Z

.field private animations:Z

.field private background:Landroid/graphics/drawable/Drawable;

.field private baseX:F

.field private baseY:F

.field private baseZ:F

.field private bases:Ljava/util/Map;

.field private began:Z

.field private card:Landroid/view/View;

.field private clipChildren:Z

.field private clipRowsPadding:Z

.field private clipScrollChildren:Z

.field private clipScrollPadding:Z

.field private dropAt:J

.field private dropX:F

.field private dropY:F

.field private dropZ:F

.field private grab:F

.field private liftAt:J

.field private liftX:F

.field private liftY:F

.field private liftZ:F

.field private observer:Landroid/view/ViewTreeObserver;

.field private owner:Lbt192/auto/V3DeviceScroll;

.field private phase:I

.field private reflowAt:J

.field private rows:Landroid/widget/LinearLayout;

.field private starts:Ljava/util/Map;

.field private y:F


# direct methods
.method public constructor <init>(Lbt192/auto/V3DeviceScroll;Landroid/widget/LinearLayout;Landroid/view/View;FF)V
    .registers 7

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    iput-object p2, p0, Lbt192/auto/V3DragVisual;->rows:Landroid/widget/LinearLayout;

    iput-object p3, p0, Lbt192/auto/V3DragVisual;->card:Landroid/view/View;

    iput p4, p0, Lbt192/auto/V3DragVisual;->y:F

    iput p5, p0, Lbt192/auto/V3DragVisual;->grab:F

    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lbt192/auto/V3DragVisual;->starts:Ljava/util/Map;

    new-instance v0, Ljava/util/IdentityHashMap;

    invoke-direct {v0}, Ljava/util/IdentityHashMap;-><init>()V

    iput-object v0, p0, Lbt192/auto/V3DragVisual;->bases:Ljava/util/Map;

    return-void
.end method

.method private fraction(JI)F
    .registers 10

    iget-boolean v0, p0, Lbt192/auto/V3DragVisual;->animations:Z

    if-eqz v0, :cond_22

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    sub-long/2addr v0, p1

    long-to-float v0, v0

    int-to-float v1, p3

    div-float/2addr v0, v1

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const/high16 v1, 0x3f800000  # 1.0f

    invoke-static {v0, v1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    mul-float v1, v0, v0

    const/high16 v2, 0x40000000  # 2.0f

    mul-float/2addr v0, v2

    const/high16 v2, 0x40400000  # 3.0f

    sub-float v0, v2, v0

    mul-float/2addr v0, v1

    return v0

    :cond_22
    const/high16 v0, 0x3f800000  # 1.0f

    return v0
.end method

.method private static mix(FFF)F
    .registers 4

    sub-float v0, p1, p0

    mul-float/2addr v0, p2

    add-float/2addr v0, p0

    return v0
.end method

.method private pointerTop()F
    .registers 7

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0}, Landroid/view/View;->getScrollY()I

    move-result v0

    int-to-float v0, v0

    iget v1, p0, Lbt192/auto/V3DragVisual;->y:F

    add-float/2addr v0, v1

    iget v1, p0, Lbt192/auto/V3DragVisual;->grab:F

    sub-float/2addr v0, v1

    iget-object v1, p0, Lbt192/auto/V3DragVisual;->rows:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/view/View;->getMeasuredHeight()I

    move-result v2

    if-lez v2, :cond_3e

    iget-object v3, p0, Lbt192/auto/V3DragVisual;->card:Landroid/view/View;

    invoke-virtual {v3}, Landroid/view/View;->getMeasuredHeight()I

    move-result v3

    if-lez v3, :cond_3e

    sub-int/2addr v2, v3

    invoke-virtual {v1}, Landroid/view/View;->getPaddingBottom()I

    move-result v3

    sub-int/2addr v2, v3

    int-to-float v2, v2

    invoke-virtual {v1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v3

    const/16 v4, 0x8

    invoke-static {v3, v4}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v3

    int-to-float v3, v3

    add-float/2addr v2, v3

    invoke-virtual {v1}, Landroid/view/View;->getPaddingTop()I

    move-result v1

    int-to-float v1, v1

    sub-float/2addr v1, v3

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v0

    :cond_3e
    return v0
.end method


# virtual methods
.method public begin()V
    .registers 9

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->card:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iput-object v1, p0, Lbt192/auto/V3DragVisual;->background:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/view/View;->getScaleX()F

    move-result v1

    iput v1, p0, Lbt192/auto/V3DragVisual;->baseX:F

    invoke-virtual {v0}, Landroid/view/View;->getScaleY()F

    move-result v1

    iput v1, p0, Lbt192/auto/V3DragVisual;->baseY:F

    invoke-virtual {v0}, Landroid/view/View;->getTranslationZ()F

    move-result v1

    iput v1, p0, Lbt192/auto/V3DragVisual;->baseZ:F

    iget-object v1, p0, Lbt192/auto/V3DragVisual;->rows:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getClipChildren()Z

    move-result v2

    iput-boolean v2, p0, Lbt192/auto/V3DragVisual;->clipChildren:Z

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getClipToPadding()Z

    move-result v2

    iput-boolean v2, p0, Lbt192/auto/V3DragVisual;->clipRowsPadding:Z

    iget-object v2, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v2}, Landroid/view/ViewGroup;->getClipChildren()Z

    move-result v3

    iput-boolean v3, p0, Lbt192/auto/V3DragVisual;->clipScrollChildren:Z

    invoke-virtual {v2}, Landroid/view/ViewGroup;->getClipToPadding()Z

    move-result v3

    iput-boolean v3, p0, Lbt192/auto/V3DragVisual;->clipScrollPadding:Z

    invoke-static {}, Landroid/animation/ValueAnimator;->areAnimatorsEnabled()Z

    move-result v3

    iput-boolean v3, p0, Lbt192/auto/V3DragVisual;->animations:Z

    const/4 v3, 0x0

    :goto_3d
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v4

    if-ge v3, v4, :cond_57

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getTranslationY()F

    move-result v5

    invoke-static {v5}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v5

    iget-object v6, p0, Lbt192/auto/V3DragVisual;->bases:Ljava/util/Map;

    invoke-interface {v6, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v3, v3, 0x1

    goto :goto_3d

    :cond_57
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v3

    const/16 v4, 0xc

    invoke-static {v3}, Lbt192/auto/V3Setup;->isNarrowPortrait(Landroid/content/Context;)Z

    move-result v5

    if-eqz v5, :cond_65

    const/16 v4, 0x8

    :cond_65
    invoke-static {v3, v4}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v5

    const/4 v6, 0x1

    invoke-static {v5, v6}, Ljava/lang/Math;->max(II)I

    move-result v5

    int-to-float v5, v5

    div-float/2addr v4, v5

    const v5, 0x3d23d70a  # 0.04f

    invoke-static {v4, v5}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const/high16 v5, 0x3f800000  # 1.0f

    add-float/2addr v4, v5

    iget v5, p0, Lbt192/auto/V3DragVisual;->baseX:F

    mul-float/2addr v4, v5

    iput v4, p0, Lbt192/auto/V3DragVisual;->liftX:F

    const v4, 0x3f866666  # 1.05f

    iget v5, p0, Lbt192/auto/V3DragVisual;->baseY:F

    mul-float/2addr v4, v5

    iput v4, p0, Lbt192/auto/V3DragVisual;->liftY:F

    const/16 v4, 0x8

    invoke-static {v3, v4}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v4

    int-to-float v4, v4

    iget v5, p0, Lbt192/auto/V3DragVisual;->baseZ:F

    add-float/2addr v4, v5

    iput v4, p0, Lbt192/auto/V3DragVisual;->liftZ:F

    new-instance v4, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v4}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const v5, -0x100901

    invoke-virtual {v4, v5}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/16 v5, 0xa

    invoke-static {v3, v5}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v5

    int-to-float v5, v5

    invoke-virtual {v4, v5}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const/4 v5, 0x1

    invoke-static {v3, v5}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v5

    const v6, -0x9f5a06

    invoke-virtual {v4, v5, v6}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    const/4 v3, 0x1

    iput-boolean v3, p0, Lbt192/auto/V3DragVisual;->began:Z

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->setClipToPadding(Z)V

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->setClipToPadding(Z)V

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    invoke-virtual {v0, v4}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lbt192/auto/V3DragVisual;->liftAt:J

    const/4 v0, 0x1

    iput v0, p0, Lbt192/auto/V3DragVisual;->phase:I

    invoke-virtual {p0}, Lbt192/auto/V3DragVisual;->capture()V

    invoke-virtual {v2}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    iput-object v0, p0, Lbt192/auto/V3DragVisual;->observer:Landroid/view/ViewTreeObserver;

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->addOnPreDrawListener(Landroid/view/ViewTreeObserver$OnPreDrawListener;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lbt192/auto/V3DragVisual;->active:Z

    invoke-virtual {v2}, Landroid/view/View;->postInvalidateOnAnimation()V

    return-void
.end method

.method public capture()V
    .registers 7

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->starts:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    iget-object v1, p0, Lbt192/auto/V3DragVisual;->rows:Landroid/widget/LinearLayout;

    const/4 v2, 0x0

    :goto_8
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-ge v2, v3, :cond_26

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getTop()I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {v3}, Landroid/view/View;->getTranslationY()F

    move-result v5

    add-float/2addr v4, v5

    invoke-static {v4}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v4

    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v2, v2, 0x1

    goto :goto_8

    :cond_26
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lbt192/auto/V3DragVisual;->reflowAt:J

    return-void
.end method

.method public cleanup()V
    .registers 8

    const/4 v0, 0x0

    iput-boolean v0, p0, Lbt192/auto/V3DragVisual;->active:Z

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->observer:Landroid/view/ViewTreeObserver;

    if-eqz v0, :cond_16

    invoke-virtual {v0}, Landroid/view/ViewTreeObserver;->isAlive()Z

    move-result v1

    if-nez v1, :cond_13

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    :cond_13
    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeOnPreDrawListener(Landroid/view/ViewTreeObserver$OnPreDrawListener;)V

    :cond_16
    iget-boolean v0, p0, Lbt192/auto/V3DragVisual;->began:Z

    if-eqz v0, :cond_6b

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->rows:Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    :goto_1d
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_3c

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    const/4 v3, 0x0

    iget-object v4, p0, Lbt192/auto/V3DragVisual;->bases:Ljava/util/Map;

    invoke-interface {v4, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-eqz v4, :cond_36

    check-cast v4, Ljava/lang/Float;

    invoke-virtual {v4}, Ljava/lang/Float;->floatValue()F

    move-result v3

    :cond_36
    invoke-virtual {v2, v3}, Landroid/view/View;->setTranslationY(F)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1d

    :cond_3c
    iget-object v1, p0, Lbt192/auto/V3DragVisual;->card:Landroid/view/View;

    iget v2, p0, Lbt192/auto/V3DragVisual;->baseX:F

    invoke-virtual {v1, v2}, Landroid/view/View;->setScaleX(F)V

    iget v2, p0, Lbt192/auto/V3DragVisual;->baseY:F

    invoke-virtual {v1, v2}, Landroid/view/View;->setScaleY(F)V

    iget v2, p0, Lbt192/auto/V3DragVisual;->baseZ:F

    invoke-virtual {v1, v2}, Landroid/view/View;->setTranslationZ(F)V

    iget-object v2, p0, Lbt192/auto/V3DragVisual;->background:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    iget-boolean v1, p0, Lbt192/auto/V3DragVisual;->clipChildren:Z

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    iget-boolean v1, p0, Lbt192/auto/V3DragVisual;->clipRowsPadding:Z

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setClipToPadding(Z)V

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    iget-boolean v1, p0, Lbt192/auto/V3DragVisual;->clipScrollChildren:Z

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    iget-boolean v1, p0, Lbt192/auto/V3DragVisual;->clipScrollPadding:Z

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setClipToPadding(Z)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lbt192/auto/V3DragVisual;->began:Z

    :cond_6b
    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0, p0}, Lbt192/auto/V3DeviceScroll;->visualEnded(Lbt192/auto/V3DragVisual;)V

    return-void
.end method

.method public drop()V
    .registers 5

    invoke-virtual {p0}, Lbt192/auto/V3DragVisual;->capture()V

    invoke-direct {p0}, Lbt192/auto/V3DragVisual;->pointerTop()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iget-object v1, p0, Lbt192/auto/V3DragVisual;->starts:Ljava/util/Map;

    iget-object v2, p0, Lbt192/auto/V3DragVisual;->card:Landroid/view/View;

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {v2}, Landroid/view/View;->getScaleX()F

    move-result v0

    iput v0, p0, Lbt192/auto/V3DragVisual;->dropX:F

    invoke-virtual {v2}, Landroid/view/View;->getScaleY()F

    move-result v0

    iput v0, p0, Lbt192/auto/V3DragVisual;->dropY:F

    invoke-virtual {v2}, Landroid/view/View;->getTranslationZ()F

    move-result v0

    iput v0, p0, Lbt192/auto/V3DragVisual;->dropZ:F

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lbt192/auto/V3DragVisual;->dropAt:J

    const/4 v0, 0x2

    iput v0, p0, Lbt192/auto/V3DragVisual;->phase:I

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0}, Landroid/view/View;->postInvalidateOnAnimation()V

    return-void
.end method

.method public onPreDraw()Z
    .registers 15

    :try_start_0
    iget-boolean v0, p0, Lbt192/auto/V3DragVisual;->active:Z

    if-eqz v0, :cond_d5

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0, p0}, Lbt192/auto/V3DeviceScroll;->visualCurrent(Lbt192/auto/V3DragVisual;)Z

    move-result v1

    if-eqz v1, :cond_d5

    iget v1, p0, Lbt192/auto/V3DragVisual;->phase:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_32

    iget-wide v1, p0, Lbt192/auto/V3DragVisual;->liftAt:J

    const/16 v3, 0xb4

    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3DragVisual;->fraction(JI)F

    move-result v9

    iget v1, p0, Lbt192/auto/V3DragVisual;->baseX:F

    iget v2, p0, Lbt192/auto/V3DragVisual;->liftX:F

    invoke-static {v1, v2, v9}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v1

    iget v2, p0, Lbt192/auto/V3DragVisual;->baseY:F

    iget v3, p0, Lbt192/auto/V3DragVisual;->liftY:F

    invoke-static {v2, v3, v9}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v2

    iget v3, p0, Lbt192/auto/V3DragVisual;->baseZ:F

    iget v4, p0, Lbt192/auto/V3DragVisual;->liftZ:F

    invoke-static {v3, v4, v9}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v3

    goto :goto_52

    :cond_32
    iget-wide v1, p0, Lbt192/auto/V3DragVisual;->dropAt:J

    const/16 v3, 0xc8

    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3DragVisual;->fraction(JI)F

    move-result v9

    iget v1, p0, Lbt192/auto/V3DragVisual;->dropX:F

    iget v2, p0, Lbt192/auto/V3DragVisual;->baseX:F

    invoke-static {v1, v2, v9}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v1

    iget v2, p0, Lbt192/auto/V3DragVisual;->dropY:F

    iget v3, p0, Lbt192/auto/V3DragVisual;->baseY:F

    invoke-static {v2, v3, v9}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v2

    iget v3, p0, Lbt192/auto/V3DragVisual;->dropZ:F

    iget v4, p0, Lbt192/auto/V3DragVisual;->baseZ:F

    invoke-static {v3, v4, v9}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v3

    :goto_52
    iget-object v4, p0, Lbt192/auto/V3DragVisual;->card:Landroid/view/View;

    invoke-virtual {v4, v1}, Landroid/view/View;->setScaleX(F)V

    invoke-virtual {v4, v2}, Landroid/view/View;->setScaleY(F)V

    invoke-virtual {v4, v3}, Landroid/view/View;->setTranslationZ(F)V

    iget-object v1, p0, Lbt192/auto/V3DragVisual;->rows:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/view/View;->getPaddingTop()I

    move-result v2

    const/4 v3, 0x0

    const/4 v10, 0x0

    :goto_65
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v5

    if-ge v3, v5, :cond_c1

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/View;->getMeasuredHeight()I

    move-result v6

    if-lez v6, :cond_d7

    int-to-float v7, v2

    iget-object v8, p0, Lbt192/auto/V3DragVisual;->bases:Ljava/util/Map;

    invoke-interface {v8, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    if-eqz v8, :cond_85

    check-cast v8, Ljava/lang/Float;

    invoke-virtual {v8}, Ljava/lang/Float;->floatValue()F

    move-result v8

    add-float/2addr v7, v8

    :cond_85
    if-ne v5, v4, :cond_93

    iget v8, p0, Lbt192/auto/V3DragVisual;->phase:I

    const/4 v11, 0x1

    if-ne v8, v11, :cond_91

    invoke-direct {p0}, Lbt192/auto/V3DragVisual;->pointerTop()F

    move-result v7

    goto :goto_b4

    :cond_91
    move v8, v9

    goto :goto_9b

    :cond_93
    iget-wide v11, p0, Lbt192/auto/V3DragVisual;->reflowAt:J

    const/16 v13, 0xb4

    invoke-direct {p0, v11, v12, v13}, Lbt192/auto/V3DragVisual;->fraction(JI)F

    move-result v8

    :goto_9b
    const/high16 v11, 0x3f800000  # 1.0f

    cmpg-float v11, v8, v11

    if-gez v11, :cond_a2

    const/4 v10, 0x1

    :cond_a2
    iget-object v11, p0, Lbt192/auto/V3DragVisual;->starts:Ljava/util/Map;

    invoke-interface {v11, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    if-eqz v11, :cond_b4

    check-cast v11, Ljava/lang/Float;

    invoke-virtual {v11}, Ljava/lang/Float;->floatValue()F

    move-result v11

    invoke-static {v11, v7, v8}, Lbt192/auto/V3DragVisual;->mix(FFF)F

    move-result v7

    :cond_b4
    :goto_b4
    invoke-virtual {v5}, Landroid/view/View;->getTop()I

    move-result v8

    int-to-float v8, v8

    sub-float/2addr v7, v8

    invoke-virtual {v5, v7}, Landroid/view/View;->setTranslationY(F)V

    add-int/2addr v2, v6

    add-int/lit8 v3, v3, 0x1

    goto :goto_65

    :cond_c1
    const/high16 v1, 0x3f800000  # 1.0f

    cmpg-float v1, v9, v1

    if-ltz v1, :cond_d2

    iget v1, p0, Lbt192/auto/V3DragVisual;->phase:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_d0

    invoke-virtual {p0}, Lbt192/auto/V3DragVisual;->cleanup()V

    goto :goto_d5

    :cond_d0
    if-eqz v10, :cond_d5

    :cond_d2
    invoke-virtual {v0}, Landroid/view/View;->postInvalidateOnAnimation()V
    :try_end_d5
    .catchall {:try_start_0 .. :try_end_d5} :catchall_db

    :cond_d5
    :goto_d5
    const/4 v0, 0x1

    return v0

    :cond_d7
    invoke-virtual {v0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    goto :goto_d5

    :catchall_db
    move-exception v0

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V

    goto :goto_d5
.end method

.method public point(F)V
    .registers 4

    iget v0, p0, Lbt192/auto/V3DragVisual;->phase:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_c

    iput p1, p0, Lbt192/auto/V3DragVisual;->y:F

    iget-object v0, p0, Lbt192/auto/V3DragVisual;->owner:Lbt192/auto/V3DeviceScroll;

    invoke-virtual {v0}, Landroid/view/View;->postInvalidateOnAnimation()V

    :cond_c
    return-void
.end method
