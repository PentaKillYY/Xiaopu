//
//  SecondSelectLevelViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SecondSelectLevelViewController.h"

@interface SecondSelectLevelViewController ()
@property(nonatomic,weak)IBOutlet UIButton* orgButton;
@property(nonatomic,weak)IBOutlet UIButton* oneButton;
@property(nonatomic,weak)IBOutlet UIButton* twoButton;
@property(nonatomic,weak)IBOutlet UIButton* threeButton;
@property(nonatomic,weak)IBOutlet UIButton* fourButton;
@property(nonatomic,weak)IBOutlet UIButton* fiveButton;
@property(nonatomic,weak)IBOutlet UIButton* sixButton;
@property(nonatomic,weak)IBOutlet UIButton* sevenButton;
@property(nonatomic,weak)IBOutlet UIButton* eightButton;
@end

@implementation SecondSelectLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.orgButton.titleLabel.numberOfLines = 2;
    [self.orgButton setTitle:@"培训\n机构" forState:0];
    self.orgButton.backgroundColor = SPECIALISTNAVCOLOR;
    [self.orgButton.layer setCornerRadius:45];
    
    self.oneButton.backgroundColor = LIGHTORANGE;
    [self.oneButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.twoButton.backgroundColor = LIGHTORANGE;
    [self.twoButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.threeButton.backgroundColor = LIGHTORANGE;
    [self.threeButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.fourButton.backgroundColor = LIGHTORANGE;
    [self.fourButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.fiveButton.backgroundColor = LIGHTORANGE;
    [self.fiveButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.sixButton.backgroundColor = LIGHTORANGE;
    [self.sixButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.sevenButton.backgroundColor = LIGHTORANGE;
    [self.sevenButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
    
    self.eightButton.backgroundColor = LIGHTORANGE;
    [self.eightButton.layer setCornerRadius:(Main_Screen_Width-16*5)/8];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backToFirstSelect:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)goToHome:(id)sender{
    UIButton* button = (UIButton*)sender;
    UserInfo* info =[UserInfo sharedUserInfo];
    info.secondSelectIndex = [NSString stringWithFormat:@"%d",button.tag];
    [info synchronize];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* mainTab = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTab"];
    AppDelegate*delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = mainTab;
}

@end
