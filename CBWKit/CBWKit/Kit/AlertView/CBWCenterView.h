//
//  CBWCenterView.h
//  CBWAlertView
//
//  Created by 陈博文 on 16/4/25.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

extern float const kCBWAlertViewCornerRadius;
extern float const separatorMargin;//iphone6+不会消失
extern float const normalMargin;
extern float const lrMargin;
extern float const titleLabelH;
extern float const titleLabelBottomMargin;
extern float const titleFont;
extern float const messageFont;
extern float const buttonFont;
extern float const buttonHeight;
extern float const showDuring;
extern float const dismisDuring;
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@interface CBWCenterView : UIView

/** containerView*/
@property (nonatomic ,strong) UIView *containerView;
/** 底部 button 的 title*/
@property (nonatomic ,strong) NSArray *buttonTitles;
/** 提示框的 title*/
@property (nonatomic ,copy) NSString *title;
/** 提示框的 message*/
@property (nonatomic ,copy) NSString *message;
/** 处理button 点击的block*/
@property (nonatomic ,strong) void (^buttonClickActionBlock)(CBWCenterView *alertView,NSUInteger index);

-(instancetype)init;

- (void)show;
- (void)dismiss;
@end
