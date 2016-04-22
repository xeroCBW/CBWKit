//
//  CBWProgressView.m
//  ios 进度条
//
//  Created by 陈博文 on 16/4/12.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWProgressView.h"
#import "UIColor+BFPaperColors.h"
@interface CBWProgressView ()

/** 进度条*/
@property (nonatomic ,weak) UIView *progressView;

@end

@implementation CBWProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
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
//    view.layer.cornerRadius = self.frame.size.height * 0.5;
//    view.layer.masksToBounds = YES;
    
    self.progressView = view;
}


-(void)setProgress:(CGFloat)progress{
    
    _progress = progress;
    if (progress == 0) {
        self.progressView.backgroundColor = [UIColor clearColor];
    }else{
        self.progressView.backgroundColor = [UIColor colorWithHexString:@"#a8d2ff"];
       
        CGRect frame = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
        
        [UIView animateWithDuration:1.5 animations:^{
            
            self.progressView.frame = frame;
            
        }];

    }
    
}


@end
