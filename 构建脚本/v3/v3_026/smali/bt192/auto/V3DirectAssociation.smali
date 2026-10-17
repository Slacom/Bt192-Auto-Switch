.class public final Lbt192/auto/V3DirectAssociation;
.super Ljava/lang/Object;


# direct methods
.method public static associated(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 5

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_2f

    invoke-static {p1}, Lbt192/auto/V3DirectAssociation;->requestName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2f

    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->ownList(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2f

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_16
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2f

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Landroid/companion/AssociationInfo;

    if-eqz v2, :cond_16

    check-cast v1, Landroid/companion/AssociationInfo;

    invoke-static {v1, p1}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_16
    :try_end_2c
    .catchall {:try_start_0 .. :try_end_2c} :catchall_2e

    const/4 v0, 0x1

    return v0

    :catchall_2e
    move-exception v0

    :cond_2f
    const/4 v0, 0x0

    return v0
.end method

.method public static canSelfManage(Landroid/content/Context;)Z
    .registers 3

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_13

    if-eqz p0, :cond_13

    const-string v0, "android.permission.REQUEST_COMPANION_SELF_MANAGED"

    invoke-virtual {p0, v0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_13
    :try_end_10
    .catchall {:try_start_0 .. :try_end_10} :catchall_12

    const/4 v0, 0x1

    return v0

    :catchall_12
    move-exception v0

    :cond_13
    const/4 v0, 0x0

    return v0
.end method

.method public static macOf(Landroid/companion/AssociationInfo;)Ljava/lang/String;
    .registers 2

    :try_start_0
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->macOfUnchecked(Landroid/companion/AssociationInfo;)Ljava/lang/String;

    move-result-object v0
    :try_end_4
    .catchall {:try_start_0 .. :try_end_4} :catchall_5

    return-object v0

    :catchall_5
    move-exception v0

    const/4 v0, 0x0

    return-object v0
.end method

.method private static macOfUnchecked(Landroid/companion/AssociationInfo;)Ljava/lang/String;
    .registers 4

    if-eqz p0, :cond_4a

    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getId()I

    move-result v0

    if-lez v0, :cond_4a

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_3b

    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->isSelfManaged()Z

    move-result v0

    if-eqz v0, :cond_3b

    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getDisplayName()Ljava/lang/CharSequence;

    move-result-object v0

    if-eqz v0, :cond_4a

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "蓝牙192 · "

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4a

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/V3DirectAssociation;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4a

    invoke-static {p0, v0}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4a

    goto :goto_49

    :cond_3b
    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getDeviceMacAddress()Landroid/net/MacAddress;

    move-result-object v0

    if-eqz v0, :cond_4a

    invoke-virtual {v0}, Landroid/net/MacAddress;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lbt192/auto/V3DirectAssociation;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_49
    return-object v0

    :cond_4a
    const/4 v0, 0x0

    return-object v0
.end method

.method public static macs(Landroid/content/Context;)Ljava/util/Set;
    .registers 5

    :try_start_0
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->ownList(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2b

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_f
    :goto_f
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_29

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Landroid/companion/AssociationInfo;

    if-eqz v3, :cond_f

    check-cast v2, Landroid/companion/AssociationInfo;

    invoke-static {v2}, Lbt192/auto/V3DirectAssociation;->macOfUnchecked(Landroid/companion/AssociationInfo;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_f

    invoke-interface {v1, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_f
    :try_end_29
    .catchall {:try_start_0 .. :try_end_29} :catchall_2a

    :cond_29
    return-object v1

    :catchall_2a
    move-exception v0

    :cond_2b
    const/4 v0, 0x0

    return-object v0
.end method

.method public static makeRequest(Ljava/lang/String;)Landroid/companion/AssociationRequest;
    .registers 4

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_21

    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->requestName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_21

    new-instance v1, Landroid/companion/AssociationRequest$Builder;

    invoke-direct {v1}, Landroid/companion/AssociationRequest$Builder;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/companion/AssociationRequest$Builder;->setSelfManaged(Z)Landroid/companion/AssociationRequest$Builder;

    invoke-virtual {v1, v0}, Landroid/companion/AssociationRequest$Builder;->setDisplayName(Ljava/lang/CharSequence;)Landroid/companion/AssociationRequest$Builder;

    invoke-virtual {v1, v2}, Landroid/companion/AssociationRequest$Builder;->setForceConfirmation(Z)Landroid/companion/AssociationRequest$Builder;

    invoke-virtual {v1}, Landroid/companion/AssociationRequest$Builder;->build()Landroid/companion/AssociationRequest;

    move-result-object v0
    :try_end_1f
    .catchall {:try_start_0 .. :try_end_1f} :catchall_20

    return-object v0

    :catchall_20
    move-exception v0

    :cond_21
    const/4 v0, 0x0

    return-object v0
.end method

.method public static matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    .registers 5

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_2a

    if-eqz p0, :cond_2a

    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->isSelfManaged()Z

    move-result v0

    if-eqz v0, :cond_2a

    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getId()I

    move-result v0

    if-lez v0, :cond_2a

    invoke-static {p1}, Lbt192/auto/V3DirectAssociation;->requestName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2a

    invoke-virtual {p0}, Landroid/companion/AssociationInfo;->getDisplayName()Ljava/lang/CharSequence;

    move-result-object v2

    if-eqz v2, :cond_2a

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_28
    .catchall {:try_start_0 .. :try_end_28} :catchall_29

    return v0

    :catchall_29
    move-exception v0

    :cond_2a
    const/4 v0, 0x0

    return v0
.end method

.method private static normalize(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

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
    move-exception v0

    :cond_14
    const/4 v0, 0x0

    return-object v0
.end method

.method private static ownList(Landroid/content/Context;)Ljava/util/List;
    .registers 3

    :try_start_0
    if-eqz p0, :cond_12

    const-string v0, "companiondevice"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/companion/CompanionDeviceManager;

    if-eqz v0, :cond_12

    invoke-virtual {v0}, Landroid/companion/CompanionDeviceManager;->getMyAssociations()Ljava/util/List;

    move-result-object v0
    :try_end_10
    .catchall {:try_start_0 .. :try_end_10} :catchall_11

    return-object v0

    :catchall_11
    move-exception v0

    :cond_12
    const/4 v0, 0x0

    return-object v0
.end method

.method public static owns(Landroid/content/Context;Landroid/companion/AssociationInfo;Ljava/lang/String;)Z
    .registers 7

    :try_start_0
    invoke-static {p1, p2}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_33

    invoke-virtual {p1}, Landroid/companion/AssociationInfo;->getId()I

    move-result v3

    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->ownList(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_33

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_14
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_33

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Landroid/companion/AssociationInfo;

    if-eqz v2, :cond_14

    check-cast v1, Landroid/companion/AssociationInfo;

    invoke-virtual {v1}, Landroid/companion/AssociationInfo;->getId()I

    move-result v2

    if-ne v2, v3, :cond_14

    invoke-static {v1, p2}, Lbt192/auto/V3DirectAssociation;->matches(Landroid/companion/AssociationInfo;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_14
    :try_end_30
    .catchall {:try_start_0 .. :try_end_30} :catchall_32

    const/4 v0, 0x1

    return v0

    :catchall_32
    move-exception v0

    :cond_33
    const/4 v0, 0x0

    return v0
.end method

.method public static requestName(Ljava/lang/String;)Ljava/lang/String;
    .registers 4

    :try_start_0
    invoke-static {p0}, Lbt192/auto/V3DirectAssociation;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_16

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "蓝牙192 · "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_14
    .catchall {:try_start_0 .. :try_end_14} :catchall_15

    return-object v0

    :catchall_15
    move-exception v0

    :cond_16
    const/4 v0, 0x0

    return-object v0
.end method
