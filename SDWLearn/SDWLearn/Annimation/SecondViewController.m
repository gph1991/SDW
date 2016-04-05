//
//  SecondViewController.m
//  SDWLearn
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 gph. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    UIDatePicker *picker;
    ClockFace *clock;
}

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor cyanColor];
    
    clock = [[ClockFace alloc]init];
    clock.position = CGPointMake(self.view.bounds.size.width/2, 300);
    [self.view.layer addSublayer:clock];
    [clock setTime:[NSDate new]];
    
    picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 70, 320, 50)];
    [picker addTarget:self action:@selector(timeChange) forControlEvents:UIControlEventValueChanged];
    picker.datePickerMode = UIDatePickerModeTime;
    picker.timeZone = [NSTimeZone localTimeZone];
    [self.view addSubview:picker];
    
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"wx" withExtension:@"png"];
    CIImage *coreImage = [CIImage imageWithContentsOfURL:url];
    CIFilter *sepialFilter = [CIFilter filterWithName:@"CIColorControls"];
    [sepialFilter setValue:coreImage forKey:kCIInputImageKey];
    [sepialFilter setValue:@(5) forKey:@"inputContrast"];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *output = [sepialFilter outputImage];
    CGImageRef temp = [context createCGImage:output fromRect:[output extent]];
    UIImage *image = [UIImage imageWithCGImage:temp];
    [self showAllFilters];
    // Do any additional setup after loading the view.
}

-(void)timeChange
{
    [clock setTime:picker.date];
}

-(void)showAllFilters
{
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filterNames)
    {
        CIFilter *filter=[CIFilter filterWithName:filterName];
        NSLog(@"\r filter:%@\r attributes:%@",filterName,[filter attributes]);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
