.class public final Lorg/lsposed/hiddenapibypass/HiddenApiBypass;
.super Ljava/lang/Object;
.source "HiddenApiBypass.java"


# static fields
.field static final synthetic $assertionsDisabled:Z = false

.field private static final TAG:Ljava/lang/String; = "HiddenApiBypass"

.field private static final artFieldBias:J

.field private static final artFieldSize:J

.field private static final artMethodBias:J

.field private static final artMethodSize:J

.field private static final artOffset:J

.field private static final classOffset:J

.field private static final iFieldOffset:J

.field private static final methodOffset:J

.field private static final methodsOffset:J

.field private static final sFieldOffset:J

.field private static final unsafe:Lsun/misc/Unsafe;


# direct methods
.method static constructor <clinit>()V
    .registers 30

    .line 45
    nop

    .line 63
    :try_start_1
    const-class v0, Lsun/misc/Unsafe;

    const-string v1, "getUnsafe"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lsun/misc/Unsafe;

    sput-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    .line 64
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    if-eqz v0, :cond_159

    .line 65
    new-instance v0, Lorg/lsposed/hiddenapibypass/CoreOjClassLoader;

    invoke-direct {v0}, Lorg/lsposed/hiddenapibypass/CoreOjClassLoader;-><init>()V

    move-object v1, v0

    .line 66
    .local v1, "bootClassloader":Ljava/lang/ClassLoader;
    const-class v0, Ljava/lang/reflect/Executable;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    move-object v3, v0

    .line 67
    .local v3, "executableClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-class v0, Ljava/lang/invoke/MethodHandle;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    move-object v4, v0

    .line 68
    .local v4, "methodHandleClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-class v0, Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    move-object v5, v0

    .line 69
    .local v5, "classClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v6, "artMethod"

    invoke-virtual {v3, v6}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    invoke-virtual {v0, v6}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v6

    sput-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodOffset:J

    .line 70
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v6, "declaringClass"

    invoke-virtual {v3, v6}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    invoke-virtual {v0, v6}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v6

    sput-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->classOffset:J

    .line 71
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v6, "artFieldOrMethod"

    invoke-virtual {v4, v6}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    invoke-virtual {v0, v6}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v6

    sput-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J
    :try_end_6c
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_1 .. :try_end_6c} :catch_15f

    .line 75
    :try_start_6c
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v6, "fields"

    invoke-virtual {v5, v6}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    invoke-virtual {v0, v6}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v6
    :try_end_78
    .catch Ljava/lang/NoSuchFieldException; {:try_start_6c .. :try_end_78} :catch_7a
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_6c .. :try_end_78} :catch_15f

    .line 76
    .local v6, "iField":J
    move-wide v8, v6

    .line 80
    .local v8, "sField":J
    goto :goto_93

    .line 77
    .end local v6  # "iField":J
    .end local v8  # "sField":J
    :catch_7a
    move-exception v0

    .line 78
    .local v0, "e":Ljava/lang/NoSuchFieldException;
    :try_start_7b
    sget-object v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v7, "iFields"

    invoke-virtual {v5, v7}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    invoke-virtual {v6, v7}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v6

    .line 79
    .restart local v6  # "iField":J
    sget-object v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v9, "sFields"

    invoke-virtual {v5, v9}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v9

    invoke-virtual {v8, v9}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v8

    .line 81
    .end local v0  # "e":Ljava/lang/NoSuchFieldException;
    .restart local v8  # "sField":J
    :goto_93
    sput-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->iFieldOffset:J

    .line 82
    sput-wide v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->sFieldOffset:J

    .line 83
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    const-string v10, "methods"

    invoke-virtual {v5, v10}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v10

    invoke-virtual {v0, v10}, Lsun/misc/Unsafe;->objectFieldOffset(Ljava/lang/reflect/Field;)J

    move-result-wide v10

    sput-wide v10, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodsOffset:J

    .line 84
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    const-string v10, "a"

    new-array v11, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v10, v11}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 85
    .local v0, "mA":Ljava/lang/reflect/Method;
    const-class v10, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    const-string v11, "b"

    new-array v2, v2, [Ljava/lang/Class;

    invoke-virtual {v10, v11, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 86
    .local v2, "mB":Ljava/lang/reflect/Method;
    const/4 v10, 0x1

    invoke-virtual {v0, v10}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 87
    invoke-virtual {v2, v10}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 88
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflect(Ljava/lang/reflect/Method;)Ljava/lang/invoke/MethodHandle;

    move-result-object v11

    .line 89
    .local v11, "mhA":Ljava/lang/invoke/MethodHandle;
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v12

    invoke-virtual {v12, v2}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflect(Ljava/lang/reflect/Method;)Ljava/lang/invoke/MethodHandle;

    move-result-object v12

    .line 90
    .local v12, "mhB":Ljava/lang/invoke/MethodHandle;
    sget-object v13, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v14, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    invoke-virtual {v13, v11, v14, v15}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v13

    .line 91
    .local v13, "aAddr":J
    sget-object v15, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    move-object/from16 v17, v11

    .end local v11  # "mhA":Ljava/lang/invoke/MethodHandle;
    .local v17, "mhA":Ljava/lang/invoke/MethodHandle;
    sget-wide v10, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    invoke-virtual {v15, v12, v10, v11}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v10

    .line 92
    .local v10, "bAddr":J
    sget-object v15, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    move-object/from16 v18, v0

    .end local v0  # "mA":Ljava/lang/reflect/Method;
    .local v18, "mA":Ljava/lang/reflect/Method;
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    move-object/from16 v19, v1

    move-object/from16 v20, v2

    .end local v1  # "bootClassloader":Ljava/lang/ClassLoader;
    .end local v2  # "mB":Ljava/lang/reflect/Method;
    .local v19, "bootClassloader":Ljava/lang/ClassLoader;
    .local v20, "mB":Ljava/lang/reflect/Method;
    sget-wide v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodsOffset:J

    invoke-virtual {v15, v0, v1, v2}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v0

    .line 93
    .local v0, "aMethods":J
    sub-long v21, v10, v13

    sput-wide v21, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodSize:J

    .line 98
    sub-long v21, v13, v0

    sget-wide v23, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodSize:J

    sub-long v21, v21, v23

    sput-wide v21, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodBias:J

    .line 99
    const-class v2, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    const-string v15, "i"

    invoke-virtual {v2, v15}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 100
    .local v2, "fI":Ljava/lang/reflect/Field;
    const-class v15, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    move-wide/from16 v21, v0

    .end local v0  # "aMethods":J
    .local v21, "aMethods":J
    const-string v0, "j"

    invoke-virtual {v15, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 101
    .local v0, "fJ":Ljava/lang/reflect/Field;
    const/4 v1, 0x1

    invoke-virtual {v2, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 102
    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 103
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflectGetter(Ljava/lang/reflect/Field;)Ljava/lang/invoke/MethodHandle;

    move-result-object v1

    .line 104
    .local v1, "mhI":Ljava/lang/invoke/MethodHandle;
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v15

    invoke-virtual {v15, v0}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflectGetter(Ljava/lang/reflect/Field;)Ljava/lang/invoke/MethodHandle;

    move-result-object v15

    .line 105
    .local v15, "mhJ":Ljava/lang/invoke/MethodHandle;
    move-object/from16 v16, v0

    .end local v0  # "fJ":Ljava/lang/reflect/Field;
    .local v16, "fJ":Ljava/lang/reflect/Field;
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    move-object/from16 v24, v2

    move-object/from16 v23, v3

    .end local v2  # "fI":Ljava/lang/reflect/Field;
    .end local v3  # "executableClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local v23, "executableClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local v24, "fI":Ljava/lang/reflect/Field;
    sget-wide v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    invoke-virtual {v0, v1, v2, v3}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v2

    .line 106
    .local v2, "iAddr":J
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    move-object/from16 v25, v4

    move-object/from16 v26, v5

    .end local v4  # "methodHandleClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v5  # "classClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local v25, "methodHandleClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local v26, "classClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    invoke-virtual {v0, v15, v4, v5}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v4

    .line 107
    .local v4, "jAddr":J
    sget-object v0, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    move-object/from16 v27, v1

    .end local v1  # "mhI":Ljava/lang/invoke/MethodHandle;
    .local v27, "mhI":Ljava/lang/invoke/MethodHandle;
    const-class v1, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    move-wide/from16 v28, v6

    .end local v6  # "iField":J
    .local v28, "iField":J
    sget-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->iFieldOffset:J

    invoke-virtual {v0, v1, v6, v7}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v0

    .line 108
    .local v0, "iFields":J
    sub-long v6, v4, v2

    sput-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artFieldSize:J

    .line 113
    sub-long v6, v2, v0

    sput-wide v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artFieldBias:J

    .line 117
    .end local v0  # "iFields":J
    .end local v2  # "iAddr":J
    .end local v4  # "jAddr":J
    .end local v8  # "sField":J
    .end local v10  # "bAddr":J
    .end local v12  # "mhB":Ljava/lang/invoke/MethodHandle;
    .end local v13  # "aAddr":J
    .end local v15  # "mhJ":Ljava/lang/invoke/MethodHandle;
    .end local v16  # "fJ":Ljava/lang/reflect/Field;
    .end local v17  # "mhA":Ljava/lang/invoke/MethodHandle;
    .end local v18  # "mA":Ljava/lang/reflect/Method;
    .end local v19  # "bootClassloader":Ljava/lang/ClassLoader;
    .end local v20  # "mB":Ljava/lang/reflect/Method;
    .end local v21  # "aMethods":J
    .end local v23  # "executableClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v24  # "fI":Ljava/lang/reflect/Field;
    .end local v25  # "methodHandleClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v26  # "classClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v27  # "mhI":Ljava/lang/invoke/MethodHandle;
    .end local v28  # "iField":J
    nop

    .line 118
    return-void

    .line 64
    :cond_159
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
    :try_end_15f
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_7b .. :try_end_15f} :catch_15f

    .line 114
    :catch_15f
    move-exception v0

    .line 115
    .local v0, "e":Ljava/lang/ReflectiveOperationException;
    const-string v1, "HiddenApiBypass"

    const-string v2, "Initialize error"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 116
    new-instance v1, Ljava/lang/ExceptionInInitializerError;

    invoke-direct {v1, v0}, Ljava/lang/ExceptionInInitializerError;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public constructor <init>()V
    .registers 1

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static varargs addHiddenApiExemptions([Ljava/lang/String;)Z
    .registers 3
    .param p0, "signaturePrefixes"  # [Ljava/lang/String;

    .line 369
    sget-object v0, Lorg/lsposed/hiddenapibypass/Helper;->signaturePrefixes:Ljava/util/Set;

    invoke-static {p0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 370
    sget-object v0, Lorg/lsposed/hiddenapibypass/Helper;->signaturePrefixes:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    .line 371
    .local v0, "strings":[Ljava/lang/String;
    sget-object v1, Lorg/lsposed/hiddenapibypass/Helper;->signaturePrefixes:Ljava/util/Set;

    invoke-interface {v1, v0}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    .line 372
    invoke-static {v0}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->setHiddenApiExemptions([Ljava/lang/String;)Z

    move-result v1

    return v1
.end method

.method public static clearHiddenApiExemptions()Z
    .registers 1

    .line 383
    sget-object v0, Lorg/lsposed/hiddenapibypass/Helper;->signaturePrefixes:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 384
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    invoke-static {v0}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->setHiddenApiExemptions([Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static varargs getDeclaredConstructor(Ljava/lang/Class;[Ljava/lang/Class;)Ljava/lang/reflect/Constructor;
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;[",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/reflect/Constructor<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;
        }
    .end annotation

    .line 258
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local p1, "parameterTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    invoke-static {p0}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->getDeclaredMethods(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    .line 260
    .local v0, "methods":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Executable;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_8
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_34

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/reflect/Executable;

    .line 261
    .local v2, "method":Ljava/lang/reflect/Executable;
    instance-of v3, v2, Ljava/lang/reflect/Constructor;

    if-nez v3, :cond_19

    goto :goto_8

    .line 262
    :cond_19
    invoke-virtual {v2}, Ljava/lang/reflect/Executable;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v3

    .line 263
    .local v3, "expectedTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    array-length v4, v3

    array-length v5, p1

    if-eq v4, v5, :cond_22

    goto :goto_8

    .line 264
    :cond_22
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_23
    array-length v5, p1

    if-ge v4, v5, :cond_30

    .line 265
    aget-object v5, p1, v4

    aget-object v6, v3, v4

    if-eq v5, v6, :cond_2d

    goto :goto_8

    .line 264
    :cond_2d
    add-int/lit8 v4, v4, 0x1

    goto :goto_23

    .line 267
    .end local v4  # "i":I
    :cond_30
    move-object v1, v2

    check-cast v1, Ljava/lang/reflect/Constructor;

    return-object v1

    .line 269
    .end local v2  # "method":Ljava/lang/reflect/Executable;
    .end local v3  # "expectedTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    :cond_34
    new-instance v1, Ljava/lang/NoSuchMethodException;

    const-string v2, "Cannot find matching constructor"

    invoke-direct {v1, v2}, Ljava/lang/NoSuchMethodException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static varargs getDeclaredMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .registers 10
    .param p1, "methodName"  # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/reflect/Method;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;
        }
    .end annotation

    .line 232
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .local p2, "parameterTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    invoke-static {p0}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->getDeclaredMethods(Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    .line 234
    .local v0, "methods":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Executable;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_8
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/reflect/Executable;

    .line 235
    .local v2, "method":Ljava/lang/reflect/Executable;
    invoke-virtual {v2}, Ljava/lang/reflect/Executable;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1f

    goto :goto_8

    .line 236
    :cond_1f
    instance-of v3, v2, Ljava/lang/reflect/Method;

    if-nez v3, :cond_24

    goto :goto_8

    .line 237
    :cond_24
    invoke-virtual {v2}, Ljava/lang/reflect/Executable;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v3

    .line 238
    .local v3, "expectedTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    array-length v4, v3

    array-length v5, p2

    if-eq v4, v5, :cond_2d

    goto :goto_8

    .line 239
    :cond_2d
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_2e
    array-length v5, p2

    if-ge v4, v5, :cond_3b

    .line 240
    aget-object v5, p2, v4

    aget-object v6, v3, v4

    if-eq v5, v6, :cond_38

    goto :goto_8

    .line 239
    :cond_38
    add-int/lit8 v4, v4, 0x1

    goto :goto_2e

    .line 242
    .end local v4  # "i":I
    :cond_3b
    move-object v1, v2

    check-cast v1, Ljava/lang/reflect/Method;

    return-object v1

    .line 244
    .end local v2  # "method":Ljava/lang/reflect/Executable;
    .end local v3  # "expectedTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    :cond_3f
    new-instance v1, Ljava/lang/NoSuchMethodException;

    const-string v2, "Cannot find matching method"

    invoke-direct {v1, v2}, Ljava/lang/NoSuchMethodException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static getDeclaredMethods(Ljava/lang/Class;)Ljava/util/List;
    .registers 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/util/List<",
            "Ljava/lang/reflect/Executable;",
            ">;"
        }
    .end annotation

    .line 194
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {p0}, Ljava/lang/Class;->isPrimitive()Z

    move-result v0

    if-nez v0, :cond_72

    invoke-virtual {p0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_72

    .line 197
    :cond_d
    :try_start_d
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    const-string v1, "a"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 198
    .local v0, "mA":Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 199
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflect(Ljava/lang/reflect/Method;)Ljava/lang/invoke/MethodHandle;

    move-result-object v1
    :try_end_24
    .catch Ljava/lang/NoSuchMethodException; {:try_start_d .. :try_end_24} :catch_6c
    .catch Ljava/lang/IllegalAccessException; {:try_start_d .. :try_end_24} :catch_6a

    move-object v0, v1

    .line 202
    .local v0, "mh":Ljava/lang/invoke/MethodHandle;
    nop

    .line 203
    sget-object v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodsOffset:J

    invoke-virtual {v1, p0, v2, v3}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v8

    .line 204
    .local v8, "methods":J
    const-wide/16 v1, 0x0

    cmp-long v1, v8, v1

    if-nez v1, :cond_39

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 205
    :cond_39
    sget-object v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    invoke-virtual {v1, v8, v9}, Lsun/misc/Unsafe;->getInt(J)I

    move-result v1

    .line 207
    .local v1, "numMethods":I
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v10, v2

    .line 208
    .local v10, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Executable;>;"
    const/4 v2, 0x0

    move v11, v2

    .local v11, "i":I
    :goto_47
    if-ge v11, v1, :cond_69

    .line 209
    int-to-long v2, v11

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodSize:J

    mul-long/2addr v2, v4

    add-long/2addr v2, v8

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodBias:J

    add-long v12, v2, v4

    .line 210
    .local v12, "method":J
    sget-object v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    move-object v3, v0

    move-wide v6, v12

    invoke-virtual/range {v2 .. v7}, Lsun/misc/Unsafe;->putLong(Ljava/lang/Object;JJ)V

    .line 211
    const-class v2, Ljava/lang/reflect/Executable;

    invoke-static {v2, v0}, Ljava/lang/invoke/MethodHandles;->reflectAs(Ljava/lang/Class;Ljava/lang/invoke/MethodHandle;)Ljava/lang/reflect/Member;

    move-result-object v2

    check-cast v2, Ljava/lang/reflect/Executable;

    .line 215
    .local v2, "member":Ljava/lang/reflect/Executable;
    invoke-interface {v10, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 208
    .end local v2  # "member":Ljava/lang/reflect/Executable;
    .end local v12  # "method":J
    add-int/lit8 v11, v11, 0x1

    goto :goto_47

    .line 217
    .end local v11  # "i":I
    :cond_69
    return-object v10

    .line 200
    .end local v0  # "mh":Ljava/lang/invoke/MethodHandle;
    .end local v1  # "numMethods":I
    .end local v8  # "methods":J
    .end local v10  # "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Executable;>;"
    :catch_6a
    move-exception v0

    goto :goto_6d

    :catch_6c
    move-exception v0

    .line 201
    .local v0, "e":Ljava/lang/ReflectiveOperationException;
    :goto_6d
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 194
    .end local v0  # "e":Ljava/lang/ReflectiveOperationException;
    :cond_72
    :goto_72
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static getInstanceFields(Ljava/lang/Class;)Ljava/util/List;
    .registers 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/util/List<",
            "Ljava/lang/reflect/Field;",
            ">;"
        }
    .end annotation

    .line 281
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {p0}, Ljava/lang/Class;->isPrimitive()Z

    move-result v0

    if-nez v0, :cond_7a

    invoke-virtual {p0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-eqz v0, :cond_e

    goto/16 :goto_7a

    .line 284
    :cond_e
    :try_start_e
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    const-string v1, "i"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 285
    .local v0, "fI":Ljava/lang/reflect/Field;
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 286
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflectGetter(Ljava/lang/reflect/Field;)Ljava/lang/invoke/MethodHandle;

    move-result-object v1
    :try_end_22
    .catch Ljava/lang/IllegalAccessException; {:try_start_e .. :try_end_22} :catch_74
    .catch Ljava/lang/NoSuchFieldException; {:try_start_e .. :try_end_22} :catch_72

    move-object v0, v1

    .line 289
    .local v0, "mh":Ljava/lang/invoke/MethodHandle;
    nop

    .line 290
    sget-object v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->iFieldOffset:J

    invoke-virtual {v1, p0, v2, v3}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v8

    .line 291
    .local v8, "fields":J
    const-wide/16 v1, 0x0

    cmp-long v1, v8, v1

    if-nez v1, :cond_37

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 292
    :cond_37
    sget-object v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    invoke-virtual {v1, v8, v9}, Lsun/misc/Unsafe;->getInt(J)I

    move-result v1

    .line 294
    .local v1, "numFields":I
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v10, v2

    .line 295
    .local v10, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Field;>;"
    const/4 v2, 0x0

    move v11, v2

    .local v11, "i":I
    :goto_45
    if-ge v11, v1, :cond_71

    .line 296
    int-to-long v2, v11

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artFieldSize:J

    mul-long/2addr v2, v4

    add-long/2addr v2, v8

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artFieldBias:J

    add-long v12, v2, v4

    .line 297
    .local v12, "field":J
    sget-object v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    move-object v3, v0

    move-wide v6, v12

    invoke-virtual/range {v2 .. v7}, Lsun/misc/Unsafe;->putLong(Ljava/lang/Object;JJ)V

    .line 298
    const-class v2, Ljava/lang/reflect/Field;

    invoke-static {v2, v0}, Ljava/lang/invoke/MethodHandles;->reflectAs(Ljava/lang/Class;Ljava/lang/invoke/MethodHandle;)Ljava/lang/reflect/Member;

    move-result-object v2

    check-cast v2, Ljava/lang/reflect/Field;

    .line 301
    .local v2, "member":Ljava/lang/reflect/Field;
    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v3

    invoke-static {v3}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v3

    if-nez v3, :cond_6e

    .line 302
    invoke-interface {v10, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 295
    .end local v2  # "member":Ljava/lang/reflect/Field;
    .end local v12  # "field":J
    :cond_6e
    add-int/lit8 v11, v11, 0x1

    goto :goto_45

    .line 304
    .end local v11  # "i":I
    :cond_71
    return-object v10

    .line 287
    .end local v0  # "mh":Ljava/lang/invoke/MethodHandle;
    .end local v1  # "numFields":I
    .end local v8  # "fields":J
    .end local v10  # "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Field;>;"
    :catch_72
    move-exception v0

    goto :goto_75

    :catch_74
    move-exception v0

    .line 288
    .local v0, "e":Ljava/lang/ReflectiveOperationException;
    :goto_75
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 281
    .end local v0  # "e":Ljava/lang/ReflectiveOperationException;
    :cond_7a
    :goto_7a
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static getStaticFields(Ljava/lang/Class;)Ljava/util/List;
    .registers 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/util/List<",
            "Ljava/lang/reflect/Field;",
            ">;"
        }
    .end annotation

    .line 315
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {p0}, Ljava/lang/Class;->isPrimitive()Z

    move-result v0

    if-nez v0, :cond_7a

    invoke-virtual {p0}, Ljava/lang/Class;->isArray()Z

    move-result v0

    if-eqz v0, :cond_e

    goto/16 :goto_7a

    .line 318
    :cond_e
    :try_start_e
    const-class v0, Lorg/lsposed/hiddenapibypass/Helper$NeverCall;

    const-string v1, "s"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 319
    .local v0, "fS":Ljava/lang/reflect/Field;
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 320
    invoke-static {}, Ljava/lang/invoke/MethodHandles;->lookup()Ljava/lang/invoke/MethodHandles$Lookup;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/invoke/MethodHandles$Lookup;->unreflectGetter(Ljava/lang/reflect/Field;)Ljava/lang/invoke/MethodHandle;

    move-result-object v1
    :try_end_22
    .catch Ljava/lang/IllegalAccessException; {:try_start_e .. :try_end_22} :catch_74
    .catch Ljava/lang/NoSuchFieldException; {:try_start_e .. :try_end_22} :catch_72

    move-object v0, v1

    .line 323
    .local v0, "mh":Ljava/lang/invoke/MethodHandle;
    nop

    .line 324
    sget-object v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->sFieldOffset:J

    invoke-virtual {v1, p0, v2, v3}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v8

    .line 325
    .local v8, "fields":J
    const-wide/16 v1, 0x0

    cmp-long v1, v8, v1

    if-nez v1, :cond_37

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 326
    :cond_37
    sget-object v1, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    invoke-virtual {v1, v8, v9}, Lsun/misc/Unsafe;->getInt(J)I

    move-result v1

    .line 328
    .local v1, "numFields":I
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v10, v2

    .line 329
    .local v10, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Field;>;"
    const/4 v2, 0x0

    move v11, v2

    .local v11, "i":I
    :goto_45
    if-ge v11, v1, :cond_71

    .line 330
    int-to-long v2, v11

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artFieldSize:J

    mul-long/2addr v2, v4

    add-long/2addr v2, v8

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artFieldBias:J

    add-long v12, v2, v4

    .line 331
    .local v12, "field":J
    sget-object v2, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artOffset:J

    move-object v3, v0

    move-wide v6, v12

    invoke-virtual/range {v2 .. v7}, Lsun/misc/Unsafe;->putLong(Ljava/lang/Object;JJ)V

    .line 332
    const-class v2, Ljava/lang/reflect/Field;

    invoke-static {v2, v0}, Ljava/lang/invoke/MethodHandles;->reflectAs(Ljava/lang/Class;Ljava/lang/invoke/MethodHandle;)Ljava/lang/reflect/Member;

    move-result-object v2

    check-cast v2, Ljava/lang/reflect/Field;

    .line 335
    .local v2, "member":Ljava/lang/reflect/Field;
    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v3

    invoke-static {v3}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v3

    if-eqz v3, :cond_6e

    .line 336
    invoke-interface {v10, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 329
    .end local v2  # "member":Ljava/lang/reflect/Field;
    .end local v12  # "field":J
    :cond_6e
    add-int/lit8 v11, v11, 0x1

    goto :goto_45

    .line 338
    .end local v11  # "i":I
    :cond_71
    return-object v10

    .line 321
    .end local v0  # "mh":Ljava/lang/invoke/MethodHandle;
    .end local v1  # "numFields":I
    .end local v8  # "fields":J
    .end local v10  # "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/reflect/Field;>;"
    :catch_72
    move-exception v0

    goto :goto_75

    :catch_74
    move-exception v0

    .line 322
    .local v0, "e":Ljava/lang/ReflectiveOperationException;
    :goto_75
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 315
    .end local v0  # "e":Ljava/lang/ReflectiveOperationException;
    :cond_7a
    :goto_7a
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static varargs invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;
    .registers 21
    .param p1, "thiz"  # Ljava/lang/Object;
    .param p2, "methodName"  # Ljava/lang/String;
    .param p3, "args"  # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/Object;",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Object;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/reflect/InvocationTargetException;,
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 163
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    move-object/from16 v0, p1

    move-object/from16 v1, p3

    if-eqz v0, :cond_15

    invoke-virtual/range {p0 .. p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_d

    goto :goto_15

    .line 164
    :cond_d
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "this object is not an instance of the given class"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 166
    :cond_15
    :goto_15
    const-class v2, Lorg/lsposed/hiddenapibypass/Helper$InvokeStub;

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, [Ljava/lang/Object;

    aput-object v6, v4, v5

    const-string v5, "invoke"

    invoke-virtual {v2, v5, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 167
    .local v2, "stub":Ljava/lang/reflect/Method;
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 168
    sget-object v3, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v4, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodsOffset:J

    move-object/from16 v12, p0

    invoke-virtual {v3, v12, v4, v5}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v3

    .line 169
    .local v3, "methods":J
    const-wide/16 v5, 0x0

    cmp-long v5, v3, v5

    const-string v13, "Cannot find matching method"

    if-eqz v5, :cond_7c

    .line 170
    sget-object v5, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    invoke-virtual {v5, v3, v4}, Lsun/misc/Unsafe;->getInt(J)I

    move-result v5

    .line 172
    .local v5, "numMethods":I
    const/4 v6, 0x0

    move v14, v6

    .local v14, "i":I
    :goto_42
    if-ge v14, v5, :cond_74

    .line 173
    int-to-long v6, v14

    sget-wide v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodSize:J

    mul-long/2addr v6, v8

    add-long/2addr v6, v3

    sget-wide v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodBias:J

    add-long v15, v6, v8

    .line 174
    .local v15, "method":J
    sget-object v6, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodOffset:J

    move-object v7, v2

    move-wide v10, v15

    invoke-virtual/range {v6 .. v11}, Lsun/misc/Unsafe;->putLong(Ljava/lang/Object;JJ)V

    .line 177
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v6

    move-object/from16 v7, p2

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_71

    .line 178
    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v6

    .line 179
    .local v6, "params":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    invoke-static {v6, v1}, Lorg/lsposed/hiddenapibypass/Helper;->checkArgsForInvokeMethod([Ljava/lang/Class;[Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_71

    .line 180
    invoke-virtual {v2, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    return-object v8

    .line 172
    .end local v6  # "params":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    .end local v15  # "method":J
    :cond_71
    add-int/lit8 v14, v14, 0x1

    goto :goto_42

    :cond_74
    move-object/from16 v7, p2

    .line 183
    .end local v14  # "i":I
    new-instance v6, Ljava/lang/NoSuchMethodException;

    invoke-direct {v6, v13}, Ljava/lang/NoSuchMethodException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 169
    .end local v5  # "numMethods":I
    :cond_7c
    move-object/from16 v7, p2

    new-instance v5, Ljava/lang/NoSuchMethodException;

    invoke-direct {v5, v13}, Ljava/lang/NoSuchMethodException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method public static varargs newInstance(Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    .registers 20
    .param p1, "initargs"  # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;[",
            "Ljava/lang/Object;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/reflect/InvocationTargetException;,
            Ljava/lang/InstantiationException;
        }
    .end annotation

    .line 129
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const-class v2, Lorg/lsposed/hiddenapibypass/Helper$InvokeStub;

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    const-string v5, "invoke"

    invoke-virtual {v2, v5, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 130
    .local v2, "stub":Ljava/lang/reflect/Method;
    const-class v4, Lorg/lsposed/hiddenapibypass/Helper$InvokeStub;

    new-array v5, v3, [Ljava/lang/Class;

    const-class v7, [Ljava/lang/Object;

    aput-object v7, v5, v6

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v4

    .line 131
    .local v4, "ctor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<*>;"
    invoke-virtual {v4, v3}, Ljava/lang/reflect/Constructor;->setAccessible(Z)V

    .line 132
    sget-object v3, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v5, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodsOffset:J

    invoke-virtual {v3, v0, v5, v6}, Lsun/misc/Unsafe;->getLong(Ljava/lang/Object;J)J

    move-result-wide v5

    .line 133
    .local v5, "methods":J
    const-wide/16 v7, 0x0

    cmp-long v3, v5, v7

    const-string v14, "Cannot find matching constructor"

    if-eqz v3, :cond_85

    .line 134
    sget-object v3, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    invoke-virtual {v3, v5, v6}, Lsun/misc/Unsafe;->getInt(J)I

    move-result v3

    .line 136
    .local v3, "numMethods":I
    const/4 v7, 0x0

    move v15, v7

    .local v15, "i":I
    :goto_3b
    if-ge v15, v3, :cond_7f

    .line 137
    int-to-long v7, v15

    sget-wide v9, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodSize:J

    mul-long/2addr v7, v9

    add-long/2addr v7, v5

    sget-wide v9, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->artMethodBias:J

    add-long v16, v7, v9

    .line 138
    .local v16, "method":J
    sget-object v7, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v9, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodOffset:J

    move-object v8, v2

    move-wide/from16 v11, v16

    invoke-virtual/range {v7 .. v12}, Lsun/misc/Unsafe;->putLong(Ljava/lang/Object;JJ)V

    .line 141
    const-string v7, "<init>"

    invoke-virtual {v2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_7c

    .line 142
    sget-object v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v10, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->methodOffset:J

    move-object v9, v4

    move-wide/from16 v12, v16

    invoke-virtual/range {v8 .. v13}, Lsun/misc/Unsafe;->putLong(Ljava/lang/Object;JJ)V

    .line 143
    sget-object v7, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->unsafe:Lsun/misc/Unsafe;

    sget-wide v8, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->classOffset:J

    invoke-virtual {v7, v4, v8, v9, v0}, Lsun/misc/Unsafe;->putObject(Ljava/lang/Object;JLjava/lang/Object;)V

    .line 144
    invoke-virtual {v4}, Ljava/lang/reflect/Constructor;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v7

    .line 145
    .local v7, "params":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    invoke-static {v7, v1}, Lorg/lsposed/hiddenapibypass/Helper;->checkArgsForInvokeMethod([Ljava/lang/Class;[Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_7c

    .line 146
    invoke-virtual {v4, v1}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    return-object v8

    .line 136
    .end local v7  # "params":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    .end local v16  # "method":J
    :cond_7c
    add-int/lit8 v15, v15, 0x1

    goto :goto_3b

    .line 149
    .end local v15  # "i":I
    :cond_7f
    new-instance v7, Ljava/lang/NoSuchMethodException;

    invoke-direct {v7, v14}, Ljava/lang/NoSuchMethodException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 133
    .end local v3  # "numMethods":I
    :cond_85
    new-instance v3, Ljava/lang/NoSuchMethodException;

    invoke-direct {v3, v14}, Ljava/lang/NoSuchMethodException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static varargs setHiddenApiExemptions([Ljava/lang/String;)Z
    .registers 7
    .param p0, "signaturePrefixes"  # [Ljava/lang/String;

    .line 351
    const-string v0, "setHiddenApiExemptions"

    const/4 v1, 0x0

    :try_start_3
    const-class v2, Ldalvik/system/VMRuntime;

    const-string v3, "getRuntime"

    new-array v4, v1, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {v2, v5, v3, v4}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 352
    .local v2, "runtime":Ljava/lang/Object;
    const-class v3, Ldalvik/system/VMRuntime;

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v2, v0, v4}, Lorg/lsposed/hiddenapibypass/HiddenApiBypass;->invoke(Ljava/lang/Class;Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_17
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_3 .. :try_end_17} :catch_19

    .line 353
    const/4 v0, 0x1

    return v0

    .line 354
    .end local v2  # "runtime":Ljava/lang/Object;
    :catch_19
    move-exception v2

    .line 355
    .local v2, "e":Ljava/lang/ReflectiveOperationException;
    const-string v3, "HiddenApiBypass"

    invoke-static {v3, v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 356
    return v1
.end method
