//
//  DataApproximator.m
//  DouglasPeuckerDemo
//
//  Created by Levi on 2022/1/4.
//

#import "DataApproximator.h"

@implementation DataApproximator

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

@end
