//
//  CBWProgressView.h
//  ios 进度条
//
//  Created by 陈博文 on 16/4/12.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBWProgressView : UIView
/** 进度(0~1)*/
@property (nonatomic ,assign) CGFloat progress;
/** 颜色,进度为0的时候默认为 clearColor*/
@property (nonatomic ,strong) UIColor *progressViewColor;

- (CBWProgressView *)initProgressViewWithFrame:(CGRect )frame withRoundCorner:(BOOL )isRoundCorner withBackgroupColor:(UIColor *)backgroundColor withProgressColor:(UIColor *)progressColor;

@end
