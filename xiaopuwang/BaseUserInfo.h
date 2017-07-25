//
//  BaseUserInfo.h
//  Kuaizhi
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#define OBJC_STRINGIFY(x) @#x
#define encodeObject(x) [aCoder encodeObject:self.x forKey:OBJC_STRINGIFY(x)]
#define decodeObject(x) self.x = [aDecoder decodeObjectForKey:OBJC_STRINGIFY(x)]
@interface BaseUserInfo : NSObject<NSCoding>
- (void)synchronize;

- (void)setWithDict:(NSDictionary *)dict;
@end
