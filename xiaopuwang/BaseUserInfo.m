//
//  BaseUserInfo.m
//  Kuaizhi
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseUserInfo.h"

@implementation BaseUserInfo
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
}

/**
 *  保存Model
 */

- (void)synchronize{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:self];
    [defaults setObject:data forKey:NSStringFromClass(self.class)];
    [defaults synchronize];
}
/**
 *  设置Model
 *
 *  @param dict 数据
 */


- (void)setWithDict:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setValue:obj forKey:key];
    }];
}

@end
