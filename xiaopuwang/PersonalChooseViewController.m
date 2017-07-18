//
//  PersonalChooseViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/17.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PersonalChooseViewController.h"
#import "CustomAlertTableView.h"

@interface PersonalChooseViewController ()<RowSelectDelegate,UIAlertViewDelegate>
{
    CustomAlertTableView* ct;
}
@property(nonatomic,weak)IBOutlet UIButton* searchButton;
@property(nonatomic,weak)IBOutlet UIButton* schoolButton;
@property(nonatomic,weak)IBOutlet UIButton* courseButton;

@end

@implementation PersonalChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自助择校";
    
    [self.searchButton.layer setCornerRadius:3.0];
    self.searchButton.backgroundColor  = MAINCOLOR;
    
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitle:@"确认快速筛选" forState:UIControlStateNormal];
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

- (IBAction)schoolTypeAction:(id)sender{
    ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:10 title:@"请选择学校类型"];
    ct.delegate = self;

    [self.view addSubview:ct];
    
}


- (IBAction)courseTypeAction:(id)sender{
    if([self.schoolButton.titleLabel.text isEqualToString:@"选择学校类型"]){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"请先选择学校类型，再选择对应课程" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"选择学校类型", nil];
        [alert show];
    }else{
        ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:10 title:@"请选择课程类型"];
        ct.delegate = self;
        [self.view addSubview:ct];

    }
}

#pragma  mark - RowSelectDelegate
-(void)selectRow:(NSInteger)rowIndex{
    DLog(@"%ld",rowIndex);
    [ct dismiss];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex  == 1) {
        [self schoolTypeAction:self.schoolButton];
    }
}
@end
