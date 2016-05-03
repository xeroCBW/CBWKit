# CBWKit

this is a daliy tool labrary.

####Index

1.AlertView

2.InfiniteScrollview

3.ProgressLineView

####How to use?



use the CBWAlertView

```
 CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"title" andMessage:@"message..."];
    
    view.titleTextColor = [UIColor redColor];
    view.messageTextColor = [UIColor greenColor];
    
    [view addButtonWithTitle:@"cancel" color:[UIColor lightGrayColor] handler:^(CBWAlertView *alertView) {
        NSLog(@"cancelAction");
        NSLog(@"%@",alertView);
    }];
    
    UIColor *color = [UIColor colorWithRed:0 green:118.0/255.0 blue:255.0/255.0 alpha:1.0];
    [view addButtonWithTitle:@"yes" color:color handler:^(CBWAlertView *alertView) {
        NSLog(@"yes");
        NSLog(@"%@",alertView);
    }];
    
    [view show];

```

another alertView animation effect

```
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

```




use the InfiniteScrollview

```
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

```

```
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
```
use the progressView

```
 //设置进度条
    CGRect frame = CGRectMake(0, 20, 200, 40);
    CBWProgressView *progressView = [[CBWProgressView alloc]initWithFrame:frame];
    
    progressView.backgroundColor = [UIColor greenColor];
    progressView.progressViewColor = [UIColor redColor];
    progressView.progress = 0.8;
    
    [self.view addSubview:progressView];
```