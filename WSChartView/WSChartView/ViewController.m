//
//  ViewController.m
//  WSChartView
//
//  Created by wangsong on 16/3/23.
//  Copyright © 2016年 wangsong. All rights reserved.
//

#import "ViewController.h"
#import "WSHistogramView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WSHistogramView *histogram = [[WSHistogramView alloc] initWithFrame:CGRectMake(30, 30, 200, 150)];
    histogram.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:histogram];
//        histogram.colorOfAxis = [UIColor redColor];
    histogram.chartdata = @[@59,@69,@79,@89,@99,@109,@119,@129,@139];

    histogram.widthOfAxis = -1;
//    histogram.shouldNotShowAxis = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
