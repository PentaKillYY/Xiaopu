//
//  FirstSelectLevelViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "FirstSelectLevelViewController.h"
#import "AppDelegate.h"
@interface FirstSelectLevelViewController ()
@property(nonatomic,weak)IBOutlet UIButton* orgButton;
@property(nonatomic,weak)IBOutlet UIButton* interButton;
@property(nonatomic,weak)IBOutlet UIButton* overseaButton;

@end

@implementation FirstSelectLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    self.orgButton.titleLabel.numberOfLines = 2;
    [self.orgButton setTitle:@"培训\n机构" forState:0];
    self.interButton.titleLabel.numberOfLines = 2;
    [self.interButton setTitle:@"国际\n学校" forState:0];
    self.overseaButton.titleLabel.numberOfLines = 2;
    [self.overseaButton setTitle:@"海外\n学校" forState:0];
    
    self.orgButton.backgroundColor = SPECIALISTNAVCOLOR;
    self.interButton.backgroundColor = SPECIALISTNAVCOLOR;
    self.overseaButton.backgroundColor = SPECIALISTNAVCOLOR;
    
    [self.orgButton.layer setCornerRadius:35];
    [self.interButton.layer setCornerRadius:35];
    [self.overseaButton.layer setCornerRadius:35];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goToSecondChoose:(id)sender{
    UIButton* button = (UIButton*)sender;
    UserInfo* info =[UserInfo sharedUserInfo];
    info.firstSelectIndex = [NSString stringWithFormat:@"%d",button.tag];
    [info synchronize];
    [self performSegueWithIdentifier:@"FirstSelectToSecond" sender:self];
}

-(IBAction)goToHome:(id)sender{
    UIButton* button = (UIButton*)sender;
    
    UserInfo* info =[UserInfo sharedUserInfo];
    info.firstSelectIndex = [NSString stringWithFormat:@"%d",button.tag];
    [info synchronize];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* mainTab = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTab"];
    AppDelegate*delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = mainTab;
}
@end
