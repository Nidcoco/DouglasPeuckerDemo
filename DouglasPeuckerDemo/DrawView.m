//
//  DrawView.m
//  DouglasPeuckerDemo
//
//  Created by Levi on 2022/1/5.
//

#import "DrawView.h"

@implementation DrawView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    
    for (int i = 0; i < self.points.count; i ++) {
        CGPoint point = [self.points[i] CGPointValue];
        if (i == 0) {
            CGContextMoveToPoint(context, point.x, point.y);
        } else {
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
    
    [[UIColor redColor] setStroke];
    
    CGContextStrokePath(context);

}

- (void)setPoints:(NSArray *)points
{
    if (_points == nil) {
        for (int i = 0; i < points.count; i ++) {
            CGPoint point = [points[i] CGPointValue];

            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x - 2.5, point.y - 2.5, 5, 5) cornerRadius:2.5];

            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            layer.fillColor = [UIColor blackColor].CGColor;
            [self.layer addSublayer:layer];
        }
    }
    _points = points;
}

@end
