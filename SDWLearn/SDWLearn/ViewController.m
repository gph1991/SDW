//
//  ViewController.m
//  SDWLearn
//
//  Created by Product Division 1 on 15/10/13.
//  Copyright (c) 2015年 gph. All rights reserved.
//

#import "YYViewHierarchy3D.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"
#import "ViewController.h"

#define WIDTH 50


@interface ViewController ()<UIAlertViewDelegate>
{
    BOOL pageStillLoading;
}
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIView *upView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:@"http://img2.selfimg.com.cn/Lself554/2015/10/12/1444646779_w8TQcc.jpg"]];
//    [self.image1 sd_setImageWithURL:[NSURL URLWithString:@"http://img2.selfimg.com.cn/Lself554/2015/10/12/1444646779_w8TQcc.jpg"]];
//    CAShapeLayer *layer  =[CAShapeLayer layer];
//    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)].CGPath;
    
//    [YYViewHierarchy3D show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (IBAction)btnDonw:(id)sender
{
    NSArray *arr = [UIApplication sharedApplication].windows;
    
    pageStillLoading = YES;
    [NSThread detachNewThreadSelector:@selector(handlerRequest)toTarget:self withObject:nil];
    [self.image1 setHidden:YES];
    while (pageStillLoading)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    [self.image1 setHidden:NO];
}

-(void)handlerRequest
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        pageStillLoading = NO;
        NSLog(@"%@",@(pageStillLoading));
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [YYViewHierarchy3D show];

//    [self drawMyLayer];
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有相机访问权限，请在设置-隐私-相机中进行设置！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
//    [alertView show];
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 绘制图层
-(void)drawMyLayer{
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    //获得根图层
    CALayer *layer=[[CALayer alloc]init];
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH,WIDTH);
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius = WIDTH/2;
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = .9;
    //设置边框
    //    layer.borderColor=[UIColor whiteColor].CGColor;
    //    layer.borderWidth=1;
    
    //设置锚点
    //    layer.anchorPoint=CGPointZero;
    
    [self.view.layer addSublayer:layer];
    
   
    NSLog(@"This is OK");
}

//#pragma mark 点击放大
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch=[touches anyObject];
//    CALayer *layer=self.view.layer.sublayers[0];
//    CGFloat width=layer.bounds.size.width;
//    if (width==WIDTH)
//    {
//        width=WIDTH*4;
//    }
//    else
//    {
//        width=WIDTH;
//    }
//    
//    layer.bounds=CGRectMake(0, 0, width, width);
//    layer.position=[touch locationInView:self.view];
//    layer.cornerRadius=width/2;
//}

@end
