//
//  WSHistogramTitleLabel.m
//  WSChartView
//
//  Created by wangsong on 16/3/24.
//  Copyright © 2016年 wangsong. All rights reserved.
//

#import "WSHistogramTitleLabel.h"

@implementation WSHistogramTitleLabel

/** 柱状图标题 */

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self sizeToFit];
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}


@end
