//
//  WSHistogramView.h
//  WSChartView
//
//  Created by wangsong on 16/3/24.
//  Copyright © 2016年 wangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSHistogramView : UIView

/** 柱状图数据 数组 */
@property(nonatomic,strong) NSArray *chartdata;

/**----------------------------------------------------------------------------------*/
/** X轴和Y轴的颜色 */
@property(nonatomic,strong) UIColor *colorOfAxis;
/** X轴和Y轴的宽度 // 设置为0表示不显示坐标轴 */
@property(nonatomic,assign) CGFloat widthOfAxis;
/** 是否不显示坐标轴  如果设置为是否显示坐标轴，那么默认为NO，就相当于默认不显示，而我希望默认显示坐标轴，这样设置不是我想要的，所以改为“是否不显示坐标轴”*/
@property(nonatomic,assign) BOOL shouldNotShowAxis;

/**----------------------------------------------------------------------------------*/
/** 柱状图标题 */
@property(nonatomic,strong) NSString *titleOfTitleLabel;
/** 柱状图背景色 */
@property(nonatomic,strong) UIColor *backgroundColorOfTitleLabel;


@end
