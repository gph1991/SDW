//
//  ViewController.m
//  SDWLearn
//
//  Created by Product Division 1 on 15/10/13.
//  Copyright (c) 2015年 gph. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImage+Rotate_Flip.h"
#import "YFF_BaseModel.h"
#import "CustomLayer.h"
#import "YYViewHierarchy3D.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import "UIImageView+PHDownloader.h"

#define WIDTH 50


@interface ViewController ()<UIAlertViewDelegate,UIScrollViewDelegate>
{
    BOOL pageStillLoading;
    CustomLayer *testLayer;
    UIView *view;
}

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIView *upView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    char *s = "gph";
    self.view.backgroundColor = [UIColor whiteColor];

    UIImage *image = [UIImage imageNamed:@"wx"];
    NSData *data1 = UIImagePNGRepresentation(image);
    NSString *imageStr = [data1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSData *data2 = [[NSData alloc]initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image1 = [UIImage imageWithData:data2];
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:@"http://gphsubmit.applinzi.com/download.jpg"]];
    
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:s];
    
//    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)].CGPath;
//    YFF_BaseModel *model = [[YFF_BaseModel alloc]initWithDataDic:@{@"name":@"tt"}];
    
    
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, 320, 200)];
//    scrollView.contentSize = CGSizeMake(320, 700);
//    scrollView.backgroundColor = [UIColor blueColor];
//    scrollView.delegate = self;
//    [self.view addSubview:scrollView];
    

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%s",context);
}

//
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    self.name = [NSString stringWithFormat:@"%d",arc4random()%50];
}

//
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging:%d",decelerate);
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
    self.image1.layer.transform =  CATransform3DRotate(self.image1.layer.transform,M_PI_4/2 , 1, 0, 0);
    
//    pageStillLoading = YES;
//    [NSThread detachNewThreadSelector:@selector(handlerRequest)toTarget:self withObject:nil];
//    [self.image1 setHidden:YES];
//    while (pageStillLoading)
//    {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
//    
//    [self.image1 setHidden:NO];
}

- (IBAction)yRotate:(id)sender
{
    self.image1.layer.transform =  CATransform3DRotate(self.image1.layer.transform,M_PI_4/2 , 0, 1, 0);
}

- (IBAction)zRotate:(id)sender
{
    self.image1.layer.transform =  CATransform3DRotate(self.image1.layer.transform,M_PI_4 , 0, 0, 1);
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
    [self presentViewController:[[SecondViewController alloc]init] animated:YES completion:nil];
    
//    [self keyFrameAnimation1];
//    [self test];
//    [YYViewHierarchy3D show];

    
    
    
//    UIView *tmp = [[UIView alloc]initWithFrame:CGRectMake(60, 60, 60, 60)];
//    tmp.backgroundColor = [UIColor cyanColor];
//    tmp.layer.anchorPointZ = -5;
//    [self.view addSubview:tmp];
////
//    view = [[UIView alloc]initWithFrame:CGRectMake(60, 0, 60, 60)];
//    view.backgroundColor = [UIColor blueColor];
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pand:)];
//    view.layer.anchorPointZ = -500;
//    [view addGestureRecognizer:pan];
//    [self.view addSubview:view];
//
    
//    [self drawMyLayer];
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有相机访问权限，请在设置-隐私-相机中进行设置！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
//    [alertView show];
}
- (void)pand:(UIPanGestureRecognizer *)gestureRecognizer
{
    static CGRect oldFrame;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        oldFrame = gestureRecognizer.view.frame;
    }
    
    CGPoint change = [gestureRecognizer translationInView:self.view];
    CGPoint change2 = [gestureRecognizer locationInView:self.view];
    
//    NSLog(@"trans %.2f,%.2f",change.x,change.y);
    NSLog(@"location %.2f,%.2f",change2.x,change2.y);
    
    CGRect newFrame = oldFrame;
    newFrame.origin.x += change.x;
    newFrame.origin.y += change.y;
    view.frame = newFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)test
{
    testLayer = [CustomLayer layer];
    testLayer.progress = 1;
    testLayer.contentsScale = [UIScreen mainScreen].scale;
    testLayer.bounds = self.view.bounds;
    [self.view.layer addSublayer:testLayer];
 
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"progress"];
    basic.duration = 5;
    basic.fromValue = @0.0;
    basic.toValue = @1.0;
    basic.autoreverses = NO;
    [testLayer addAnimation:basic forKey:@"1234"];
}

#pragma mark 绘制图层
-(void)drawMyLayer
{
    TestRec *recView = [[TestRec alloc]initWithFrame:CGRectMake(150, 150, 100, 100)];
    [self.view addSubview:recView];
    
    UIBezierPath *trackPath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 350) radius:30 startAngle:0 endAngle:M_PI_2*3 clockwise:1];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor cyanColor].CGColor;
    layer.path = trackPath.CGPath;
   
    [self.view.layer addSublayer:layer];
//
//    CGSize size=[UIScreen mainScreen].bounds.size;
//    
//    //获得根图层
//    CALayer *layer=[[CALayer alloc]init];
//    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
//    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
//    //设置中心点
//    layer.position = CGPointMake(size.width/2, size.height/2);
//    //设置大小
//    layer.bounds = CGRectMake(0, 0, WIDTH,WIDTH);
//    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
//    layer.cornerRadius = WIDTH/2;
//    //设置阴影
//    layer.shadowColor = [UIColor grayColor].CGColor;
//    layer.shadowOffset = CGSizeMake(2, 2);
//    layer.shadowOpacity = .9;
//    //设置边框
//    //    layer.borderColor=[UIColor whiteColor].CGColor;
//    //    layer.borderWidth=1;
//    
//    //设置锚点
//    //    layer.anchorPoint=CGPointZero;
//    
//    [self.view.layer addSublayer:layer];
//    
   
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


-(void)keyFrameAnimation1
{
    
    UIView *bb = [[UIView alloc]initWithFrame:CGRectMake(20, 200, 20, 30)];
    bb.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bb];
    
    CGRect boud = CGRectMake(50, 50, 100, 100);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = CGPathCreateWithEllipseInRect(boud, NULL);
    animation.duration = 4;
    animation.repeatCount = HUGE_VALF;
    animation.calculationMode = kCAAnimationPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.additive = YES;
    [bb.layer addAnimation:animation forKey:@"shake"];
}

-(void)keyFrameAnimation2
{
    UIView *bb = [[UIView alloc]initWithFrame:CGRectMake(20, 200, 20, 30)];
    bb.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bb];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    animation.additive = YES;
    [bb.layer addAnimation:animation forKey:@"shake"];
}

@end
