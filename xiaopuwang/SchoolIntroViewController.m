//
//  SchoolIntroViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/3.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolIntroViewController.h"

@interface SchoolIntroViewController ()
@property(nonatomic,weak)IBOutlet UIWebView* webView;
@end

@implementation SchoolIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校介绍";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
