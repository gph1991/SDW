//
//  ClockFace.m
//  SDWLearn
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 gph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ClockFace.h"

@interface ClockFace()


@property (nonatomic,strong) CAShapeLayer *hourHand;
@property (nonatomic,strong) CAShapeLayer *minuteHand;

@end

@implementation ClockFace
-(instancetype)init
{
    if (self == [super init])
    {
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor whiteColor].CGColor;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.lineWidth = 4;
        
        self.hourHand = [CAShapeLayer layer];
        self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -80, 4, 80)].CGPath;
        self.hourHand.fillColor = [UIColor blackColor].CGColor;
        self.hourHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.hourHand];
        
        self.minuteHand = [CAShapeLayer layer];
        self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, 2, 90)].CGPath;
        self.minuteHand.fillColor = [UIColor blackColor].CGColor;
        self.minuteHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.minuteHand];
        
    }
    
    return  self;
}

-(void)setTime:(NSDate *)time
{
    _time = time;
    NSLog(@"%@",time);
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:time];
    self.hourHand.affineTransform  = CGAffineTransformMakeRotation(components.hour/12.0*2*M_PI);
    self.minuteHand.affineTransform  = CGAffineTransformMakeRotation(components.minute/60.0*2*M_PI);
}









@end
