//
//  CBWPayView.h
//  payAlertView
//
//  Created by 陈博文 on 16/4/26.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBWPayView : UIView

/** containerView*/
@property (nonatomic ,strong) UIScrollView *containerView;

/** selectedAction*/
@property (nonatomic ,copy) void (^didSelectedAction)(NSInteger index,NSInteger tag,CBWPayView *view);
- (instancetype)init;
- (void)show;
- (void)dismiss;
@end
