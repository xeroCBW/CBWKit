//
//  NSString+CBWReplaceStr.h
//  CBWKit
//
//  Created by 陈博文 on 16/5/11.
//  Copyright © 2016年 陈博文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CBWReplaceStr)
- (NSString *)replaceUrl;
- (NSString *)replaceUrlWith:(NSString *)str;
@end
