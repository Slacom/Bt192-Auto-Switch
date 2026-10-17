.class public final Lbt192/auto/V3Ui;
.super Ljava/lang/Object;


# direct methods
.method public static badge(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    .registers 11

    const/4 v1, 0x2

    invoke-static {p0, p1, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v0

    const v1, -0x80604

    const v2, -0x8a7e6b

    const/4 v3, 0x1

    if-eq p2, v3, :cond_15

    const/4 v3, 0x2

    if-eq p2, v3, :cond_1c

    const/4 v3, 0x3

    if-eq p2, v3, :cond_23

    goto :goto_29

    :cond_15
    const v1, -0x130209

    const v2, -0xea7fc3

    goto :goto_29

    :cond_1c
    const v1, -0x415

    const v2, -0x4bacf7

    goto :goto_29

    :cond_23
    const v1, -0x120c01

    const v2, -0xda9c15

    :goto_29
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    const/16 v2, 0x8

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {p0, v1, v2, v3, v4}, Lbt192/auto/V3Ui;->shape(Landroid/content/Context;IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v6

    const/4 v7, 0x4

    invoke-static {p0, v7}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v7

    invoke-virtual {v0, v6, v7, v6, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    return-object v0
.end method

.method public static box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    .registers 3

    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    return-object v0
.end method

.method public static button(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/Button;
    .registers 6

    new-instance v0, Landroid/widget/Button;

    invoke-direct {v0, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setAllCaps(Z)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setIncludeFontPadding(Z)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setMinWidth(I)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setMinimumWidth(I)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setStateListAnimator(Landroid/animation/StateListAnimator;)V

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setElevation(F)V

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setTranslationZ(F)V

    const/4 v1, 0x2

    const/high16 v2, 0x41600000  # 14.0f

    invoke-virtual {v0, v1, v2}, Landroid/widget/Button;->setTextSize(IF)V

    invoke-static {p0, p2}, Lbt192/auto/V3Ui;->buttonBackground(Landroid/content/Context;I)Landroid/graphics/drawable/RippleDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setBackgroundTintList(Landroid/content/res/ColorStateList;)V

    const v1, -0xda9c15

    const/4 v2, 0x1

    if-ne p2, v2, :cond_37

    const/4 v1, -0x1

    :cond_37
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTextColor(I)V

    const/16 v1, 0x2c

    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setMinHeight(I)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setMinimumHeight(I)V

    const/16 v1, 0xc

    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    const/4 v2, 0x6

    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    invoke-virtual {v0, v1, v2, v1, v2}, Landroid/widget/Button;->setPadding(IIII)V

    return-object v0
.end method

.method private static buttonBackground(Landroid/content/Context;I)Landroid/graphics/drawable/RippleDrawable;
    .registers 11

    const/4 v1, -0x1

    const/16 v2, 0xa

    const/4 v3, 0x1

    const v4, -0xda9c15

    const v5, 0x332563eb

    const/4 v6, 0x1

    if-eq p1, v6, :cond_11

    const/4 v6, 0x2

    if-eq p1, v6, :cond_19

    goto :goto_1b

    :cond_11
    const v1, -0xda9c15

    const/4 v3, 0x0

    const v5, 0x33ffffff

    goto :goto_1b

    :cond_19
    const/4 v1, 0x0

    const/4 v3, 0x0

    :goto_1b
    invoke-static {p0, v1, v2, v3, v4}, Lbt192/auto/V3Ui;->shape(Landroid/content/Context;IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    const/4 v1, -0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {p0, v1, v2, v3, v4}, Lbt192/auto/V3Ui;->shape(Landroid/content/Context;IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-static {v5}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v8

    new-instance v0, Landroid/graphics/drawable/RippleDrawable;

    invoke-direct {v0, v8, v6, v7}, Landroid/graphics/drawable/RippleDrawable;-><init>(Landroid/content/res/ColorStateList;Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;)V

    return-object v0
.end method

.method public static card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    .registers 7

    const/4 v0, 0x1

    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;

    move-result-object v0

    const/4 v1, -0x1

    const/16 v2, 0xc

    const/4 v3, 0x1

    invoke-static {p0, v3}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v3

    const v4, -0x1c1811

    invoke-static {p0, v1, v2, v3, v4}, Lbt192/auto/V3Ui;->shape(Landroid/content/Context;IIII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/16 v1, 0xe

    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    return-object v0
.end method

.method public static dp(Landroid/content/Context;I)I
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    int-to-float v1, p1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method public static icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    .registers 9

    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    sget-object v1, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    :try_start_a
    new-instance v1, Lbt192/auto/V3Icon;

    invoke-direct {v1, p1, p2}, Lbt192/auto/V3Icon;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    if-eqz p3, :cond_2b

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    invoke-virtual {v1, p3}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/4 v2, 0x6

    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    invoke-virtual {v0, v2, v2, v2, v2}, Landroid/widget/ImageView;->setPadding(IIII)V
    :try_end_2b
    .catchall {:try_start_a .. :try_end_2b} :catchall_2c

    :cond_2b
    return-object v0

    :catchall_2c
    move-exception v4

    return-object v0
.end method

.method public static label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    .registers 8

    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setIncludeFontPadding(Z)V

    const/high16 v1, 0x41600000  # 14.0f

    const v2, -0xdfdbd4

    const/4 v3, 0x1

    if-eq p2, v3, :cond_1e

    const/4 v3, 0x2

    if-eq p2, v3, :cond_29

    const/4 v3, 0x3

    if-eq p2, v3, :cond_21

    const/4 v3, 0x4

    if-eq p2, v3, :cond_2f

    goto :goto_34

    :cond_1e
    const/high16 v1, 0x41900000  # 18.0f

    goto :goto_23

    :cond_21
    const/high16 v1, 0x41b00000  # 22.0f

    :goto_23
    const/4 v3, 0x0

    const/4 v4, 0x1

    invoke-virtual {v0, v3, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    goto :goto_34

    :cond_29
    const/high16 v1, 0x41400000  # 12.0f

    const v2, -0x8a7e6b

    goto :goto_34

    :cond_2f
    const/high16 v1, 0x41500000  # 13.0f

    const v2, -0xda9c15

    :goto_34
    const/4 v3, 0x2

    invoke-virtual {v0, v3, v1}, Landroid/widget/TextView;->setTextSize(IF)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    return-object v0
.end method

.method private static shape(Landroid/content/Context;IIII)Landroid/graphics/drawable/GradientDrawable;
    .registers 7

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    invoke-static {p0, p2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    if-lez p3, :cond_15

    invoke-virtual {v0, p3, p4}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    :cond_15
    return-object v0
.end method
