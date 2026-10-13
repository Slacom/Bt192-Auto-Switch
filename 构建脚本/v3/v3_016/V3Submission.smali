.class public final Lbt192/auto/V3Submission;
.super Ljava/lang/Object;

# Process-local submission ledger, NOT a proxy request slot or a durable journal.
# Every field access is under CdmTrigger.class, including all private helpers.
# Never lock V3Submission.class / Worker.class; no throwing <clinit> allocation.
.field private static pending:Ljava/util/Set;
.field private static poisoned:Z

# Caller owns CdmTrigger.class. Exceptions propagate to the poisoning handler.
# Invalid input is not an exception and never changes the ledger.
.method private static normalize(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    if-eqz p0, :invalid
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Landroid/bluetooth/BluetoothAdapter;->checkBluetoothAddress(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :invalid
    return-object v0
    :invalid
    const/4 v0, 0x0
    return-object v0
.end method

# Caller owns CdmTrigger.class and checked poisoned first. Publish only after init.
.method private static ready()V
    .locals 1
    sget-object v0, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;
    if-nez v0, :done
    new-instance v0, Ljava/util/HashSet;
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
    sput-object v0, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;
    :done
    return-void
.end method

# Call immediately after submit's final valid gate, before submitted/setter.
# An ambiguous throwing setter MUST retain this reservation. No timeout/epoch GC:
# the Bluetooth stack cannot retract a submission; expiry is not proof of failure.
.method public static reserve(Ljava/lang/String;)Z
    .locals 4
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    const/4 v2, 0x0
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    if-nez v1, :exit
    invoke-static {p0}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :exit
    invoke-static {}, Lbt192/auto/V3Submission;->ready()V
    sget-object v3, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;
    invoke-interface {v3, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    move-result v2
    :try_end
    :exit
    monitor-exit v0
    return v2
    :caught
    move-exception v3
    # Do not inspect partially initialized/mutated objects or invoke cleanup.
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    const/4 v2, 0x0
    goto :exit
    .catchall {:try_start .. :try_end} :caught
.end method

# Caller owns CdmTrigger.class and checked poison. Remove ONLY this MAC.
.method private static releaseLocked(Ljava/lang/String;)V
    .locals 2
    invoke-static {p0}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :done
    invoke-static {}, Lbt192/auto/V3Submission;->ready()V
    sget-object v1, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;
    invoke-interface {v1, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :done
    return-void
.end method

# Caller must prove NEW current 192 read + valid real connection (same lock).
# Another MAC/global epoch/config change, or a cached UI snapshot, is NOT evidence.
.method public static confirmed(Ljava/lang/String;)V
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    if-nez v1, :exit
    invoke-static {p0}, Lbt192/auto/V3Submission;->releaseLocked(Ljava/lang/String;)V
    :try_end
    :exit
    monitor-exit v0
    return-void
    :caught
    move-exception v2
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    goto :exit
    .catchall {:try_start .. :try_end} :caught
.end method

# Caller must prove real target A2DP disconnect or actual connectedDevices absence.
# A physical profile-proxy no-callback/service-disconnect is NOT this evidence.
# A later real target disconnect may therefore start a new connection episode.
.method public static disconnected(Ljava/lang/String;)V
    .locals 3
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    if-nez v1, :exit
    invoke-static {p0}, Lbt192/auto/V3Submission;->releaseLocked(Ljava/lang/String;)V
    :try_end
    :exit
    monitor-exit v0
    return-void
    :caught
    move-exception v2
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    goto :exit
    .catchall {:try_start .. :try_end} :caught
.end method

# UI state only. Poison displays pending for ANY input so UI never permits resend.
.method public static pending(Ljava/lang/String;)Z
    .locals 4
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    const/4 v2, 0x1
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    if-nez v1, :exit
    const/4 v2, 0x0
    invoke-static {p0}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :exit
    invoke-static {}, Lbt192/auto/V3Submission;->ready()V
    sget-object v3, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;
    invoke-interface {v3, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
    move-result v2
    :try_end
    :exit
    monitor-exit v0
    return v2
    :caught
    move-exception v3
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    const/4 v2, 0x1
    goto :exit
    .catchall {:try_start .. :try_end} :caught
.end method

# ONLY explicit user action: "允许重新检查/重试该耳机（可能重复下发）".
# Eligibility must be revalidated under the coordinator lock. This does not clear
# the original physical proxy slot or other MAC submissions. request is bounded
# by the existing coordinator; true means authorized/requested, NOT confirmed.
# No automatic caller, 8-second expiry, config toggle or epoch-based reset allowed.
.method public static retry(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 4
    const-class v0, Lbt192/auto/CdmTrigger;
    monitor-enter v0
    :try_start
    const/4 v2, 0x0
    sget-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    if-nez v1, :exit
    invoke-static {p1}, Lbt192/auto/V3Submission;->normalize(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :exit
    invoke-static {p0, v1}, Lbt192/auto/V3Targets;->eligible(Landroid/content/Context;Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, :exit
    invoke-static {}, Lbt192/auto/V3Submission;->ready()V
    sget-object v3, Lbt192/auto/V3Submission;->pending:Ljava/util/Set;
    invoke-interface {v3, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    invoke-static {}, Lbt192/auto/CdmTrigger;->invalidate()V
    invoke-static {p0}, Lbt192/auto/CdmTrigger;->request(Landroid/content/Context;)V
    const/4 v2, 0x1
    :try_end
    :exit
    monitor-exit v0
    return v2
    :caught
    move-exception v3
    # Even a failure AFTER removal is ambiguous: poison before releasing the lock.
    const/4 v1, 0x1
    sput-boolean v1, Lbt192/auto/V3Submission;->poisoned:Z
    const/4 v2, 0x0
    goto :exit
    .catchall {:try_start .. :try_end} :caught
.end method
