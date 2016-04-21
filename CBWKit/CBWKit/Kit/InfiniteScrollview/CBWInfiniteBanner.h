//
//  CBWInfiniteBanner.h
//  CBWKit
//
//  Created by 陈博文 on 16/4/21.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBWInfiniteBanner : UIView
/** 本地图片名 */
@property (nonatomic, strong) NSArray *imageNames;
///** 远程图片URL */
@property (nonatomic, strong) NSArray *imageURLs;
///** 图片 */
//@property (nonatomic, strong) NSArray *images;

//点击事件的 block 或者 delegate

/** 点击事件的 block*/
@property (nonatomic ,copy) void(^block)(NSInteger index);
@end
