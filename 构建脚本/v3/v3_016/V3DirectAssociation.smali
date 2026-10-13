.class public final Lbt192/auto/V3DirectAssociation;
.super Ljava/lang/Object;

# No preferences, hidden association creation, or process-local authorization cache.
.method private static normalize(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    :try_start
    if-eqz p0, :none
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :none
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static requestName(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    :try_start
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :none
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "蓝牙192 · "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# This ROM protects SELF_MANAGED as signature|privileged. API level is not a grant.
.method public static canSelfManage(Landroid/content/Context;)Z
    .locals 2
    :try_start
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x23
    if-lt v0, v1, :no
    if-eqz p0, :no
    const-string v0, "android.permission.REQUEST_COMPANION_SELF_MANAGED"
    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I
    move-result v0
    if-nez v0, :no
    :try_end
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static makeRequest(Ljava/lang/String;)Landroid/companion/AssociationRequest;
    .locals 3
    :try_start
    # isSelfManaged() is public only from API35; no hidden fallback on 33/34.
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x23
    if-lt v0, v1, :none
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->requestName(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :none
    new-instance v1, Landroid/companion/AssociationRequest$Builder;
    invoke-direct {v1}, Landroid/companion/AssociationRequest$Builder;-><init>()V
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/companion/AssociationRequest$Builder;->setSelfManaged(Z)Landroid/companion/AssociationRequest$Builder;
    invoke-virtual {v1, v0}, Landroid/companion/AssociationRequest$Builder;->setDisplayName(Ljava/lang/CharSequence;)Landroid/companion/AssociationRequest$Builder;
    # API33 public: require system consent even when CDM could otherwise skip it.
    invoke-virtual {v1, v2}, Landroid/companion/AssociationRequest$Builder;->setForceConfirmation(Z)Landroid/companion/AssociationRequest$Builder;
    invoke-virtual {v1}, Landroid/companion/AssociationRequest$Builder;->build()Landroid/companion/AssociationRequest;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Application tag maps a local choice; it is NOT system proof of a physical MAC.
.method public static matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    .locals 3
    :try_start
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x23
    if-lt v0, v1, :no
    if-eqz p0, :no
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->isSelfManaged()Z
    move-result v0
    if-eqz v0, :no
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getId()I
    move-result v0
    if-lez v0, :no
    invoke-static {p1}, Lbt192/auto/V3DirectAssociation;->requestName(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :no
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getDisplayName()Ljava/lang/CharSequence;
    move-result-object v2
    if-eqz v2, :no
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    :try_end
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Actual current-package/user list only. Null means unavailable/unknown.
.method private static ownList(Landroid/content/Context;)Ljava/util/List;
    .locals 2
    :try_start
    if-eqz p0, :none
    const-string v0, "companiondevice"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/companion/CompanionDeviceManager;
    if-eqz v0, :none
    invoke-virtual {v0}, Landroid/companion/CompanionDeviceManager;->getMyAssociations()Ljava/util/List;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

.method public static associated(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3
    :try_start
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x23
    if-lt v0, v1, :no
    invoke-static {p1}, Lbt192/auto/V3DirectAssociation;->requestName(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :no
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->ownList(Landroid/content/Context;)Ljava/util/List;
    move-result-object v0
    if-eqz v0, :no
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :no
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    instance-of v2, v1, Landroid/companion/AssociationInfo;
    if-eqz v2, :loop
    check-cast v1, Landroid/companion/AssociationInfo;
    invoke-static {v1, p1}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :loop
    :try_end
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Payload alone never grants: callback ID and exact tag must be in own CDM list.
.method public static owns(Landroid/content/Context;Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    .locals 4
    :try_start
    invoke-static {p1, p2}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :no
    invoke-virtual {p1}, Landroid/companion/AssociationInfo;->getId()I
    move-result v3
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->ownList(Landroid/content/Context;)Ljava/util/List;
    move-result-object v0
    if-eqz v0, :no
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :no
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    instance-of v2, v1, Landroid/companion/AssociationInfo;
    if-eqz v2, :loop
    check-cast v1, Landroid/companion/AssociationInfo;
    invoke-virtual {v1}, Landroid/companion/AssociationInfo;->getId()I
    move-result v2
    if-ne v2, v3, :loop
    invoke-static {v1, p2}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :loop
    :try_end
    const/4 v0, 0x1
    return v0
    :caught
    move-exception v0
    :no
    const/4 v0, 0x0
    return v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Normal record: real public MAC (API33). Self-managed: strict API35 exact tag.
.method public static macOf(Landroid/companion/AssociationInfo;)Ljava/lang/String;
    .locals 1
    :try_start
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->macOfUnchecked(Landroid/companion/AssociationInfo;)Ljava/lang/String;
    move-result-object v0
    :try_end
    return-object v0
    :caught
    move-exception v0
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method

# Enumeration uses the throwing internal reader: no partial-success snapshot.
.method private static macOfUnchecked(Landroid/companion/AssociationInfo;)Ljava/lang/String;
    .locals 3
    if-eqz p0, :none
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getId()I
    move-result v0
    if-lez v0, :none
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x23
    if-lt v0, v1, :normal
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->isSelfManaged()Z
    move-result v0
    if-eqz v0, :normal
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getDisplayName()Ljava/lang/CharSequence;
    move-result-object v0
    if-eqz v0, :none
    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "蓝牙192 · "
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :none
    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v1
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/V3DirectAssociation;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :none
    invoke-static {p0, v0}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :none
    goto :result
    :normal
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getDeviceMacAddress()Landroid/net/MacAddress;
    move-result-object v0
    if-eqz v0, :none
    invoke-virtual {v0}, Landroid/net/MacAddress;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Lbt192/auto/V3DirectAssociation;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    :result
    return-object v0
    :none
    const/4 v0, 0x0
    return-object v0
.end method

# Background status sampler only. Empty is known-empty; null is unknown.
.method public static macs(Landroid/content/Context;)Ljava/util/Set;
    .locals 4
    :try_start
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->ownList(Landroid/content/Context;)Ljava/util/List;
    move-result-object v0
    if-eqz v0, :none
    new-instance v1, Ljava/util/HashSet;
    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :loop
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :done
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    instance-of v3, v2, Landroid/companion/AssociationInfo;
    if-eqz v3, :loop
    check-cast v2, Landroid/companion/AssociationInfo;
    invoke-static {v2}, Lbt192/auto/V3DirectAssociation;->macOfUnchecked(Landroid/companion/AssociationInfo;)Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :loop
    invoke-interface {v1, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    goto :loop
    :try_end
    :done
    return-object v1
    :caught
    move-exception v0
    :none
    const/4 v0, 0x0
    return-object v0
    .catchall {:try_start .. :try_end} :caught
.end method
