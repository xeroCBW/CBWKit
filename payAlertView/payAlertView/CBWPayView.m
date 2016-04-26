//
//  CBWPayView.m
//  payAlertView
//
//  Created by 陈博文 on 16/4/26.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWPayView.h"

static float const containerViewH = 300;
static float const kCBWAlertViewCornerRadius = 3.0;
#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW [UIScreen mainScreen].bounds.size.width

#define starFrame CGRectMake(0, screenH, screenW, containerViewH)
#define endFrame CGRectMake(0, screenH - containerViewH, screenW, containerViewH)

#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@interface CBWPayView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation CBWPayView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 100, 40);
        [self addSubview:button];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor greenColor];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}
#pragma mark - method
- (void) creatContainerView{
    
    if (self.containerView == nil) {
        self.containerView = [[UIScrollView alloc] initWithFrame:starFrame];
        self.containerView.pagingEnabled = YES;
        self.containerView.bounces = NO;
        self.containerView.layer.cornerRadius = kCBWAlertViewCornerRadius;
        self.containerView.layer.masksToBounds = YES;
    }
    
    
    
    self.containerView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.containerView];
}
- (void)addSubViewToView:(UIScrollView *)container{
 
    container.contentSize = CGSizeMake(container.bounds.size.width * 2, 0);
    //自己定义
    UITableView *tableView = [[UITableView alloc]initWithFrame:container.bounds style:UITableViewStyleGrouped];
    tableView.tag = 1;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = randomColor;
    [container addSubview:tableView];
    
    
    CGRect frame = CGRectMake(container.bounds.size.width * 1, 0, container.bounds.size.width, container.bounds.size.height);
    UITableView *tableView1 = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.tag = 2;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.backgroundColor = randomColor;
    [container addSubview:tableView1];
 
}

#pragma mark - show && dismiss
- (void)show{
    
    [self creatContainerView];
    [self addSubViewToView:self.containerView];
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         //设置尺寸
                         self.containerView.frame = endFrame;
                         
                     }
                     completion:nil
     ];

}
- (void)dismiss{
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         
                         self.alpha = 0.0;
                         self.containerView.frame = starFrame;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];

}
#pragma mark - datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if (tableView.tag == 2) {
        cell.textLabel.text = @"2222";
    }else{
         cell.textLabel.text = @"111";
    }
    
    return cell;
}
#pragma mark - delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd=====%zd",indexPath.row,tableView.tag);
}
@end
