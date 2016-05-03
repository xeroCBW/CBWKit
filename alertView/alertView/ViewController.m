//
//  ViewController.m
//  alertView
//
//  Created by 陈博文 on 16/4/29.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消息消息消消息消息消息消息消消息消消息消息消消息消消息消我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"---=-=-=--=-");
    }];
    [vc addAction:cancle];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"---=-=-=--=-");
    }];

    
    [vc addAction:ok];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

@end
