.class public final Lbt192/auto/V3IconChoice;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private final currentKind:I

.field private dialog:Ljava/lang/ref/WeakReference;

.field private final identity:Ljava/lang/String;

.field private final mac:Ljava/lang/String;

.field private final owner:Ljava/lang/ref/WeakReference;


# direct methods
.method private constructor <init>(Lbt192/auto/V3Setup;Ljava/lang/String;)V
    .registers 5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lbt192/auto/V3IconChoice;->owner:Ljava/lang/ref/WeakReference;

    iput-object p2, p0, Lbt192/auto/V3IconChoice;->mac:Ljava/lang/String;

    const/4 v0, 0x0

    :try_start_d
    invoke-static {p1, p2}, Lbt192/auto/V3DevicePrefs;->kind(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0
    :try_end_11
    .catchall {:try_start_d .. :try_end_11} :catchall_12

    goto :goto_14

    :catchall_12
    move-exception v1

    const/4 v0, 0x0

    :goto_14
    const/16 v1, 0x9

    if-eq v0, v1, :cond_19

    const/4 v0, 0x0

    :cond_19
    iput v0, p0, Lbt192/auto/V3IconChoice;->currentKind:I

    invoke-static {p2}, Lbt192/auto/V3IconChoice;->identity(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lbt192/auto/V3IconChoice;->identity:Ljava/lang/String;

    return-void
.end method

.method private static alive(Lbt192/auto/V3Setup;)Z
    .registers 3

    :try_start_0
    if-eqz p0, :cond_11

    invoke-virtual {p0}, Lbt192/auto/V3Setup;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_11

    invoke-virtual {p0}, Lbt192/auto/V3Setup;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_11

    const/4 v0, 0x1
    :try_end_f
    .catchall {:try_start_0 .. :try_end_f} :catchall_10

    return v0

    :catchall_10
    move-exception v1

    :cond_11
    const/4 v0, 0x0

    return v0
.end method

.method private content(Landroid/content/Context;)Landroid/widget/LinearLayout;
    .registers 10

    :try_start_0
    const/4 v1, 0x1

    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_64

    const/16 v1, 0xc

    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    iget-object v1, p0, Lbt192/auto/V3IconChoice;->identity:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {p1, v1, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    if-eqz v1, :cond_64

    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    const/high16 v2, 0x41400000  # 12.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v2, 0xc

    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v3, v3, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const/4 v1, 0x0

    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;

    move-result-object v2

    if-eqz v2, :cond_64

    const/16 v1, 0x9

    const-string v5, "TWS 耳机"

    invoke-direct {p0, p1, v1, v5}, Lbt192/auto/V3IconChoice;->option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v3

    if-eqz v3, :cond_64

    const/4 v1, 0x0

    const-string v5, "头戴式耳机"

    invoke-direct {p0, p1, v1, v5}, Lbt192/auto/V3IconChoice;->option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v4

    if-eqz v4, :cond_64

    invoke-virtual {v3, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v4, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    invoke-static {p1}, Lbt192/auto/V3IconChoice;->note(Landroid/content/Context;)Landroid/widget/TextView;

    move-result-object v1

    if-eqz v1, :cond_64

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :try_end_62
    .catchall {:try_start_0 .. :try_end_62} :catchall_63

    return-object v0

    :catchall_63
    move-exception v7

    :cond_64
    const/4 v0, 0x0

    return-object v0
.end method

.method private dismissQuietly()V
    .registers 3

    :try_start_0
    iget-object v0, p0, Lbt192/auto/V3IconChoice;->dialog:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_11

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_11

    check-cast v0, Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V
    :try_end_f
    .catchall {:try_start_0 .. :try_end_f} :catchall_10

    goto :goto_11

    :catchall_10
    move-exception v1

    :cond_11
    :goto_11
    return-void
.end method

.method private static identity(Ljava/lang/String;)Ljava/lang/String;
    .registers 6

    :try_start_0
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_42

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_a
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_42

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    if-eqz v1, :cond_a

    array-length v2, v1

    const/4 v3, 0x2

    if-lt v2, v3, :cond_a

    const/4 v2, 0x0

    aget-object v2, v1, v2

    if-eqz v2, :cond_a

    invoke-virtual {p0, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_a

    const/4 v2, 0x1

    aget-object v1, v1, v2

    if-eqz v1, :cond_42

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_42

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_40
    .catchall {:try_start_0 .. :try_end_40} :catchall_41

    return-object v1

    :catchall_41
    move-exception v4

    :cond_42
    return-object p0
.end method

.method private static mac(Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    :try_start_0
    if-eqz p0, :cond_14

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_14
    :try_end_12
    .catchall {:try_start_0 .. :try_end_12} :catchall_13

    return-object v0

    :catchall_13
    move-exception v2

    :cond_14
    const/4 v0, 0x0

    return-object v0
.end method

.method private static note(Landroid/content/Context;)Landroid/widget/TextView;
    .registers 5

    :try_start_0
    const-string v0, "按设备保存，重启后保留；仅更换外观，不影响关联与切换。"

    const/4 v1, 0x2

    invoke-static {p0, v0, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v0

    if-eqz v0, :cond_1a

    const/high16 v1, 0x41400000  # 12.0f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v1, 0xc

    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1, v2, v2}, Landroid/widget/TextView;->setPadding(IIII)V
    :try_end_18
    .catchall {:try_start_0 .. :try_end_18} :catchall_19

    return-object v0

    :catchall_19
    move-exception v3

    :cond_1a
    const/4 v0, 0x0

    return-object v0
.end method

.method private option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;
    .registers 12

    :try_start_0
    invoke-static {p1}, Lbt192/auto/V3Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_d1

    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/16 v1, 0x2c

    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setMinimumWidth(I)V

    const/16 v1, 0x90

    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setMinimumHeight(I)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    const/4 v4, -0x2

    const/high16 v5, 0x3f800000  # 1.0f

    invoke-direct {v2, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    const/4 v1, 0x4

    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3, v1, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setFocusable(Z)V

    iget v4, p0, Lbt192/auto/V3IconChoice;->currentKind:I

    if-ne p2, v4, :cond_73

    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    const/16 v2, 0xc

    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const/4 v2, 0x2

    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    const v3, -0xda9c15

    invoke-virtual {v1, v2, v3}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setSelected(Z)V

    const-string v1, "，已选择"

    invoke-virtual {p3, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    goto :goto_77

    :cond_73
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setSelected(Z)V

    :goto_77
    const v2, -0xda9c15

    const v3, -0x120c01

    invoke-static {p1, p2, v2, v3}, Lbt192/auto/V3Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;

    move-result-object v1

    if-eqz v1, :cond_d1

    const/16 v2, 0x38

    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const/4 v2, 0x0

    invoke-static {p1, p3, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    if-eqz v1, :cond_d1

    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    const/16 v2, 0x8

    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2, v3, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const-string v2, " "

    iget v4, p0, Lbt192/auto/V3IconChoice;->currentKind:I

    if-ne p2, v4, :cond_b2

    const-string v2, "✓ 已选择"

    :cond_b2
    const/4 v3, 0x4

    invoke-static {p1, v2, v3}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;

    move-result-object v1

    if-eqz v1, :cond_d1

    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V

    const/high16 v2, 0x41400000  # 12.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    const/4 v2, 0x4

    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2, v3, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :try_end_cf
    .catchall {:try_start_0 .. :try_end_cf} :catchall_d0

    return-object v0

    :catchall_d0
    move-exception v7

    :cond_d1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static show(Lbt192/auto/V3Setup;Ljava/lang/String;)V
    .registers 12

    :try_start_0
    invoke-static {p0}, Lbt192/auto/V3IconChoice;->alive(Lbt192/auto/V3Setup;)Z

    move-result v0

    if-eqz v0, :cond_42

    invoke-static {p1}, Lbt192/auto/V3IconChoice;->mac(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_42

    invoke-virtual {p0, v1}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_42

    new-instance v2, Lbt192/auto/V3IconChoice;

    invoke-direct {v2, p0, v1}, Lbt192/auto/V3IconChoice;-><init>(Lbt192/auto/V3Setup;Ljava/lang/String;)V

    invoke-direct {v2, p0}, Lbt192/auto/V3IconChoice;->content(Landroid/content/Context;)Landroid/widget/LinearLayout;

    move-result-object v3

    if-eqz v3, :cond_42

    new-instance v7, Landroid/app/AlertDialog$Builder;

    invoke-direct {v7, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v4, "选择设备图标"

    invoke-virtual {v7, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v7, v3}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    const-string v4, "取消"

    const/4 v0, 0x0

    invoke-virtual {v7, v4, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v7}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v8

    if-eqz v8, :cond_42

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, v8}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, v2, Lbt192/auto/V3IconChoice;->dialog:Ljava/lang/ref/WeakReference;

    invoke-virtual {v8}, Landroid/app/AlertDialog;->show()V
    :try_end_40
    .catchall {:try_start_0 .. :try_end_40} :catchall_41

    goto :goto_42

    :catchall_41
    move-exception v9

    :cond_42
    :goto_42
    return-void
.end method

.method private static toast(Landroid/content/Context;Z)V
    .registers 5

    :try_start_0
    const-string v0, "图标未保存；读取异常时使用默认图标"

    if-eqz p1, :cond_6

    const-string v0, "图标已保存"

    :cond_6
    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    if-eqz v0, :cond_12

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end_10
    .catchall {:try_start_0 .. :try_end_10} :catchall_11

    goto :goto_12

    :catchall_11
    move-exception v2

    :cond_12
    :goto_12
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 8

    :try_start_0
    if-eqz p1, :cond_3b

    iget-object v0, p0, Lbt192/auto/V3IconChoice;->owner:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lbt192/auto/V3Setup;

    invoke-static {v0}, Lbt192/auto/V3IconChoice;->alive(Lbt192/auto/V3Setup;)Z

    move-result v1

    if-eqz v1, :cond_38

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Ljava/lang/Integer;

    if-eqz v2, :cond_38

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/16 v3, 0x9

    if-eq v2, v3, :cond_24

    if-nez v2, :cond_38

    :cond_24
    iget-object v3, p0, Lbt192/auto/V3IconChoice;->mac:Ljava/lang/String;

    invoke-virtual {v0, v3}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_38

    invoke-static {v0, v3, v2}, Lbt192/auto/V3DevicePrefs;->save(Landroid/content/Context;Ljava/lang/String;I)Z

    move-result v4

    invoke-static {v0, v4}, Lbt192/auto/V3IconChoice;->toast(Landroid/content/Context;Z)V

    invoke-virtual {v0}, Lbt192/auto/V3Setup;->iconChanged()V
    :try_end_36
    .catchall {:try_start_0 .. :try_end_36} :catchall_37

    goto :goto_38

    :catchall_37
    move-exception v5

    :cond_38
    :goto_38
    invoke-direct {p0}, Lbt192/auto/V3IconChoice;->dismissQuietly()V

    :cond_3b
    return-void
.end method
