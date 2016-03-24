//
//  WSHistogramView.m
//  WSChartView
//
//  Created by wangsong on 16/3/24.
//  Copyright © 2016年 wangsong. All rights reserved.
//

#import "WSHistogramView.h"
#import "WSHistogramBar.h"
#import "WSHistogramTitleLabel.h"

#define X_YAXIS 20// Y轴的X坐标 == X轴的X坐标
#define Y_YAXIS 40// Y轴的Y坐标
#define W_YAXIS  1// Y轴的宽度
#define H_YAXIS  (self.frame.size.height - 60)// Y轴的高度 其中60 = 20 + 40

#define X_XAXIS  20// X轴的X坐标 == Y轴的X坐标
#define Y_XAXIS  (self.frame.size.height - 20 - 1)// X轴的Y坐标 = 总高度 - X轴距离底部的距离20 - X轴的高度1
#define W_XAXIS  (self.frame.size.width - 40)// X轴的宽度 = 总宽度 - 左右间距（20 * 2）
#define H_XAXIS  1// X轴的高度

@interface WSHistogramView ()
{
    NSInteger count; /** 柱状图的个数 */
    CGFloat widthOfHistogram; /** 柱状图的宽度 */
    CGFloat heightOfHistogram; /** 柱状图的高度 */
    CGFloat spaceBetweenHistogram; /** 柱状图间隙的宽度 */
    
    CGFloat maxOfData; /** 数组中的最大值 */
    CGFloat minOfData; /** 数组中的最小值 */
        
}
@end


@implementation WSHistogramView

/** 柱状图 */

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        if (self.frame.size.width < 100) {
            
            CGRect temp = self.frame;
            temp.size.width = 100;
            self.frame = temp;
        }
        if (self.frame.size.height < 100) {
            
            CGRect temp = self.frame;
            temp.size.height = 100;
            self.frame = temp;
        }

        // 初始化坐标系的各种参数
        [self commonInit];
    }
    return self;
}

// 设置柱状图的基本常规属性
- (void)commonInit
{
    // 默认背景颜色
    self.backgroundColor = [UIColor lightGrayColor];
    
    // 柱状图的宽度
    widthOfHistogram = 40;
    // 柱状图间隙的宽度
    spaceBetweenHistogram = 20;
    // 柱状图的最大高度
    heightOfHistogram = H_YAXIS - 10;
    // 柱状图的标题
    WSHistogramTitleLabel *titleLabel = [[WSHistogramTitleLabel alloc] init];
    titleLabel.text = self.titleOfTitleLabel;
    titleLabel.backgroundColor = self.backgroundColorOfTitleLabel;
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(self.frame.size.width * 0.5, 10);
    [self addSubview:titleLabel];
}

- (void)setChartdata:(NSArray *)chartdata
{
    _chartdata = [NSArray arrayWithArray:chartdata];
    count = _chartdata.count;

    // width = 柱状图宽度+间隙宽度
    CGFloat width = W_XAXIS / count;
    // 柱状图宽度
    widthOfHistogram = width * 0.5;
    // 柱状图间隙宽度
    spaceBetweenHistogram = width - widthOfHistogram;
    
    [self findMaxAndMinNumberOfData];
    
    // 绘制柱状图
    [self strokeHistogram];
}

- (void)strokeHistogram
{
    for (int i = 0; i < _chartdata.count; i++) {
        float percentage = [_chartdata[i] floatValue] / maxOfData;
        
        // 计算每个柱状图的frame
        CGFloat X = X_YAXIS + W_YAXIS + spaceBetweenHistogram * 0.5 + i * (widthOfHistogram + spaceBetweenHistogram);
        CGFloat H = percentage * heightOfHistogram;
        CGFloat Y = Y_XAXIS - H - H_XAXIS;
        WSHistogramBar *bar = [[WSHistogramBar alloc] initWithFrame:CGRectMake(X, Y, widthOfHistogram, H)];
        bar.backgroundColor = [UIColor lightGrayColor];
        
        // 把柱状图添加到父控件
        [self addSubview:bar];
    }
}

- (void)findMaxAndMinNumberOfData
{
    maxOfData = CGFLOAT_MIN;
    minOfData = CGFLOAT_MAX;
    
    for (NSNumber *number in _chartdata) {
        if (maxOfData < number.floatValue) {
            maxOfData = number.floatValue;
        } else if (minOfData > number.floatValue) {
            minOfData = number.floatValue;
        }
        
        if (maxOfData - (int)maxOfData == 0) {
            maxOfData = (int)maxOfData;
        } else {
            maxOfData = (int)maxOfData + 1;
        }
    }
}
- (void)drawRect:(CGRect)rect
{
    // 不能在这里修改frame，否则还是按照原来的frame绘制的
//    if (self.frame.size.width < 100 || self.frame.size.height < 100) {
//        CGRect temp = self.frame;
//        
//        temp.size.width = 100;
//        temp.size.height = 100;
//        
//        self.frame = temp;
//    }

    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 拼接路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 设置起点
    [path moveToPoint:CGPointMake(20, 40)]; // 以Y轴上方为起始点
    // 绘制直线
    [path addLineToPoint:CGPointMake(20, Y_XAXIS)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - 20, Y_XAXIS)];
    // 添加路径到上下文
    CGContextAddPath(context, path.CGPath);
    
    // 设置绘图状态，比如颜色、线段宽度、线段顶角样式、连接样式
    if (self.colorOfAxis) {
        [_colorOfAxis setStroke]; // 用户设置了坐标轴的颜色
    } else {
        [[UIColor lightGrayColor] setStroke]; // 否则默认显示浅灰色
    }
    if (self.widthOfAxis && self.widthOfAxis != 1) {
        CGContextSetLineWidth(context, self.widthOfAxis); // 用户指定的坐标轴宽度
    } else if (self.shouldNotShowAxis) {
        CGContextSetLineWidth(context, 0); // 不显示坐标轴，只显示柱状图
    }
    else {
        CGContextSetLineWidth(context, 1); // 坐标轴默认宽度为1
    }
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapSquare);
    // 渲染上下文
    CGContextStrokePath(context);
}

// 过滤宽度为负数的情况
- (void)setWidthOfAxis:(CGFloat)widthOfAxis
{
    if (widthOfAxis < 0) {
        _widthOfAxis = 1;
    }
}

- (void)setColorOfAxis:(UIColor *)colorOfAxis
{
    if (![colorOfAxis isEqual:[UIColor lightGrayColor]]) {
        _colorOfAxis = colorOfAxis;
    } else {
        _colorOfAxis = colorOfAxis;
    }
}

@end
