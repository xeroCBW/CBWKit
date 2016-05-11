//
//  CBWImageWithColor.m
//  CBWKit
//
//  Created by 陈博文 on 16/5/11.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "CBWImageWithColor.h"
#import <UIKit/UIKit.h>

@implementation CBWImageWithColor
//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
