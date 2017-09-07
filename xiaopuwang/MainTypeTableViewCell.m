//
//  MainTypeTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/5.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainTypeTableViewCell.h"

@implementation MainTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupUI{
    UserInfo* info = [UserInfo sharedUserInfo];

    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    
    if ([info.firstSelectIndex intValue] == 1) {
        NSString* keyString = @"org_9";
        NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
        
        for (int i = 120; i< 120+array.count; i++) {
            UIButton* button = [self.contentView viewWithTag:i];
            
            [button setImage:[UIImage imageNamed:[array[i-120] objectForKey:@"imgUrl"]] forState:0];
            [button.imageView.image setAccessibilityIdentifier:[array[i-120] objectForKey:@"imgUrl"]];

            button.hidden = NO;
        }
        
        
        for (int i =130;  i< 130+array.count; i++) {
            UILabel* label = [self.contentView viewWithTag:i];
            label.text = [array[i-130] objectForKey:@"txt"];
            label.hidden = NO;
        }
        
        for (NSInteger i = 120+array.count; i<130; i++) {
            UIButton* button = [self.contentView viewWithTag:i];
            button.hidden = YES;
        }
        
        for (NSInteger i = 130+array.count; i<140; i++) {
            UILabel* label = [self.contentView viewWithTag:i];
            
            label.hidden = YES;
        }
    }else if ([info.firstSelectIndex intValue] == 2){
        NSString* keyString = @"org_10";
        NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
        
        for (int i = 120; i< 120+array.count; i++) {
            UIButton* button = [self.contentView viewWithTag:i];
            
            [button setImage:[UIImage imageNamed:[array[i-120] objectForKey:@"imgUrl"]] forState:0];
            [button.imageView.image setAccessibilityIdentifier:[array[i-120] objectForKey:@"imgUrl"]];

            button.hidden = NO;
        }
        
        
        for (int i =130;  i< 130+array.count; i++) {
            UILabel* label = [self.contentView viewWithTag:i];
            label.text = [array[i-130] objectForKey:@"txt"];
            label.hidden = NO;
        }
        
        for (NSInteger i = 120+array.count; i<130; i++) {
            UIButton* button = [self.contentView viewWithTag:i];
            button.hidden = YES;
        }
        
        for (NSInteger i = 130+array.count; i<140; i++) {
            UILabel* label = [self.contentView viewWithTag:i];
            
            label.hidden = YES;
        }
    }else{
        
        NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
        NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
        
        for (int i = 120; i< 120+array.count; i++) {
            UIButton* button = [self.contentView viewWithTag:i];
            
            [button setImage:[UIImage imageNamed:[array[i-120] objectForKey:@"imgUrl"]] forState:0];
            [button.imageView.image setAccessibilityIdentifier:[array[i-120] objectForKey:@"imgUrl"]];

            button.hidden = NO;
        }
        
        
        for (int i =130;  i< 130+array.count; i++) {
            UILabel* label = [self.contentView viewWithTag:i];
            label.text = [array[i-130] objectForKey:@"txt"];
            label.hidden = NO;
        }
        
        for (NSInteger i = 120+array.count; i<130; i++) {
            UIButton* button = [self.contentView viewWithTag:i];
            button.hidden = YES;
        }
        
        for (NSInteger i = 130+array.count; i<140; i++) {
            UILabel* label = [self.contentView viewWithTag:i];

            label.hidden = YES;
        }
        
    }
}

-(IBAction)clickTypeAction:(id)sender{
    [self.delegate selectMainTypeDelegate:sender];
}
@end
