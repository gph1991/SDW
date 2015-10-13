//
//  ViewController.m
//  SDWLearn
//
//  Created by Product Division 1 on 15/10/13.
//  Copyright (c) 2015年 gph. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.image1 sd_setImageWithURL:[NSURL URLWithString:@"http://img2.selfimg.com.cn/Lself554/2015/10/12/1444646779_w8TQcc.jpg"]];
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:@"http://img2.selfimg.com.cn/Lself554/2015/10/12/1444646779_w8TQcc.jpg"]];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
