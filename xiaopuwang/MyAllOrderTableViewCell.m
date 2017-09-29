//
//  MyAllOrderTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyAllOrderTableViewCell.h"

@implementation MyAllOrderTableViewCell

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
    
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"￥%.2f",[item getDouble:@"OriginalPrice"]] attributes:attribtDic];
    
    self.originPrice.attributedText = attribtStr;
    
    self.realPrice.text = [NSString stringWithFormat:@"￥%.2f",[item getDouble:@"TotalPrice"]];
    self.studentName.text = [NSString stringWithFormat:@"学生姓名:%@",[item getString:@"StudentName"]];
    self.orderID.text = [NSString stringWithFormat:@"订单编号:%@",[item getString:@"OrderNum"]];
    
    
   
    
    
    if ([item getInt:@"PayType"] == 1) {
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f(线上支付)",[item getDouble:@"TotalPrice"]];
    }else{
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f(线下支付)",[item getDouble:@"TotalPrice"]];
    }
    
    if ([[item getString:@"TradeStatus1"] isEqualToString:@"已支付"]) {
        //已支付已评价
        self.appointState.text = [item getString:@"EvaluateStatus"];
        [self.deleteOrderButton.layer setCornerRadius:3.0];
        [self.deleteOrderButton.layer setBorderColor:MAINCOLOR.CGColor];
        [self.deleteOrderButton.layer setBorderWidth:0.5];
        [self.deleteOrderButton.layer setMasksToBounds:YES];
        [self.deleteOrderButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [self.deleteOrderButton setTitle:@"  分享抽学费  " forState:UIControlStateNormal];
    }else{
        //已取消未评价
        self.appointState.text = [item getString:@"TradeStatus1"];
        [self.deleteOrderButton.layer setCornerRadius:3.0];
        [self.deleteOrderButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.deleteOrderButton.layer setBorderWidth:0.5];
        [self.deleteOrderButton.layer setMasksToBounds:YES];
        [self.deleteOrderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.deleteOrderButton setTitle:@"  删除订单  " forState:UIControlStateNormal];
    }
}

-(IBAction)deleteButtonAction:(id)sender{
    [self.delegate deleteOrShareOrderDelegate:sender];
}
@end
