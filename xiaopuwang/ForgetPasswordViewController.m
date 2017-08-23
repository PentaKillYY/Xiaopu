//
//  ForgetPasswordViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/23.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "MyService.h"
#import "UIButton+JKCountDown.h"
#import "UITextField+JKInputLimit.h"

@interface ForgetPasswordViewController ()
@property(nonatomic,weak)IBOutlet UITextField* usernameTextfield;
@property(nonatomic,weak)IBOutlet UITextField* validCodeTextfield;
@property(nonatomic,weak)IBOutlet UITextField* passwordTextField;

@property(nonatomic,weak)IBOutlet UIButton* registerButton;
@property(nonatomic,weak)IBOutlet UIButton* backToLogin;
@property(nonatomic,weak)IBOutlet UIButton* sendValid;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationItem.hidesBackButton = YES;
    
    
    [self.sendValid.layer setCornerRadius:3.0];
    [self.sendValid.layer setMasksToBounds:YES];
    
    [self.registerButton.layer  setCornerRadius:3.0];
    [self.registerButton.layer setMasksToBounds:YES];
    
    self.passwordTextField.jk_maxLength=12;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendValid:(id)sender{
    [self sendValidCodeRequest];
}

-(IBAction)resetPassword:(id)sender{
    [self checkValidCodeRequest];
}

-(IBAction)backToLogin:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendValidCodeRequest{
    if ([VerifyRegexTool validateMobile:self.usernameTextfield.text]) {
        [[MyService sharedMyService] sendValidCodeWithParameters:@{@"name":@"客户",@"mobile":self.usernameTextfield.text} onCompletion:^(id json) {
            [self.sendValid jk_startTime:59 title:@"发送验证码" waitTittle:@"已发送"];
        } onFailure:^(id json) {
            
        }];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:InvalidPhone];
    }
}

-(void)checkValidCodeRequest{
    if (self.validCodeTextfield.text.length) {
        [[MyService sharedMyService] checkValidCodeWithParameters:@{@"validateval":self.usernameTextfield.text,@"validateno":self.validCodeTextfield.text} onCompletion:^(id json) {
            [self resetPasswordRequest];
            
        } onFailure:^(id json) {
            
        }];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyValid];
    }
}

-(void)resetPasswordRequest{
    if (self.passwordTextField.text.length >5) {
        [[MyService sharedMyService] resetPasswordWithParameters:@{@"loginName":self.usernameTextfield.text,@"password":self.passwordTextField.text} onCompletion:^(id json) {
            [self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(id json) {
            
        }];
    }else{
        if (self.passwordTextField.text.length == 0) {
            [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyPassword];
        }else if (self.passwordTextField.text.length <6){
            [[AppCustomHud sharedEKZCustomHud] showTextHud:PasswordMinLenth];
        }
    }
}
@end
