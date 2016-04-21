//
//  ViewController.m
//  CBWKit
//
//  Created by 陈博文 on 16/4/21.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CBWFrame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //frame 使用实例
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.x = 100;
    view.y = 100;
    view.width = 100;
    view.height = 100;
    [self.view addSubview:view];
    
    
}



@end
