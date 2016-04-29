//
//  CBWCenterView.h
//  CBWAlertView
//
//  Created by 陈博文 on 16/4/25.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

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
