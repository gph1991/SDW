//
//  TestRec.m
//  SDWLearn
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 gph. All rights reserved.
//

#import "TestRec.h"

@implementation TestRec

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//填充颜色
//    CGContextMoveToPoint(context, 160, 180);
    CGContextAddArc(context, 50, 50, 30, M_PI_2, 0 , 0);
    
    /*
     
     For example, on iOS,a UIView flips the Y-coordinate by scaling the Y values by -1. In a flipped coordinate system, specifying a clockwise arc results in a counterclockwise arc after the transformation is applied
     
     CGContextAddArc属于CG类库
     有两种方式 原始方式 1.M_PI_2在上部，0为逆时针。最终的结果要进行翻转(y=y*-1)变为UIView的坐标系
     简便方式 2.M_PI_2在下部，0为顺时针。无需额外处理
     
     UIBezierPath 属于UIKit。结果无需额外处理。M_PI_2在下部，1为顺时针
     */
//    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}

@end
