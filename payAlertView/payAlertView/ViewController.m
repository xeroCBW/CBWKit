//
//  ViewController.m
//  payAlertView
//
//  Created by 陈博文 on 16/4/26.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import "CBWPayView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (IBAction)buttonClick:(id)sender {
    
    CBWPayView *view = [[CBWPayView alloc]init];
    view.didSelectedAction = ^(NSInteger index,NSInteger tag,CBWPayView *view){
        
        [view dismiss];
        NSLog(@"----------");
        
        
        //延迟一会
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIViewController *vc = [[UIViewController alloc]init];
            vc.view.frame = [UIScreen mainScreen].bounds;
            vc.view.backgroundColor = [UIColor greenColor];
            
            [self presentViewController:vc animated:YES completion:nil];
        });
        
        
    };
    [view show];
}



@end
