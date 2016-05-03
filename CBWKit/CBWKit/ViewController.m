//
//  ViewController.m
//  CBWKit
//
//  Created by 陈博文 on 16/4/21.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CBWFrame.h"
#import "CBWInfiniteBanner.h"
#import "CBWProgressView.h"
#import "UIColor+CBWColor.h"
#import "CBWCenterView.h"
#import "CBWTestVC.h"
#import "CBWAlertView.h"


@interface ViewController ()

/** 图片数组*/
@property (nonatomic ,strong) NSMutableArray *array;

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
    
    //图片轮播
    CBWInfiniteBanner *banner = [[CBWInfiniteBanner alloc]init];
    banner.x = 0;
    banner.y = 300;
    banner.width = [UIScreen mainScreen].bounds.size.width;
    banner.height = 150;

    banner.imageURLs = self.array;
    
  __weak typeof(self) weakself = self;
    
    banner.block = ^(NSUInteger index){
        
        NSLog(@"%@",weakself.array[index]);
        
    };
    
    [self.view addSubview:banner];
    
    
    //设置进度条
    CGRect frame = CGRectMake(0, 20, 200, 40);
    CBWProgressView *progressView = [[CBWProgressView alloc]initWithFrame:frame];
    
    progressView.backgroundColor = [UIColor greenColor];
    progressView.progressViewColor = [UIColor redColor];
    progressView.progress = 0.8;
    
    [self.view addSubview:progressView];
    
    CBWLog(NSDocumentDirectory)
    
}
- (IBAction)buttonclick:(id)sender {
    
    //显示提示框
    CBWCenterView *alertView = [[CBWCenterView alloc]init];
    alertView.buttonTitles = @[@"取消",@"退出企业"];
    
    alertView.title = @"退出该企业";
    alertView.message = @"可以更具 index 来设置所需要的操作可以更";
    
    alertView.buttonClickActionBlock = ^(CBWCenterView *alertView,NSUInteger index){
        NSLog(@"%zd",index);
        
        //可以更具 index 来设置所需要的操作
        
        if (index == 0) {
            //蓝色的,要做操作
            CBWTestVC *vc = [[CBWTestVC alloc]init];
            vc.view.backgroundColor = [UIColor redColor];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else{
            //灰色不操作
        }
        //不使用延迟也看不出来
    };
    [alertView show];

}

//上层的 touchBegin 不能响应,下面的就会响应,响应者链条

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消息消息消消息消息消息消息消消息消消息消息消消息消消息消我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消我的消" andMessage:@""];
    [view addButtonWithTitle:@"取消" color:[UIColor grayColor] handler:^(CBWAlertView *alertView) {
        NSLog(@"取消按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    [view addButtonWithTitle:@"确定" color:[UIColor blueColor] handler:^(CBWAlertView *alertView) {
        NSLog(@"确定按钮点击");
        NSLog(@"%@",alertView);
    }];
    
    [view show];

   
}

#pragma mark - setter && getter
- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray arrayWithArray:@[
                                                  @"http://imgnews.gmw.cn/attachement/jpg/site2/20160418/2657389265644373609.jpg",
                                                  @"http://y1.ifengimg.com/cmpp/2016/04/20/22/4f71c045-8e40-41cb-a80c-85a7ef0a93f4_size33_w550_h366.jpg",
                                                  @"http://photocdn.sohu.com/20160125/mp56380067_1453710497642_1_th.jpeg",
                                                  @"http://photocdn.sohu.com/20160125/mp56380067_1453710497642_3.jpeg",
                                                  
                                                  ]];
    }
    return _array;
}

@end
