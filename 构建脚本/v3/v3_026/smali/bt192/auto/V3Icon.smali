.class public final Lbt192/auto/V3Icon;
.super Landroid/graphics/drawable/Drawable;


# instance fields
.field private final paint:Landroid/graphics/Paint;

.field private final path:Landroid/graphics/Path;


# direct methods
.method public constructor <init>(II)V
    .registers 5

    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lbt192/auto/V3Icon;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p2}, Landroid/graphics/Paint;->setColor(I)V

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    sget-object v1, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    const v1, 0x3fd9999a  # 1.7f

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    invoke-static {p1}, Lbt192/auto/V3Icon;->pathFor(I)Landroid/graphics/Path;

    move-result-object v1

    iput-object v1, p0, Lbt192/auto/V3Icon;->path:Landroid/graphics/Path;

    return-void
.end method

.method private paintInto(Landroid/graphics/Canvas;)V
    .registers 12

    iget-object v9, p0, Lbt192/auto/V3Icon;->path:Landroid/graphics/Path;

    if-eqz v9, :cond_38

    invoke-virtual {p0}, Lbt192/auto/V3Icon;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    if-lez v1, :cond_38

    if-lez v2, :cond_38

    int-to-float v1, v1

    int-to-float v2, v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v3

    const/high16 v4, 0x41c00000  # 24.0f

    div-float/2addr v3, v4

    mul-float v5, v3, v4

    sub-float/2addr v1, v5

    sub-float/2addr v2, v5

    const/high16 v6, 0x40000000  # 2.0f

    div-float/2addr v1, v6

    div-float/2addr v2, v6

    iget v6, v0, Landroid/graphics/Rect;->left:I

    iget v7, v0, Landroid/graphics/Rect;->top:I

    int-to-float v6, v6

    int-to-float v7, v7

    add-float/2addr v1, v6

    add-float/2addr v2, v7

    invoke-virtual {p1, v1, v2}, Landroid/graphics/Canvas;->translate(FF)V

    invoke-virtual {p1, v3, v3}, Landroid/graphics/Canvas;->scale(FF)V

    iget-object v8, p0, Lbt192/auto/V3Icon;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v9, v8}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    :cond_38
    return-void
.end method

