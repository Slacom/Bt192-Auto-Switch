.class public Lbt192/auto/V3Setup;
.super Landroid/app/Activity;
.field private settingActions:Landroid/widget/LinearLayout;
.field private usableWidthPx:I
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnApplyWindowInsetsListener;
.implements Ljava/lang/Runnable;
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;
.implements Landroid/view/View$OnLayoutChangeListener;

.field private body:Landroid/widget/LinearLayout;

.field private mainScroll:Landroid/widget/ScrollView;
.field private deviceScroll:Landroid/widget/ScrollView;
.field private devicesBody:Landroid/widget/LinearLayout;
.field private listCount:Landroid/widget/TextView;
.field private wide:Z
.field private listHeightPx:I
.field private seenWidth:I
.field private seenHeight:I
.field private savedPageScroll:I
.field private savedDeviceScroll:I
.field private restoreScroll:Z
.field private reflowHandler:Landroid/os/Handler;
.field private reflowTask:Ljava/lang/Runnable;
.field private reflowQueued:Z

.field private pendingMac:Ljava/lang/String;
.field private requestToken:I
.field private awaitingAssociation:Z
.field private chooserOpened:Z
.field private associationRc:I
.field private associationHandler:Landroid/os/Handler;
.field private associationTimeout:Ljava/lang/Runnable;
.field private runtimeHandler:Landroid/os/Handler;
.field private runtimeRows:Ljava/util/Map;
.field private observedStatusVersion:I

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    return-void
.end method

.method protected onResume()V
    .locals 2
    invoke-super {p0}, Landroid/app/Activity;->onResume()V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->stopRuntimeUpdates()V
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :try_start
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v0, p0, Lbt192/auto/V3Setup;->runtimeHandler:Landroid/os/Handler;
    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private toast(Ljava/lang/String;)V
    .locals 2
    :try_start
    const/4 v0, 0x1
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v1
    invoke-virtual {v1}, Landroid/widget/Toast;->show()V
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 6
    :try_start
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x1e
    if-lt v0, v1, :legacy
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I
    move-result v0
    invoke-static {}, Landroid/view/WindowInsets$Type;->displayCutout()I
    move-result v1
    or-int/2addr v0, v1
    invoke-virtual {p2, v0}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;
    move-result-object v0
    iget v1, v0, Landroid/graphics/Insets;->left:I
    iget v2, v0, Landroid/graphics/Insets;->top:I
    iget v3, v0, Landroid/graphics/Insets;->right:I
    iget v4, v0, Landroid/graphics/Insets;->bottom:I
    goto :padding
    :legacy
    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetLeft()I
    move-result v1
    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetTop()I
    move-result v2
    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetRight()I
    move-result v3
    invoke-virtual {p2}, Landroid/view/WindowInsets;->getSystemWindowInsetBottom()I
    move-result v4
    :padding
    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/view/View;->setPadding(IIII)V
    :try_end
    return-object p2
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-object p2
    .catchall {:try_start .. :try_end} :caught
.end method

.method private text(Ljava/lang/String;)V
    .locals 3
    const/4 v0, 0x2
    invoke-static {p0, p1, v0}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v0
    iget-object v1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

.method private button(Ljava/lang/String;I)V
    .locals 2
    const/4 v0, 0x0
    invoke-direct {p0, p1, p2, v0}, Lbt192/auto/V3Setup;->actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    move-result-object v0
    iget-object v1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

# Per-feature permission tests do not depend on user acknowledgement flags.
.method private nearbyGranted()Z
    .locals 3
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x1f
    if-lt v0, v1, :legacy
    const-string v0, "android.permission.BLUETOOTH_CONNECT"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :denied
    const-string v0, "android.permission.BLUETOOTH_SCAN"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :denied
    :legacy
    const/4 v0, 0x1
    return v0
    :denied
    const/4 v0, 0x0
    return v0
.end method

