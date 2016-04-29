//
//  CBWCenterView.m
//  CBWAlertView
//
//  Created by 陈博文 on 16/4/25.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWCenterView.h"

static float const kCBWAlertViewCornerRadius  = 10.0;
static float const separatorMargin = 0.5;//iphone6+不会消失
static float const normalMargin = 20.0;
static float const lrMargin = 17.5;
static float const titleLabelH = 20;
static float const titleLabelBottomMargin = 10;
static float const titleFont = 17;
static float const messageFont = 13.0;
static float const buttonFont = 17.0;
static float const buttonHeight  = 45.0;
static float const showDuring = 0.35f;
static float const dismisDuring = 0.1f;
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@implementation CBWCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
     
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        [self addGestureRecognizer:tap];
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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, titleLabelH)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:titleFont];
//            titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(w * 0.5, normalMargin + titleLabelH * 0.5);
    
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
    messageLabel.frame = CGRectMake(lrMargin, normalMargin + titleLabelH + titleLabelBottomMargin, w - 2*lrMargin, messageSize.height);
    NSLog(@"%f====%f",messageSize.height,messageSize.width);
    
    //h需要改变
    CGFloat  h = [self isBlankString:message]?normalMargin + titleLabelH + normalMargin:normalMargin + titleLabelH + titleLabelBottomMargin + messageSize.height + normalMargin;
    
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
    if (self.buttonTitles==nil) { return; }
    
    CGFloat buttonWidth = container.bounds.size.width / [self.buttonTitles count];
    
//    设置横线
    CGRect frame = CGRectMake(0,container.bounds.size.height - buttonHeight - separatorMargin, container.bounds.size.width, separatorMargin);
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor grayColor];
    [container addSubview:view];
    
    
    for (int i=0; i<[self.buttonTitles count]; i++) {
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton addTarget:self action:@selector(alertDialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];
        
        [closeButton setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont systemFontOfSize:buttonFont]];
        closeButton.backgroundColor = [UIColor whiteColor];
        if (i == 0) {
            [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        }else{
            [closeButton setFrame:CGRectMake(i * buttonWidth + separatorMargin, container.bounds.size.height - buttonHeight, buttonWidth - separatorMargin, buttonHeight)];
            [closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [closeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

            
        }
        
        [container addSubview:closeButton];
    }
}

- (void)alertDialogButtonTouchUpInside:(UIButton *)button{
    
//    NSLog(@"%ld",(long)button.tag);
    self.buttonClickActionBlock(self,button.tag);
    
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
    
        self.containerView.layer.transform = CATransform3DMakeScale(0.0f, 0.0f, 1.0);//设置原先的动画
        
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
        
        
        [UIView animateWithDuration:showDuring delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                             //设置进来的由大变小的动画
                             self.containerView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1);
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
#pragma mark - setter && getter 
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
