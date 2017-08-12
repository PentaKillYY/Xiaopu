//
//  MyChangePasswordViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyChangePasswordViewController.h"
#import "BZGFormField.h"
#import "MyService.h"
@interface MyChangePasswordViewController ()<BZGFormFieldDelegate>
@property(nonatomic,weak)IBOutlet BZGFormField* originPassordField;
@property(nonatomic,weak)IBOutlet BZGFormField* passwordField;
@property(nonatomic,weak)IBOutlet BZGFormField* validatePasswordField;
@property(nonatomic,weak)IBOutlet UIButton* changePasswordButton;
@end

@implementation MyChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    
    _originPassordField.textField.placeholder = @"初始密码";
    _originPassordField.textField.font = [UIFont systemFontOfSize:13.0];
    _originPassordField.delegate = self;
    _passwordField.textField.placeholder = @"新密码";
    _passwordField.textField.font = [UIFont systemFontOfSize:13.0];
    _passwordField.delegate = self;
    _validatePasswordField.textField.placeholder = @"确认新密码";
    _validatePasswordField.textField.font = [UIFont systemFontOfSize:13.0];
    _validatePasswordField.delegate = self;
    _changePasswordButton.backgroundColor = MAINCOLOR;
    [_changePasswordButton.layer setCornerRadius:3.0];
    [_changePasswordButton.layer setMasksToBounds:YES];
    
    [self validatePasswordSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)validatePasswordSetting{
    [self.originPassordField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        if ([text isEqualToString:[UserInfo sharedUserInfo].password] ) {
            return YES;
        }else{
            return NO;
        }
        
    }];
    
    [self.passwordField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        return (text.length <= 15 && text.length >= 6);
    }];
    
    [self.validatePasswordField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        if ([text isEqualToString:self.passwordField.textField.text] ) {
            return YES;
        }else{
            return NO;
        }
        
    }];
}

#pragma mark - NetwordRequest
-(void)changePasswordRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    if (self.originPassordField.formFieldState ==1 && self.passwordField.formFieldState == 1 && self.validatePasswordField.formFieldState == 1) {
        [[MyService sharedMyService] changePasswordWithParameters:@{@"loginName":info.telphone,@"password":self.passwordField.textField.text} onCompletion:^(id json) {
            [self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(id json) {
            
        }];
    }else if (self.originPassordField.formFieldState !=1){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:OriginPasswordInvalid];
    }else if (self.passwordField.formFieldState != 1){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:ChangePasswordInvalid];
    }else if (self.validatePasswordField.formFieldState != 1){
    
        [[AppCustomHud sharedEKZCustomHud] showTextHud:ValidPasswordInvalid];
    }
    
    
}
@end
