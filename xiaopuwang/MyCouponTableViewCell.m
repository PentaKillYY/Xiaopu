//
//  MyCouponTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyCouponTableViewCell.h"

@implementation MyCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)couponDetailAction:(id)sender{
    
    UIButton* button = (UIButton*)sender;
    button.selected = !button.selected;
    
    if (button.selected) {
        [UIView animateWithDuration:0.3f animations:^{
            self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
           
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            //        复原
            self.arrowImage.transform =  CGAffineTransformMakeRotation(2*M_PI);

        } completion:^(BOOL finished) {
            
        }];
    }
    
     [self.delegate changeDetailShowDelegate:sender];
}

-(void)bingdingViewModel:(DataItem*)item{
    self.couponBackImage.layer.shadowColor = [UIColor blackColor].CGColor;
    self.couponBackImage.layer.shadowOpacity = 0.8f;
    self.couponBackImage.layer.shadowRadius = 2.f;
    self.couponBackImage.layer.shadowOffset = CGSizeMake(0,1);

    self.couponNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"Price"]];
    self.couponBackImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Coupon-%d.png",[[item getString:@"CouponType"] intValue]]];
    NSString *string1 = [item getString:@"OverdueTime"];
    NSString *string2 = @" ";
    NSRange range = [string1 rangeOfString:string2];
    self.couponTime.text = [string1 substringToIndex:range.location];
    if([[item getString:@"CouponType"] intValue]==1 || [[item getString:@"CouponType"] intValue]==8){
        self.couponTime.textColor = [UIColor blackColor];
        self.couponNumber.textColor = [UIColor blackColor];
        self.couponDesc.textColor = [UIColor blackColor];
        self.couponName.textColor = [UIColor blackColor];
        self.couponTime.textColor = [UIColor blackColor];
        self.couponNuit.textColor = [UIColor blackColor];
        [self.couponDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.arrowImage setImage:V_IMAGE(@"黑箭头")];
        Dashline *verticalDashLine = [[Dashline alloc] initWithFrame:CGRectMake(100, 23.5, 0.5, 50) withLineLength:6 withLineSpacing:3 withLineColor:[UIColor blackColor]];
        [self.bgView addSubview:verticalDashLine];
    }else{
        self.couponTime.textColor = [UIColor whiteColor];
        self.couponNumber.textColor = [UIColor whiteColor];
        self.couponDesc.textColor = [UIColor whiteColor];
        self.couponName.textColor = [UIColor whiteColor];
        self.couponTime.textColor = [UIColor whiteColor];
        self.couponNuit.textColor = [UIColor whiteColor];
        [self.couponDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.arrowImage setImage:V_IMAGE(@"箭头")];
        Dashline *verticalDashLine = [[Dashline alloc] initWithFrame:CGRectMake(100, 23.5, 0.5, 50) withLineLength:6 withLineSpacing:3 withLineColor:[UIColor whiteColor]];
        [self.bgView addSubview:verticalDashLine];
    }
}

@end
