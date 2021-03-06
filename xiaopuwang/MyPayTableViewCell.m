//
//  MyPayTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyPayTableViewCell.h"

@implementation MyPayTableViewCell

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
    self.orgChineseName.text = [item getString:@"Subject"];
    self.orgContent.preferredMaxLayoutWidth =Main_Screen_Width-74;
    self.orgContent.numberOfLines = 0;
    self.orgContent.text = [item getString:@"TeachCourses"];
    self.appointState.textColor = SPECIALISTNAVCOLOR;
    self.appointState.text = [item getString:@"TradeStatus1"];
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"￥%.2f",[item getDouble:@"OriginalPrice"]] attributes:attribtDic];
    
    self.originPrice.attributedText = attribtStr;
    
    self.realPrice.text = [NSString stringWithFormat:@"￥%.2f",[item getDouble:@"TotalPrice"]];
    self.studentName.text = [NSString stringWithFormat:@"学生姓名:%@",[item getString:@"StudentName"]];
    self.orderID.text = [NSString stringWithFormat:@"订单编号:%@",[item getString:@"OrderNum"]];
    
    [self.cancelOrderButton.layer setCornerRadius:3.0];
    [self.cancelOrderButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cancelOrderButton.layer setBorderWidth:0.5];
    [self.cancelOrderButton.layer setMasksToBounds:YES];
    [self.cancelOrderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
    [self.dealOrderButton.layer setCornerRadius:3.0];
    [self.dealOrderButton.layer setBorderColor:MAINCOLOR.CGColor];
    [self.dealOrderButton.layer setBorderWidth:0.5];
    [self.dealOrderButton.layer setMasksToBounds:YES];
    [self.dealOrderButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];

    
    if ([item getInt:@"PayType"] == 1) {
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f(线上支付)",[item getDouble:@"TotalPrice"]];
        self.cancelOrderButton.hidden = NO;
        [self.cancelOrderButton setTitle:@"  取消订单  " forState:UIControlStateNormal];
        [self.dealOrderButton setTitle:@"  立即付款  " forState:UIControlStateNormal];
        self.dealOrderButton.userInteractionEnabled = YES;
        
    }else{
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f(线下支付)",[item getDouble:@"TotalPrice"]];
        self.cancelOrderButton.hidden = YES;
        [self.dealOrderButton setTitle:@"  等待审核  " forState:UIControlStateNormal];
        self.dealOrderButton.userInteractionEnabled = NO;
    }
    
}


-(IBAction)cancelOrderAction:(id)sender{
    [self.delegate cancelDelegate:sender];
}

-(IBAction)PayOrderAction:(id)sender{
    [self.delegate payDelegate:sender];
}
@end
