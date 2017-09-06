//
//  InnerLabel.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/5.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InnerLabel.h"

@implementation InnerLabel
- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}
@end
