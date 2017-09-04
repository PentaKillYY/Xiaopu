//
//  CouponGiveViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CouponGiveViewController.h"
#import "Dashline.h"
#import "MyService.h"
@interface CouponGiveViewController ()
{
    DataResult* userResult;
}
@property(nonatomic,weak)IBOutlet UILabel* couponNumber;
@property(nonatomic,weak)IBOutlet UILabel* couponNuit;
@property(nonatomic,weak)IBOutlet UILabel* couponDesc;
@property(nonatomic,weak)IBOutlet UILabel* couponName;
@property(nonatomic,weak)IBOutlet UILabel* couponTime;
@property(nonatomic,weak)IBOutlet UIImageView* couponBackImage;
@property(nonatomic,weak)IBOutlet UIView* bgView;
@property(nonatomic,weak)IBOutlet UIButton* giveButton;
@property(nonatomic,weak)IBOutlet UITextField* givetextField;

@end

@implementation CouponGiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"赠送好友";
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:nil];
    
    self.navigationController.navigationBar.barTintColor = SPECIALISTNAVCOLOR;
    
    [self.giveButton.layer setCornerRadius:3.0];
    [self.giveButton.layer setMasksToBounds:YES];
    [self.giveButton setBackgroundColor:SPECIALISTNAVCOLOR];
    [self.giveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self setupCouponView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupCouponView{
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.8f;
    self.bgView.layer.shadowRadius = 2.f;
    self.bgView.layer.shadowOffset = CGSizeMake(0,1);
    
    self.couponNumber.text = [NSString stringWithFormat:@"%d",[self.couponItem getInt:@"Price"]];
    self.couponBackImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Coupon-%d.png",[[self.couponItem getString:@"CouponType"] intValue]]];
    NSString *string1 = [self.couponItem getString:@"OverdueTime"];
    NSString *string2 = @" ";
    NSRange range = [string1 rangeOfString:string2];
    self.couponTime.text = [string1 substringToIndex:range.location];
    
    if([[self.couponItem getString:@"CouponType"] intValue]==1 || [[self.couponItem getString:@"CouponType"] intValue]==8){
        self.couponTime.textColor = [UIColor blackColor];
        self.couponNumber.textColor = [UIColor blackColor];
        self.couponDesc.textColor = [UIColor blackColor];
        self.couponName.textColor = [UIColor blackColor];
        self.couponTime.textColor = [UIColor blackColor];
        self.couponNuit.textColor = [UIColor blackColor];
        Dashline *verticalDashLine = [[Dashline alloc] initWithFrame:CGRectMake(100, 23.5, 0.5, 50) withLineLength:6 withLineSpacing:3 withLineColor:[UIColor blackColor]];
        [self.couponBackImage addSubview:verticalDashLine];
    }else{
        self.couponTime.textColor = [UIColor whiteColor];
        self.couponNumber.textColor = [UIColor whiteColor];
        self.couponDesc.textColor = [UIColor whiteColor];
        self.couponName.textColor = [UIColor whiteColor];
        self.couponTime.textColor = [UIColor whiteColor];
        self.couponNuit.textColor = [UIColor whiteColor];
        Dashline *verticalDashLine = [[Dashline alloc] initWithFrame:CGRectMake(100, 23.5, 0.5, 50) withLineLength:6 withLineSpacing:3 withLineColor:[UIColor whiteColor]];
        [self.couponBackImage addSubview:verticalDashLine];
    }
}

-(IBAction)giveToAnotherAction:(id)sender{
    [self searchUserIdRequest];
}

#pragma mark - NetwordRequest
-(void)giveCouponRequest{
    [[MyService sharedMyService] giveCouponWithParameters:@{@"id":[self.couponItem getString:@"Id"],@"giveUserId":[userResult.detailinfo getString:@"User_ID"]} onCompletion:^(id json) {
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}

-(void)searchUserIdRequest{
    BOOL isPhone= [VerifyRegexTool validateMobile:self.givetextField.text];
    if (isPhone) {
        [[MyService sharedMyService] searchUserByPhoneWithParameters:@{@"phone":self.givetextField.text} onCompletion:^(id json) {
            
            userResult = json;
            [self giveCouponRequest];
            
        } onFailure:^(id json) {
            [[AppCustomHud sharedEKZCustomHud] showTextHud:InvalidUser];
        }];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:InvalidPhone];
    }
}
@end
