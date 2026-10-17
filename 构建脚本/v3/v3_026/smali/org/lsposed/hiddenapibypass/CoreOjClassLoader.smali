.class final Lorg/lsposed/hiddenapibypass/CoreOjClassLoader;
.super Ldalvik/system/PathClassLoader;
.source "CoreOjClassLoader.java"


# static fields
.field static final synthetic $assertionsDisabled:Z


# direct methods
.method static constructor <clinit>()V
    .registers 0

    .line 12
    return-void
.end method

.method constructor <init>()V
    .registers 3

    .line 21
    invoke-static {}, Lorg/lsposed/hiddenapibypass/CoreOjClassLoader;->getCoreOjPath()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 22
    return-void
.end method

.method private static getCoreOjPath()Ljava/lang/String;
    .registers 3

    .line 15
    const-string v0, "java.boot.class.path"

    const-string v1, ""

    invoke-static {v0, v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 16
    .local v0, "bootClassPath":Ljava/lang/String;
    if-eqz v0, :cond_15

    .line 17
    const-string v1, ":"

    const/4 v2, 0x2

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    aget-object v1, v1, v2

    return-object v1

    .line 16
    :cond_15
    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1
.end method


# virtual methods
.method public loadClass(Ljava/lang/String;)Ljava/lang/Class;
    .registers 3
    .param p1, "name"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;
        }
    .end annotation

    .line 26
    const-class v0, Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f

    .line 27
    const-class v0, Ljava/lang/Object;

    return-object v0

    .line 30
    :cond_f
    :try_start_f
    invoke-virtual {p0, p1}, Lorg/lsposed/hiddenapibypass/CoreOjClassLoader;->findClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_13
    .catch Ljava/lang/ClassNotFoundException; {:try_start_f .. :try_end_13} :catch_14

    return-object v0

    .line 31
    :catch_14
    move-exception v0

    .line 34
    const-class v0, Ljava/lang/reflect/Executable;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_24

    .line 35
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$Executable;

    return-object v0

    .line 36
    :cond_24
    const-class v0, Ljava/lang/invoke/MethodHandle;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_33

    .line 37
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$MethodHandle;

    return-object v0

    .line 38
    :cond_33
    const-class v0, Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_42

    .line 39
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$Class;

    return-object v0

    .line 41
    :cond_42
    invoke-super {p0, p1}, Ldalvik/system/PathClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    return-object v0
.end method
