.class public final Lbt192/auto/V3DeviceOrder;
.super Ljava/lang/Object;

# UI-only MAIN-THREAD order preference. Never changes Targets, CDM or runtime.
# Pin previous value if commit publishes a failed write into SharedPrefs memory.
.field private static pinned:Ljava/lang/String;

.method private static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2
    const-string v0, "v3_ui_prefs"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    return-object v0
.end method

.method private static read(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    sget-object v0, Lbt192/auto/V3DeviceOrder;->pinned:Ljava/lang/String;
    if-nez v0, :done
    invoke-static {p0}, Lbt192/auto/V3DeviceOrder;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "device_order_v1"
    const-string v2, ""
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    :done
    return-object v0
.end method

.method public static rows(Landroid/content/Context;Ljava/util/List;)Ljava/util/List;
    .locals 8
    :try_start
    new-instance v0, Ljava/util/LinkedHashMap;
    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :rows
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :saved
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, [Ljava/lang/String;
    const/4 v3, 0x0
    aget-object v3, v2, v3
    invoke-interface {v0, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    goto :rows
    :saved
    new-instance v4, Ljava/util/ArrayList;
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V
    invoke-static {p0}, Lbt192/auto/V3DeviceOrder;->read(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v1
    const-string v2, ","
    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v1
    const/4 v2, 0x0
    :ordered
    array-length v3, v1
    if-ge v2, v3, :remaining
    aget-object v3, v1, v2
    invoke-interface {v0, v3}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v3
    if-eqz v3, :next
    invoke-interface {v4, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :next
    add-int/lit8 v2, v2, 0x1
    goto :ordered
    :remaining
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;
    move-result-object v0
    invoke-interface {v4, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
    :try_end
    return-object v4
    .catchall {:try_start .. :try_end} :caught
    :caught
    move-exception v7
    # Read failure: display original snapshot, never invent/authorize a row.
    return-object p1
.end method

.method public static capture(Landroid/widget/LinearLayout;)Ljava/util/List;
    .locals 4
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    const/4 v1, 0x0
    :loop
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I
    move-result v2
    if-ge v1, v2, :done
    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v3
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    add-int/lit8 v1, v1, 0x1
    goto :loop
    :done
    return-object v0
.end method

.method public static restore(Landroid/widget/LinearLayout;Ljava/util/List;)V
    .locals 2
    invoke-virtual {p0}, Landroid/view/ViewGroup;->removeAllViews()V
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :done
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/view/View;
    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
    goto :loop
    :done
    return-void
.end method

.method public static save(Landroid/content/Context;Landroid/widget/LinearLayout;)Z
    .locals 10
    const/4 v9, 0x0
    :prepare_start
    invoke-static {p0}, Lbt192/auto/V3DeviceOrder;->read(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v9
    # Allocation and collecting all keys happen BEFORE any preference write.
    new-instance v0, Ljava/util/LinkedHashSet;
    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V
    const/4 v1, 0x0
    :children
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I
    move-result v2
    if-ge v1, v2, :old_keys
    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v2
    invoke-virtual {v2}, Landroid/view/View;->getTag()Ljava/lang/Object;
    move-result-object v2
    instance-of v3, v2, Ljava/lang/String;
    if-eqz v3, :child_next
    check-cast v2, Ljava/lang/String;
    const-string v3, "order:"
    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, :child_next
    const/4 v3, 0x6
    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v2
    invoke-interface {v0, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :child_next
    add-int/lit8 v1, v1, 0x1
    goto :children
    :old_keys
    const-string v1, ","
    invoke-virtual {v9, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v1
    const/4 v2, 0x0
    :old_loop
    array-length v3, v1
    if-ge v2, v3, :serialize
    aget-object v3, v1, v2
    invoke-virtual {v3}, Ljava/lang/String;->length()I
    move-result v4
    const/16 v5, 0x11
    if-ne v4, v5, :old_next
    invoke-interface {v0, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :old_next
    add-int/lit8 v2, v2, 0x1
    goto :old_loop
    :serialize
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :csv
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :write
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I
    move-result v3
    if-eqz v3, :append
    const-string v3, ","
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :append
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :csv
    :write
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    invoke-static {p0}, Lbt192/auto/V3DeviceOrder;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v1, "device_order_v1"
    # Pin OLD before putString/commit: even exceptions cannot expose new memory.
    sput-object v9, Lbt192/auto/V3DeviceOrder;->pinned:Ljava/lang/String;
    invoke-interface {v0, v1, v8}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v1
    if-eqz v1, :fail
    const/4 v0, 0x0
    sput-object v0, Lbt192/auto/V3DeviceOrder;->pinned:Ljava/lang/String;
    const/4 v0, 0x1
    :prepare_end
    return v0
    :caught
    move-exception v0
    :fail
    const/4 v0, 0x0
    return v0
    .catchall {:prepare_start .. :prepare_end} :caught
.end method