.method private static pathFor(I)Landroid/graphics/Path;
    .registers 3

    packed-switch p0, :pswitch_data_2a

    const/4 v0, 0x0

    return-object v0

    :pswitch_5  #0x0
    const-string v0, "M4 13V11C4 6.6 7.6 3 12 3S20 6.6 20 11V13 M4 12H6V19H4C2.9 19 2 18.1 2 17V14C2 12.9 2.9 12 4 12 M20 12H18V19H20C21.1 19 22 18.1 22 17V14C22 12.9 21.1 12 20 12"

    goto :goto_22

    :pswitch_8  #0x1
    const-string v0, "M12 3V21L18 16L6 6 M12 3L18 8L6 18"

    goto :goto_22

    :pswitch_b  #0x2
    const-string v0, "M14 4C14 5.1 13.1 6 12 6S10 5.1 10 4S10.9 2 12 2S14 2.9 14 4Z M4 8L12 10L20 8 M12 10V14 M8 21L12 14L16 21"

    goto :goto_22

    :pswitch_e  #0x3
    const-string v0, "M3 7H19V17H3Z M21 10V14 M6 10V14 M10 10V14 M14 10V14"

    goto :goto_22

    :pswitch_11  #0x4
    const-string v0, "M5 19C2 11 7 5 20 4C20 15 16 21 7 19 M5 21L15 10 M9 16V12 M12 13H16"

    goto :goto_22

    :pswitch_14  #0x5
    const-string v0, "M10 3H14L14.5 5.5L17 7L19.4 6.2L21.4 9.8L19.5 11.5V14L21.4 15.7L19.4 19.2L17 18.4L14.5 19.8L14 22H10L9.5 19.8L7 18.4L4.6 19.2L2.6 15.7L4.5 14V11.5L2.6 9.8L4.6 6.2L7 7L9.5 5.5Z M15 12.5C15 14.2 13.7 15.5 12 15.5S9 14.2 9 12.5S10.3 9.5 12 9.5S15 10.8 15 12.5Z"

    goto :goto_22

    :pswitch_17  #0x6
    const-string v0, "M2 12H5L7 5L10 20L13 4L16 17L18 9L20 12H22"

    goto :goto_22

    :pswitch_1a  #0x7
    const-string v0, "M20 9C18.7 5.3 14.7 3.2 10.9 4C7.2 4.7 4.5 8 4.5 12 M20 4V9H15 M4 15C5.3 18.7 9.3 20.8 13.1 20C16.8 19.3 19.5 16 19.5 12 M4 20V15H9"

    goto :goto_22

    :pswitch_1d  #0x8
    const-string v0, "M12 5V19 M5 12H19"

    goto :goto_22

    :pswitch_20  #0x9
    const-string v0, "M8 4H6C4.3 4 3 5.3 3 7S4.3 10 6 10H7V18.5C7 19.3 7.7 20 8.5 20S10 19.3 10 18.5V6C10 4.9 9.1 4 8 4Z M6 6.5V7.5 M16 4H18C19.7 4 21 5.3 21 7S19.7 10 18 10H17V18.5C17 19.3 16.3 20 15.5 20S14 19.3 14 18.5V6C14 4.9 14.9 4 16 4Z M18 6.5V7.5"

    :goto_22
    :try_start_22
    invoke-static {v0}, Landroidx/core/graphics/PathParser;->createPathFromPathData(Ljava/lang/String;)Landroid/graphics/Path;

    move-result-object v0
    :try_end_26
    .catchall {:try_start_22 .. :try_end_26} :catchall_27

    return-object v0

    :catchall_27
    move-exception v1

    const/4 v0, 0x0

    return-object v0

    :pswitch_data_2a
    .packed-switch 0x0
        :pswitch_5  #00000000
        :pswitch_8  #00000001
        :pswitch_b  #00000002
        :pswitch_e  #00000003
        :pswitch_11  #00000004
        :pswitch_14  #00000005
        :pswitch_17  #00000006
        :pswitch_1a  #00000007
        :pswitch_1d  #00000008
        :pswitch_20  #00000009
    .end packed-switch
.end method

.method private static restoreQuietly(Landroid/graphics/Canvas;I)V
    .registers 3

    :try_start_0
    invoke-virtual {p0, p1}, Landroid/graphics/Canvas;->restoreToCount(I)V
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_4

    return-void

    :catchall_4
    move-exception v0

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .registers 4

    const/4 v0, -0x1

    :try_start_1
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v0

    invoke-direct {p0, p1}, Lbt192/auto/V3Icon;->paintInto(Landroid/graphics/Canvas;)V
    :try_end_8
    .catchall {:try_start_1 .. :try_end_8} :catchall_c

    invoke-static {p1, v0}, Lbt192/auto/V3Icon;->restoreQuietly(Landroid/graphics/Canvas;I)V

    return-void

    :catchall_c
    move-exception v1

    if-ltz v0, :cond_12

    invoke-static {p1, v0}, Lbt192/auto/V3Icon;->restoreQuietly(Landroid/graphics/Canvas;I)V

    :cond_12
    return-void
.end method

.method public getIntrinsicHeight()I
    .registers 2

    const/16 v0, 0x18

    return v0
.end method

.method public getIntrinsicWidth()I
    .registers 2

    const/16 v0, 0x18

    return v0
.end method

.method public getOpacity()I
    .registers 2

    const/4 v0, -0x3

    return v0
.end method

.method public setAlpha(I)V
    .registers 5

    const/4 v0, 0x0

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result v1

    const/16 v0, 0xff

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    iget-object v2, p0, Lbt192/auto/V3Icon;->paint:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    invoke-virtual {p0}, Lbt192/auto/V3Icon;->invalidateSelf()V

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .registers 3

    iget-object v0, p0, Lbt192/auto/V3Icon;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    invoke-virtual {p0}, Lbt192/auto/V3Icon;->invalidateSelf()V

    return-void
.end method
