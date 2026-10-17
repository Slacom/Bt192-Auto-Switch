.class public Lorg/lsposed/hiddenapibypass/Helper;
.super Ljava/lang/Object;
.source "Helper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/lsposed/hiddenapibypass/Helper$InvokeStub;,
        Lorg/lsposed/hiddenapibypass/Helper$NeverCall;,
        Lorg/lsposed/hiddenapibypass/Helper$Executable;,
        Lorg/lsposed/hiddenapibypass/Helper$AccessibleObject;,
        Lorg/lsposed/hiddenapibypass/Helper$Class;,
        Lorg/lsposed/hiddenapibypass/Helper$MethodHandle;
    }
.end annotation


# static fields
.field static final signaturePrefixes:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 25
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lorg/lsposed/hiddenapibypass/Helper;->signaturePrefixes:Ljava/util/Set;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static checkArgsForInvokeMethod([Ljava/lang/Class;[Ljava/lang/Object;)Z
    .registers 6
    .param p1, "args"  # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/Class<",
            "*>;[",
            "Ljava/lang/Object;",
            ")Z"
        }
    .end annotation

    .line 28
    .local p0, "params":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    array-length v0, p0

    array-length v1, p1

    const/4 v2, 0x0

    if-eq v0, v1, :cond_6

    return v2

    .line 29
    :cond_6
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_7
    array-length v1, p0

    if-ge v0, v1, :cond_8d

    .line 30
    aget-object v1, p0, v0

    invoke-virtual {v1}, Ljava/lang/Class;->isPrimitive()Z

    move-result v1

    if-eqz v1, :cond_7a

    .line 31
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_1f

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Integer;

    if-nez v1, :cond_1f

    return v2

    .line 32
    :cond_1f
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_2c

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Byte;

    if-nez v1, :cond_2c

    return v2

    .line 33
    :cond_2c
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_39

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Character;

    if-nez v1, :cond_39

    return v2

    .line 34
    :cond_39
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_46

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Boolean;

    if-nez v1, :cond_46

    return v2

    .line 35
    :cond_46
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_53

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Double;

    if-nez v1, :cond_53

    return v2

    .line 36
    :cond_53
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_60

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Float;

    if-nez v1, :cond_60

    return v2

    .line 37
    :cond_60
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_6d

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Long;

    if-nez v1, :cond_6d

    return v2

    .line 38
    :cond_6d
    aget-object v1, p0, v0

    sget-object v3, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    if-ne v1, v3, :cond_89

    aget-object v1, p1, v0

    instance-of v1, v1, Ljava/lang/Short;

    if-nez v1, :cond_89

    return v2

    .line 39
    :cond_7a
    aget-object v1, p1, v0

    if-eqz v1, :cond_89

    aget-object v1, p0, v0

    aget-object v3, p1, v0

    invoke-virtual {v1, v3}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_89

    return v2

    .line 29
    :cond_89
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_7

    .line 41
    .end local v0  # "i":I
    :cond_8d
    const/4 v0, 0x1

    return v0
.end method
