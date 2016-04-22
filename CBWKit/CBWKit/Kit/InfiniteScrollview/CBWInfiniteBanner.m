//
//  CBWInfiniteBanner.m
//  CBWKit
//
//  Created by 陈博文 on 16/4/21.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWInfiniteBanner.h"
#import <UIImageView+WebCache.h>

@interface CBWInfiniteBanner ()<UIScrollViewDelegate>
/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** pageControl */
@property (nonatomic, weak) UIPageControl *pageControl;
/** timer */
@property (nonatomic, weak) NSTimer *timer;
/** 记录当前选中的图片 index*/
@property (nonatomic ,assign) NSUInteger index;
@end
@implementation CBWInfiniteBanner
/** imageView的数量 */
static NSUInteger const CBWImageViewCount = 3;

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // scrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor redColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 3个UIImageView
        for (NSUInteger i = 0; i < CBWImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            
            [scrollView addSubview:imageView];
        }
        
        // pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor blueColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 开启定时器
        [self startTimer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // scrollView
    self.scrollView.frame = self.bounds;
    
    // pageControl
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 30;
    CGFloat pageControlX = self.bounds.size.width - pageControlW;
    CGFloat pageControlY = self.bounds.size.height - pageControlH;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    // 3个UIImageView
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    for (NSUInteger i = 0; i < CBWImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat imageX = i * imageW;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    }
    self.scrollView.contentSize = CGSizeMake(CBWImageViewCount * imageW, 0);
    
    // 更新UIImageView内容
    [self updateContent];
}

#pragma mark - 属性setter
- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    // 设置总页码
    self.pageControl.numberOfPages = imageNames.count;
}
-(void)setImageURLs:(NSArray *)imageURLs{
    _imageURLs = imageURLs;
    self.pageControl.numberOfPages = imageURLs.count;
}
#pragma mark - 其他方法
/**
 * 1.从左到右重新设置每一个UIImageView的图片
 * 2.重置UIScrollView的contentOffset.width == 1倍宽度
 */
- (void)updateContent
{
    // 1.从左到右重新设置每一个UIImageView的图片
    for (NSUInteger i = 0; i < CBWImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // 求出i位置imageView对应的图片索引
        NSInteger imageIndex = 0; // 这里的imageIndex不能用NSUInteger
        if (i == 0) { // 当前页码 - 1
            imageIndex = self.pageControl.currentPage - 1;
        } else if (i == 2) { // 当前页码 + 1
            imageIndex = self.pageControl.currentPage + 1;
        } else { // // 当前页码
            imageIndex = self.pageControl.currentPage;
        }
        
        // 判断越界
        if (imageIndex == -1) { // 最后一张图片
            imageIndex = self.imageURLs.count - 1;
        } else if (imageIndex == self.imageURLs.count) { // 最前面那张
            imageIndex = 0;
        }
        
        //判断图片的类型,然后对图片进行赋值
        NSURL *url = [NSURL URLWithString:self.imageURLs[imageIndex]];
        UIImage *placeHold = [UIImage imageNamed:@"placeholder"];
        [imageView sd_setImageWithURL:url placeholderImage:placeHold];
        
        // 绑定图片索引到UIImageView的tag
        imageView.tag = imageIndex;
        
        //给中间图片添加 tap 手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        if (i == 1 ) {
            self.index = imageView.tag;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
        }


    }
    
    // 2.重置UIScrollView的contentOffset.width == 1倍宽度
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}


- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"===%ld===",self.index);
    if (self.block) {
        self.block(self.index);
    }
}

#pragma mark - <UIScrollViewDelegate>
/**
 * 只要scrollView滚动，就会调用这个方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // imageView的x 和 scrollView偏移量x 的最小差值
    CGFloat minDelta = MAXFLOAT;
    
    // 找出显示在最中间的图片索引
    NSInteger centerImageIndex = 0;
    
    for (NSUInteger i = 0; i < CBWImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // ABS : 取得绝对值
        CGFloat delta = ABS(imageView.frame.origin.x - self.scrollView.contentOffset.x);
        if (delta < minDelta) {
            minDelta = delta;
            centerImageIndex = imageView.tag;
        }
    }
    
    // 设置页码
    self.pageControl.currentPage = centerImageIndex;
}

/**
 * 滚动完毕后调用（前提：手松开后继续滚动）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}

/**
 * 当用户即将开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 * 当用户即将结束拖拽的时候调用
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self startTimer];
}

#pragma mark - 定时器处理
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(2 * self.scrollView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self updateContent];
    }];
}

@end
