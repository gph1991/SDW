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
    CGContextAddArc(context, 50, 50, 30, 0, M_PI_2*3 , 0);
    
    /*
     CGContextAddArc属于CG类库
     所以最终的结果要沿X轴进行翻转(y=y*-1，这种情况下，M_PI_2在上部)
     或者简单起见1表示逆时针，0表示顺时针。
     UIBezierPath 属于UIKit。结果无需额外处理。M_PI_2在下部
     */
//    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}

@end
