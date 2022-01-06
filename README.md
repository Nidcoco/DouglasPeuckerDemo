

# 介绍

> Douglas-Peukcer算法由D.Douglas和T.Peueker于1973年提出，是线状要素抽稀的经典算法。用它处理大量冗余的几何数据点，既可以达到数据量精简的目的，有可以在很大程度上保留几何形状的骨架。

# 算法思路

将待处理曲线的首末点虚连一条直线,求所有中间点与直线的距离,并找出最大距离值dmax ,用dmax与抽稀阈值tolerance相比较：

若dmax < tolerance，这条曲线上的中间点全部舍去;

若dmax ≥ tolerance，则以该点为界，把曲线分为两部分,对这两部分曲线重复上述过程，直至所有的点都被处理完成。

![](https://upload-images.jianshu.io/upload_images/12618366-a2fff3852698bb8c.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


# 用途

> 可用于图表的绘制和地图绘制线减少轨迹点

# Demo效果

![](https://upload-images.jianshu.io/upload_images/12618366-0405a5571987c848.gif?imageMogr2/auto-orient/strip)

# 递归核心代码

```
- (NSArray *)reduceWithDouglasPeuker:(NSArray *)points tolerance:(CGFloat)tolerance
{
    if (tolerance <= 0 || points.count < 3) {
        return points;
    }
    
    NSInteger index = 0;
    CGFloat dmax = 0.f;
    
    // 遍历除首尾点以外的点
    for (NSInteger i = 1; i < points.count - 1; i ++) {
        CGFloat distance = [self getDistanceWithStartPoint:[points.firstObject CGPointValue] endPoint:[points.lastObject CGPointValue] betweenPoint:[points[i] CGPointValue]];
        if (distance > dmax)
        {
            dmax = distance;
            index = i;
        }
    }
    
    // 递归
    if (dmax >= tolerance) {
        NSArray *resultList = [self reduceWithDouglasPeuker:[points subarrayWithRange:NSMakeRange(0, index)] tolerance:tolerance];
        return [resultList arrayByAddingObjectsFromArray:[self reduceWithDouglasPeuker:[points subarrayWithRange:NSMakeRange(index, points.count - index)] tolerance:tolerance]];
    } else {
        return @[points.firstObject, points.lastObject];
    }
    
}

// 鞋带公式求三角形的高, 也可以用海伦公式
- (CGFloat)getDistanceWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint betweenPoint:(CGPoint)point
{
    CGFloat dx = startPoint.x - endPoint.x;
    CGFloat dy = startPoint.y - endPoint.y;
    
    CGFloat sxey = startPoint.x * endPoint.y;
    CGFloat exsy = endPoint.x * startPoint.y;
    
    // 起止点的长度
    CGFloat length = sqrt(dx * dx + dy * dy);
    
    return fabs(dy * point.x - dx * point.y + sxey - exsy) / length;
}
```

# Demo

[Demo](https://github.com/Nidcoco/DouglasPeuckerDemo "Title")

# 参考

[计算几何-道格拉斯普克(Douglas-Peuker)算法](https://zhuanlan.zhihu.com/p/74906781 "Title")
