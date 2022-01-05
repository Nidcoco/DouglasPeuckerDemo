//
//  DataApproximator.h
//  DouglasPeuckerDemo
//
//  Created by Levi on 2022/1/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 算法的基本思路
 将待处理曲线的首末点虚连一条直线,求所有中间点与直线的距离,并找出最大距离值dmax ,用dmax与抽稀阈值threshold相比较：

 若dmax < threshold，这条曲线上的中间点全部舍去;

 若dmax ≥ threshold，则以该点为界，把曲线分为两部分,对这两部分曲线重复上述过程，直至所有的点都被处理完成。
 */

@interface DataApproximator : NSObject

/**
 * 道格拉斯算法 递归实现
 * @param points 要通过道格拉斯算法处理的点的数组
 * @param tolerance 阈值
 * @return 返回经过道格拉斯算法处理后得到的点的数组
 */
- (NSArray *)reduceWithDouglasPeuker:(NSArray *)points tolerance:(CGFloat)tolerance;

@end

NS_ASSUME_NONNULL_END
