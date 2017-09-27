//
//  InviteViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteBannerTableViewCell.h"
#import "InviteSendTableViewCell.h"
#import "InviteStrategyTableViewCell.h"
#import "InvitePeopleAndRuleTableViewCell.h"
#import "InvitePeopleContentTableViewCell.h"
#import "InvitePeopleBottomTableViewCell.h"

@interface InviteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section<3) {
        return 1;
    }else{
        return 11;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 200;
    }else if (indexPath.section==1){
        return 180;
    }else if (indexPath.section ==2){
        return  (Main_Screen_Width-24)/231*128 +8;
    }else{
        return 44;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        InviteBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteBannerTableViewCell" owner:self options:nil].firstObject;
       
        return cell;
    }else if (indexPath.section==1){
        InviteSendTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteSendTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else if (indexPath.section==2){
        InviteStrategyTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InviteStrategyTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }else{
        if (indexPath.row ==0) {
            InvitePeopleAndRuleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InvitePeopleAndRuleTableViewCell" owner:self options:nil].firstObject;
            
            return cell;
        }else if (indexPath.row ==10) {
            InvitePeopleBottomTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InvitePeopleBottomTableViewCell" owner:self options:nil].firstObject;
            
            return cell;
        }else{
            InvitePeopleContentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"InvitePeopleContentTableViewCell" owner:self options:nil].firstObject;
            
            return cell;
        }
        
    }
}
@end
