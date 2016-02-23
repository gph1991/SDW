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

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *touchView = self;
    
    if ([self pointInside:point withEvent:event] &&
        (!self.hidden) &&
        self.userInteractionEnabled &&
        (self.alpha >= 0.01f))
    {
        for (UIView *subView in self.subviews)
        {
            //注意，这里有坐标转换，将point点转换到subview中，好好理解下
            CGPoint subPoint = CGPointMake(point.x - subView.frame.origin.x,
                                           point.y - subView.frame.origin.y);
            UIView *subTouchView = [subView hitTest:subPoint withEvent:event];
            
            if(subTouchView)
            {
                //找到touch事件对应的view，停止遍历
                touchView = subTouchView;
                break;
            }
        }
    }
    else
    {
        //此点不在该View中，那么连遍历也省了，直接返回nil
        touchView = nil;
    }
    
    return touchView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return CGRectContainsPoint(self.bounds, point);
}


@end
