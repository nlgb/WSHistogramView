//
//  WSHistogramBar.m
//  WSChartView
//
//  Created by wangsong on 16/3/24.
//  Copyright © 2016年 wangsong. All rights reserved.
//

#import "WSHistogramBar.h"

@interface WSHistogramBar ()
{
    BOOL shouldTapBar; /** 标记是否点击了柱状图 */

}
@end

@implementation WSHistogramBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBar)];
        [self addGestureRecognizer:tapGes];
    }
    
    return self;
}

- (void)didTapBar
{
    shouldTapBar = !shouldTapBar;
    if (shouldTapBar) {
        NSLog(@"点击了");
        self.backgroundColor = [UIColor blueColor];
    } else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}


@end
