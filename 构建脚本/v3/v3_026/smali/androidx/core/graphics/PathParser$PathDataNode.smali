.class public Landroidx/core/graphics/PathParser$PathDataNode;
.super Ljava/lang/Object;
.source "PathParser.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/core/graphics/PathParser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "PathDataNode"
.end annotation


# instance fields
.field private final mParams:[F

.field private mType:C


# direct methods
.method constructor <init>(C[F)V
    .registers 3
    .param p1, "type"  # C
    .param p2, "params"  # [F

    .line 411
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 412
    iput-char p1, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    .line 413
    iput-object p2, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    .line 414
    return-void
.end method

.method constructor <init>(Landroidx/core/graphics/PathParser$PathDataNode;)V
    .registers 5
    .param p1, "n"  # Landroidx/core/graphics/PathParser$PathDataNode;

    .line 416
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 417
    iget-char v0, p1, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    iput-char v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    .line 418
    iget-object v0, p1, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    iget-object v1, p1, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    array-length v1, v1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Landroidx/core/graphics/PathParser;->copyOfRange([FII)[F

    move-result-object v0

    iput-object v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    .line 419
    return-void
.end method

.method static synthetic access$000(Landroidx/core/graphics/PathParser$PathDataNode;)C
    .registers 2
    .param p0, "x0"  # Landroidx/core/graphics/PathParser$PathDataNode;

    .line 393
    iget-char v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    return v0
.end method

.method static synthetic access$002(Landroidx/core/graphics/PathParser$PathDataNode;C)C
    .registers 2
    .param p0, "x0"  # Landroidx/core/graphics/PathParser$PathDataNode;
    .param p1, "x1"  # C

    .line 393
    iput-char p1, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    return p1
.end method

.method static synthetic access$100(Landroidx/core/graphics/PathParser$PathDataNode;)[F
    .registers 2
    .param p0, "x0"  # Landroidx/core/graphics/PathParser$PathDataNode;

    .line 393
    iget-object v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    return-object v0
.end method

.method static synthetic access$200(Landroid/graphics/Path;[FCC[F)V
    .registers 5
    .param p0, "x0"  # Landroid/graphics/Path;
    .param p1, "x1"  # [F
    .param p2, "x2"  # C
    .param p3, "x3"  # C
    .param p4, "x4"  # [F

    .line 393
    invoke-static {p0, p1, p2, p3, p4}, Landroidx/core/graphics/PathParser$PathDataNode;->addCommand(Landroid/graphics/Path;[FCC[F)V

    return-void
.end method

.method private static addCommand(Landroid/graphics/Path;[FCC[F)V
    .registers 30
    .param p0, "path"  # Landroid/graphics/Path;
    .param p1, "current"  # [F
    .param p2, "previousCmd"  # C
    .param p3, "cmd"  # C
    .param p4, "val"  # [F

    .line 459
    move-object/from16 v10, p0

    move-object/from16 v11, p4

    const/4 v0, 0x2

    .line 460
    .local v0, "incr":I
    const/4 v12, 0x0

    aget v1, p1, v12

    .line 461
    .local v1, "currentX":F
    const/4 v13, 0x1

    aget v2, p1, v13

    .line 462
    .local v2, "currentY":F
    const/4 v14, 0x2

    aget v3, p1, v14

    .line 463
    .local v3, "ctrlPointX":F
    const/4 v15, 0x3

    aget v4, p1, v15

    .line 464
    .local v4, "ctrlPointY":F
    const/16 v16, 0x4

    aget v5, p1, v16

    .line 465
    .local v5, "currentSegmentStartX":F
    const/16 v17, 0x5

    aget v6, p1, v17

    .line 469
    .local v6, "currentSegmentStartY":F
    sparse-switch p3, :sswitch_data_3ea

    move/from16 v18, v0

    goto :goto_3f

    .line 472
    :sswitch_1f
    invoke-virtual/range {p0 .. p0}, Landroid/graphics/Path;->close()V

    .line 476
    move v1, v5

    .line 477
    move v2, v6

    .line 478
    move v3, v5

    .line 479
    move v4, v6

    .line 480
    invoke-virtual {v10, v1, v2}, Landroid/graphics/Path;->moveTo(FF)V

    .line 481
    move/from16 v18, v0

    goto :goto_3f

    .line 504
    :sswitch_2c
    const/4 v0, 0x4

    .line 505
    move/from16 v18, v0

    goto :goto_3f

    .line 488
    :sswitch_30
    const/4 v0, 0x2

    .line 489
    move/from16 v18, v0

    goto :goto_3f

    .line 494
    :sswitch_34
    const/4 v0, 0x1

    .line 495
    move/from16 v18, v0

    goto :goto_3f

    .line 498
    :sswitch_38
    const/4 v0, 0x6

    .line 499
    move/from16 v18, v0

    goto :goto_3f

    .line 508
    :sswitch_3c
    const/4 v0, 0x7

    move/from16 v18, v0

    .line 512
    .end local v0  # "incr":I
    .local v18, "incr":I
    :goto_3f
    const/4 v0, 0x0

    move/from16 v9, p2

    move v8, v0

    move v7, v1

    move/from16 v19, v3

    move/from16 v20, v4

    move/from16 v21, v5

    move/from16 v22, v6

    move v6, v2

    .end local v1  # "currentX":F
    .end local v2  # "currentY":F
    .end local v3  # "ctrlPointX":F
    .end local v4  # "ctrlPointY":F
    .end local v5  # "currentSegmentStartX":F
    .end local p2  # "previousCmd":C
    .local v6, "currentY":F
    .local v7, "currentX":F
    .local v8, "k":I
    .local v9, "previousCmd":C
    .local v19, "ctrlPointX":F
    .local v20, "ctrlPointY":F
    .local v21, "currentSegmentStartX":F
    .local v22, "currentSegmentStartY":F
    :goto_4d
    array-length v0, v11

    if-ge v8, v0, :cond_3d6

    .line 513
    const/16 v0, 0x54

    const/16 v1, 0x53

    const/16 v2, 0x51

    const/16 v3, 0x43

    const/16 v4, 0x74

    const/16 v5, 0x73

    const/16 v15, 0x71

    const/16 v14, 0x63

    const/high16 v23, 0x40000000  # 2.0f

    const/4 v13, 0x0

    sparse-switch p3, :sswitch_data_43c

    move v12, v6

    move v14, v7

    move/from16 v24, v8

    move v15, v9

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .end local v9  # "previousCmd":C
    .local v12, "currentY":F
    .local v14, "currentX":F
    .local v15, "previousCmd":C
    .local v24, "k":I
    goto/16 :goto_3cc

    .line 561
    .end local v12  # "currentY":F
    .end local v14  # "currentX":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .restart local v9  # "previousCmd":C
    :sswitch_6d
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    invoke-virtual {v10, v13, v0}, Landroid/graphics/Path;->rLineTo(FF)V

    .line 562
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-float/2addr v6, v0

    .line 563
    move/from16 v24, v8

    move v15, v9

    goto/16 :goto_3cc

    .line 633
    :sswitch_7e
    const/4 v1, 0x0

    .line 634
    .local v1, "reflectiveCtrlPointX":F
    const/4 v3, 0x0

    .line 635
    .local v3, "reflectiveCtrlPointY":F
    if-eq v9, v15, :cond_88

    if-eq v9, v4, :cond_88

    if-eq v9, v2, :cond_88

    if-ne v9, v0, :cond_8c

    .line 637
    :cond_88
    sub-float v1, v7, v19

    .line 638
    sub-float v3, v6, v20

    .line 640
    :cond_8c
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-int/lit8 v2, v8, 0x1

    aget v2, v11, v2

    invoke-virtual {v10, v1, v3, v0, v2}, Landroid/graphics/Path;->rQuadTo(FFFF)V

    .line 642
    add-float v0, v7, v1

    .line 643
    .end local v19  # "ctrlPointX":F
    .local v0, "ctrlPointX":F
    add-float v2, v6, v3

    .line 644
    .end local v20  # "ctrlPointY":F
    .local v2, "ctrlPointY":F
    add-int/lit8 v4, v8, 0x0

    aget v4, v11, v4

    add-float/2addr v7, v4

    .line 645
    add-int/lit8 v4, v8, 0x1

    aget v4, v11, v4

    add-float/2addr v6, v4

    .line 646
    move/from16 v19, v0

    move/from16 v20, v2

    move/from16 v24, v8

    move v15, v9

    goto/16 :goto_3cc

    .line 587
    .end local v0  # "ctrlPointX":F
    .end local v1  # "reflectiveCtrlPointX":F
    .end local v2  # "ctrlPointY":F
    .end local v3  # "reflectiveCtrlPointY":F
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_ae
    const/4 v0, 0x0

    .line 588
    .local v0, "reflectiveCtrlPointX":F
    const/4 v2, 0x0

    .line 589
    .local v2, "reflectiveCtrlPointY":F
    if-eq v9, v14, :cond_bc

    if-eq v9, v5, :cond_bc

    if-eq v9, v3, :cond_bc

    if-ne v9, v1, :cond_b9

    goto :goto_bc

    :cond_b9
    move v13, v0

    move v14, v2

    goto :goto_c2

    .line 591
    :cond_bc
    :goto_bc
    sub-float v0, v7, v19

    .line 592
    sub-float v2, v6, v20

    move v13, v0

    move v14, v2

    .line 594
    .end local v0  # "reflectiveCtrlPointX":F
    .end local v2  # "reflectiveCtrlPointY":F
    .local v13, "reflectiveCtrlPointX":F
    .local v14, "reflectiveCtrlPointY":F
    :goto_c2
    add-int/lit8 v0, v8, 0x0

    aget v3, v11, v0

    add-int/lit8 v0, v8, 0x1

    aget v4, v11, v0

    add-int/lit8 v0, v8, 0x2

    aget v5, v11, v0

    add-int/lit8 v0, v8, 0x3

    aget v15, v11, v0

    move-object/from16 v0, p0

    move v1, v13

    move v2, v14

    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    move v6, v15

    invoke-virtual/range {v0 .. v6}, Landroid/graphics/Path;->rCubicTo(FFFFFF)V

    .line 598
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-float/2addr v0, v7

    .line 599
    .end local v19  # "ctrlPointX":F
    .local v0, "ctrlPointX":F
    add-int/lit8 v1, v8, 0x1

    aget v1, v11, v1

    add-float v6, v12, v1

    .line 600
    .end local v20  # "ctrlPointY":F
    .local v6, "ctrlPointY":F
    add-int/lit8 v1, v8, 0x2

    aget v1, v11, v1

    add-float/2addr v7, v1

    .line 601
    add-int/lit8 v1, v8, 0x3

    aget v1, v11, v1

    add-float/2addr v1, v12

    .line 602
    .end local v12  # "currentY":F
    .local v1, "currentY":F
    move/from16 v19, v0

    move/from16 v20, v6

    move/from16 v24, v8

    move v15, v9

    move v6, v1

    goto/16 :goto_3cc

    .line 619
    .end local v0  # "ctrlPointX":F
    .end local v1  # "currentY":F
    .end local v13  # "reflectiveCtrlPointX":F
    .end local v14  # "reflectiveCtrlPointY":F
    .local v6, "currentY":F
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_fa
    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-int/lit8 v1, v8, 0x1

    aget v1, v11, v1

    add-int/lit8 v2, v8, 0x2

    aget v2, v11, v2

    add-int/lit8 v3, v8, 0x3

    aget v3, v11, v3

    invoke-virtual {v10, v0, v1, v2, v3}, Landroid/graphics/Path;->rQuadTo(FFFF)V

    .line 620
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-float/2addr v0, v7

    .line 621
    .end local v19  # "ctrlPointX":F
    .restart local v0  # "ctrlPointX":F
    add-int/lit8 v1, v8, 0x1

    aget v1, v11, v1

    add-float v6, v12, v1

    .line 622
    .end local v20  # "ctrlPointY":F
    .local v6, "ctrlPointY":F
    add-int/lit8 v1, v8, 0x2

    aget v1, v11, v1

    add-float/2addr v7, v1

    .line 623
    add-int/lit8 v1, v8, 0x3

    aget v1, v11, v1

    add-float/2addr v1, v12

    .line 624
    .end local v12  # "currentY":F
    .restart local v1  # "currentY":F
    move/from16 v19, v0

    move/from16 v20, v6

    move/from16 v24, v8

    move v15, v9

    move v6, v1

    goto/16 :goto_3cc

    .line 515
    .end local v0  # "ctrlPointX":F
    .end local v1  # "currentY":F
    .local v6, "currentY":F
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_12d
    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-float/2addr v7, v0

    .line 516
    add-int/lit8 v0, v8, 0x1

    aget v0, v11, v0

    add-float v6, v12, v0

    .line 517
    .end local v12  # "currentY":F
    .restart local v6  # "currentY":F
    if-lez v8, :cond_14b

    .line 521
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-int/lit8 v1, v8, 0x1

    aget v1, v11, v1

    invoke-virtual {v10, v0, v1}, Landroid/graphics/Path;->rLineTo(FF)V

    move/from16 v24, v8

    move v15, v9

    goto/16 :goto_3cc

    .line 523
    :cond_14b
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-int/lit8 v1, v8, 0x1

    aget v1, v11, v1

    invoke-virtual {v10, v0, v1}, Landroid/graphics/Path;->rMoveTo(FF)V

    .line 524
    move v0, v7

    .line 525
    .end local v21  # "currentSegmentStartX":F
    .local v0, "currentSegmentStartX":F
    move v1, v6

    .line 527
    .end local v22  # "currentSegmentStartY":F
    .local v1, "currentSegmentStartY":F
    move/from16 v21, v0

    move/from16 v22, v1

    move/from16 v24, v8

    move v15, v9

    goto/16 :goto_3cc

    .line 543
    .end local v0  # "currentSegmentStartX":F
    .end local v1  # "currentSegmentStartY":F
    .restart local v21  # "currentSegmentStartX":F
    .restart local v22  # "currentSegmentStartY":F
    :sswitch_161
    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-int/lit8 v1, v8, 0x1

    aget v1, v11, v1

    invoke-virtual {v10, v0, v1}, Landroid/graphics/Path;->rLineTo(FF)V

    .line 544
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-float/2addr v7, v0

    .line 545
    add-int/lit8 v0, v8, 0x1

    aget v0, v11, v0

    add-float v6, v12, v0

    .line 546
    .end local v12  # "currentY":F
    .restart local v6  # "currentY":F
    move/from16 v24, v8

    move v15, v9

    goto/16 :goto_3cc

    .line 553
    :sswitch_17d
    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    invoke-virtual {v10, v0, v13}, Landroid/graphics/Path;->rLineTo(FF)V

    .line 554
    add-int/lit8 v0, v8, 0x0

    aget v0, v11, v0

    add-float/2addr v7, v0

    .line 555
    move/from16 v24, v8

    move v15, v9

    goto/16 :goto_3cc

    .line 569
    .end local v12  # "currentY":F
    .restart local v6  # "currentY":F
    :sswitch_18f
    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    add-int/lit8 v0, v8, 0x0

    aget v1, v11, v0

    add-int/lit8 v0, v8, 0x1

    aget v2, v11, v0

    add-int/lit8 v0, v8, 0x2

    aget v3, v11, v0

    add-int/lit8 v0, v8, 0x3

    aget v4, v11, v0

    add-int/lit8 v0, v8, 0x4

    aget v5, v11, v0

    add-int/lit8 v0, v8, 0x5

    aget v6, v11, v0

    move-object/from16 v0, p0

    invoke-virtual/range {v0 .. v6}, Landroid/graphics/Path;->rCubicTo(FFFFFF)V

    .line 572
    add-int/lit8 v0, v8, 0x2

    aget v0, v11, v0

    add-float/2addr v0, v7

    .line 573
    .end local v19  # "ctrlPointX":F
    .local v0, "ctrlPointX":F
    add-int/lit8 v1, v8, 0x3

    aget v1, v11, v1

    add-float v6, v12, v1

    .line 574
    .end local v20  # "ctrlPointY":F
    .local v6, "ctrlPointY":F
    add-int/lit8 v1, v8, 0x4

    aget v1, v11, v1

    add-float/2addr v7, v1

    .line 575
    add-int/lit8 v1, v8, 0x5

    aget v1, v11, v1

    add-float/2addr v1, v12

    .line 577
    .end local v12  # "currentY":F
    .local v1, "currentY":F
    move/from16 v19, v0

    move/from16 v20, v6

    move/from16 v24, v8

    move v15, v9

    move v6, v1

    goto/16 :goto_3cc

    .line 664
    .end local v0  # "ctrlPointX":F
    .end local v1  # "currentY":F
    .local v6, "currentY":F
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_1cc
    move v12, v6

    .end local v6  # "currentY":F
    .restart local v12  # "currentY":F
    add-int/lit8 v0, v8, 0x5

    aget v0, v11, v0

    add-float v3, v0, v7

    add-int/lit8 v0, v8, 0x6

    aget v0, v11, v0

    add-float v4, v0, v12

    add-int/lit8 v0, v8, 0x0

    aget v5, v11, v0

    add-int/lit8 v0, v8, 0x1

    aget v6, v11, v0

    add-int/lit8 v0, v8, 0x2

    aget v14, v11, v0

    add-int/lit8 v0, v8, 0x3

    aget v0, v11, v0

    cmpl-float v0, v0, v13

    if-eqz v0, :cond_1ef

    const/4 v15, 0x1

    goto :goto_1f0

    :cond_1ef
    const/4 v15, 0x0

    :goto_1f0
    add-int/lit8 v0, v8, 0x4

    aget v0, v11, v0

    cmpl-float v0, v0, v13

    if-eqz v0, :cond_1fa

    const/4 v13, 0x1

    goto :goto_1fb

    :cond_1fa
    const/4 v13, 0x0

    :goto_1fb
    move-object/from16 v0, p0

    move v1, v7

    move v2, v12

    move v10, v7

    .end local v7  # "currentX":F
    .local v10, "currentX":F
    move v7, v14

    move/from16 v24, v8

    .end local v8  # "k":I
    .restart local v24  # "k":I
    move v8, v15

    move v14, v9

    .end local v9  # "previousCmd":C
    .local v14, "previousCmd":C
    move v9, v13

    invoke-static/range {v0 .. v9}, Landroidx/core/graphics/PathParser$PathDataNode;->drawArc(Landroid/graphics/Path;FFFFFFFZZ)V

    .line 674
    add-int/lit8 v8, v24, 0x5

    aget v0, v11, v8

    add-float v7, v10, v0

    .line 675
    .end local v10  # "currentX":F
    .restart local v7  # "currentX":F
    add-int/lit8 v8, v24, 0x6

    aget v0, v11, v8

    add-float v6, v12, v0

    .line 676
    .end local v12  # "currentY":F
    .restart local v6  # "currentY":F
    move v0, v7

    .line 677
    .end local v19  # "ctrlPointX":F
    .restart local v0  # "ctrlPointX":F
    move v1, v6

    .line 678
    .end local v20  # "ctrlPointY":F
    .local v1, "ctrlPointY":F
    move-object/from16 v10, p0

    move/from16 v19, v0

    move/from16 v20, v1

    move v15, v14

    goto/16 :goto_3cc

    .line 565
    .end local v0  # "ctrlPointX":F
    .end local v1  # "ctrlPointY":F
    .end local v14  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v8  # "k":I
    .restart local v9  # "previousCmd":C
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_220
    move v12, v6

    move v10, v7

    move/from16 v24, v8

    move v14, v9

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .end local v9  # "previousCmd":C
    .restart local v10  # "currentX":F
    .restart local v12  # "currentY":F
    .restart local v14  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    move v9, v10

    move-object/from16 v10, p0

    .end local v10  # "currentX":F
    .local v9, "currentX":F
    invoke-virtual {v10, v9, v0}, Landroid/graphics/Path;->lineTo(FF)V

    .line 566
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    .line 567
    .end local v12  # "currentY":F
    .local v0, "currentY":F
    move v6, v0

    move v7, v9

    move v15, v14

    goto/16 :goto_3cc

    .line 648
    .end local v0  # "currentY":F
    .end local v14  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    :sswitch_238
    move v12, v6

    move/from16 v24, v8

    move v14, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v14  # "previousCmd":C
    .restart local v24  # "k":I
    move v1, v9

    .line 649
    .local v1, "reflectiveCtrlPointX":F
    move v3, v12

    .line 650
    .restart local v3  # "reflectiveCtrlPointY":F
    if-eq v14, v15, :cond_247

    if-eq v14, v4, :cond_247

    if-eq v14, v2, :cond_247

    if-ne v14, v0, :cond_24f

    .line 652
    :cond_247
    mul-float v7, v9, v23

    sub-float v1, v7, v19

    .line 653
    mul-float v6, v12, v23

    sub-float v3, v6, v20

    .line 655
    :cond_24f
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v2, v11, v8

    invoke-virtual {v10, v1, v3, v0, v2}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 657
    move v0, v1

    .line 658
    .end local v19  # "ctrlPointX":F
    .local v0, "ctrlPointX":F
    move v2, v3

    .line 659
    .end local v20  # "ctrlPointY":F
    .local v2, "ctrlPointY":F
    add-int/lit8 v8, v24, 0x0

    aget v4, v11, v8

    .line 660
    .end local v9  # "currentX":F
    .local v4, "currentX":F
    add-int/lit8 v8, v24, 0x1

    aget v5, v11, v8

    .line 661
    .end local v12  # "currentY":F
    .local v5, "currentY":F
    move/from16 v19, v0

    move/from16 v20, v2

    move v7, v4

    move v6, v5

    move v15, v14

    goto/16 :goto_3cc

    .line 604
    .end local v0  # "ctrlPointX":F
    .end local v1  # "reflectiveCtrlPointX":F
    .end local v2  # "ctrlPointY":F
    .end local v3  # "reflectiveCtrlPointY":F
    .end local v4  # "currentX":F
    .end local v5  # "currentY":F
    .end local v14  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_26d
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    move v0, v9

    .line 605
    .local v0, "reflectiveCtrlPointX":F
    move v2, v12

    .line 606
    .local v2, "reflectiveCtrlPointY":F
    if-eq v15, v14, :cond_280

    if-eq v15, v5, :cond_280

    if-eq v15, v3, :cond_280

    if-ne v15, v1, :cond_27d

    goto :goto_280

    :cond_27d
    move v7, v0

    move v8, v2

    goto :goto_28a

    .line 608
    :cond_280
    :goto_280
    mul-float v7, v9, v23

    sub-float v0, v7, v19

    .line 609
    mul-float v6, v12, v23

    sub-float v2, v6, v20

    move v7, v0

    move v8, v2

    .line 611
    .end local v0  # "reflectiveCtrlPointX":F
    .end local v2  # "reflectiveCtrlPointY":F
    .local v7, "reflectiveCtrlPointX":F
    .local v8, "reflectiveCtrlPointY":F
    :goto_28a
    add-int/lit8 v0, v24, 0x0

    aget v3, v11, v0

    add-int/lit8 v0, v24, 0x1

    aget v4, v11, v0

    add-int/lit8 v0, v24, 0x2

    aget v5, v11, v0

    add-int/lit8 v0, v24, 0x3

    aget v6, v11, v0

    move-object/from16 v0, p0

    move v1, v7

    move v2, v8

    invoke-virtual/range {v0 .. v6}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 613
    add-int/lit8 v0, v24, 0x0

    aget v0, v11, v0

    .line 614
    .end local v19  # "ctrlPointX":F
    .local v0, "ctrlPointX":F
    add-int/lit8 v1, v24, 0x1

    aget v1, v11, v1

    .line 615
    .end local v20  # "ctrlPointY":F
    .local v1, "ctrlPointY":F
    add-int/lit8 v2, v24, 0x2

    aget v2, v11, v2

    .line 616
    .end local v9  # "currentX":F
    .local v2, "currentX":F
    add-int/lit8 v3, v24, 0x3

    aget v3, v11, v3

    .line 617
    .end local v12  # "currentY":F
    .local v3, "currentY":F
    move/from16 v19, v0

    move/from16 v20, v1

    move v7, v2

    move v6, v3

    goto/16 :goto_3cc

    .line 626
    .end local v0  # "ctrlPointX":F
    .end local v1  # "ctrlPointY":F
    .end local v2  # "currentX":F
    .end local v3  # "currentY":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .local v7, "currentX":F
    .local v8, "k":I
    .local v9, "previousCmd":C
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_2b9
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v1, v11, v8

    add-int/lit8 v8, v24, 0x2

    aget v2, v11, v8

    add-int/lit8 v8, v24, 0x3

    aget v3, v11, v8

    invoke-virtual {v10, v0, v1, v2, v3}, Landroid/graphics/Path;->quadTo(FFFF)V

    .line 627
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    .line 628
    .end local v19  # "ctrlPointX":F
    .restart local v0  # "ctrlPointX":F
    add-int/lit8 v8, v24, 0x1

    aget v1, v11, v8

    .line 629
    .end local v20  # "ctrlPointY":F
    .restart local v1  # "ctrlPointY":F
    add-int/lit8 v8, v24, 0x2

    aget v2, v11, v8

    .line 630
    .end local v9  # "currentX":F
    .restart local v2  # "currentX":F
    add-int/lit8 v8, v24, 0x3

    aget v3, v11, v8

    .line 631
    .end local v12  # "currentY":F
    .restart local v3  # "currentY":F
    move/from16 v19, v0

    move/from16 v20, v1

    move v7, v2

    move v6, v3

    goto/16 :goto_3cc

    .line 529
    .end local v0  # "ctrlPointX":F
    .end local v1  # "ctrlPointY":F
    .end local v2  # "currentX":F
    .end local v3  # "currentY":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_2e9
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    .line 530
    .end local v9  # "currentX":F
    .local v0, "currentX":F
    add-int/lit8 v8, v24, 0x1

    aget v1, v11, v8

    .line 531
    .end local v12  # "currentY":F
    .local v1, "currentY":F
    if-lez v24, :cond_307

    .line 535
    add-int/lit8 v8, v24, 0x0

    aget v2, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v3, v11, v8

    invoke-virtual {v10, v2, v3}, Landroid/graphics/Path;->lineTo(FF)V

    move v7, v0

    move v6, v1

    goto/16 :goto_3cc

    .line 537
    :cond_307
    add-int/lit8 v8, v24, 0x0

    aget v2, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v3, v11, v8

    invoke-virtual {v10, v2, v3}, Landroid/graphics/Path;->moveTo(FF)V

    .line 538
    move v2, v0

    .line 539
    .end local v21  # "currentSegmentStartX":F
    .local v2, "currentSegmentStartX":F
    move v3, v1

    .line 541
    .end local v22  # "currentSegmentStartY":F
    .local v3, "currentSegmentStartY":F
    move v7, v0

    move v6, v1

    move/from16 v21, v2

    move/from16 v22, v3

    goto/16 :goto_3cc

    .line 548
    .end local v0  # "currentX":F
    .end local v1  # "currentY":F
    .end local v2  # "currentSegmentStartX":F
    .end local v3  # "currentSegmentStartY":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    .restart local v21  # "currentSegmentStartX":F
    .restart local v22  # "currentSegmentStartY":F
    :sswitch_31c
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v1, v11, v8

    invoke-virtual {v10, v0, v1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 549
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    .line 550
    .end local v9  # "currentX":F
    .restart local v0  # "currentX":F
    add-int/lit8 v8, v24, 0x1

    aget v1, v11, v8

    .line 551
    .end local v12  # "currentY":F
    .restart local v1  # "currentY":F
    move v7, v0

    move v6, v1

    goto/16 :goto_3cc

    .line 557
    .end local v0  # "currentX":F
    .end local v1  # "currentY":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    :sswitch_338
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    invoke-virtual {v10, v0, v12}, Landroid/graphics/Path;->lineTo(FF)V

    .line 558
    add-int/lit8 v8, v24, 0x0

    aget v0, v11, v8

    .line 559
    .end local v9  # "currentX":F
    .restart local v0  # "currentX":F
    move v7, v0

    goto/16 :goto_3cc

    .line 579
    .end local v0  # "currentX":F
    .end local v12  # "currentY":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    :sswitch_34b
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x0

    aget v1, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v2, v11, v8

    add-int/lit8 v8, v24, 0x2

    aget v3, v11, v8

    add-int/lit8 v8, v24, 0x3

    aget v4, v11, v8

    add-int/lit8 v8, v24, 0x4

    aget v5, v11, v8

    add-int/lit8 v8, v24, 0x5

    aget v6, v11, v8

    move-object/from16 v0, p0

    invoke-virtual/range {v0 .. v6}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 581
    add-int/lit8 v8, v24, 0x4

    aget v0, v11, v8

    .line 582
    .end local v9  # "currentX":F
    .restart local v0  # "currentX":F
    add-int/lit8 v8, v24, 0x5

    aget v1, v11, v8

    .line 583
    .end local v12  # "currentY":F
    .restart local v1  # "currentY":F
    add-int/lit8 v8, v24, 0x2

    aget v2, v11, v8

    .line 584
    .end local v19  # "ctrlPointX":F
    .local v2, "ctrlPointX":F
    add-int/lit8 v8, v24, 0x3

    aget v3, v11, v8

    .line 585
    .end local v20  # "ctrlPointY":F
    .local v3, "ctrlPointY":F
    move v7, v0

    move v6, v1

    move/from16 v19, v2

    move/from16 v20, v3

    goto :goto_3cc

    .line 680
    .end local v0  # "currentX":F
    .end local v1  # "currentY":F
    .end local v2  # "ctrlPointX":F
    .end local v3  # "ctrlPointY":F
    .end local v15  # "previousCmd":C
    .end local v24  # "k":I
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v8  # "k":I
    .local v9, "previousCmd":C
    .restart local v19  # "ctrlPointX":F
    .restart local v20  # "ctrlPointY":F
    :sswitch_384
    move v12, v6

    move/from16 v24, v8

    move v15, v9

    move v9, v7

    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .local v9, "currentX":F
    .restart local v12  # "currentY":F
    .restart local v15  # "previousCmd":C
    .restart local v24  # "k":I
    add-int/lit8 v8, v24, 0x5

    aget v3, v11, v8

    add-int/lit8 v8, v24, 0x6

    aget v4, v11, v8

    add-int/lit8 v8, v24, 0x0

    aget v5, v11, v8

    add-int/lit8 v8, v24, 0x1

    aget v6, v11, v8

    add-int/lit8 v8, v24, 0x2

    aget v7, v11, v8

    add-int/lit8 v8, v24, 0x3

    aget v0, v11, v8

    cmpl-float v0, v0, v13

    if-eqz v0, :cond_3a7

    const/4 v8, 0x1

    goto :goto_3a8

    :cond_3a7
    const/4 v8, 0x0

    :goto_3a8
    add-int/lit8 v0, v24, 0x4

    aget v0, v11, v0

    cmpl-float v0, v0, v13

    if-eqz v0, :cond_3b2

    const/4 v13, 0x1

    goto :goto_3b3

    :cond_3b2
    const/4 v13, 0x0

    :goto_3b3
    move-object/from16 v0, p0

    move v1, v9

    move v2, v12

    move v14, v9

    .end local v9  # "currentX":F
    .local v14, "currentX":F
    move v9, v13

    invoke-static/range {v0 .. v9}, Landroidx/core/graphics/PathParser$PathDataNode;->drawArc(Landroid/graphics/Path;FFFFFFFZZ)V

    .line 690
    add-int/lit8 v8, v24, 0x5

    aget v0, v11, v8

    .line 691
    .end local v14  # "currentX":F
    .restart local v0  # "currentX":F
    add-int/lit8 v8, v24, 0x6

    aget v1, v11, v8

    .line 692
    .end local v12  # "currentY":F
    .restart local v1  # "currentY":F
    move v2, v0

    .line 693
    .end local v19  # "ctrlPointX":F
    .restart local v2  # "ctrlPointX":F
    move v3, v1

    move v7, v0

    move v6, v1

    move/from16 v19, v2

    move/from16 v20, v3

    .line 696
    .end local v0  # "currentX":F
    .end local v1  # "currentY":F
    .end local v2  # "ctrlPointX":F
    .restart local v6  # "currentY":F
    .restart local v7  # "currentX":F
    .restart local v19  # "ctrlPointX":F
    :goto_3cc
    move/from16 v9, p3

    .line 512
    .end local v15  # "previousCmd":C
    .local v9, "previousCmd":C
    add-int v8, v24, v18

    const/4 v12, 0x0

    const/4 v13, 0x1

    const/4 v14, 0x2

    const/4 v15, 0x3

    .end local v24  # "k":I
    .restart local v8  # "k":I
    goto/16 :goto_4d

    :cond_3d6
    move v12, v6

    move v14, v7

    .line 698
    .end local v6  # "currentY":F
    .end local v7  # "currentX":F
    .end local v8  # "k":I
    .restart local v12  # "currentY":F
    .restart local v14  # "currentX":F
    const/4 v0, 0x0

    aput v14, p1, v0

    .line 699
    const/4 v0, 0x1

    aput v12, p1, v0

    .line 700
    const/4 v0, 0x2

    aput v19, p1, v0

    .line 701
    const/4 v0, 0x3

    aput v20, p1, v0

    .line 702
    aput v21, p1, v16

    .line 703
    aput v22, p1, v17

    .line 704
    return-void

    nop

    :sswitch_data_3ea
    .sparse-switch
        0x41 -> :sswitch_3c
        0x43 -> :sswitch_38
        0x48 -> :sswitch_34
        0x4c -> :sswitch_30
        0x4d -> :sswitch_30
        0x51 -> :sswitch_2c
        0x53 -> :sswitch_2c
        0x54 -> :sswitch_30
        0x56 -> :sswitch_34
        0x5a -> :sswitch_1f
        0x61 -> :sswitch_3c
        0x63 -> :sswitch_38
        0x68 -> :sswitch_34
        0x6c -> :sswitch_30
        0x6d -> :sswitch_30
        0x71 -> :sswitch_2c
        0x73 -> :sswitch_2c
        0x74 -> :sswitch_30
        0x76 -> :sswitch_34
        0x7a -> :sswitch_1f
    .end sparse-switch

    :sswitch_data_43c
    .sparse-switch
        0x41 -> :sswitch_384
        0x43 -> :sswitch_34b
        0x48 -> :sswitch_338
        0x4c -> :sswitch_31c
        0x4d -> :sswitch_2e9
        0x51 -> :sswitch_2b9
        0x53 -> :sswitch_26d
        0x54 -> :sswitch_238
        0x56 -> :sswitch_220
        0x61 -> :sswitch_1cc
        0x63 -> :sswitch_18f
        0x68 -> :sswitch_17d
        0x6c -> :sswitch_161
        0x6d -> :sswitch_12d
        0x71 -> :sswitch_fa
        0x73 -> :sswitch_ae
        0x74 -> :sswitch_7e
        0x76 -> :sswitch_6d
    .end sparse-switch
.end method

.method private static arcToBezier(Landroid/graphics/Path;DDDDDDDDD)V
    .registers 81
    .param p0, "p"  # Landroid/graphics/Path;
    .param p1, "cx"  # D
    .param p3, "cy"  # D
    .param p5, "a"  # D
    .param p7, "b"  # D
    .param p9, "e1x"  # D
    .param p11, "e1y"  # D
    .param p13, "theta"  # D
    .param p15, "start"  # D
    .param p17, "sweep"  # D

    .line 811
    move-wide/from16 v0, p5

    const-wide/high16 v2, 0x4010000000000000L  # 4.0

    mul-double v4, p17, v2

    const-wide v6, 0x400921fb54442d18L  # Math.PI

    div-double/2addr v4, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->abs(D)D

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v4

    double-to-int v4, v4

    .line 813
    .local v4, "numSegments":I
    move-wide/from16 v5, p15

    .line 814
    .local v5, "eta1":D
    invoke-static/range {p13 .. p14}, Ljava/lang/Math;->cos(D)D

    move-result-wide v7

    .line 815
    .local v7, "cosTheta":D
    invoke-static/range {p13 .. p14}, Ljava/lang/Math;->sin(D)D

    move-result-wide v9

    .line 816
    .local v9, "sinTheta":D
    invoke-static {v5, v6}, Ljava/lang/Math;->cos(D)D

    move-result-wide v11

    .line 817
    .local v11, "cosEta1":D
    invoke-static {v5, v6}, Ljava/lang/Math;->sin(D)D

    move-result-wide v13

    .line 818
    .local v13, "sinEta1":D
    neg-double v2, v0

    mul-double/2addr v2, v7

    mul-double/2addr v2, v13

    mul-double v17, p7, v9

    mul-double v17, v17, v11

    sub-double v2, v2, v17

    .line 819
    .local v2, "ep1x":D
    move-wide/from16 v17, v2

    .end local v2  # "ep1x":D
    .local v17, "ep1x":D
    neg-double v2, v0

    mul-double/2addr v2, v9

    mul-double/2addr v2, v13

    mul-double v19, p7, v7

    mul-double v19, v19, v11

    add-double v2, v2, v19

    .line 821
    .local v2, "ep1y":D
    move-wide/from16 v19, v2

    .end local v2  # "ep1y":D
    .local v19, "ep1y":D
    int-to-double v2, v4

    div-double v2, p17, v2

    .line 822
    .local v2, "anglePerSegment":D
    const/16 v21, 0x0

    move-wide/from16 v23, v5

    move/from16 v15, v21

    move-wide/from16 v5, p9

    move-wide/from16 v21, v17

    move-wide/from16 v17, p11

    .end local p9  # "e1x":D
    .end local p11  # "e1y":D
    .local v5, "e1x":D
    .local v15, "i":I
    .local v17, "e1y":D
    .local v21, "ep1x":D
    .local v23, "eta1":D
    :goto_4c
    if-ge v15, v4, :cond_10f

    .line 823
    add-double v27, v23, v2

    .line 824
    .local v27, "eta2":D
    invoke-static/range {v27 .. v28}, Ljava/lang/Math;->sin(D)D

    move-result-wide v29

    .line 825
    .local v29, "sinEta2":D
    invoke-static/range {v27 .. v28}, Ljava/lang/Math;->cos(D)D

    move-result-wide v31

    .line 826
    .local v31, "cosEta2":D
    mul-double v33, v0, v7

    mul-double v33, v33, v31

    add-double v33, p1, v33

    mul-double v35, p7, v9

    mul-double v35, v35, v29

    move-wide/from16 v37, v2

    .end local v2  # "anglePerSegment":D
    .local v37, "anglePerSegment":D
    sub-double v2, v33, v35

    .line 827
    .local v2, "e2x":D
    mul-double v33, v0, v9

    mul-double v33, v33, v31

    add-double v33, p3, v33

    mul-double v35, p7, v7

    mul-double v35, v35, v29

    move-wide/from16 v39, v11

    .end local v11  # "cosEta1":D
    .local v39, "cosEta1":D
    add-double v11, v33, v35

    .line 828
    .local v11, "e2y":D
    move-wide/from16 v33, v13

    .end local v13  # "sinEta1":D
    .local v33, "sinEta1":D
    neg-double v13, v0

    mul-double/2addr v13, v7

    mul-double v13, v13, v29

    mul-double v35, p7, v9

    mul-double v35, v35, v31

    sub-double v13, v13, v35

    .line 829
    .local v13, "ep2x":D
    move-wide/from16 p9, v11

    .end local v11  # "e2y":D
    .local p9, "e2y":D
    neg-double v11, v0

    mul-double/2addr v11, v9

    mul-double v11, v11, v29

    mul-double v35, p7, v7

    mul-double v35, v35, v31

    add-double v11, v11, v35

    .line 830
    .local v11, "ep2y":D
    sub-double v35, v27, v23

    const-wide/high16 v41, 0x4000000000000000L  # 2.0

    div-double v35, v35, v41

    invoke-static/range {v35 .. v36}, Ljava/lang/Math;->tan(D)D

    move-result-wide v35

    .line 831
    .local v35, "tanDiff2":D
    sub-double v41, v27, v23

    .line 832
    invoke-static/range {v41 .. v42}, Ljava/lang/Math;->sin(D)D

    move-result-wide v41

    const-wide/high16 v43, 0x4008000000000000L  # 3.0

    mul-double v45, v35, v43

    mul-double v45, v45, v35

    const-wide/high16 v25, 0x4010000000000000L  # 4.0

    add-double v45, v45, v25

    invoke-static/range {v45 .. v46}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v45

    const-wide/high16 v47, 0x3ff0000000000000L  # 1.0

    sub-double v45, v45, v47

    mul-double v41, v41, v45

    div-double v41, v41, v43

    .line 833
    .local v41, "alpha":D
    mul-double v43, v41, v21

    add-double v0, v5, v43

    .line 834
    .local v0, "q1x":D
    mul-double v43, v41, v19

    move/from16 v16, v4

    move-wide/from16 p11, v5

    .end local v4  # "numSegments":I
    .end local v5  # "e1x":D
    .local v16, "numSegments":I
    .local p11, "e1x":D
    add-double v4, v17, v43

    .line 835
    .local v4, "q1y":D
    mul-double v43, v41, v13

    move-wide/from16 v45, v7

    .end local v7  # "cosTheta":D
    .local v45, "cosTheta":D
    sub-double v6, v2, v43

    .line 836
    .local v6, "q2x":D
    mul-double v43, v41, v11

    move-wide/from16 v47, v9

    move-wide/from16 v8, p9

    move-wide/from16 p9, v11

    .end local v9  # "sinTheta":D
    .end local v11  # "ep2y":D
    .local v8, "e2y":D
    .local v47, "sinTheta":D
    .local p9, "ep2y":D
    sub-double v10, v8, v43

    .line 839
    .local v10, "q2y":D
    const/4 v12, 0x0

    move/from16 v43, v15

    move-object/from16 v15, p0

    .end local v15  # "i":I
    .local v43, "i":I
    invoke-virtual {v15, v12, v12}, Landroid/graphics/Path;->rLineTo(FF)V

    .line 841
    double-to-float v12, v0

    move-wide/from16 v56, v0

    .end local v0  # "q1x":D
    .local v56, "q1x":D
    double-to-float v0, v4

    double-to-float v1, v6

    move-wide/from16 v58, v4

    .end local v4  # "q1y":D
    .local v58, "q1y":D
    double-to-float v4, v10

    double-to-float v5, v2

    move-wide/from16 v60, v6

    .end local v6  # "q2x":D
    .local v60, "q2x":D
    double-to-float v6, v8

    move-object/from16 v49, p0

    move/from16 v50, v12

    move/from16 v51, v0

    move/from16 v52, v1

    move/from16 v53, v4

    move/from16 v54, v5

    move/from16 v55, v6

    invoke-virtual/range {v49 .. v55}, Landroid/graphics/Path;->cubicTo(FFFFFF)V

    .line 847
    move-wide/from16 v23, v27

    .line 848
    move-wide v5, v2

    .line 849
    .end local p11  # "e1x":D
    .restart local v5  # "e1x":D
    move-wide/from16 v17, v8

    .line 850
    move-wide/from16 v21, v13

    .line 851
    move-wide/from16 v19, p9

    .line 822
    .end local v2  # "e2x":D
    .end local v8  # "e2y":D
    .end local v10  # "q2y":D
    .end local v13  # "ep2x":D
    .end local v27  # "eta2":D
    .end local v29  # "sinEta2":D
    .end local v31  # "cosEta2":D
    .end local v35  # "tanDiff2":D
    .end local v41  # "alpha":D
    .end local v56  # "q1x":D
    .end local v58  # "q1y":D
    .end local v60  # "q2x":D
    .end local p9  # "ep2y":D
    add-int/lit8 v0, v43, 0x1

    move v15, v0

    move/from16 v4, v16

    move-wide/from16 v13, v33

    move-wide/from16 v2, v37

    move-wide/from16 v11, v39

    move-wide/from16 v7, v45

    move-wide/from16 v9, v47

    move-wide/from16 v0, p5

    .end local v43  # "i":I
    .local v0, "i":I
    goto/16 :goto_4c

    .line 853
    .end local v0  # "i":I
    .end local v16  # "numSegments":I
    .end local v33  # "sinEta1":D
    .end local v37  # "anglePerSegment":D
    .end local v39  # "cosEta1":D
    .end local v45  # "cosTheta":D
    .end local v47  # "sinTheta":D
    .local v2, "anglePerSegment":D
    .local v4, "numSegments":I
    .restart local v7  # "cosTheta":D
    .restart local v9  # "sinTheta":D
    .local v11, "cosEta1":D
    .local v13, "sinEta1":D
    :cond_10f
    return-void
.end method

.method private static drawArc(Landroid/graphics/Path;FFFFFFFZZ)V
    .registers 83
    .param p0, "p"  # Landroid/graphics/Path;
    .param p1, "x0"  # F
    .param p2, "y0"  # F
    .param p3, "x1"  # F
    .param p4, "y1"  # F
    .param p5, "a"  # F
    .param p6, "b"  # F
    .param p7, "theta"  # F
    .param p8, "isMoreThanHalf"  # Z
    .param p9, "isPositiveArc"  # Z

    .line 718
    move/from16 v10, p1

    move/from16 v11, p2

    move/from16 v12, p3

    move/from16 v13, p4

    move/from16 v14, p5

    move/from16 v15, p6

    move/from16 v9, p9

    move/from16 v8, p7

    float-to-double v0, v8

    invoke-static {v0, v1}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v35

    .line 720
    .local v35, "thetaD":D
    invoke-static/range {v35 .. v36}, Ljava/lang/Math;->cos(D)D

    move-result-wide v37

    .line 721
    .local v37, "cosTheta":D
    invoke-static/range {v35 .. v36}, Ljava/lang/Math;->sin(D)D

    move-result-wide v39

    .line 724
    .local v39, "sinTheta":D
    float-to-double v0, v10

    mul-double v0, v0, v37

    float-to-double v2, v11

    mul-double v2, v2, v39

    add-double/2addr v0, v2

    float-to-double v2, v14

    div-double v41, v0, v2

    .line 725
    .local v41, "x0p":D
    neg-float v0, v10

    float-to-double v0, v0

    mul-double v0, v0, v39

    float-to-double v2, v11

    mul-double v2, v2, v37

    add-double/2addr v0, v2

    float-to-double v2, v15

    div-double v43, v0, v2

    .line 726
    .local v43, "y0p":D
    float-to-double v0, v12

    mul-double v0, v0, v37

    float-to-double v2, v13

    mul-double v2, v2, v39

    add-double/2addr v0, v2

    float-to-double v2, v14

    div-double v45, v0, v2

    .line 727
    .local v45, "x1p":D
    neg-float v0, v12

    float-to-double v0, v0

    mul-double v0, v0, v39

    float-to-double v2, v13

    mul-double v2, v2, v37

    add-double/2addr v0, v2

    float-to-double v2, v15

    div-double v47, v0, v2

    .line 730
    .local v47, "y1p":D
    sub-double v49, v41, v45

    .line 731
    .local v49, "dx":D
    sub-double v51, v43, v47

    .line 732
    .local v51, "dy":D
    add-double v0, v41, v45

    const-wide/high16 v2, 0x4000000000000000L  # 2.0

    div-double v53, v0, v2

    .line 733
    .local v53, "xm":D
    add-double v0, v43, v47

    div-double v55, v0, v2

    .line 735
    .local v55, "ym":D
    mul-double v0, v49, v49

    mul-double v2, v51, v51

    add-double v6, v0, v2

    .line 736
    .local v6, "dsq":D
    const-wide/16 v0, 0x0

    cmpl-double v2, v6, v0

    const-string v3, "PathParser"

    if-nez v2, :cond_69

    .line 737
    const-string v0, " Points are coincident"

    invoke-static {v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 738
    return-void

    .line 740
    :cond_69
    const-wide/high16 v4, 0x3ff0000000000000L  # 1.0

    div-double/2addr v4, v6

    const-wide/high16 v16, 0x3fd0000000000000L  # 0.25

    sub-double v57, v4, v16

    .line 741
    .local v57, "disc":D
    cmpg-double v2, v57, v0

    if-gez v2, :cond_b6

    .line 742
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Points are too far apart "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6, v7}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 743
    invoke-static {v6, v7}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    const-wide v2, 0x3ffffff583a53b8eL  # 1.99999

    div-double/2addr v0, v2

    double-to-float v5, v0

    .line 744
    .local v5, "adjust":F
    mul-float v16, v14, v5

    mul-float v17, v15, v5

    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v18, v5

    .end local v5  # "adjust":F
    .local v18, "adjust":F
    move/from16 v5, v16

    move-wide/from16 v59, v6

    .end local v6  # "dsq":D
    .local v59, "dsq":D
    move/from16 v6, v17

    move/from16 v7, p7

    move/from16 v8, p8

    move v12, v9

    move/from16 v9, p9

    invoke-static/range {v0 .. v9}, Landroidx/core/graphics/PathParser$PathDataNode;->drawArc(Landroid/graphics/Path;FFFFFFFZZ)V

    .line 746
    return-void

    .line 748
    .end local v18  # "adjust":F
    .end local v59  # "dsq":D
    .restart local v6  # "dsq":D
    :cond_b6
    move-wide/from16 v59, v6

    move v12, v9

    .end local v6  # "dsq":D
    .restart local v59  # "dsq":D
    invoke-static/range {v57 .. v58}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    .line 749
    .local v2, "s":D
    mul-double v4, v2, v49

    .line 750
    .local v4, "sdx":D
    mul-double v6, v2, v51

    .line 753
    .local v6, "sdy":D
    move/from16 v8, p8

    if-ne v8, v12, :cond_ca

    .line 754
    sub-double v16, v53, v6

    .line 755
    .local v16, "cx":D
    add-double v18, v55, v4

    .local v18, "cy":D
    goto :goto_ce

    .line 757
    .end local v16  # "cx":D
    .end local v18  # "cy":D
    :cond_ca
    add-double v16, v53, v6

    .line 758
    .restart local v16  # "cx":D
    sub-double v18, v55, v4

    .line 761
    .restart local v18  # "cy":D
    :goto_ce
    sub-double v0, v43, v18

    move-wide/from16 v61, v2

    .end local v2  # "s":D
    .local v61, "s":D
    sub-double v2, v41, v16

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v0

    .line 763
    .local v0, "eta0":D
    sub-double v2, v47, v18

    move-wide/from16 v63, v4

    .end local v4  # "sdx":D
    .local v63, "sdx":D
    sub-double v4, v45, v16

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v2

    .line 765
    .local v2, "eta1":D
    sub-double v4, v2, v0

    .line 766
    .local v4, "sweep":D
    const-wide/16 v20, 0x0

    cmpl-double v9, v4, v20

    if-ltz v9, :cond_ec

    const/4 v9, 0x1

    goto :goto_ed

    :cond_ec
    const/4 v9, 0x0

    :goto_ed
    if-eq v12, v9, :cond_fd

    .line 767
    cmpl-double v9, v4, v20

    const-wide v20, 0x401921fb54442d18L  # 6.283185307179586

    if-lez v9, :cond_fb

    .line 768
    sub-double v4, v4, v20

    goto :goto_fd

    .line 770
    :cond_fb
    add-double v4, v4, v20

    .line 774
    :cond_fd
    :goto_fd
    move-wide/from16 v65, v2

    .end local v2  # "eta1":D
    .local v65, "eta1":D
    float-to-double v2, v14

    mul-double v16, v16, v2

    .line 775
    float-to-double v2, v15

    mul-double v2, v2, v18

    .line 776
    .end local v18  # "cy":D
    .local v2, "cy":D
    move-wide/from16 v67, v16

    .line 777
    .local v67, "tcx":D
    mul-double v18, v16, v37

    mul-double v20, v2, v39

    sub-double v69, v18, v20

    .end local v16  # "cx":D
    .local v69, "cx":D
    move-wide/from16 v17, v69

    .line 778
    mul-double v19, v67, v39

    mul-double v21, v2, v37

    add-double v2, v19, v21

    move-wide/from16 v19, v2

    .line 780
    move-wide/from16 v71, v2

    .end local v2  # "cy":D
    .local v71, "cy":D
    float-to-double v2, v14

    move-wide/from16 v21, v2

    float-to-double v2, v15

    move-wide/from16 v23, v2

    float-to-double v2, v10

    move-wide/from16 v25, v2

    float-to-double v2, v11

    move-wide/from16 v27, v2

    move-object/from16 v16, p0

    move-wide/from16 v29, v35

    move-wide/from16 v31, v0

    move-wide/from16 v33, v4

    invoke-static/range {v16 .. v34}, Landroidx/core/graphics/PathParser$PathDataNode;->arcToBezier(Landroid/graphics/Path;DDDDDDDDD)V

    .line 781
    return-void
.end method

.method public static nodesToPath([Landroidx/core/graphics/PathParser$PathDataNode;Landroid/graphics/Path;)V
    .registers 2
    .param p0, "node"  # [Landroidx/core/graphics/PathParser$PathDataNode;
    .param p1, "path"  # Landroid/graphics/Path;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 435
    invoke-static {p0, p1}, Landroidx/core/graphics/PathParser;->nodesToPath([Landroidx/core/graphics/PathParser$PathDataNode;Landroid/graphics/Path;)V

    .line 436
    return-void
.end method


# virtual methods
.method public getParams()[F
    .registers 2

    .line 408
    iget-object v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    return-object v0
.end method

.method public getType()C
    .registers 2

    .line 404
    iget-char v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    return v0
.end method

.method public interpolatePathDataNode(Landroidx/core/graphics/PathParser$PathDataNode;Landroidx/core/graphics/PathParser$PathDataNode;F)V
    .registers 8
    .param p1, "nodeFrom"  # Landroidx/core/graphics/PathParser$PathDataNode;
    .param p2, "nodeTo"  # Landroidx/core/graphics/PathParser$PathDataNode;
    .param p3, "fraction"  # F

    .line 449
    iget-char v0, p1, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    iput-char v0, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mType:C

    .line 450
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_5
    iget-object v1, p1, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    array-length v1, v1

    if-ge v0, v1, :cond_1f

    .line 451
    iget-object v1, p0, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    iget-object v2, p1, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    aget v2, v2, v0

    const/high16 v3, 0x3f800000  # 1.0f

    sub-float/2addr v3, p3

    mul-float/2addr v2, v3

    iget-object v3, p2, Landroidx/core/graphics/PathParser$PathDataNode;->mParams:[F

    aget v3, v3, v0

    mul-float/2addr v3, p3

    add-float/2addr v2, v3

    aput v2, v1, v0

    .line 450
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 454
    .end local v0  # "i":I
    :cond_1f
    return-void
.end method
