//
//  CBWAlertView.m
//  CBWKit
//
//  Created by 陈博文 on 16/4/29.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWAlertView.h"
#import "CBWCenterView.h"
//#import "CABasicAnimation.h"
//#import <CAPropertyAnimation.h>
#import <QuartzCore/CALayer.h>
#import <Foundation/NSObject.h>


#pragma mark - AlertButtonItem
@interface AlertButtonItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, copy) CBWAlertViewHandler action;
@end
//一定要有实现,要不然不能运行
@implementation AlertButtonItem

@end
#pragma mark - CBWAlertView

@interface CBWAlertView ()
/** 提示框的 title*/
@property (nonatomic ,copy) NSString *title;
/** 提示框的 message*/
@property (nonatomic ,copy) NSString *message;
/** 用来装 buttonItem 的数组*/
@property (nonatomic ,strong) NSMutableArray *items;
@end



@implementation CBWAlertView

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        self.frame = [UIScreen mainScreen].bounds;
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
    
    
}

#pragma mark - method
- (void) creatContainerView{
    
    if (self.containerView == nil) {
        
        [self setUpDefaultView];
        
    }
    
    //重新设置尺寸,增加下面 button 的位置
    [self resizeFrameContainerView:self.containerView];
    
    self.containerView.center = self.center;
    self.containerView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.containerView];
}

- (void)setUpDefaultView{
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 250;
    
    NSString *title = self.title;
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:titleFont];
    //            titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake( w - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size;
    titleLabel.numberOfLines = 0;
    titleLabel.frame = CGRectMake(lrMargin, 0, w - 2*lrMargin, titleSize.height);
    titleLabel.center = CGPointMake(w * 0.5, normalMargin + titleSize.height * 0.5);
    
    NSString *message = self.message;
    // 初始化label
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    //            messageLabel.backgroundColor = [UIColor yellowColor];
    // label获取字符串
    messageLabel.text = message;
    // label获取字体
    messageLabel.font = [UIFont systemFontOfSize:messageFont];
    // 根据获取到的字符串以及字体计算label需要的size
    CGSize messageSize = [message boundingRectWithSize:CGSizeMake( w - 2*lrMargin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageLabel.font} context:nil].size;
    // 设置无限换行
    messageLabel.numberOfLines = 0;
    
    if ([self isBlankString:message]) {
        messageSize.height = 0 - titleLabelBottomMargin;//置为空,没有默认也会有一行
    }else{
        //不做处理
    }
    messageLabel.frame = CGRectMake(lrMargin, normalMargin + titleSize.height + titleLabelBottomMargin, w - 2*lrMargin, messageSize.height);
    NSLog(@"%f====%f",messageSize.height,messageSize.width);
    
    //h需要改变
    CGFloat  h = [self isBlankString:message]?normalMargin + titleSize.height + normalMargin:normalMargin + titleSize.height + titleLabelBottomMargin + messageSize.height + normalMargin;
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.containerView.layer.cornerRadius = kCBWAlertViewCornerRadius;
    self.containerView.layer.masksToBounds = YES;
    
    UIView *backgroupView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    backgroupView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:backgroupView];
    
    [self.containerView addSubview:titleLabel];
    [self.containerView addSubview:messageLabel];
}

- (void)addButtonsToView: (UIView *)container
{
    if (self.items.count == 0) { return; }
    
    CGFloat buttonWidth = container.bounds.size.width / self.items.count;
    
    //设置横线
    CGRect frame = CGRectMake(0,container.bounds.size.height - buttonHeight - separatorMargin, container.bounds.size.width, separatorMargin);
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor grayColor];
    [container addSubview:view];
    
    
    for (int i=0; i<self.items.count; i++) {
        
        AlertButtonItem *item = self.items[i];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setTitle:item.title forState:UIControlStateNormal];
        [closeButton setTitleColor:item.color forState:UIControlStateNormal];
        [closeButton setTitleColor:item.color forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
        closeButton.backgroundColor = [UIColor whiteColor];
        
        if (i == 0) {
            [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        }else{
            [closeButton setFrame:CGRectMake(i * buttonWidth + separatorMargin, container.bounds.size.height - buttonHeight, buttonWidth - separatorMargin, buttonHeight)];
        }
        closeButton.tag = i;
        [closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:closeButton];
    }
}


- (void)resizeFrameContainerView:(UIView *)containerView{
    
    CGRect frame = containerView.frame;
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height + buttonHeight);
    containerView.frame = frame;
    
}

#pragma mark - show && dismiss

-(void)show{
    
    [self creatContainerView];
    [self addButtonsToView:self.containerView];
    
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    CASpringAnimation *scale = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    scale.mass = 3.0;
    scale.stiffness = 1000.0;
    scale.damping = 500.0;
    scale.fromValue = @(1.2);
    scale.toValue = @(1.0);

    
    [self.containerView.layer addAnimation:scale forKey:scale.keyPath];
    
    [UIView animateWithDuration:showDuring delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
                         
                     }
                     completion:nil
     ];
    
    
    
}

- (void)dismiss{
    [UIView animateWithDuration:dismisDuring delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         //子类没有做动画
                         CATransform3D currentTransform = self.containerView.layer.transform;
                         self.containerView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.containerView.layer.opacity = 0.0f;
                         
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
    
}

#pragma mark - public

- (void)addButtonWithTitle:(NSString *)title color:(UIColor *)color handler:(CBWAlertViewHandler)handler{
  
    AlertButtonItem *item = [[AlertButtonItem alloc] init];
    item.title = title;
    item.color = color;
    item.action = handler;
    [self.items addObject:item];

}


#pragma mark - setter && getter
-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}



#pragma mark - private

- (void)buttonAction:(UIButton *)button{
    
    AlertButtonItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
    [self dismiss];
}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