.method private accessibilityEnabled()Z
    .locals 6
    :try_start
    const-string v0, "accessibility"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/accessibility/AccessibilityManager;
    if-eqz v0, :disabled
    const/4 v1, -0x1
    invoke-virtual {v0, v1}, Landroid/view/accessibility/AccessibilityManager;->getEnabledAccessibilityServiceList(I)Ljava/util/List;
    move-result-object v0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :disabled
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/accessibilityservice/AccessibilityServiceInfo;
    invoke-virtual {v1}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getResolveInfo()Landroid/content/pm/ResolveInfo;
    move-result-object v1
    iget-object v1, v1, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;
    iget-object v2, v1, Landroid/content/pm/ServiceInfo;->packageName:Ljava/lang/String;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :loop
    iget-object v1, v1, Landroid/content/pm/ServiceInfo;->name:Ljava/lang/String;
    const-string v2, "bt192.auto.WatchService2"
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :loop
    const/4 v0, 0x1
    :try_end
    return v0
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :disabled
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method private batteryStatus()Ljava/lang/String;
    .locals 2
    :try_start
    const-string v0, "power"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/os/PowerManager;
    if-eqz v0, :unknown
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/os/PowerManager;->isIgnoringBatteryOptimizations(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :restricted
    const-string v0, "Android标准电池优化：已豁免（不等于厂商无限制）"
    :try_end
    return-object v0
    :restricted
    const-string v0, "Android标准电池优化：未豁免（厂商策略另行确认）"
    return-object v0
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    :unknown
    const-string v0, "Android标准电池优化：无法读取"
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# No private vendor status API is assumed. The acknowledgement text is explicit.
.method private vendorRow(Ljava/lang/String;Ljava/lang/String;II)V
    .locals 7
    const-string v2, "系统暂无法直接读取"
    const-string v3, "待确认"
    const/4 v4, 0x2
    invoke-static {p0, p2}, Lbt192/auto/V3Prefs;->acknowledged(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v6
    if-eqz v6, :vendor_ready
    const-string v3, "用户已确认"
    const-string v2, "未由系统核验，不再提醒"
    const/4 v4, 0x3
    :vendor_ready
    move-object v1, p1
    move v5, p3
    move-object v0, p0
    invoke-direct/range {v0 .. v5}, Lbt192/auto/V3Setup;->settingRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    if-nez v6, :vendor_done
    iget-object v0, p0, Lbt192/auto/V3Setup;->settingActions:Landroid/widget/LinearLayout;
    const-string v1, "确认已开启"
    const/4 v2, 0x0
    invoke-direct {p0, v1, p4, v2}, Lbt192/auto/V3Setup;->actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :vendor_done
    iget-object v0, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->divider(Landroid/widget/LinearLayout;)V
    return-void
.end method


.method private refresh()V
    .locals 10
    :try_start
    iget-object v0, p0, Lbt192/auto/V3Setup;->deviceScroll:Landroid/widget/ScrollView;
    if-eqz v0, :refresh_ready
    check-cast v0, Lbt192/auto/V3DeviceScroll;
    invoke-virtual {v0}, Lbt192/auto/V3DeviceScroll;->busy()Z
    move-result v0
    if-eqz v0, :refresh_ready
    return-void
    :refresh_ready
    invoke-static {}, Lbt192/auto/V3StatusStore;->version()I
    move-result v8
    invoke-direct {p0}, Lbt192/auto/V3Setup;->saveScroll()V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->measureWindow()V
    new-instance v0, Ljava/util/HashMap;
    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V
    iput-object v0, p0, Lbt192/auto/V3Setup;->runtimeRows:Ljava/util/Map;
    const/4 v0, 0x1
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const v0, 0xfff7f9fc
    invoke-virtual {v1, v0}, Landroid/view/View;->setBackgroundColor(I)V
    invoke-virtual {v1, p0}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V
    invoke-virtual {v1, p0}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V
    invoke-virtual {p0, v1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V
    invoke-virtual {v1}, Landroid/view/View;->requestApplyInsets()V
    invoke-direct {p0, v1}, Lbt192/auto/V3Setup;->header(Landroid/widget/LinearLayout;)V
    new-instance v2, Landroid/widget/ScrollView;
    invoke-direct {v2, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V
    const/4 v0, 0x1
    invoke-virtual {v2, v0}, Landroid/view/View;->setNestedScrollingEnabled(Z)V
    iput-object v2, p0, Lbt192/auto/V3Setup;->mainScroll:Landroid/widget/ScrollView;
    invoke-direct {p0, v1, v2}, Lbt192/auto/V3Setup;->flex(Landroid/widget/LinearLayout;Landroid/view/View;)V
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v3
    const/16 v0, 0x10
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v0
    invoke-virtual {v3, v0, v0, v0, v0}, Landroid/view/View;->setPadding(IIII)V
    invoke-virtual {v2, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V
    iput-object v3, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-direct {p0, v3}, Lbt192/auto/V3Setup;->devicePanel(Landroid/widget/LinearLayout;)V
    invoke-direct {p0, v3}, Lbt192/auto/V3Setup;->deviceActions(Landroid/widget/LinearLayout;)V
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->wide:Z
    xor-int/lit8 v0, v0, 0x1
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v4
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-static {p0}, Lbt192/auto/V3Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    move-result-object v5
    invoke-static {p0}, Lbt192/auto/V3Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    move-result-object v6
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->wide:Z
    if-eqz v0, :stacked
    invoke-direct {p0, v4, v5}, Lbt192/auto/V3Setup;->panelWeight(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const/16 v0, 0xc
    invoke-direct {p0, v4, v0}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    invoke-direct {p0, v4, v6}, Lbt192/auto/V3Setup;->panelWeight(Landroid/widget/LinearLayout;Landroid/view/View;)V
    goto :panels
    :stacked
    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/16 v0, 0xc
    invoke-direct {p0, v4, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    invoke-virtual {v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :panels
    iput-object v5, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-direct {p0}, Lbt192/auto/V3Setup;->permissionsPanel()V
    iput-object v6, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-direct {p0}, Lbt192/auto/V3Setup;->backgroundPanel()V
    invoke-direct {p0, v5, v6}, Lbt192/auto/V3Setup;->equalPanels(Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;)V
    iput-object v3, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    const/16 v0, 0xc
    invoke-direct {p0, v3, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    invoke-static {p0}, Lbt192/auto/V3Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    move-result-object v4
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-direct {p0, v4}, Lbt192/auto/V3Setup;->statusPanel(Landroid/widget/LinearLayout;)V
    # Capture the version before reading any views: a concurrent publication
    # during render must cause another UI pass, not be silently marked consumed.
    iput v8, p0, Lbt192/auto/V3Setup;->observedStatusVersion:I
    const/4 v0, 0x1
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->restoreScroll:Z
    invoke-direct {p0}, Lbt192/auto/V3Setup;->lightBars()V
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const-string v0, "界面或状态读取失败，请重新打开或刷新"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private details()V
    .locals 3
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v1
    const-string v2, "package:"
    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    return-void
.end method

.method private autostartSettings()V
    .locals 3
    :try_start
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const-string v1, "com.miui.securitycenter"
    const-string v2, "com.miui.permcenter.autostart.AutoStartManagementActivity"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-direct {p0}, Lbt192/auto/V3Setup;->details()V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private requestNearby()V
    .locals 4
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x1f
    if-lt v0, v1, :legacy
    const/4 v0, 0x2
    new-array v0, v0, [Ljava/lang/String;
    const/4 v1, 0x0
    const-string v2, "android.permission.BLUETOOTH_CONNECT"
    aput-object v2, v0, v1
    const/4 v1, 0x1
    const-string v2, "android.permission.BLUETOOTH_SCAN"
    aput-object v2, v0, v1
    const/16 v1, 0x3010
    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->requestPermissions([Ljava/lang/String;I)V
    return-void
    :legacy
    const-string v0, "当前Android版本无需附近设备运行时授权"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1
    :try_start
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4
    :try_start
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v0
    instance-of v1, v0, Ljava/lang/String;
    if-eqz v1, :fixed_action
    check-cast v0, Ljava/lang/String;
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->deviceAction(Ljava/lang/String;)V
    goto :done
    :fixed_action
    invoke-virtual {p1}, Landroid/view/View;->getId()I
    move-result v0
    packed-switch v0, :actions
    return-void
    :nearby
    invoke-direct {p0}, Lbt192/auto/V3Setup;->requestNearby()V
    goto :done
    :accessibility
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.settings.ACCESSIBILITY_SETTINGS"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    goto :done
    :battery
    const-string v0, "请在应用省电策略中选择无限制；完成后可点击确认已开启"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->details()V
    goto :done
    :battery_ack
    const-string v0, "battery_ack"
    goto :ack
    :autostart
    invoke-direct {p0}, Lbt192/auto/V3Setup;->autostartSettings()V
    goto :done
    :autostart_ack
    const-string v0, "autostart_ack"
    :ack
    const/4 v1, 0x1
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Prefs;->acknowledge(Landroid/content/Context;Ljava/lang/String;Z)Z
    move-result v0
    if-nez v0, :refresh
    const-string v0, "确认保存失败，请重试；提醒尚未关闭"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    goto :refresh
    :reset
    invoke-static {p0}, Lbt192/auto/V3Prefs;->resetAcknowledgements(Landroid/content/Context;)Z
    move-result v2
    if-nez v2, :refresh
    const-string v0, "提醒重置保存失败，当前会话仍会提醒，请重试"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    goto :refresh
    :details
    invoke-direct {p0}, Lbt192/auto/V3Setup;->details()V
    goto :done
    :cancel_association
    iget v1, p0, Lbt192/auto/V3Setup;->requestToken:I
    const-string v0, "已停止等待；系统可能稍后完成关联，但不会自动开启切换"
    invoke-virtual {p0, v0, v1}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    goto :done
    :discover
    const/4 v0, 0x0
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->associate(Ljava/lang/String;)V
    goto :done
    :bluetooth_settings
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.settings.BLUETOOTH_SETTINGS"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    goto :done
    :refresh
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const-string v0, "操作失败或系统不提供此入口，可从系统设置手动配置"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
    :actions
    .packed-switch 0x3001
        :nearby
        :accessibility
        :battery
        :battery_ack
        :autostart
        :autostart_ack
        :reset
        :details
        :refresh
        :discover
        :bluetooth_settings
        :cancel_association
    .end packed-switch
.end method

# Each association is user-confirmed through the system chooser.
# Association does not imply pairing, A2DP connectivity or LHDC V5 capability.
.method private drawDevices()V
    .locals 2
    iget-object v1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    :try_start
    invoke-direct {p0}, Lbt192/auto/V3Setup;->drawDevicesUnchecked()V
    :try_end
    iput-object v1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    return-void
    :caught
    move-exception v0
    iput-object v1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const-string v0, "列表读取失败，请检查连接权限后刷新"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->text(Ljava/lang/String;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private drawDevicesUnchecked()V
    .locals 5
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v0
    invoke-static {p0, v0}, Lbt192/auto/V3DeviceOrder;->rows(Landroid/content/Context;Ljava/util/List;)Ljava/util/List;
    move-result-object v0
    invoke-interface {v0}, Ljava/util/List;->size()I
    move-result v1
    invoke-direct {p0, v1}, Lbt192/auto/V3Setup;->setDeviceCount(I)V
    if-nez v1, :list
    invoke-static {}, Lbt192/auto/V3StatusStore;->notice()Ljava/lang/String;
    move-result-object v1
    invoke-direct {p0, v1}, Lbt192/auto/V3Setup;->text(Ljava/lang/String;)V
    return-void
    :list
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :done
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [Ljava/lang/String;
    const/4 v2, 0x0
    aget-object v2, v1, v2
    const/4 v3, 0x1
    aget-object v3, v1, v3
    invoke-direct {p0, v3, v2}, Lbt192/auto/V3Setup;->deviceRow(Ljava/lang/String;Ljava/lang/String;)V
    goto :loop
    :done
    return-void
.end method

.method private deviceButton(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    const/4 v0, 0x2
    invoke-static {p0, p1, v0}, Lbt192/auto/V3Ui;->button(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/Button;
    move-result-object v0
    invoke-virtual {p2, p3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const/16 v1, 0x13
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V
    iget-object v2, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

# Snapshot is for decoration only; ? is NOT a disconnected claim or authority.
.method private cachedConnection(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    :try_start
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :unknown
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [Ljava/lang/String;
    if-eqz v1, :loop
    array-length v2, v1
    const/4 v3, 0x4
    if-lt v2, v3, :loop
    const/4 v2, 0x0
    aget-object v2, v1, v2
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :loop
    const/4 v2, 0x3
    aget-object v0, v1, v2
    :try_end
    return-object v0
    :caught
    move-exception v3
    :unknown
    const-string v0, "?"
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Current public A2DP read immediately before EVERY per-device mutation/action.
# This never initializes a proxy on UI thread; background Sampler owns bootstrap.
.method public deviceConnected(Ljava/lang/String;)Z
    .locals 4
    :try_start
    invoke-direct {p0}, Lbt192/auto/V3Setup;->connectGranted()Z
    move-result v0
    if-eqz v0, :no
    invoke-static {p1}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :no
    invoke-static {}, Lbt192/auto/V3Broker;->peek()Landroid/bluetooth/BluetoothA2dp;
    move-result-object v0
    if-eqz v0, :no
    invoke-static {v0}, Lbt192/auto/V3Broker;->isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z
    move-result v1
    if-eqz v1, :no
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;
    move-result-object v1
    if-eqz v1, :no
    invoke-virtual {v1, p1}, Landroid/bluetooth/BluetoothAdapter;->getRemoteDevice(Ljava/lang/String;)Landroid/bluetooth/BluetoothDevice;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/bluetooth/BluetoothA2dp;->getConnectionState(Landroid/bluetooth/BluetoothDevice;)I
    move-result v2
    const/4 v3, 0x2
    if-ne v2, v3, :no
    invoke-static {v0}, Lbt192/auto/V3Broker;->isCurrent(Landroid/bluetooth/BluetoothA2dp;)Z
    move-result v1
    :try_end
    return v1
    :caught
    move-exception v3
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method public requireDeviceConnected(Ljava/lang/String;)Z
    .locals 1
    invoke-virtual {p0, p1}, Lbt192/auto/V3Setup;->deviceConnected(Ljava/lang/String;)Z
    move-result v0
    if-nez v0, :done
    const-string v0, "请先连接耳机或音箱，确认连接后再操作"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    const/4 v0, 0x0
    :done
    return v0
.end method

# ViewGroup.setEnabled alone does NOT disable its children. Gate every descendant.
.method private gateDeviceView(Landroid/view/View;Z)V
    .locals 3
    invoke-virtual {p1, p2}, Landroid/view/View;->setEnabled(Z)V
    instance-of v0, p1, Landroid/view/ViewGroup;
    if-eqz v0, :done
    check-cast p1, Landroid/view/ViewGroup;
    const/4 v0, 0x0
    :loop
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I
    move-result v1
    if-ge v0, v1, :done
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v2
    invoke-direct {p0, v2, p2}, Lbt192/auto/V3Setup;->gateDeviceView(Landroid/view/View;Z)V
    add-int/lit8 v0, v0, 0x1
    goto :loop
    :done
    return-void
.end method

.method private deviceRow(Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    iget-object v9, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    const/4 v0, 0x1
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const-string v1, "order:"
    invoke-virtual {v1, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    const/4 v1, 0x4
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    const/4 v1, 0x0
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const/16 v2, 0x10
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setGravity(I)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-direct {p0, v1, p2}, Lbt192/auto/V3Setup;->compactDeviceIcon(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    const/4 v2, 0x4
    invoke-direct {p0, v1, v2}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    const/4 v2, 0x1
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v2
    invoke-direct {p0, v1, v2}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const/4 v3, 0x0
    invoke-static {p0, p1, v3}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v3
    const/high16 v4, 0x41600000
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V
    sget-object v4, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V
    invoke-direct {p0, v3}, Lbt192/auto/V3Setup;->compactLine(Landroid/widget/TextView;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-direct {p0, p2}, Lbt192/auto/V3Setup;->cachedAssociation(Ljava/lang/String;)Z
    move-result v5
    if-eqz v5, :not_associated
    const-string v3, "系统授权已确认 · 已选目标"
    goto :association_label
    :not_associated
    const-string v3, "系统关联未确认"
    :association_label
    const/4 v4, 0x2
    invoke-static {p0, v3, v4}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v3
    const/high16 v4, 0x41300000
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V
    invoke-direct {p0, v3}, Lbt192/auto/V3Setup;->compactLine(Landroid/widget/TextView;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/4 v4, 0x2
    invoke-static {p0, p2, v4}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v3
    const/high16 v4, 0x41200000
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V
    invoke-direct {p0, v3}, Lbt192/auto/V3Setup;->compactLine(Landroid/widget/TextView;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-static {p0, p2}, Lbt192/auto/V3Targets;->configured(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v6
    if-nez v5, :switch
    if-nez v6, :switch
    const-string v2, "关联"
    const/4 v3, 0x0
    invoke-static {p0, v2, v3}, Lbt192/auto/V3Ui;->button(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/Button;
    move-result-object v2
    const/16 v3, 0x30
    invoke-static {p0, v3}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v3
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setMinHeight(I)V
    invoke-virtual {v2, v3}, Landroid/view/View;->setMinimumHeight(I)V
    const-string v3, "associate:"
    invoke-virtual {v3, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    goto :details
    :switch
    invoke-direct {p0, v1, p2, v6}, Lbt192/auto/V3Setup;->toggle(Landroid/widget/LinearLayout;Ljava/lang/String;Z)V
    :details
    iput-object v0, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    if-eqz v6, :no_runtime
    invoke-static {p2}, Lbt192/auto/V3Submission;->pending(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :no_runtime
    const-string v2, "允许重试（可能重复请求）"
    const-string v3, "retry:"
    invoke-direct {p0, v2, v3, p2}, Lbt192/auto/V3Setup;->deviceButton(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :no_runtime
    invoke-direct {p0, p2}, Lbt192/auto/V3Setup;->cachedConnection(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v7
    const-string v8, "1"
    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v8
    if-nez v8, :connected_controls
    const-string v3, "0"
    invoke-virtual {v3, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :connection_unknown
    const-string v7, "未连接"
    goto :connection_note
    :connection_unknown
    const-string v7, "连接待确认"
    goto :connection_note
    :connected_controls
    const-string v7, "已连接"
    :connection_note
    # State remains accessible without allocating a fourth visual text row.
    invoke-virtual {p1, v7}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v7
    invoke-virtual {v0, v7}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->compactDivider(Landroid/widget/LinearLayout;)V
    invoke-direct {p0, v0, v8}, Lbt192/auto/V3Setup;->gateDeviceView(Landroid/view/View;Z)V
    if-nez v8, :gate_done
    const/high16 v3, 0x3f000000
    invoke-virtual {v0, v3}, Landroid/view/View;->setAlpha(F)V
    :gate_done
    iput-object v9, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    return-void
.end method

.method private deviceAction(Ljava/lang/String;)V
    .locals 3
    const-string v0, "icon:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :check_state_refresh
    const/4 v0, 0x5
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p0, v0}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :refresh
    invoke-static {p0, v0}, Lbt192/auto/V3IconChoice;->show(Lbt192/auto/V3Setup;Ljava/lang/String;)V
    return-void
    :check_state_refresh
    const-string v0, "state_refresh"
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :check_legacy_status
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    return-void
    :check_legacy_status
    :associate_action
    const-string v0, "associate:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :check_enable
    const/16 v0, 0xa
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p0, v0}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :refresh
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->associate(Ljava/lang/String;)V
    return-void
    :check_enable
    const-string v0, "enable:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :check_disable
    const/4 v0, 0x7
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    const/4 v1, 0x1
    goto :store
    :check_disable
    const-string v0, "retry:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :disable_action
    const/4 v0, 0x6
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p0, v0}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :refresh
    invoke-static {p0, v0}, Lbt192/auto/V3Submission;->retry(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v2
    if-nez v2, :refresh
    const-string v0, "重试未获资格或请求失败；请先确认系统关联和自动切换开关"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    goto :refresh
    :disable_action
    const-string v0, "disable:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :done
    const/16 v0, 0x8
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    const/4 v1, 0x0
    :store
    invoke-virtual {p0, v0}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :refresh
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Targets;->setEnabled(Landroid/content/Context;Ljava/lang/String;Z)Z
    move-result v2
    if-nez v2, :refresh
    const-string v0, "保存失败或系统关联未确认，未开启自动切换；请重试"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    :refresh
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :done
    return-void
.end method

.method private associate(Ljava/lang/String;)V
    .locals 7
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->awaitingAssociation:Z
    if-eqz v0, :ready
    const-string v0, "已有系统关联请求，请完成或取消后再操作"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    :ready
    if-eqz p1, :discovery_permission
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x23
    if-lt v0, v1, :discovery_permission
    invoke-direct {p0}, Lbt192/auto/V3Setup;->connectGranted()Z
    move-result v0
    if-eqz v0, :request_direct_permission
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;
    move-result-object v0
    if-eqz v0, :unavailable
    invoke-static {p1}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :invalid
    invoke-virtual {v0, p1}, Landroid/bluetooth/BluetoothAdapter;->getRemoteDevice(Ljava/lang/String;)Landroid/bluetooth/BluetoothDevice;
    move-result-object v0
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothDevice;->getBondState()I
    move-result v0
    const/16 v1, 0xc
    if-eq v0, v1, :permission_ready
    const-string v0, "此目标尚未配对，需先通过系统发现与配对"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    :request_direct_permission
    invoke-direct {p0}, Lbt192/auto/V3Setup;->requestNearby()V
    return-void
    :discovery_permission
    if-eqz p1, :permission_message_done
    const-string v0, "将使用系统单设备确认流程，优先检查已有配对"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    :permission_message_done
    invoke-direct {p0}, Lbt192/auto/V3Setup;->nearbyGranted()Z
    move-result v0
    if-nez v0, :permission_ready
    invoke-direct {p0}, Lbt192/auto/V3Setup;->requestNearby()V
    return-void
    :permission_ready
    if-eqz p1, :new_association
    invoke-static {p1}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :invalid
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->associated(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :new_association
    const-string v0, "此设备已有系统关联，可直接开启自动切换"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    return-void
    :new_association
    const-string v0, "companiondevice"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/companion/CompanionDeviceManager;
    if-eqz v0, :unavailable
    if-eqz p1, :discover_build
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->canSelfManage(Landroid/content/Context;)Z
    move-result v1
    if-eqz v1, :discover_build
    invoke-static {p1}, Lbt192/auto/V3DirectAssociation;->makeRequest(Ljava/lang/String;)Landroid/companion/AssociationRequest;
    move-result-object v2
    if-eqz v2, :invalid
    goto :association_request_ready
    :discover_build
    invoke-direct {p0}, Lbt192/auto/V3Setup;->nearbyGranted()Z
    move-result v1
    if-nez v1, :discovery_granted
    invoke-direct {p0}, Lbt192/auto/V3Setup;->requestNearby()V
    return-void
    :discovery_granted
    new-instance v1, Landroid/companion/BluetoothDeviceFilter$Builder;
    invoke-direct {v1}, Landroid/companion/BluetoothDeviceFilter$Builder;-><init>()V
    if-eqz p1, :filter_ready
    invoke-virtual {v1, p1}, Landroid/companion/BluetoothDeviceFilter$Builder;->setAddress(Ljava/lang/String;)Landroid/companion/BluetoothDeviceFilter$Builder;
    :filter_ready
    invoke-virtual {v1}, Landroid/companion/BluetoothDeviceFilter$Builder;->build()Landroid/companion/BluetoothDeviceFilter;
    move-result-object v1
    new-instance v2, Landroid/companion/AssociationRequest$Builder;
    invoke-direct {v2}, Landroid/companion/AssociationRequest$Builder;-><init>()V
    invoke-virtual {v2, v1}, Landroid/companion/AssociationRequest$Builder;->addDeviceFilter(Landroid/companion/DeviceFilter;)Landroid/companion/AssociationRequest$Builder;
    # Actual ROM single-device + address filter first checks existing bonded devices.
    if-eqz p1, :ordinary_confirmation
    const/4 v1, 0x1
    invoke-virtual {v2, v1}, Landroid/companion/AssociationRequest$Builder;->setSingleDevice(Z)Landroid/companion/AssociationRequest$Builder;
    :ordinary_confirmation
    const/4 v1, 0x1
    invoke-virtual {v2, v1}, Landroid/companion/AssociationRequest$Builder;->setForceConfirmation(Z)Landroid/companion/AssociationRequest$Builder;
    invoke-virtual {v2}, Landroid/companion/AssociationRequest$Builder;->build()Landroid/companion/AssociationRequest;
    move-result-object v2
    :association_request_ready
    invoke-static {p0}, Lbt192/auto/V3Prefs;->reserveAssociationToken(Landroid/content/Context;)I
    move-result v3
    if-lez v3, :token_failed
    iput v3, p0, Lbt192/auto/V3Setup;->requestToken:I
    iput v3, p0, Lbt192/auto/V3Setup;->associationRc:I
    const/4 v1, 0x0
    iput-boolean v1, p0, Lbt192/auto/V3Setup;->chooserOpened:Z
    iput-object p1, p0, Lbt192/auto/V3Setup;->pendingMac:Ljava/lang/String;
    const/4 v1, 0x1
    iput-boolean v1, p0, Lbt192/auto/V3Setup;->awaitingAssociation:Z
    :associate_start
    new-instance v4, Lbt192/auto/V3Association;
    invoke-direct {v4, p0, v3}, Lbt192/auto/V3Association;-><init>(Lbt192/auto/V3Setup;I)V
    new-instance v5, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v6
    invoke-direct {v5, v6}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v5, p0, Lbt192/auto/V3Setup;->associationHandler:Landroid/os/Handler;
    iput-object v4, p0, Lbt192/auto/V3Setup;->associationTimeout:Ljava/lang/Runnable;
    invoke-direct {p0}, Lbt192/auto/V3Setup;->scheduleAssociationTimeout()V
    invoke-virtual {v0, v2, v4, v5}, Landroid/companion/CompanionDeviceManager;->associate(Landroid/companion/AssociationRequest;Landroid/companion/CompanionDeviceManager$Callback;Landroid/os/Handler;)V
    :associate_end
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    if-eqz p1, :discovery_toast
    const-string v0, "请在系统窗口确认该设备；优先检查已有配对，关联后自行开启自动切换"
    goto :show_request_toast
    :discovery_toast
    const-string v0, "请让耳机进入可发现状态并在系统弹窗中选择；关联后仍需配对连接"
    :show_request_toast
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    :associate_caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const-string v0, "系统关联请求被拒绝或执行失败；具体原因已写入日志"
    invoke-virtual {p0, v0, v3}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    return-void
    :token_failed
    const-string v0, "关联请求编号保存失败；未发起系统请求，请重试"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    :invalid
    const-string v0, "蓝牙设备地址无效"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    :unavailable
    const-string v0, "此系统未提供伴侣设备关联服务"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    return-void
    .catchall {:associate_start .. :associate_end} :associate_caught
.end method

.method public associationCurrent(I)Z
    .locals 1
    iget v0, p0, Lbt192/auto/V3Setup;->requestToken:I
    if-ne v0, p1, :no
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->awaitingAssociation:Z
    if-eqz v0, :no
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z
    move-result v0
    if-nez v0, :no
    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z
    move-result v0
    if-nez v0, :no
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

.method public showAssociation(Landroid/content/IntentSender;I)V
    .locals 7
    invoke-virtual {p0, p2}, Lbt192/auto/V3Setup;->associationCurrent(I)Z
    move-result v0
    if-eqz v0, :done
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->chooserOpened:Z
    if-nez v0, :done
    :try_start
    const/4 v0, 0x1
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->chooserOpened:Z
    move-object v0, p0
    move-object v1, p1
    iget v2, p0, Lbt192/auto/V3Setup;->associationRc:I
    const/4 v3, 0x0
    const/4 v4, 0x0
    const/4 v5, 0x0
    const/4 v6, 0x0
    invoke-virtual/range {v0 .. v6}, Landroid/app/Activity;->startIntentSenderForResult(Landroid/content/IntentSender;ILandroid/content/Intent;III)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    const-string v0, "无法打开系统关联确认页"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public associationFailure(Ljava/lang/String;I)V
    .locals 1
    invoke-virtual {p0, p2}, Lbt192/auto/V3Setup;->associationCurrent(I)Z
    move-result v0
    if-eqz v0, :done
    invoke-direct {p0}, Lbt192/auto/V3Setup;->clearAssociationTimeout()V
    const/4 v0, 0x0
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->awaitingAssociation:Z
    iput-object v0, p0, Lbt192/auto/V3Setup;->pendingMac:Ljava/lang/String;
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    invoke-direct {p0, p1}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :done
    return-void
.end method

.method public associationCreated(Ljava/lang/String;I)V
    .locals 3
    invoke-virtual {p0, p2}, Lbt192/auto/V3Setup;->associationCurrent(I)Z
    move-result v0
    if-eqz v0, :done
    if-eqz p1, :invalid
    invoke-static {p1}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :invalid
    iget-object v0, p0, Lbt192/auto/V3Setup;->pendingMac:Ljava/lang/String;
    if-eqz v0, :verify_association
    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :invalid
    :verify_association
    invoke-static {p0, p1}, Lbt192/auto/V3Targets;->associated(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :not_verified
    const-string v0, "系统关联已确认；请在对应耳机项开启自动切换并连接耳机"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    return-void
    :not_verified
    const-string v0, "关联结果尚未通过系统回读，请刷新确认；未开启自动切换"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    return-void
    :invalid
    const-string v0, "关联结果与请求设备不一致；未开启自动切换"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    :done
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3
    :try_start
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    iget v0, p0, Lbt192/auto/V3Setup;->associationRc:I
    if-ne p1, v0, :done
    iget v1, p0, Lbt192/auto/V3Setup;->requestToken:I
    invoke-virtual {p0, v1}, Lbt192/auto/V3Setup;->associationCurrent(I)Z
    move-result v0
    if-eqz v0, :done
    const/4 v0, -0x1
    if-eq p2, v0, :accepted
    const-string v0, "系统关联已取消；原有关联与开关未改变"
    invoke-virtual {p0, v0, v1}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    goto :done
    :accepted
    # Modern Android completes via onAssociationCreated; legacy exposes EXTRA_DEVICE.
    if-eqz p3, :done
    const-string v0, "android.companion.extra.DEVICE"
    invoke-virtual {p3, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;
    move-result-object v0
    instance-of v2, v0, Landroid/bluetooth/BluetoothDevice;
    if-eqz v2, :done
    check-cast v0, Landroid/bluetooth/BluetoothDevice;
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p0, v0, v1}, Lbt192/auto/V3Setup;->associationCreated(Ljava/lang/String;I)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    iget v1, p0, Lbt192/auto/V3Setup;->requestToken:I
    const-string v0, "关联结果读取失败；未开启自动切换"
    invoke-virtual {p0, v0, v1}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method protected onDestroy()V
    .locals 1
    invoke-direct {p0}, Lbt192/auto/V3Setup;->cancelReflow()V
    iget-object v0, p0, Lbt192/auto/V3Setup;->deviceScroll:Landroid/widget/ScrollView;
    if-eqz v0, :order_cancelled
    check-cast v0, Lbt192/auto/V3DeviceScroll;
    invoke-virtual {v0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    :order_cancelled
    invoke-direct {p0}, Lbt192/auto/V3Setup;->stopRuntimeUpdates()V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->clearAssociationTimeout()V
    const/4 v0, 0x0
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->awaitingAssociation:Z
    iget v0, p0, Lbt192/auto/V3Setup;->requestToken:I
    add-int/lit8 v0, v0, 0x1
    iput v0, p0, Lbt192/auto/V3Setup;->requestToken:I
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V
    return-void
.end method


.method public run()V
    .locals 3
    :try_start
    iget-object v0, p0, Lbt192/auto/V3Setup;->runtimeHandler:Landroid/os/Handler;
    if-eqz v0, :done
    invoke-static {}, Lbt192/auto/V3StatusStore;->version()I
    move-result v0
    iget v1, p0, Lbt192/auto/V3Setup;->observedStatusVersion:I
    if-eq v0, v1, :rearm
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :try_end
    :rearm
    iget-object v0, p0, Lbt192/auto/V3Setup;->runtimeHandler:Landroid/os/Handler;
    if-eqz v0, :done
    const-wide/16 v1, 0x7d0
    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    goto :rearm
    .catchall {:try_start .. :try_end} :caught
.end method

.method private stopRuntimeUpdates()V
    .locals 1
    :try_start
    iget-object v0, p0, Lbt192/auto/V3Setup;->runtimeHandler:Landroid/os/Handler;
    if-eqz v0, :clear
    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :clear
    const/4 v0, 0x0
    iput-object v0, p0, Lbt192/auto/V3Setup;->runtimeHandler:Landroid/os/Handler;
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method protected onPause()V
    .locals 1
    iget-object v0, p0, Lbt192/auto/V3Setup;->deviceScroll:Landroid/widget/ScrollView;
    if-eqz v0, :order_cancelled
    check-cast v0, Lbt192/auto/V3DeviceScroll;
    invoke-virtual {v0}, Lbt192/auto/V3DeviceScroll;->cancelGesture()V
    :order_cancelled
    invoke-direct {p0}, Lbt192/auto/V3Setup;->stopRuntimeUpdates()V
    invoke-super {p0}, Landroid/app/Activity;->onPause()V
    return-void
.end method

.method private scheduleAssociationTimeout()V
    .locals 4
    iget-object v0, p0, Lbt192/auto/V3Setup;->associationHandler:Landroid/os/Handler;
    iget-object v1, p0, Lbt192/auto/V3Setup;->associationTimeout:Ljava/lang/Runnable;
    const-wide/32 v2, 0x1d4c0
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void
.end method

.method private clearAssociationTimeout()V
    .locals 2
    :try_start
    iget-object v0, p0, Lbt192/auto/V3Setup;->associationHandler:Landroid/os/Handler;
    iget-object v1, p0, Lbt192/auto/V3Setup;->associationTimeout:Ljava/lang/Runnable;
    if-eqz v0, :clear
    if-eqz v1, :clear
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :clear
    const/4 v0, 0x0
    iput-object v0, p0, Lbt192/auto/V3Setup;->associationHandler:Landroid/os/Handler;
    iput-object v0, p0, Lbt192/auto/V3Setup;->associationTimeout:Ljava/lang/Runnable;
    :try_end
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method private actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    .locals 1
    invoke-static {p0, p1, p3}, Lbt192/auto/V3Ui;->button(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/Button;
    move-result-object v0
    invoke-virtual {v0, p2}, Landroid/view/View;->setId(I)V
    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    return-object v0
.end method

.method private weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    .locals 4
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v1, 0x0
    const/4 v2, -0x2
    const/high16 v3, 0x3f800000
    invoke-direct {v0, v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void
.end method

.method private flex(Landroid/widget/LinearLayout;Landroid/view/View;)V
    .locals 4
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v1, -0x1
    const/4 v2, 0x0
    const/high16 v3, 0x3f800000
    invoke-direct {v0, v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void
.end method

.method private fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    .locals 1
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;
    invoke-direct {v0, p3, p4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void
.end method

.method private gap(Landroid/widget/LinearLayout;I)V
    .locals 3
    new-instance v0, Landroid/view/View;
    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    invoke-static {p0, p2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    const/4 v2, -0x1
    invoke-direct {p0, p1, v0, v2, v1}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    return-void
.end method

.method private horizontalGap(Landroid/widget/LinearLayout;I)V
    .locals 3
    new-instance v0, Landroid/view/View;
    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    invoke-static {p0, p2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    const/4 v2, 0x1
    invoke-direct {p0, p1, v0, v1, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    return-void
.end method

.method private divider(Landroid/widget/LinearLayout;)V
    .locals 4
    const/16 v0, 0x8
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    new-instance v0, Landroid/view/View;
    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    const v1, 0xffe7eaf0
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V
    const/4 v1, -0x1
    const/4 v2, 0x1
    invoke-direct {p0, p1, v0, v1, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    const/16 v0, 0x8
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    return-void
.end method

.method private measureWindow()V
    .locals 8
    invoke-virtual {p0}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;
    move-result-object v0
    invoke-interface {v0}, Landroid/view/WindowManager;->getCurrentWindowMetrics()Landroid/view/WindowMetrics;
    move-result-object v0
    invoke-virtual {v0}, Landroid/view/WindowMetrics;->getBounds()Landroid/graphics/Rect;
    move-result-object v1
    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I
    move-result v2
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I
    move-result v3
    invoke-virtual {v0}, Landroid/view/WindowMetrics;->getWindowInsets()Landroid/view/WindowInsets;
    move-result-object v0
    invoke-static {}, Landroid/view/WindowInsets$Type;->systemBars()I
    move-result v1
    invoke-static {}, Landroid/view/WindowInsets$Type;->displayCutout()I
    move-result v4
    or-int/2addr v1, v4
    invoke-virtual {v0, v1}, Landroid/view/WindowInsets;->getInsetsIgnoringVisibility(I)Landroid/graphics/Insets;
    move-result-object v0
    iget v1, v0, Landroid/graphics/Insets;->left:I
    iget v4, v0, Landroid/graphics/Insets;->right:I
    add-int/2addr v1, v4
    sub-int/2addr v2, v1
    iget v1, v0, Landroid/graphics/Insets;->top:I
    iget v4, v0, Landroid/graphics/Insets;->bottom:I
    add-int/2addr v1, v4
    sub-int/2addr v3, v1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v1
    iget v4, v1, Landroid/util/DisplayMetrics;->density:F
    int-to-float v5, v2
    div-float/2addr v5, v4
    float-to-int v5, v5
    const/16 v6, 0x258
    const/4 v7, 0x0
    if-lt v5, v6, :width_ready
    const/4 v7, 0x1
    :width_ready
    iput-boolean v7, p0, Lbt192/auto/V3Setup;->wide:Z
    iput v2, p0, Lbt192/auto/V3Setup;->usableWidthPx:I
    div-int/lit8 v3, v3, 0x4
    const/16 v5, 0x80
    invoke-static {p0, v5}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v5
    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;
    move-result-object v0
    iget v7, v0, Landroid/content/res/Configuration;->fontScale:F
    const/high16 v6, 0x3f800000
    invoke-static {v6, v7}, Ljava/lang/Math;->max(FF)F
    move-result v7
    int-to-float v5, v5
    mul-float/2addr v5, v7
    float-to-int v5, v5
    invoke-static {v3, v5}, Ljava/lang/Math;->max(II)I
    move-result v3
    div-int/lit8 v5, v3, 0x4
    add-int/2addr v3, v5
    div-int/lit8 v5, v3, 0x4
    add-int/2addr v3, v5
    # Floor only for small/large-font windows; ordinary tablet gets exact1.25.
    const/16 v5, 0x100
    invoke-static {p0, v5}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v5
    int-to-float v5, v5
    mul-float/2addr v5, v7
    float-to-int v5, v5
    invoke-static {v3, v5}, Ljava/lang/Math;->max(II)I
    move-result v3
    iput v3, p0, Lbt192/auto/V3Setup;->listHeightPx:I
    return-void
.end method

.method private header(Landroid/widget/LinearLayout;)V
    .locals 6
    const/4 v0, 0x0
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    const/16 v1, 0x10
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    const/16 v2, 0x8
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    invoke-virtual {v0, v1, v2, v1, v2}, Landroid/view/View;->setPadding(IIII)V
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/4 v1, 0x0
    const v2, 0xff20242c
    const/4 v3, 0x0
    invoke-static {p0, v1, v2, v3}, Lbt192/auto/V3Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    move-result-object v1
    const/16 v2, 0x1c
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    invoke-direct {p0, v0, v1, v2, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    const/16 v1, 0x8
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    const-string v1, "蓝牙192"
    const/4 v2, 0x3
    invoke-static {p0, v1, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/16 v1, 0x8
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    const-string v1, "v3"
    const/4 v2, 0x3
    invoke-static {p0, v1, v2}, Lbt192/auto/V3Ui;->badge(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v1, Landroid/view/View;
    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->headerSpacer(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const-string v1, "刷新"
    const/16 v2, 0x3009
    const/4 v3, 0x2
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

.method private devicePanel(Landroid/widget/LinearLayout;)V
    .locals 6
    invoke-static {p0}, Lbt192/auto/V3Ui;->card(Landroid/content/Context;)Landroid/widget/LinearLayout;
    move-result-object v0
    const/4 v1, -0x1
    iget v2, p0, Lbt192/auto/V3Setup;->listHeightPx:I
    invoke-direct {p0, p1, v0, v1, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    const/4 v1, 0x0
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const-string v2, "我的蓝牙设备"
    const/4 v3, 0x1
    invoke-static {p0, v2, v3}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v2
    invoke-direct {p0, v1, v2}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const-string v2, "设备列表"
    const/4 v3, 0x0
    invoke-static {p0, v2, v3}, Lbt192/auto/V3Ui;->badge(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v2
    iput-object v2, p0, Lbt192/auto/V3Setup;->listCount:Landroid/widget/TextView;
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const-string v1, "已配对与系统关联设备 · 独立开关"
    const/4 v2, 0x2
    invoke-static {p0, v1, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/16 v1, 0x8
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    new-instance v1, Lbt192/auto/V3DeviceScroll;
    invoke-direct {v1, p0}, Lbt192/auto/V3DeviceScroll;-><init>(Landroid/content/Context;)V
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/view/View;->setNestedScrollingEnabled(Z)V
    const/4 v3, 0x0
    invoke-virtual {v1, v3}, Landroid/view/View;->setVerticalScrollBarEnabled(Z)V
    iput-object v1, p0, Lbt192/auto/V3Setup;->deviceScroll:Landroid/widget/ScrollView;
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->flex(Landroid/widget/LinearLayout;Landroid/view/View;)V
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V
    iput-object v2, p0, Lbt192/auto/V3Setup;->devicesBody:Landroid/widget/LinearLayout;
    iput-object v2, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-direct {p0}, Lbt192/auto/V3Setup;->drawDevices()V
    iput-object p1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    return-void
.end method

.method private setDeviceCount(I)V
    .locals 3
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v1, " 台"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    iget-object v1, p0, Lbt192/auto/V3Setup;->listCount:Landroid/widget/TextView;
    if-eqz v1, :done
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :done
    return-void
.end method

.method private deviceActions(Landroid/widget/LinearLayout;)V
    .locals 5
    const/16 v0, 0xc
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    const/4 v0, 0x0
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const-string v1, "发现并关联耳机"
    const/16 v2, 0x300a
    const/4 v3, 0x1
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    move-result-object v1
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const/16 v1, 0x8
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    const-string v1, "蓝牙设置"
    const/16 v2, 0x300b
    const/4 v3, 0x0
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    move-result-object v1
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->awaitingAssociation:Z
    if-eqz v0, :idle
    const-string v0, "停止等待当前关联（不删除系统关联）"
    const/16 v1, 0x300c
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->button(Ljava/lang/String;I)V
    :idle
    const/16 v0, 0xc
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    return-void
.end method

.method private connectGranted()Z
    .locals 1
    const-string v0, "android.permission.BLUETOOTH_CONNECT"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :no
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

.method private permissionsPanel()V
    .locals 7
    const-string v0, "权限状态"
    const/4 v1, 0x1
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v0
    iget-object v6, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-direct {p0, v6}, Lbt192/auto/V3Setup;->divider(Landroid/widget/LinearLayout;)V
    const-string v1, "附近设备"
    const-string v2, "按实际授权读取连接与发现权限"
    const-string v3, "已授权"
    const/4 v4, 0x1
    const/4 v5, 0x0
    invoke-direct {p0}, Lbt192/auto/V3Setup;->nearbyGranted()Z
    move-result v0
    if-nez v0, :nearby_ready
    const-string v3, "待授权"
    const/4 v4, 0x2
    const/16 v5, 0x3001
    invoke-direct {p0}, Lbt192/auto/V3Setup;->connectGranted()Z
    move-result v0
    if-nez v0, :partial
    invoke-direct {p0}, Lbt192/auto/V3Setup;->scanGranted()Z
    move-result v0
    if-eqz v0, :nearby_ready
    :partial
    const-string v3, "部分授权"
    :nearby_ready
    move-object v0, p0
    invoke-direct/range {v0 .. v5}, Lbt192/auto/V3Setup;->settingRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    invoke-direct {p0, v6}, Lbt192/auto/V3Setup;->divider(Landroid/widget/LinearLayout;)V
    const-string v1, "无障碍服务"
    const-string v2, "未启用或状态尚未确认"
    const-string v3, "待配置"
    const/4 v4, 0x2
    const/16 v5, 0x3002
    invoke-direct {p0}, Lbt192/auto/V3Setup;->accessibilityEnabled()Z
    move-result v0
    if-eqz v0, :access_ready
    const-string v3, "已启用"
    const/4 v4, 0x1
    const/4 v5, 0x0
    const-string v2, "已启用，后台绑定尚未确认"
    sget-object v0, Lbt192/auto/WatchService2;->current:Lbt192/auto/WatchService2;
    if-eqz v0, :access_ready
    const-string v2, "后台服务已绑定"
    :access_ready
    move-object v0, p0
    invoke-direct/range {v0 .. v5}, Lbt192/auto/V3Setup;->settingRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    return-void
.end method


.method private statusLine(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 4
    const/4 v0, 0x0
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    const/16 v1, 0x10
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V
    const-string v1, "附近设备"
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    const/4 v2, 0x1
    if-nez v1, :icon_ready
    const-string v1, "无障碍服务"
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    const/4 v2, 0x2
    if-nez v1, :icon_ready
    const/4 v2, 0x3
    :icon_ready
    invoke-direct {p0, v0, v2, p3}, Lbt192/auto/V3Setup;->leadingIcon(Landroid/widget/LinearLayout;II)V
    const/4 v1, 0x0
    invoke-static {p0, p1, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    invoke-static {p0, p2, p3}, Lbt192/auto/V3Ui;->badge(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    iget-object v2, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

.method private backgroundPanel()V
    .locals 7
    const-string v0, "后台运行"
    const/4 v1, 0x1
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v0
    iget-object v4, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-direct {p0, v4}, Lbt192/auto/V3Setup;->divider(Landroid/widget/LinearLayout;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->batteryStatus()Ljava/lang/String;
    move-result-object v0
    const-string v1, "无法读取"
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-nez v1, :battery_unknown
    const-string v1, "未豁免"
    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-nez v1, :battery_restricted
    const-string v0, "已豁免"
    const/4 v1, 0x1
    goto :battery_label
    :battery_unknown
    const-string v0, "未知"
    const/4 v1, 0x0
    goto :battery_label
    :battery_restricted
    const-string v0, "未豁免"
    const/4 v1, 0x2
    :battery_label
    move-object v3, v0
    move v4, v1
    const-string v1, "标准电池优化"
    const-string v2, "仅代表Android标准策略"
    const/4 v5, 0x0
    move-object v0, p0
    invoke-direct/range {v0 .. v5}, Lbt192/auto/V3Setup;->settingRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    iget-object v4, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-direct {p0, v4}, Lbt192/auto/V3Setup;->divider(Landroid/widget/LinearLayout;)V
    const-string v0, "厂商省电策略"
    const-string v1, "battery_ack"
    const/16 v2, 0x3003
    const/16 v3, 0x3004
    invoke-direct {p0, v0, v1, v2, v3}, Lbt192/auto/V3Setup;->vendorRow(Ljava/lang/String;Ljava/lang/String;II)V
    const-string v0, "后台自启动"
    const-string v1, "autostart_ack"
    const/16 v2, 0x3005
    const/16 v3, 0x3006
    invoke-direct {p0, v0, v1, v2, v3}, Lbt192/auto/V3Setup;->vendorRow(Ljava/lang/String;Ljava/lang/String;II)V
    return-void
.end method


.method private toggle(Landroid/widget/LinearLayout;Ljava/lang/String;Z)V
    .locals 8
    const/4 v0, 0x0
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    const/16 v1, 0x10
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V
    const-string v1, "自动切换"
    const/4 v2, 0x2
    invoke-static {p0, v1, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    const/high16 v2, 0x41300000
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V
    const/16 v2, 0x11
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setGravity(I)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v1, Landroid/widget/Switch;
    invoke-direct {v1, p0}, Landroid/widget/Switch;-><init>(Landroid/content/Context;)V
    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroid/widget/Switch;->setShowText(Z)V
    const/16 v2, 0x30
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    invoke-virtual {v1, v2}, Landroid/view/View;->setMinimumHeight(I)V
    invoke-virtual {v1, v2}, Landroid/view/View;->setMinimumWidth(I)V
    invoke-virtual {v1, p3}, Landroid/widget/CompoundButton;->setChecked(Z)V
    const-string v2, "toggle:"
    invoke-virtual {v2, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    # Attach AFTER setChecked, never invoke a configuration transaction on render.
    invoke-virtual {v1, p0}, Landroid/widget/CompoundButton;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V
    const/4 v2, -0x1
    invoke-static {v2}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/widget/Switch;->setThumbTintList(Landroid/content/res/ColorStateList;)V
    # Disabled state precedes checked: a preserved ON value is grey while offline.
    const/4 v2, 0x3
    new-array v3, v2, [[I
    const/4 v4, 0x1
    new-array v4, v4, [I
    const v5, -0x101009e
    const/4 v6, 0x0
    aput v5, v4, v6
    aput-object v4, v3, v6
    const/4 v4, 0x1
    new-array v4, v4, [I
    const v5, 0x10100a0
    aput v5, v4, v6
    const/4 v5, 0x1
    aput-object v4, v3, v5
    new-array v4, v6, [I
    const/4 v7, 0x2
    aput-object v4, v3, v7
    new-array v2, v2, [I
    const v4, 0xff9ca3af
    aput v4, v2, v6
    const v4, 0xff4a77df
    aput v4, v2, v5
    const v4, 0xffcdd3dd
    aput v4, v2, v7
    new-instance v4, Landroid/content/res/ColorStateList;
    invoke-direct {v4, v3, v2}, Landroid/content/res/ColorStateList;-><init>([[I[I)V
    invoke-virtual {v1, v4}, Landroid/widget/Switch;->setTrackTintList(Landroid/content/res/ColorStateList;)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 3
    :try_start
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v0
    instance-of v1, v0, Ljava/lang/String;
    if-eqz v1, :done
    check-cast v0, Ljava/lang/String;
    const-string v1, "toggle:"
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :done
    const/4 v1, 0x7
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {p0, v0}, Lbt192/auto/V3Setup;->requireDeviceConnected(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :refresh
    invoke-static {p0, v0, p2}, Lbt192/auto/V3Targets;->setEnabled(Landroid/content/Context;Ljava/lang/String;Z)Z
    move-result v1
    if-nez v1, :refresh
    const-string v0, "保存失败或系统关联未确认，开关已按实际状态恢复"
    invoke-direct {p0, v0}, Lbt192/auto/V3Setup;->toast(Ljava/lang/String;)V
    :refresh
    invoke-static {p0}, Lbt192/auto/V3StatusSampler;->request(Landroid/content/Context;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method




.method private saveScroll()V
    .locals 1
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->restoreScroll:Z
    if-nez v0, :done
    iget-object v0, p0, Lbt192/auto/V3Setup;->mainScroll:Landroid/widget/ScrollView;
    if-eqz v0, :device
    invoke-virtual {v0}, Landroid/view/View;->getScrollY()I
    move-result v0
    iput v0, p0, Lbt192/auto/V3Setup;->savedPageScroll:I
    :device
    iget-object v0, p0, Lbt192/auto/V3Setup;->deviceScroll:Landroid/widget/ScrollView;
    if-eqz v0, :done
    invoke-virtual {v0}, Landroid/view/View;->getScrollY()I
    move-result v0
    iput v0, p0, Lbt192/auto/V3Setup;->savedDeviceScroll:I
    :done
    return-void
.end method

.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 4
    sub-int v0, p4, p2
    sub-int v1, p5, p3
    iget v2, p0, Lbt192/auto/V3Setup;->seenWidth:I
    iget v3, p0, Lbt192/auto/V3Setup;->seenHeight:I
    iput v0, p0, Lbt192/auto/V3Setup;->seenWidth:I
    iput v1, p0, Lbt192/auto/V3Setup;->seenHeight:I
    if-eqz v2, :restore
    if-ne v0, v2, :changed
    if-eq v1, v3, :restore
    :changed
    invoke-direct {p0}, Lbt192/auto/V3Setup;->scheduleReflow()V
    :restore
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->restoreScroll:Z
    if-eqz v0, :done
    const/4 v0, 0x0
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->restoreScroll:Z
    iget-object v1, p0, Lbt192/auto/V3Setup;->mainScroll:Landroid/widget/ScrollView;
    if-eqz v1, :device
    iget v2, p0, Lbt192/auto/V3Setup;->savedPageScroll:I
    invoke-virtual {v1, v0, v2}, Landroid/view/View;->scrollTo(II)V
    :device
    iget-object v1, p0, Lbt192/auto/V3Setup;->deviceScroll:Landroid/widget/ScrollView;
    if-eqz v1, :done
    iget v2, p0, Lbt192/auto/V3Setup;->savedDeviceScroll:I
    invoke-virtual {v1, v0, v2}, Landroid/view/View;->scrollTo(II)V
    :done
    return-void
.end method

.method protected onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V
    invoke-direct {p0}, Lbt192/auto/V3Setup;->scheduleReflow()V
    return-void
.end method

.method private scheduleReflow()V
    .locals 3
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->reflowQueued:Z
    if-nez v0, :done
    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z
    move-result v0
    if-nez v0, :done
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z
    move-result v0
    if-nez v0, :done
    const/4 v0, 0x1
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->reflowQueued:Z
    :try_start
    iget-object v0, p0, Lbt192/auto/V3Setup;->reflowHandler:Landroid/os/Handler;
    if-nez v0, :handler
    invoke-static {}, Lbt192/auto/V3Reflow;->handler()Landroid/os/Handler;
    move-result-object v0
    iput-object v0, p0, Lbt192/auto/V3Setup;->reflowHandler:Landroid/os/Handler;
    :handler
    iget-object v1, p0, Lbt192/auto/V3Setup;->reflowTask:Ljava/lang/Runnable;
    if-nez v1, :post
    invoke-static {p0}, Lbt192/auto/V3Reflow;->task(Lbt192/auto/V3Setup;)Ljava/lang/Runnable;
    move-result-object v1
    iput-object v1, p0, Lbt192/auto/V3Setup;->reflowTask:Ljava/lang/Runnable;
    :post
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    move-result v2
    if-nez v2, :try_end
    const/4 v2, 0x0
    iput-boolean v2, p0, Lbt192/auto/V3Setup;->reflowQueued:Z
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    const/4 v1, 0x0
    iput-boolean v1, p0, Lbt192/auto/V3Setup;->reflowQueued:Z
    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

.method public performReflow()V
    .locals 1
    const/4 v0, 0x0
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->reflowQueued:Z
    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z
    move-result v0
    if-nez v0, :done
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z
    move-result v0
    if-nez v0, :done
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :done
    return-void
.end method

.method private cancelReflow()V
    .locals 2
    const/4 v0, 0x0
    iput-boolean v0, p0, Lbt192/auto/V3Setup;->reflowQueued:Z
    iget-object v0, p0, Lbt192/auto/V3Setup;->reflowHandler:Landroid/os/Handler;
    if-eqz v0, :done
    iget-object v1, p0, Lbt192/auto/V3Setup;->reflowTask:Ljava/lang/Runnable;
    if-eqz v1, :done
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :done
    return-void
.end method

.method private lightBars()V
    .locals 4
    :try_start
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v0
    const v1, 0xfff7f9fc
    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V
    invoke-virtual {v0, v1}, Landroid/view/Window;->setNavigationBarColor(I)V
    invoke-virtual {v0}, Landroid/view/Window;->getInsetsController()Landroid/view/WindowInsetsController;
    move-result-object v0
    if-eqz v0, :done
    const/16 v1, 0x18
    invoke-interface {v0, v1, v1}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method


.method private leadingIcon(Landroid/widget/LinearLayout;II)V
    .locals 4
    const v0, 0xff758195
    const v1, 0xfff1f3f7
    const/4 v2, 0x1
    if-ne p3, v2, :amber
    const v0, 0xff15803d
    const v1, 0xffecfdf7
    const/4 v2, 0x2
    if-ne p2, v2, :make
    const v0, 0xff2563eb
    const v1, 0xffedf3ff
    goto :make
    :amber
    const/4 v2, 0x2
    if-ne p3, v2, :make
    const v0, 0xffb45309
    const v1, 0xfffffbeb
    :make
    invoke-static {p0, p2, v0, v1}, Lbt192/auto/V3Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    move-result-object v0
    const/16 v1, 0x20
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    invoke-direct {p0, p1, v0, v1, v1}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    const/16 v0, 0x8
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    return-void
.end method

.method private panelWeight(Landroid/widget/LinearLayout;Landroid/view/View;)V
    .locals 4
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v1, 0x0
    # In an UNSPECIFIED-height scrolling page, MATCH_PARENT can collapse both
    # columns to the parent's provisional minimum. Measure natural contents.
    const/4 v2, -0x2
    const/high16 v3, 0x3f800000
    invoke-direct {v0, v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void
.end method

.method private scanGranted()Z
    .locals 1
    const-string v0, "android.permission.BLUETOOTH_SCAN"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :no
    const/4 v0, 0x1
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

# An empty View uses AT_MOST size as its default WRAP_CONTENT height. Never
# let the weighted width spacer consume the header's entire available height.
.method private headerSpacer(Landroid/widget/LinearLayout;Landroid/view/View;)V
    .locals 4
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v1, 0x0
    const/4 v2, 0x1
    const/high16 v3, 0x3f800000
    invoke-direct {v0, v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    invoke-virtual {p1, p2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void
.end method

# Lead-owned007 Activity additions. UI metadata only; no profile acquisition.
.method public iconChanged()V
    .locals 1
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z
    move-result v0
    if-nez v0, :done
    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z
    move-result v0
    if-nez v0, :done
    invoke-direct {p0}, Lbt192/auto/V3Setup;->refresh()V
    :done
    return-void
.end method

.method private cachedAssociation(Ljava/lang/String;)Z
    .locals 4
    invoke-static {}, Lbt192/auto/V3StatusStore;->devices()Ljava/util/List;
    move-result-object v0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :no
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, [Ljava/lang/String;
    const/4 v2, 0x0
    aget-object v2, v1, v2
    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :loop
    const/4 v2, 0x2
    aget-object v1, v1, v2
    const-string v2, "1"
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    return v0
    :no
    const/4 v0, 0x0
    return v0
.end method

.method private deviceIcon(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    .locals 8
    new-instance v0, Landroid/widget/FrameLayout;
    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    invoke-static {p0, p2}, Lbt192/auto/V3DevicePrefs;->kind(Landroid/content/Context;Ljava/lang/String;)I
    move-result v1
    const v2, 0xff758195
    const v3, 0xffedf3ff
    invoke-static {p0, v1, v2, v3}, Lbt192/auto/V3Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    move-result-object v1
    const/16 v2, 0x30
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;
    invoke-direct {v3, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v0, v1, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const-string v1, "icon:"
    invoke-virtual {v1, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const-string v1, "更换此设备的TWS或头戴式图标"
    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    invoke-direct {p0, p1, v0, v2, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    const/16 v1, 0x8
    invoke-direct {p0, p1, v1}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    return-void
.end method

.method private statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    .locals 5
    const/4 v0, 0x1
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    const/16 v1, 0x4
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2, v1, v2}, Landroid/view/View;->setPadding(IIII)V
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;
    const/4 v2, -0x2
    int-to-float v3, p2
    const/4 v4, 0x0
    invoke-direct {v1, v4, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    invoke-virtual {p1, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-object v0
.end method

.method private statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    .locals 1
    invoke-static {p0, p2, p3}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v0
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method

.method private statusConnection(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    .locals 3
    const-string v0, "1"
    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :disconnected
    const-string v0, "已连接"
    const/4 v1, 0x1
    goto :badge
    :disconnected
    const-string v0, "0"
    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :unknown
    const-string v0, "未连接"
    const/4 v1, 0x0
    goto :badge
    :unknown
    const-string v0, "未知"
    const/4 v1, 0x2
    :badge
    invoke-static {p0, v0, v1}, Lbt192/auto/V3Ui;->badge(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v0
    const/4 v1, -0x2
    invoke-direct {p0, p1, v0, v1, v1}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    return-void
.end method

.method private statusPanel(Landroid/widget/LinearLayout;)V
    .locals 7
    const/4 v0, 0x0
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    const-string v1, "切换状态"
    const/4 v2, 0x1
    invoke-static {p0, v1, v2}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v1
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const-string v1, "刷新状态"
    const/4 v2, 0x0
    invoke-static {p0, v1, v2}, Lbt192/auto/V3Ui;->button(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/Button;
    move-result-object v1
    const-string v2, "state_refresh"
    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-static {}, Lbt192/auto/V3StatusStore;->notice()Ljava/lang/String;
    move-result-object v1
    const/4 v2, 0x2
    invoke-direct {p0, p1, v1, v2}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    invoke-static {}, Lbt192/auto/V3StatusStore;->associatedRows()Ljava/util/List;
    move-result-object v3
    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z
    move-result v0
    if-eqz v0, :rows
    const-string v1, "暂无已确认授权的耳机；请在上方选择已配对设备并关联"
    invoke-direct {p0, p1, v1, v2}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    goto :footer
    :rows
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->wide:Z
    if-eqz v0, :iterate
    invoke-direct {p0, p1}, Lbt192/auto/V3Setup;->statusHeaders(Landroid/widget/LinearLayout;)V
    :iterate
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v3
    :loop
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z
    move-result v0
    if-eqz v0, :footer
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, [Ljava/lang/String;
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->statusDevice(Landroid/widget/LinearLayout;[Ljava/lang/String;)V
    goto :loop
    :footer
    return-void
.end method

.method private statusHeaders(Landroid/widget/LinearLayout;)V
    .locals 5
    const/4 v0, 0x0
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/16 v1, 0x20
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const-string v2, "耳机设备"
    const/4 v3, 0x2
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    const/16 v4, 0x11
    invoke-direct {p0, v0, v4}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const-string v2, "连接状态"
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    invoke-direct {p0, v0, v4}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const-string v2, "采样率"
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    const/16 v4, 0x22
    invoke-direct {p0, v0, v4}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v1
    const-string v2, "上次成功切换"
    invoke-direct {p0, v1, v2, v3}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    return-void
.end method

.method private statusDevice(Landroid/widget/LinearLayout;[Ljava/lang/String;)V
    .locals 10
    invoke-direct {p0, p1}, Lbt192/auto/V3Setup;->divider(Landroid/widget/LinearLayout;)V
    const/4 v0, 0x0
    const/4 v1, 0x1
    iget-boolean v2, p0, Lbt192/auto/V3Setup;->wide:Z
    if-nez v2, :root_mode
    const/4 v0, 0x1
    :root_mode
    invoke-static {p0, v0}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    invoke-virtual {p1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    if-eqz v2, :mobile_name
    const/16 v3, 0x20
    invoke-direct {p0, v0, v3}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v3
    goto :name
    :mobile_name
    const/4 v3, 0x1
    invoke-static {p0, v3}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v3
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :name
    const/4 v4, 0x0
    invoke-static {p0, v4}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v4
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/4 v5, 0x0
    aget-object v5, p2, v5
    invoke-direct {p0, v4, v5}, Lbt192/auto/V3Setup;->deviceIcon(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v5
    invoke-direct {p0, v4, v5}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const/4 v6, 0x1
    aget-object v6, p2, v6
    const/4 v7, 0x0
    invoke-direct {p0, v5, v6, v7}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    const/4 v6, 0x4
    aget-object v6, p2, v6
    const/4 v7, 0x2
    aget-object v7, p2, v7
    const-string v8, "?"
    invoke-virtual {v8, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v7
    if-eqz v7, :codec_label_ready
    const-string v6, "关联待确认（历史名单）"
    :codec_label_ready
    const/4 v7, 0x2
    invoke-direct {p0, v5, v6, v7}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    if-nez v2, :metrics
    const/16 v3, 0x8
    invoke-direct {p0, v0, v3}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    const/4 v3, 0x0
    invoke-static {p0, v3}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v3
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    move-object v0, v3
    :metrics
    const/16 v1, 0x11
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v3
    const/4 v4, 0x3
    aget-object v4, p2, v4
    invoke-direct {p0, v3, v4}, Lbt192/auto/V3Setup;->statusConnection(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v3
    const/4 v4, 0x5
    aget-object v4, p2, v4
    const/4 v5, 0x4
    invoke-direct {p0, v3, v4, v5}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    const/16 v1, 0x22
    invoke-direct {p0, v0, v1}, Lbt192/auto/V3Setup;->statusColumn(Landroid/widget/LinearLayout;I)Landroid/widget/LinearLayout;
    move-result-object v3
    const/4 v4, 0x7
    aget-object v4, p2, v4
    const/4 v5, 0x0
    invoke-direct {p0, v3, v4, v5}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    const-string v4, "上次成功切换"
    const/4 v5, 0x2
    if-nez v2, :complete
    invoke-direct {p0, v3, v4, v5}, Lbt192/auto/V3Setup;->statusLabel(Landroid/widget/LinearLayout;Ljava/lang/String;I)V
    :complete
    return-void
.end method

.method public selfAssociationCreated(Landroid/companion/AssociationInfo;I)V
    .locals 2
    :try_start
    invoke-virtual {p0, p2}, Lbt192/auto/V3Setup;->associationCurrent(I)Z
    move-result v0
    if-eqz v0, :done
    iget-object v1, p0, Lbt192/auto/V3Setup;->pendingMac:Ljava/lang/String;
    if-eqz v1, :wrong
    invoke-static {p0, p1, v1}, Lbt192/auto/V3DirectAssociation;->owns(Landroid/content/Context;Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :wrong
    const-string v0, "所选耳机的系统授权已回读确认；无需断开重配，请自行开启自动切换"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    goto :done
    :wrong
    const-string v0, "系统授权结果与所选耳机不符或无法回读；未开启自动切换"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    :try_end
    :done
    return-void
    :caught
    move-exception v0
    const-string v0, "系统授权读取失败；未开启自动切换"
    invoke-virtual {p0, v0, p2}, Lbt192/auto/V3Setup;->associationFailure(Ljava/lang/String;I)V
    return-void
    .catchall {:try_start .. :try_end} :caught
.end method

# Pure UI: two natural-height cards retain WRAP_CONTENT and share the larger
# measured minimum. Avoid MATCH_PARENT in an UNSPECIFIED scrolling parent.
.method private equalPanels(Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;)V
    .locals 5
    iget-boolean v0, p0, Lbt192/auto/V3Setup;->wide:Z
    if-eqz v0, :done
    iget v0, p0, Lbt192/auto/V3Setup;->usableWidthPx:I
    const/16 v1, 0x2c
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    sub-int/2addr v0, v1
    div-int/lit8 v0, v0, 0x2
    if-lez v0, :done
    const/high16 v1, 0x40000000
    invoke-static {v0, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I
    move-result v0
    const/4 v1, 0x0
    invoke-virtual {p1, v0, v1}, Landroid/view/View;->measure(II)V
    invoke-virtual {p2, v0, v1}, Landroid/view/View;->measure(II)V
    invoke-virtual {p1}, Landroid/view/View;->getMeasuredHeight()I
    move-result v2
    invoke-virtual {p2}, Landroid/view/View;->getMeasuredHeight()I
    move-result v3
    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I
    move-result v2
    invoke-virtual {p1, v2}, Landroid/view/View;->setMinimumHeight(I)V
    invoke-virtual {p2, v2}, Landroid/view/View;->setMinimumHeight(I)V
    :done
    return-void
.end method

# Title/description on the left; badge and conditional settings on the right.
# Narrow screens stack only the right action group, never create an APP-details link.
.method private settingRow(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    .locals 9
    const/4 v1, 0x0
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v0
    const/16 v1, 0x10
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V
    const/16 v1, 0x40
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v1
    invoke-virtual {v0, v1}, Landroid/view/View;->setMinimumHeight(I)V
    const/4 v1, 0x1
    const-string v2, "附近设备"
    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :icon
    const/4 v1, 0x2
    const-string v2, "无障碍服务"
    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :icon
    const/4 v1, 0x3
    const-string v2, "标准电池优化"
    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :icon
    const/4 v1, 0x4
    const-string v2, "厂商省电策略"
    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :icon
    const/4 v1, 0x5
    :icon
    invoke-direct {p0, v0, v1, p4}, Lbt192/auto/V3Setup;->leadingIcon(Landroid/widget/LinearLayout;II)V
    const/4 v1, 0x1
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v2
    invoke-direct {p0, v0, v2}, Lbt192/auto/V3Setup;->weighted(Landroid/widget/LinearLayout;Landroid/view/View;)V
    const/4 v1, 0x0
    invoke-static {p0, p1, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v3
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    const/4 v1, 0x2
    invoke-static {p0, p2, v1}, Lbt192/auto/V3Ui;->label(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v3
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    iget-boolean v1, p0, Lbt192/auto/V3Setup;->wide:Z
    xor-int/lit8 v1, v1, 0x1
    invoke-static {p0, v1}, Lbt192/auto/V3Ui;->box(Landroid/content/Context;I)Landroid/widget/LinearLayout;
    move-result-object v5
    const/16 v1, 0x15
    invoke-virtual {v5, v1}, Landroid/widget/LinearLayout;->setGravity(I)V
    iput-object v5, p0, Lbt192/auto/V3Setup;->settingActions:Landroid/widget/LinearLayout;
    invoke-static {p0, p3, p4}, Lbt192/auto/V3Ui;->badge(Landroid/content/Context;Ljava/lang/String;I)Landroid/widget/TextView;
    move-result-object v3
    invoke-virtual {v5, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    if-lez p5, :no_action
    const-string v2, "设置"
    const/16 v1, 0x3001
    if-ne p5, v1, :not_nearby
    const-string v2, "申请授权"
    :not_nearby
    const/16 v1, 0x3002
    if-ne p5, v1, :action_ready
    const-string v2, "查看设置"
    :action_ready
    const/4 v1, 0x2
    invoke-direct {p0, v2, p5, v1}, Lbt192/auto/V3Setup;->actionButton(Ljava/lang/String;II)Landroid/widget/Button;
    move-result-object v3
    invoke-virtual {v5, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    :no_action
    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    iget-object v1, p0, Lbt192/auto/V3Setup;->body:Landroid/widget/LinearLayout;
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    return-void
.end method


.method private compactDeviceIcon(Landroid/widget/LinearLayout;Ljava/lang/String;)V
    .locals 8
    new-instance v0, Landroid/widget/FrameLayout;
    invoke-direct {v0, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    invoke-static {p0, p2}, Lbt192/auto/V3DevicePrefs;->kind(Landroid/content/Context;Ljava/lang/String;)I
    move-result v1
    const v2, 0xff758195
    const v3, 0xffedf3ff
    invoke-static {p0, v1, v2, v3}, Lbt192/auto/V3Ui;->icon(Landroid/content/Context;III)Landroid/widget/ImageView;
    move-result-object v1
    const/16 v2, 0x30
    invoke-static {p0, v2}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v2
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;
    const/16 v4, 0x24
    invoke-static {p0, v4}, Lbt192/auto/V3Ui;->dp(Landroid/content/Context;I)I
    move-result v4
    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    const/16 v4, 0x11
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
    invoke-virtual {v0, v1, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const-string v1, "icon:"
    invoke-virtual {v1, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    const-string v1, "更换此设备的TWS或头戴式图标"
    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    invoke-direct {p0, p1, v0, v2, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    const/4 v1, 0x4
    invoke-direct {p0, p1, v1}, Lbt192/auto/V3Setup;->horizontalGap(Landroid/widget/LinearLayout;I)V
    return-void
.end method

.method private compactLine(Landroid/widget/TextView;)V
    .locals 1
    const/4 v0, 0x1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setSingleLine(Z)V
    sget-object v0, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V
    return-void
.end method

.method private compactDivider(Landroid/widget/LinearLayout;)V
    .locals 4
    const/4 v0, 0x4
    invoke-direct {p0, p1, v0}, Lbt192/auto/V3Setup;->gap(Landroid/widget/LinearLayout;I)V
    new-instance v0, Landroid/view/View;
    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    const v1, 0xffe7eaf0
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V
    const/4 v1, -0x1
    const/4 v2, 0x1
    invoke-direct {p0, p1, v0, v1, v2}, Lbt192/auto/V3Setup;->fixed(Landroid/widget/LinearLayout;Landroid/view/View;II)V
    return-void
.end method
