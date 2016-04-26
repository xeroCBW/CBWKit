//
//  CBWCenterView.m
//  CBWAlertView
//
//  Created by 陈博文 on 16/4/25.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWCenterView.h"

static float const kCBWAlertViewCornerRadius  = 3.0;
static float const buttonHeight  = 30.0;
#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@implementation CBWCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
     
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - method
- (void) creatContainerView{
    
    if (self.containerView == nil) {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 150)];
        self.containerView.layer.cornerRadius = kCBWAlertViewCornerRadius;
        self.containerView.layer.masksToBounds = YES;
    }
    self.containerView.center = self.center;
    self.containerView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.containerView];
}

- (void)addButtonsToView: (UIView *)container
{
    if (self.buttonTitles==nil) { return; }
    
    CGFloat buttonWidth = container.bounds.size.width / [self.buttonTitles count];
    
    for (int i=0; i<[self.buttonTitles count]; i++) {
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        
        [closeButton addTarget:self action:@selector(alertDialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];
        
        [closeButton setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [closeButton.layer setCornerRadius:kCBWAlertViewCornerRadius];
        closeButton.backgroundColor = randomColor;
        [container addSubview:closeButton];
    }
}

- (void)alertDialogButtonTouchUpInside:(UIButton *)button{
    
//    NSLog(@"%ld",(long)button.tag);
    self.buttonClickActionBlock(self,button.tag);
    
}

#pragma mark - show && dismiss

-(void)show{
    
    [self creatContainerView];
    [self addButtonsToView:self.containerView];
    
    self.containerView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);//设置原先的动画
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         
                         
                         //设置进来的由大变小的动画
                         self.containerView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                      
                       
                     }
                     completion:nil
     ];
}

- (void)dismiss{
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionTransitionNone
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

@end
