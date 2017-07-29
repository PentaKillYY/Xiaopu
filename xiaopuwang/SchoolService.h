//
//  SchoolService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolService : NSObject
+ (instancetype)sharedSchoolService;

//学校搜索页-分页查询
- (void)getSchoolListWithPage:(NSInteger)page
                         Size:(NSInteger)size
                   Parameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;
@end
