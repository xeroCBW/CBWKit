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
    
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"您还为和hi及覅Hi好是覅恢复ID还为和hi及覅Hi好是覅还为和hi及覅Hi好是覅还为和hi及覅Hi好是覅还为和hi及覅Hi好是覅您还为和hi及覅Hi好是覅恢复ID还为和hi及覅Hi好是覅还为和hi及覅Hi好是覅还为您还为和hi及覅Hi好是覅恢复ID还为和hi及覅Hi好是覅还为和hi及覅Hi好是覅还为您还为和hi及覅Hi好是覅恢复ID还为和hi及覅Hi好是覅还为和hi及覅Hi好是覅还为" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"---=-=-=--=-");
    }];
    
    [vc addAction:ok];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

@end
