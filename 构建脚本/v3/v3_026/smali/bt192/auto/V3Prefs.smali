.class public final Lbt192/auto/V3Prefs;
.super Ljava/lang/Object;


# static fields
.field private static uncertainMask:I


# direct methods
.method public static declared-synchronized acknowledge(Landroid/content/Context;Ljava/lang/String;Z)Z
    .registers 7

    const/4 v2, 0x0

    const/4 v1, 0x0

    :try_start_2
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v0

    if-eqz v0, :cond_20

    const/4 v3, 0x0

    invoke-static {p1, v3}, Lbt192/auto/V3Prefs;->mark(Ljava/lang/String;Z)V
    :try_end_1b
    .catchall {:try_start_2 .. :try_end_1b} :catchall_1c

    return v0

    :catchall_1c
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_20
    const/4 v3, 0x1

    invoke-static {p1, v3}, Lbt192/auto/V3Prefs;->mark(Ljava/lang/String;Z)V

    if-eqz v2, :cond_31

    :try_start_26
    invoke-interface {v2, p1, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_2c
    .catchall {:try_start_26 .. :try_end_2c} :catchall_2d

    goto :goto_31

    :catchall_2d
    move-exception v3

    invoke-static {v3}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_31
    :goto_31
    const/4 v0, 0x0

    return v0
.end method

.method public static declared-synchronized acknowledged(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 4

    invoke-static {p1}, Lbt192/auto/V3Prefs;->uncertain(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    const/4 v0, 0x0

    return v0

    :cond_8
    :try_start_8
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0
    :try_end_11
    .catchall {:try_start_8 .. :try_end_11} :catchall_12

    return v0

    :catchall_12
    move-exception v0

    invoke-static {v0}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    const/4 v0, 0x0

    return v0
.end method

.method private static bit(Ljava/lang/String;)I
    .registers 3

    const-string v0, "battery_ack"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    const/4 v0, 0x1

    return v0

    :cond_a
    const-string v0, "autostart_ack"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_14

    const/4 v0, 0x2

    return v0

    :cond_14
    const/4 v0, 0x0

    return v0
.end method

.method private static mark(Ljava/lang/String;Z)V
    .registers 4

    invoke-static {p0}, Lbt192/auto/V3Prefs;->bit(Ljava/lang/String;)I

    move-result v0

    sget v1, Lbt192/auto/V3Prefs;->uncertainMask:I

    if-eqz p1, :cond_a

    or-int/2addr v1, v0

    goto :goto_c

    :cond_a
    not-int v0, v0

    and-int/2addr v1, v0

    :goto_c
    sput v1, Lbt192/auto/V3Prefs;->uncertainMask:I

    return-void
.end method

.method public static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .registers 4

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_7

    move-object v0, p0

    :cond_7
    const-string v1, "v3_settings"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method public static declared-synchronized reserveAssociationToken(Landroid/content/Context;)I
    .registers 6

    :try_start_0
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "association_token_seq"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    if-ltz v2, :cond_26

    const v3, 0x7ffffffe

    if-ge v2, v3, :cond_26

    add-int/lit8 v2, v2, 0x1

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v3

    if-eqz v3, :cond_26
    :try_end_21
    .catchall {:try_start_0 .. :try_end_21} :catchall_22

    return v2

    :catchall_22
    move-exception v4

    invoke-static {v4}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_26
    const/4 v0, 0x0

    return v0
.end method

.method public static declared-synchronized resetAcknowledgements(Landroid/content/Context;)Z
    .registers 8

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const-string v3, "battery_ack"

    const-string v4, "autostart_ack"

    :try_start_7
    invoke-static {p0}, Lbt192/auto/V3Prefs;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v5

    const/4 v6, 0x0

    invoke-interface {v5, v3, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-interface {v5, v4, v6}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0, v3, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, v4, v6}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v5

    if-eqz v5, :cond_2c

    const/4 v6, 0x0

    sput v6, Lbt192/auto/V3Prefs;->uncertainMask:I
    :try_end_27
    .catchall {:try_start_7 .. :try_end_27} :catchall_28

    return v5

    :catchall_28
    move-exception v5

    invoke-static {v5}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_2c
    const/4 v6, 0x3

    sput v6, Lbt192/auto/V3Prefs;->uncertainMask:I

    if-eqz v0, :cond_3f

    :try_start_31
    invoke-interface {v0, v3, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0, v4, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :try_end_3a
    .catchall {:try_start_31 .. :try_end_3a} :catchall_3b

    goto :goto_3f

    :catchall_3b
    move-exception v5

    invoke-static {v5}, Lbt192/auto/CdmTrigger;->error(Ljava/lang/Throwable;)V

    :cond_3f
    :goto_3f
    const/4 v5, 0x0

    return v5
.end method

.method public static declared-synchronized uncertain(Ljava/lang/String;)Z
    .registers 3

    invoke-static {p0}, Lbt192/auto/V3Prefs;->bit(Ljava/lang/String;)I

    move-result v0

    sget v1, Lbt192/auto/V3Prefs;->uncertainMask:I

    and-int/2addr v0, v1

    if-eqz v0, :cond_b

    const/4 v0, 0x1

    return v0

    :cond_b
    const/4 v0, 0x0

    return v0
.end method
