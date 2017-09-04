//
//  MySpecialistTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MySpecialistTableViewCell.h"

@implementation MySpecialistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModelTypeName:(NSString*)type State:(NSInteger)state Time:(NSString*)time{
    
    self.spRemarks.text = [NSString stringWithFormat:@"预留信息:%@***%@",[[UserInfo sharedUserInfo].telphone substringToIndex:4],[[UserInfo sharedUserInfo].telphone substringWithRange:NSMakeRange([UserInfo sharedUserInfo].telphone.length-4, 4)]];
    self.spProjname.text = [NSString stringWithFormat:@"咨询项目:%@",type];
    self.spTime.text = [NSString stringWithFormat:@"咨询时间:%@", [time substringToIndex:10]];
    if (state == 0) {
        self.spState.text = @"待受理";
    }else{
        self.spState.text = @"已受理";
    }
    
    self.spState.textColor = SPECIALISTNAVCOLOR;
}
@end
