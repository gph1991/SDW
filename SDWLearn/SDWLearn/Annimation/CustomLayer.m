//
//  CustomLayer.m
//  SDWLearn
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 gph. All rights reserved.
//

static int  kLineWidth = 6;
#import "CustomLayer.h"

@implementation CustomLayer

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progress"])
    {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2 - kLineWidth / 2;
    radius = 20;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds)+40, CGRectGetMidY(self.bounds)+40);

//    CGPoint center = CGPointMake(0, 0);
    
    // O
    CGFloat originStart = M_PI * 7 / 2;
    CGFloat originEnd = M_PI * 2;
    CGFloat currentOrigin = originStart - (originStart - originEnd) * self.progress;
    
    // D
    CGFloat destStart = M_PI * 3;
    CGFloat destEnd = 0;
    CGFloat currentDest = destStart - (destStart - destEnd) * self.progress;
    
    [path addArcWithCenter:center radius:radius startAngle: currentOrigin endAngle:currentDest clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, kLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextStrokePath(ctx);
}

@end
