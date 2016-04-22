//
//  CBWProgressView.m
//  ios 进度条
//
//  Created by 陈博文 on 16/4/12.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWProgressView.h"


@interface CBWProgressView ()

/** 进度条*/
@property (nonatomic ,weak) UIView *progressView;

@end

@implementation CBWProgressView

- (CBWProgressView *)initProgressViewWithFrame:(CGRect )frame withRoundCorner:(BOOL )isRoundCorner withBackgroupColor:(UIColor *)backgroundColor withProgressColor:(UIColor *)progressColor{
    
    
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = self.frame.size.height * 0.5;
        self.layer.masksToBounds = YES;
        
        CGRect  viewFrame = CGRectMake(0, 0, 0, frame.size.height);
        UIView *view = [[UIView alloc]initWithFrame:viewFrame];
        [self addSubview:view];
        view.backgroundColor = [UIColor clearColor];
        self.progressView = view;
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    CGRect  viewFrame = CGRectMake(0, 0, 0, self.frame.size.height);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    [self addSubview:view];
    view.backgroundColor = [UIColor clearColor];
    
    self.progressView = view;
}


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    NSLog(@"%f",self.bounds.size.height);
    
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    [UIView animateWithDuration:5 animations:^{
        
        self.progressView.frame = frame;
        
    }];

}

- (void)setProgressViewColor:(UIColor *)progressViewColor{
    _progressViewColor = progressViewColor;
    
    if (_progressViewColor == nil) {
        self.progressView.backgroundColor = [UIColor clearColor];
    }else{
        self.progressView.backgroundColor = self.progressViewColor;
    }
    
   
}


@end
