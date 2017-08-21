//
//  MyEvaluateTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyEvaluateTableViewCell.h"

@implementation MyEvaluateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.orgName.text = [item getString:@"OrganizationName"];
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
    self.orgDistance.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Area"],[item getString:@"City"],[item getString:@"Field"]];
    self.orgChineseName.text = [item getString:@"ChineseName"];
    self.orgContent.preferredMaxLayoutWidth =Main_Screen_Width-74;
    self.orgContent.numberOfLines = 0;
    self.orgContent.text = [item getString:@"TeachCourses"];
    self.appointState.textColor = SPECIALISTNAVCOLOR;
    self.appointState.text = [item getString:@"EvaluateStatus"];
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"$%.2f",[item getDouble:@"OriginalPrice"]] attributes:attribtDic];
    
    self.originPrice.attributedText = attribtStr;
    
    self.realPrice.text = [NSString stringWithFormat:@"$%.2f",[item getDouble:@"TotalPrice"]];
    self.studentName.text = [NSString stringWithFormat:@"学生姓名:%@",[item getString:@"StudentName"]];
    self.orderID.text = [NSString stringWithFormat:@"订单编号:%@",[item getString:@"OrderNum"]];
    
    
    
    [self.dealOrderButton.layer setCornerRadius:3.0];
    [self.dealOrderButton.layer setBorderColor:MAINCOLOR.CGColor];
    [self.dealOrderButton.layer setBorderWidth:0.5];
    [self.dealOrderButton.layer setMasksToBounds:YES];
    [self.dealOrderButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    
    if ([item getInt:@"PayType"] == 1) {
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f(线上支付)",[item getDouble:@"TotalPrice"]];
     }else{
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f(线下支付)",[item getDouble:@"TotalPrice"]];
    }
    
    if ([item getInt:@"IsShare"] == 1) {
        [self.cancelOrderButton.layer setCornerRadius:3.0];
        [self.cancelOrderButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.cancelOrderButton.layer setBorderWidth:0.5];
        [self.cancelOrderButton.layer setMasksToBounds:YES];
        [self.cancelOrderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    }else{
        [self.cancelOrderButton setTitle:@"  分享抽学费  " forState:UIControlStateNormal];
        [self.cancelOrderButton.layer setCornerRadius:3.0];
        [self.cancelOrderButton.layer setBorderColor:MAINCOLOR.CGColor];
        [self.cancelOrderButton.layer setBorderWidth:0.5];
        [self.cancelOrderButton.layer setMasksToBounds:YES];
        [self.cancelOrderButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
}

-(IBAction)cancelAction:(id)sender{
    [self.delegate cancelEvaluateDelegate:sender];
}

-(IBAction)dealAction:(id)sender{
    [self.delegate evaluateDelegate:sender];
}
@end
