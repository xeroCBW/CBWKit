//
//  NSString+CBWReplaceStr.m
//  CBWKit
//
//  Created by 陈博文 on 16/5/11.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import "NSString+CBWReplaceStr.h"

@implementation NSString (CBWReplaceStr)
- (NSString *)replaceUrl{
    NSString *str = self;
    
    str = [NSString stringWithFormat:@"909000==%@",str];
    
    return str;
}

- (NSString *)replaceUrlWith:(NSString *)str{
    
    
    if ([str hasPrefix:@"http://htest.qianduan.com"]) {
        //        str = [str stringByReplacingOccurrencesOfString:@"http://htest.qianduan.com" withString:[UCSInfo shareInfo].TMobileDomain];
        
    }
    
    return str;
}

#pragma mark - 判断字符串是否为空

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
