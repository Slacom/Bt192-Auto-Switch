.class public final Lbt192/auto/V3IconChoice;
.super Ljava/lang/Object;
.implements Landroid/view/View$OnClickListener;

# No runtime action: this listener owns only immutable MAC + weak UI references.
.field private final owner:Ljava/lang/ref/WeakReference;
.field private final mac:Ljava/lang/String;
.field private final identity:Ljava/lang/String;
.field private final currentKind:I
.field private dialog:Ljava/lang/ref/WeakReference;

.method private constructor <init>(Lbt192/auto/V3Setup;Ljava/lang/String;)V
    .locals 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, p0, Lbt192/auto/V3IconChoice;->owner:Ljava/lang/ref/WeakReference;
    iput-object p2, p0, Lbt192/auto/V3IconChoice;->mac:Ljava/lang/String;
    # The immutable normalized MAC supplied by show identifies this chooser.
    # Capture only the legal decoration value; no edit/activation/runtime call.
    const/4 v0, 0x0
    :read_start
    invoke-static {p1, p2}, Lbt192/auto/V3DevicePrefs;->kind(Landroid/content/Context;Ljava/lang/String;)I
    move-result v0
    :read_end
    goto :legal
    .catchall {:read_start .. :read_end} :read_failed
    :read_failed
    move-exception v1
    const/4 v0, 0x0
    :legal
    const/16 v1, 0x9
    if-eq v0, v1, :store
    const/4 v0, 0x0
    :store
    iput v0, p0, Lbt192/auto/V3IconChoice;->currentKind:I
    invoke-static {p2}, Lbt192/auto/V3IconChoice;->identity(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    iput-object v0, p0, Lbt192/auto/V3IconChoice;->identity:Ljava/lang/String;
    return-void
.end method

# Read ONLY the published cache. MAC is the identity; never merge by device name.
.method private static identity(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    :try_start
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v0
    if-eqz v0, :fallback
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :fallback
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [Ljava/lang/String;
    if-eqz v1, :loop
    array-length v2, v1
    const/4 v3, 0x2
    if-lt v2, v3, :loop
    const/4 v2, 0x0
    aget-object v2, v1, v2
    if-eqz v2, :loop
    invoke-virtual {p0, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :loop
    const/4 v2, 0x1
    aget-object v1, v1, v2
    if-eqz v1, :fallback
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z
    move-result v2
    if-nez v2, :fallback
    const-string v2, "\n"
    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v1, p0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    :try_end
    return-object v1
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v4
    :fallback
    return-object p0
.end method

.method private static alive(Lbt192/auto/V3Setup;)Z
    .locals 2
    :try_start
    if-eqz p0, :no
    invoke-virtual {p0}, Lbt192/auto/V3Setup;->isFinishing()Z
    move-result v0
    if-nez v0, :no
    invoke-virtual {p0}, Lbt192/auto/V3Setup;->isDestroyed()Z
    move-result v0
    if-nez v0, :no
    const/4 v0, 0x1
    :try_end
    return v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v1
    :no
    const/4 v0, 0x0
    return v0
.end method

.method private static mac(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    :try_start
    if-eqz p0, :no
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v0
    # Static pure format validation only, no Bluetooth adapter access.
    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :no
    :try_end
    return-object v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v2
    :no
    const/4 v0, 0x0
    return-object v0
.end method

.method private option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;
    .locals 8
    :try_start
    invoke-static {p1}, Lbt192/auto/V3Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    move-result-object v0
    if-eqz v0, :no
    const/16 v1, 0x11
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V
    const/16 v1, 0x2c             # Both cards retain >=44dp touch targets.
    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setMinimumWidth(I)V
    const/16 v1, 0x90             # Equal 144dp cards reserve the selection slot.
    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setMinimumHeight(I)V
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v3, 0x0
    const/4 v4, -0x2
    const/high16 v5, 0x3f800000
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
    if-ne p2, v4, :unselected
    # Current choice gets an actual blue 2dp border, not only an accessibility flag.
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
    goto :icon
    :unselected
    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setSelected(Z)V
    :icon
    const v2, -0xda9c15           # #2563EB ink
    const v3, -0x120c01           # #EDF3FF circle, both original icons retained.
    invoke-static {p1, p2, v2, v3}, Lbt192/auto/V3Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    move-result-object v1
    if-eqz v1, :no
    const/16 v2, 0x38
    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;
    invoke-direct {v3, v2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v0, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const/4 v2, 0x0
    invoke-static {p1, p3, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    if-eqz v1, :no
    const/16 v2, 0x11
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V
    const/16 v2, 0x8
    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    const/4 v3, 0x0
    invoke-virtual {v1, v3, v2, v3, v3}, Landroid/widget/TextView;->setPadding(IIII)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const-string v2, " "          # Same height slot on the unselected card.
    iget v4, p0, Lbt192/auto/V3IconChoice;->currentKind:I
    if-ne p2, v4, :selection_label
    const-string v2, "✓ 已选择"
    :selection_label
    const/4 v3, 0x4
    invoke-static {p1, v2, v3}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    if-eqz v1, :no
    const/16 v2, 0x11
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V
    const/high16 v2, 0x41400000   # 12sp blue visible checkmark.
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V
    const/4 v2, 0x4
    invoke-static {p1, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    const/4 v3, 0x0
    invoke-virtual {v1, v3, v2, v3, v3}, Landroid/widget/TextView;->setPadding(IIII)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :try_end
    return-object v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v7
    # No failed NEW register is inspected; an incomplete card is never shown.
    :no
    const/4 v0, 0x0
    return-object v0
.end method

.method private static note(Landroid/content/Context;)Landroid/widget/TextView;
    .locals 4
    :try_start
    const-string v0, "按设备保存，重启后保留；仅更换外观，不影响关联与切换。"
    const/4 v1, 0x2
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v0
    if-eqz v0, :no
    const/high16 v1, 0x41400000
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V
    const/16 v1, 0xc
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    const/4 v2, 0x0
    invoke-virtual {v0, v2, v1, v2, v2}, Landroid/widget/TextView;->setPadding(IIII)V
    :try_end
    return-object v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v3
    :no
    const/4 v0, 0x0
    return-object v0
.end method

# Actual full picker pane can be measured/drawn without showing a Dialog.
.method private content(Landroid/content/Context;)Landroid/widget/LinearLayout;
    .locals 8
    :try_start
    const/4 v1, 0x1
    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    if-eqz v0, :no
    const/16 v1, 0xc
    invoke-static {p1, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V
    iget-object v1, p0, Lbt192/auto/V3IconChoice;->identity:Ljava/lang/String;
    const/4 v2, 0x2
    invoke-static {p1, v1, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    if-eqz v1, :no
    const/16 v2, 0x11
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V
    const/high16 v2, 0x41400000
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
    if-eqz v2, :no
    const/16 v1, 0x9
    const-string v5, "TWS 耳机"
    invoke-direct {p0, p1, v1, v5}, Lbt192/auto/V3IconChoice;->option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;
    move-result-object v3
    if-eqz v3, :no
    const/4 v1, 0x0
    const-string v5, "头戴式耳机"
    invoke-direct {p0, p1, v1, v5}, Lbt192/auto/V3IconChoice;->option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;
    move-result-object v4
    if-eqz v4, :no
    invoke-virtual {v3, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v4, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-static {p1}, Lbt192/auto/V3IconChoice;->note(Landroid/content/Context;)Landroid/widget/TextView;
    move-result-object v1
    if-eqz v1, :no
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :try_end
    return-object v0
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v7
    # Failed child/helper/NEW paths never read partial root or card registers.
    :no
    const/4 v0, 0x0
    return-object v0
.end method

.method public static show(Lbt192/auto/V3Setup;Ljava/lang/String;)V
    .locals 10
    :try_start
    invoke-static {p0}, Lbt192/auto/V3IconChoice;->alive(Lbt192/auto/V3Setup;)Z
    move-result v0
    if-eqz v0, :done
    invoke-static {p1}, Lbt192/auto/V3IconChoice;->mac(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :done
    invoke-virtual {p0, v1}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :done
    new-instance v2, Lbt192/auto/V3IconChoice;
    invoke-direct {v2, p0, v1}, Lbt192/auto/V3IconChoice;-><init>(Lbt192/auto/V3Setup;Ljava/lang/String;)V
    invoke-direct {v2, p0}, Lbt192/auto/V3IconChoice;->content(Landroid/content/Context;)Landroid/widget/LinearLayout;
    move-result-object v3
    if-eqz v3, :done
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
    if-eqz v8, :done
    new-instance v0, Ljava/lang/ref/WeakReference;
    invoke-direct {v0, v8}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    iput-object v0, v2, Lbt192/auto/V3IconChoice;->dialog:Ljava/lang/ref/WeakReference;
    invoke-virtual {v8}, Landroid/app/AlertDialog;->show()V
    :try_end
    goto :done
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v9
    # Exception path reads no NEW registers (ART verifier-safe merge).
    :done
    return-void
.end method

.method private dismissQuietly()V
    .locals 2
    :try_start
    iget-object v0, p0, Lbt192/auto/V3IconChoice;->dialog:Ljava/lang/ref/WeakReference;
    if-eqz v0, :done
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;
    move-result-object v0
    if-eqz v0, :done
    check-cast v0, Landroid/app/AlertDialog;
    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V
    :try_end
    goto :done
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v1
    :done
    return-void
.end method

.method private static toast(Landroid/content/Context;Z)V
    .locals 3
    :try_start
    const-string v0, "图标未保存；读取异常时使用默认图标"
    if-eqz p1, :message
    const-string v0, "图标已保存"
    :message
    const/4 v1, 0x0
    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v0
    if-eqz v0, :done
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end
    goto :done
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v2
    :done
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6
    :try_start
    if-eqz p1, :done
    iget-object v0, p0, Lbt192/auto/V3IconChoice;->owner:Ljava/lang/ref/WeakReference;
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Lbt192/auto/V3Setup;
    invoke-static {v0}, Lbt192/auto/V3IconChoice;->alive(Lbt192/auto/V3Setup;)Z
    move-result v1
    if-eqz v1, :close
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v1
    instance-of v2, v1, Ljava/lang/Integer;
    if-eqz v2, :close
    check-cast v1, Ljava/lang/Integer;
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    move-result v2
    const/16 v3, 0x9
    if-eq v2, v3, :save
    if-nez v2, :close
    :save
    iget-object v3, p0, Lbt192/auto/V3IconChoice;->mac:Ljava/lang/String;
    invoke-virtual {v0, v3}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v4
    if-eqz v4, :close
    invoke-static {v0, v3, v2}, Lbt192/auto/V3DevicePrefs;->save(Landroid/content/Context;Ljava/lang/String;I)Z
    move-result v4
    invoke-static {v0, v4}, Lbt192/auto/V3IconChoice;->toast(Landroid/content/Context;Z)V
    invoke-virtual {v0}, Lbt192/auto/V3Setup;->iconChanged()V
    :try_end
    goto :close
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v5
    :close
    invoke-direct {p0}, Lbt192/auto/V3IconChoice;->dismissQuietly()V
    :done
    return-void
.end method
