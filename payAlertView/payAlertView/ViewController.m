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
    
    [view show];
}



@end
