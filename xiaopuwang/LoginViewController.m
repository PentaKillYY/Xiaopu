//
//  LoginViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "LoginViewController.h"
#import "MainService.h"
#import "MyService.h"
#import "UITextField+JKInputLimit.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)IBOutlet UIButton* loginButton;
@property(nonatomic,weak)IBOutlet UITextField* userNameTextField;
@property(nonatomic,weak)IBOutlet UITextField* passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.loginButton.layer setCornerRadius:3.0];
    [self.loginButton.layer setMasksToBounds:YES];
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.passwordTextField.jk_maxLength=12;
    
    UIBarButtonItem* leftitem = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [leftitem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:19],NSFontAttributeName, nil] forState:UIControlStateNormal];

    [leftitem setTintColor:MAINCOLOR];
    
    self.navigationItem.leftBarButtonItem = leftitem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginAction:(id)sender{
   BOOL telReg= [VerifyRegexTool validateMobile:self.userNameTextField.text];
    if (!telReg) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:InvalidPhone];
    }else if (self.passwordTextField.text.length <6){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:PasswordMinLenth];
    }else{
        [self loginRequest];
    }
}

-(IBAction)registerAction:(id)sender{
    [self performSegueWithIdentifier:@"LoginToRegister" sender:self];
}

-(IBAction)forgetPasswordAction:(id)sender{
    [self performSegueWithIdentifier:@"LoginToForgetPassword" sender:self];
}

-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)loginRequest{
    [[MainService sharedMainService] loginWithParameters:@{@"loginName":self.userNameTextField.text,@"password":self.passwordTextField.text} onCompletion:^(id json) {
        
        [self getUserBasicInfoRequest];
    } onFailure:^(id json) {
       
    }];
}

-(void)getUserBasicInfoRequest{
    [[MyService sharedMyService] getUserBasicInfoWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        [self getUserOnlyRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)getUserOnlyRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[MyService sharedMyService] getUserOnlyWithParameters:@{@"userId":info.userID} onCompletion:^(id json) {
        
        
        [self tokenRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)tokenRequest{
    [[MyService sharedMyService] getTokenWithParameters:@{@"appKey":RONGCLOUDDISKEY,@"appSecret":RONGCLOUDDISSECRET,@"userId":[UserInfo sharedUserInfo].userID,@"name":[UserInfo sharedUserInfo].telphone} onCompletion:^(id json) {
        [self uptdateTokenRequest];
        
        
        
    } onFailure:^(id json) {
        
    }];
}

-(void)uptdateTokenRequest{
    [[MyService sharedMyService] updateUserTokenWithParameters:@{@"token":[UserInfo sharedUserInfo].token} onCompletion:^(id json) {
        [self rongcloudConnect];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } onFailure:^(id json) {
        
    }];
}

#pragma mark RongCloudConnect
-(void)rongcloudConnect{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[RCIM sharedRCIM] connectWithToken:info.token  success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

@end
